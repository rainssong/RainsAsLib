package me.rainssong.manager 
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.ProgressEvent;
	import flash.filesystem.File;
	import flash.utils.Dictionary;
	import me.rainssong.net.ResumeDownloader;
	import me.rainssong.utils.StringCore;

	
	/**
	 * ...
	 * @author rainssong
	 */
	public class DownloadManager extends EventDispatcher 
	{
		private var _downloaderDic:Dictionary = new Dictionary();
		private var _total:Number;
		private var _loaded:Number;
		
		public function DownloadManager() 
		{
			
		}
		
		public function getDownloader(sourceUrl:String):ResumeDownloader
		{
			sourceUrl = sourceUrl.split("?")[0];
			var d:*=_downloaderDic[sourceUrl];
			return _downloaderDic[sourceUrl];
		}
		
		public function addDownload(sourceUrl:String, targetUrl:String = null, autoStart:Boolean = true ):ResumeDownloader
		{
			sourceUrl=sourceUrl.split("?")[0]
			
			if (!targetUrl || targetUrl == "") 
			{
				var url:String=StringCore.webToLocal(sourceUrl)
				var f:File = File.applicationStorageDirectory.resolvePath(url);
				targetUrl =f.nativePath;
				//targetUrl =File.applicationStorageDirectory.resolvePath(StringCore.webToLocal(sourceUrl)).nativePath;
			}
			
			var downloader:ResumeDownloader = getDownloader(sourceUrl);
			if (downloader!=null)
			{
				if(downloader.isDownloading)
					trace(this +targetUrl + "已经在下载了!");
				//downloader.download(sourceUrl, targetUrl,autoStart);
				return downloader;
			}
			
			downloader = new ResumeDownloader();
			downloader.download(sourceUrl, targetUrl,autoStart);
			downloader.addEventListener(Event.COMPLETE, onComplete);
			_downloaderDic[sourceUrl] = downloader;
			
			return downloader;
			//_cookie.data.downloadUrlArr = _downloaderArr;
		}
		
		private function onComplete(e:Event):void 
		{
			_total = 0;
			_loaded = 0;
			for each (var i:ResumeDownloader in  _downloaderDic)
			{
				_total++;
				if (i.isFinished)
				{
					_loaded++;
				}
			}
			
			dispatchEvent(new ProgressEvent(ProgressEvent.PROGRESS,false,false,_loaded,_total))
			if (_total==_loaded)
				dispatchEvent(new Event(Event.COMPLETE));
		}
		
		public function get  isDownloading():Boolean 
		{
			for each (var i:ResumeDownloader in  _downloaderDic)
			{
				if (!i.isFinished)
				{
					return true;
				}
			}
			return false;
		}
		
		public function get total():Number 
		{
			return _total;
		}
		
		public function get loaded():Number 
		{
			return _loaded;
		}
		
		
		
	}

}