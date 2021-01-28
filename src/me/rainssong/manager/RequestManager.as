package me.rainssong.manager
{
	import flash.events.ErrorEvent;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.TimerEvent;
	import flash.net.NetworkInfo;
	import flash.net.NetworkInterface;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	import flash.net.URLVariables;
	import flash.net.navigateToURL;
	import flash.utils.Dictionary;
	import flash.utils.Timer;
	import me.rainssong.events.ObjectEvent;
	import me.rainssong.events.RequestEvent;
	import me.rainssong.events.RequestIOErrorEvent;
	import me.rainssong.utils.RevDictionary;
	
	/**
	 * ...
	 * @author rainssong
	 */
	public class RequestManager extends EventDispatcher
	{
		private static const _loaderDic:Dictionary = new Dictionary();
		private static const _callBackDic:Dictionary = new Dictionary();
		static private const _loaderRevDic:Dictionary = new Dictionary();
		static private const _timerDic:RevDictionary = new RevDictionary(true);
		
		public function RequestManager()
		{
		
		}
		
		private function onError(e:IOErrorEvent):void
		{
			var url:String = _loaderRevDic[e.target];
			//var timer:Timer = _timerDic.getValue(url) as Timer;
			//timer.stop();
			dispatchEvent(new RequestIOErrorEvent(e.type, url, e.bubbles, e.cancelable,e.text,e.errorID));
		}
		
		private function onComplete(e:Event):void
		{
			var url:String = _loaderRevDic[e.target];
			var data:Object = e.target.data;
			//var timer:Timer = _timerDic.getValue(url)  as Timer;
			var ent:RequestEvent = new RequestEvent(e.type, url, data, e.bubbles, e.cancelable);
			
			if (_callBackDic[url] != null)
				_callBackDic[url].apply(this, [ent]);
			//timer.stop();
			
			dispatchEvent(ent);
			
		}
		
		public function hasLoader(url:String):Boolean
		{
			return _loaderDic[url];
		}
		
		public function getLoader(url:String):URLLoader
		{
			return _loaderDic[url];
		}
		
		public function createLoader(url:String):URLLoader
		{
			var loader:URLLoader = new URLLoader()
			_loaderDic[url] = loader;
			_loaderRevDic[loader] = url;
			var timer:Timer= new Timer(1000 * 10, 1);
			_timerDic.setValue(url, timer);
			
			loader.addEventListener(Event.COMPLETE, onComplete);
			loader.addEventListener(IOErrorEvent.IO_ERROR, onError);
			//loader.addEventListener(IOErrorEvent.NETWORK_ERROR, onError);
			//timer.addEventListener(TimerEvent.TIMER_COMPLETE, onTimer);
			
			return loader;
		}
		
		private function onTimer(e:TimerEvent):void 
		{
			var timer:Timer = e.currentTarget as Timer;
			var url:String = _timerDic.getKey(timer);
			dispatchEvent(new RequestIOErrorEvent(IOErrorEvent.IO_ERROR, url, e.bubbles, e.cancelable,"time up"));
		}
		
		public function destroyLoader(url:String):void
		{
			var loader:URLLoader = _loaderDic[url];
			if (loader == null)
				return;
				
			loader.close();
			loader.removeEventListener(Event.COMPLETE, onComplete);
			loader.removeEventListener(IOErrorEvent.IO_ERROR, onError);
			_loaderDic[url] = null;
			//var timer:Timer = _timerDic.getValue(url);
			//timer.removeEventListener(TimerEvent.TIMER_COMPLETE, onTimer);
		}
		
		public function sendRequest(data:Object, url:String, method:String = URLRequestMethod.POST,delay:Number=10000,contentType:String="application/x-www-form-urlencoded",callBack:Function=null):URLLoader
		{
			
			if (!hasLoader(url))
				createLoader(url);
			
			var request:URLRequest = new URLRequest(url);
			
			request.method = method;
			request.contentType = contentType;
			
			switch (contentType) 
			{
				case "application/x-www-form-urlencoded":
					var uv:URLVariables = new URLVariables();
					for (var i:String in data)
						uv[i] = data[i];
					request.data = uv;
				break;
				case "application/json":
					request.data = JSON.stringify(data);
				break;
				default:
			}
			
			//powerTrace(url, JSON.stringify(data));
			_loaderDic[url].load(request);
			_callBackDic[url] = callBack;
			//var timer:Timer = _timerDic.getValue(url)  as Timer;
			//timer.delay = delay;
			//timer.reset();
			//timer.start();
			return _loaderDic[url] as URLLoader;
		}
		
		
		public function post(url:String, data:Object = null, callBack:Function = null,  contentType:String = "application/x-www-form-urlencoded")
		{
			sendRequest(data, url, URLRequestMethod.POST, 10000, contentType, callBack);
		}
		
		public function get(url:String, data:Object = null, callBack:Function = null,  contentType:String = "application/x-www-form-urlencoded")
		{
			sendRequest(data, url, URLRequestMethod.GET, 10000, contentType, callBack);
		}
	}

}