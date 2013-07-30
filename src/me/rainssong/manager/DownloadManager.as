package me.rainssong.manager 
{
	import br.com.stimuli.loading.BulkLoader;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.filesystem.File;
	import flash.net.SharedObject;
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
		private var _cookie:Object;
		
		public function DownloadManager() 
		{
			
		}
		
		public function getDownloader(targetUrl:String):ResumeDownloader
		{
			return _downloaderDic[targetUrl];
		}
		
		
		
		public function addDownload(sourceUrl:String,targetUrl:String=null):void
		{
			if (!targetUrl || targetUrl = "") targetUrl = File.applicationStorageDirectory.resolvePath(StringCore.deleteProtocol(sourceUrl));
			if (isDownloading(targetUrl))
			{
				trace(this +targetUrl+ "已经在下载了!");
				return ;
			}
			var downloader:ResumeDownloader = new ResumeDownloader();
			downloader.download(sourceUrl, targetUrl);
			downloader.addEventListener(Event.COMPLETE, completeHandler);
			downloader.addEventListener(IOErrorEvent.IO_ERROR, completeHandler);
			_downloaderDic[targetUrl] = downloader;
			//_cookie.data.downloadUrlArr = _downloaderArr;
		}
		
		private function completeHandler(e:Event=null):void 
		{
			//_downloaderArr.splice(_downloaderArr.indexOf(ResumeDownloader(e.target)), 1);
			dispatchEvent(new Event(Event.COMPLETE));
		}
		
		public function isDownloading(targetUrl:String):Boolean 
		{
			for each (var i:ResumeDownloader in  _downloaderArr)
			{
				if (i.targetUrl == targetUrl && !i.isFinished)
				{
					return true;
				}
			}
			return false;
		}
		
	}

}