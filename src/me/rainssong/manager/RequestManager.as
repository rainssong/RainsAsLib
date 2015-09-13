package me.rainssong.manager
{
	import flash.events.ErrorEvent;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	import flash.net.URLVariables;
	import flash.utils.Dictionary;
	import me.rainssong.events.ObjectEvent;
	import me.rainssong.events.RequestEvent;
	import me.rainssong.events.RequestIOErrorEvent;
	
	/**
	 * ...
	 * @author rainssong
	 */
	public class RequestManager extends EventDispatcher
	{
		private static const _loaderDic:Dictionary = new Dictionary();
		static private const _loaderRevDic:Dictionary = new Dictionary();
		
		public function RequestManager()
		{
		
		}
		
		private function onError(e:IOErrorEvent):void
		{
			var url:String = _loaderRevDic[e.target];
			dispatchEvent(new RequestIOErrorEvent(e.type, url, e.bubbles, e.cancelable));
		}
		
		private function onComplete(e:Event):void
		{
			var url:String = _loaderRevDic[e.target];
			var data:Object = e.target.data;
			dispatchEvent(new RequestEvent(e.type, url, data, e.bubbles, e.cancelable));
		}
		
		public function hasLoader(url:String):Boolean
		{
			return _loaderDic[url];
		}
		
		public function getLoader(url):URLLoader
		{
			return _loaderDic[url];
		}
		
		public function createLoader(url:String):URLLoader
		{
			var loader:URLLoader = new URLLoader()
			_loaderDic[url] = loader;
			_loaderRevDic[loader] = url;
			
			loader.addEventListener(Event.COMPLETE, onComplete);
			loader.addEventListener(IOErrorEvent.IO_ERROR, onError);
			
			return loader;
		}
		
		public function destroyLoader(url:String):void
		{
			var loader:URLLoader = _loaderDic[url];
			loader.removeEventListener(Event.COMPLETE, onComplete);
			loader.removeEventListener(IOErrorEvent.IO_ERROR, onError);
			_loaderDic[url] = null;
		}
		
		public function sendRequest(data:Object, url:String, type:String = URLRequestMethod.POST):void
		{
			if (!hasLoader(url))
				createLoader(url);
			//MonsterDebugger.log("sendRequest:" , data, url, type);
			
			var request:URLRequest = new URLRequest(url);
			
			request.method = type;
			
			if (type == URLRequestMethod.GET)
			{
				var uv:URLVariables = new URLVariables();
				for (var i:String in data)
					uv[i] = data[i];
				
				request.data = uv;
			}
			else
			{
				request.data = JSON.stringify(data);
				request.contentType = "application/json";
			}
			
			powerTrace(url, JSON.stringify(data));
			_loaderDic[url].load(request);
		}
	}

}