/*
How to use:
SFile 是File 类的扩展  继承自File 类

新增
downloadFileByStream(_url:String,intervalBytes:Number=10000,cover:Boolean) 方法
    
      作用：断点方式下载指定地址的文件，参数 _url 指定要下载文件的地址，interval：分段下载时每段的字节数，cover：指定是否覆盖现有的文件
      如果cover为false 并且文件已经存在时 将抛出 SErrorEvent.Error事件 事件的ErrorType属性值为fileExistError


downloadFile(_url:String,cover:Boolean)
      普通方式下载指定地址的文件，参数 _url 指定要下载文件的地址，cover：指定是否覆盖现有的文件
      如果cover为false 并且文件已经存在时 将抛出 SErrorEvent.Error事件 事件的ErrorType属性值为fileExistError
 

事件：SErrorEvent.ERROR
      当下载遇到错误时调度.. 
	  属性ErrorType指定错误的类型  包括 fileExistError 和 byteLoaderIOError
	  属性file指定当前的文件
	  
      SProgressEvent.FILE_DOWN_PROGRESS
	  下载进度：属性bytesLoaded指定 已经下载的字节数 bytesTotal 为总共的字节数
	            属性file指定当前的文件
      SEvent.FILE_DOWN_COMPLETE
	            下载完成时调度
				 属性file指定当前的文件
eg：
   import com.sixuu.SFile;
   import com.sixuu.events.SErrorEvent;
   import com.sixuu.events.SProgressEvent;
   import com.sixuu.events.SEvent;

   var f:SFile=new SFile(SFile.applicationDirectory.resolvePath("1.png").nativePath)
   f.addEventListener(SErrorEvent.ERROR,onError)
   f.addEventListener(SProgressEvent.FILE_DOWN_PROGRESS,onProgress)
   f.addEventListener(SEvent.FILE_DOWN_COMPLETE,onComplete)
   f.downloadFileByStream("http://www.littlesix.com.cn/test/test.png",10000,false)

   function onError(e:SErrorEvent){
	   trace(e.errorType)
   }
   function onProgress(e:SProgressEvent){
	   trace(e.bytesLoaded,"----",e.bytesTotal)
   }
   function onComplete(e:SEvent){
	   trace("fileDownLoaded")
   }
	     


*/
package com.sixuu
{
	import flash.filesystem.File;
	import flash.filesystem.FileStream;
	import com.sixuu.events.SEvent;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	import com.sixuu.events.SErrorEvent;
	import flash.events.Event;
	import com.sixuu.events.SProgressEvent;
	import com.sixuu.events.SProgressEvent;

	[Event(name = "fileDownProgress",type = "com.sixuu.events.SProgressEvent")]
	[Event(name = "fileDownComplete",type = "com.sixuu.events.SEvent")]
	[Event(name = "error",type = "com.sixuu.events.SErrorEvent")]
	public class SFile extends File
	{
		public var sourceURL:String = "";
		public var fileLength:uint;
		private var file:File;
		private var fs:FileStream;
		private var bd:BytesDownLoader;
		private var bd1:BytesDownLoader;
		private var startPoint = 0;
		private var endPoint = 0;
		private var currentData;
		private var interval = 10000;
		private var timer:Timer = new Timer(800,0);

		public function SFile(filePath:String=null)
		{
			super(filePath);
			file = new File  ;
			fs = new FileStream  ;
			bd = new BytesDownLoader  ;
			bd1 = new BytesDownLoader  ;
			bd.addEventListener(SEvent.COMPLETE,bdComplete);
			bd1.addEventListener(SEvent.COMPLETE,bd1Complete);
			bd.addEventListener(SErrorEvent.ERROR,onError);
			bd1.addEventListener(SErrorEvent.ERROR,onError);
			bd1.addEventListener(SProgressEvent.PROGRESS,bd1Progress)
		}
		public function downloadFileByStream(_url:String,intervalBytes:Number=10000,cover:Boolean=true)
		{
			this.interval = intervalBytes;
			this.sourceURL = _url;
			file.url = this.url + "_stemp";
			if (! this.exists)
			{
				writeFile();
			}
			else if (cover)
			{
				this.deleteFile();
				writeFile();
			}
			else
			{
				var evt:SErrorEvent = new SErrorEvent("error");
				evt.errorType = "fileExistError";
				evt.file = this;
				dispatchEvent(evt);
			}
			function writeFile()
			{
				if (file.exists)
				{
					fs.open(file,"update");
					startPoint = fs.bytesAvailable;
					fs.close();
				}
				endPoint = startPoint + interval;
				bd.downLoad(sourceURL,startPoint,endPoint - 1);
				
			}

		}
		private function startDown()
		{
			startPoint = endPoint;
			endPoint = startPoint + interval;
			if (currentData != null)
			{
				saveFileData();
			}
			if (startPoint <= bd.fileLength)
			{
				bd.downLoad(this.sourceURL,this.startPoint,this.endPoint - 1);
			}
			else
			{
				file.moveTo(this,true);
				var evt:SEvent = new SEvent("fileDownComplete");
				evt.file = this;
				dispatchEvent(evt);
			}


		}
		private function saveFileData()
		{
			fs.open(file,"update");
			fs.position = fs.bytesAvailable;
			fs.writeBytes(currentData,0,currentData.length);
			fs.close();
		}
		public function downloadFile(url:String,cover:Boolean=true)
		{
			if (! this.exists)
			{
				bd1.downLoad(url);
			}else if(cover){
				this.deleteFile()
				bd1.downLoad(url);
			}else{
				var evt:SErrorEvent = new SErrorEvent("error");
				evt.errorType = "fileExistError";
				evt.file = this;
				dispatchEvent(evt);
			}

		}
		private function bd1Progress(e:SProgressEvent){
			var evt:SProgressEvent=new SProgressEvent("fileDownProgress")
			evt.bytesLoaded=e.bytesLoaded
			evt.bytesTotal=e.bytesTotal
			evt.file=this
			dispatchEvent(evt)
		}
		private function bd1Complete(e:SEvent)
		{
			fs.open(this,"write");
			fs.writeBytes(bd1.byteArray);
			fs.close();
			var evt:SEvent = new SEvent("fileDownComplete");
			evt.file = this;
			dispatchEvent(evt);
		}
		private function bdComplete(e:SEvent)
		{
			currentData = bd.byteArray;
			var evt:SProgressEvent = new SProgressEvent("fileDownProgress");
			evt.bytesLoaded = bd.endPos;
			evt.bytesTotal = bd.fileLength;
			bd.endPos>bd.fileLength?evt.bytesLoaded=bd.fileLength-1:0
			evt.file = this;
			dispatchEvent(evt);
			startDown();
		}
		private function onError(e:SErrorEvent)
		{
			var evt:SErrorEvent = new SErrorEvent("error");
			evt.errorType = e.errorType;
			evt.file = this;
			dispatchEvent(evt);
		}
		///static methods
		
		static public function get applicationDirectory():File{
			return File.applicationDirectory
		}
		static public function get applicationStorageDirectory():File{
			return File.applicationStorageDirectory
		}
		static public function get desktopDirectory():File{
			return File.desktopDirectory
		}
		static public function get documentsDirectory():File{
			return File.documentsDirectory
		}
		static public function get lineEnding():String{
			return File.lineEnding
		}
		static public function get separator():String{
			return File.separator
		}
		static public function get systemCharset():String{
			return File.systemCharset
		}
		static public function get userDirectory():File{
			return File.userDirectory
		}
		static public function createTempDirectory():File{
			return File.createTempDirectory()
		}
		static public function createTempFile():File{
			return File.createTempFile()
		}
		static public function getRootDirectories():Array{
			return File.getRootDirectories()
		}
		



	}

}