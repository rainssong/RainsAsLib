package tools
{
	import avmplus.finish;
	import com.vsdevelop.air.filesystem.FileCore;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.filesystem.File;
	import flash.filesystem.FileStream;
	import flash.net.FileReference;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import com.vsdevelop.net.SharedManage;
	import flash.net.URLRequestHeader;
	import flash.utils.ByteArray;
	import com.vsdevelop.net.SharedManage;
	import flash.utils.getDefinitionByName;
	
	/**
	 * ...
	 * @author rainssong
	 */
	public class ResumeDownloader extends EventDispatcher
	{
		private static const RANGE:int = 100000;
		private static const EXTENSION:String = "ed";
		private var _totalLength:Number;
		private var _sourceUrl:String;
		private var _tempFileUrl:String;
		private var _targetUrl:String;
		private var _autoStart:Boolean;
		private var _targetFile:File;
		private var _tempFile:File;
		private var _sourceFile:File;
		
		private var _isCover:Boolean;
		private var _bytesLoaded:Number
		
		private var _startPoint:Number = 0;
		private var _endPoint:Number;
		
		private var _isFinished:Boolean = false;
		
		public function ResumeDownloader()
		{
			
		}
		
		public function download(sourceUrl:String, targetUrl:String, autoStart:Boolean = true, isCover:Boolean = false):void
		{
			_sourceUrl = sourceUrl;
			_targetUrl = targetUrl;
			_autoStart = autoStart;
			_isCover = isCover;
			_bytesLoaded = 0;
			_isFinished = false;
			//_targetFile = FileCore.newFile(targetUrl);
			
			_targetFile = new File(targetUrl);
			_targetFile.parent.createDirectory();
			//_targetFile = (new File("/" + targetUrl)).nativePath;
			//如果有了就别下了。
			if (_targetFile.exists && !isCover)
			{
				trace(this+"文件已存在，下载取消");
				return;
			}
			
			//.substring(0, targetUrl.lastIndexOf("."))
			_tempFileUrl = targetUrl + "." + EXTENSION;
			trace(_tempFileUrl);
			//_tempFile =new File("/"+_tempFileUrl);
			_tempFile = new File(_tempFileUrl);
			_tempFile.parent.createDirectory();
			trace(_tempFile.exists);
			
			try
			{
				_sourceFile = new File(sourceUrl);
			}
			catch (e:Error)
			{
				
			}
			
			var loader:URLLoader = new URLLoader();
			loader.load(new URLRequest(sourceUrl));
			loader.addEventListener(ProgressEvent.PROGRESS, loaderProgressHandler);
		}
		
		private function loaderProgressHandler(e:ProgressEvent):void
		{
			
			_totalLength = URLLoader(e.target).bytesTotal; //得到文件的真实尺寸;
			
			trace(this + "总长度" + totalLength);
			
			URLLoader(e.target).close(); //停止load;
			
			if (_autoStart)
				
				startDownLoad(); //按照断点续传的方式下载;
		
		}
		
		public function startDownLoad():void
		{
			
			if (_tempFile.exists)
			{
				var fs:FileStream = new FileStream()
				try
				{
					fs.open(_tempFile, "read");
				}
				catch (e:Error)
				{
					trace(e);
				}
				
				if (fs)
				{
					//计算从哪个点开始下载
					_startPoint = fs.bytesAvailable;
					fs.close();
				}
			}
			
			if (_startPoint >= totalLength)
			{
				downloadFinish();
				return;
			}
			
			_endPoint = _startPoint + RANGE > _totalLength ? totalLength : (_startPoint + RANGE);
			
			var request:URLRequest = new URLRequest(_sourceUrl);
			var header:URLRequestHeader = new URLRequestHeader("Range", "bytes=" + _startPoint + "-" + _endPoint);
			request.requestHeaders.push(header);
			
			var loader:URLLoader = new URLLoader();
			
				
				
			
			
			loader.addEventListener(IOErrorEvent.IO_ERROR, loaderErrorHandler);
			
			loader.dataFormat = URLLoaderDataFormat.BINARY;
			loader.addEventListener(Event.COMPLETE, rangeDownloadCompleteHandler);
			loader.load(request);
		}
		
		private function loaderErrorHandler(e:IOErrorEvent):void 
		{
			trace(this + "下载错误,停止:" + e.text);
			dispatchEvent(new IOErrorEvent(IOErrorEvent.IO_ERROR));
			return;
		}
		
		private function rangeDownloadCompleteHandler(e:Event):void
		{
			var data:ByteArray = URLLoader(e.target).data;
			
			var fileStream:FileStream = new FileStream();
			//if (_tempFile.exists)
			//{
			try
			{
				fileStream.open(_tempFile, "update");
			}
			catch (e:Error)
			{
				trace(e);
			}
			_startPoint = fileStream.bytesAvailable;
			fileStream.position = _startPoint;
			//}
			
			//fileStream.position = fileStream.bytesAvailable;
			fileStream.writeBytes(data, 0, data.length);
			_bytesLoaded = _startPoint + data.length;
			fileStream.close();
			
			if (loadedPercent < 1)
			{
				dispatchEvent(new ProgressEvent(ProgressEvent.PROGRESS));
				trace(loadedPercent);
				startDownLoad();
			}
			else
			{
				downloadFinish();
				
				
			}
		}
		
		private function downloadFinish():void 
		{
			_isFinished = true;
			rename();
			dispatchEvent(new Event(Event.COMPLETE));
			trace(this+ _sourceUrl + "下载完成");
		}
		
		private function rename():void
		{
			_tempFile.moveTo(_targetFile, true);
		}
		
		public function getTargetFileStream(writeType:String = "write", sync:Boolean = true):FileStream
		{
			if (!_targetFile)
			{
				return null;
			}
			try
			{
				var myClass:Class = getDefinitionByName("flash.filesystem.FileStream") as Class;
				var fs:* = new myClass();
				if (!sync)
				{
					fs.openAsync(_targetFile, writeType);
				}
				else
				{
					fs.open(_targetFile, writeType);
				}
			}
			catch (e:Error)
			{
				return null;
			}
			return fs;
		}
		
		//private function getFileStream(url:String,writeType:String="write"):FileStream
		//{
		//
		//
		//
		//trace("是否存在", writeType, f.exists);
		//if (writetype == "read" && f.exists == false)
		//{
		//return null;
		//}
		//try
		//{
		//var myClass:Class = getDefinitionByName("flash.filesystem.FileStream") as Class;
		//var fs:* = new myClass();
		//if (!sync)
		//{
		//fs.openAsync(f, writetype);
		//}
		//else
		//{
		//fs.open(f, writetype);
		//}
		//}
		//catch (e:Error)
		//{
		//return null;
		//}
		//return fs;
		//}
		
		public function get loadedLength():Number
		{
			if (_targetFile)
			{
				if (_targetFile.exists)
				{
					var fileStream:FileStream = new FileStream();
					fileStream.openAsync(_targetFile, "write");
					return fileStream.bytesAvailable;
				}
			}
			
			return 0;
		}
		
		public function get tempUrl():String
		{
			return _targetUrl + "." + EXTENSION;
		}
		
		public function get totalLength():Number
		{
			return _totalLength;
		}
		
		public function get loadedPercent():Number
		{
			return _endPoint / _totalLength;
		}
		
		public function get sourceUrl():String
		{
			return _sourceUrl;
		}
		
		public function get targetUrl():String
		{
			return _targetUrl;
		}
		
		public function get autoStart():Boolean
		{
			return _autoStart;
		}
		
		public function get isFinished():Boolean 
		{
			return _isFinished;
		}
		
	
	
	}
}