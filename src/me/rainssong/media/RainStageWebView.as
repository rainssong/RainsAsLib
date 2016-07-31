package me.rainssong.media
{
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.LocationChangeEvent;
	import flash.filesystem.File;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.html.HTMLLoader;
	import flash.media.StageWebView;
	import me.rainssong.display.SmartSprite;
	import me.rainssong.utils.HtmlCreator;
	import me.rainui.RainUI;
	
	/**
	 * ...
	 * @author Rainssong
	 */
	public class RainStageWebView extends  SmartSprite
	{
		
		public var webWidth:Number;
		public var webHeight:Number;
		private var _webView:StageWebView = new StageWebView();
		private var _htmlLoader:HTMLLoader = new HTMLLoader();
		
		public function RainStageWebView(width:Number = 800, height:Number = 600)
		{
			super();
			webWidth= width;
			webHeight = height;
			this.autoDestroy=false
			//addChild(_webView)
		}
		
		override protected function onRegister():void 
		{
			super.onRegister();
			//_webView = new StageWebView();
		}
		
		override protected function onAdd(e:Event = null):void 
		{
			super.onAdd(e);
			
			_webView.stage = this.stage;
			_webView.addEventListener(LocationChangeEvent.LOCATION_CHANGE, onLocationChange);
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
		
		private function onLocationChange(e:LocationChangeEvent):void 
		{
			//dispatchEvent(new LocationChangeEvent(LocationChangeEvent.LOCATION_CHANGE));
			dispatchEvent(e);
		}
		
		override public function hide():void 
		{
			_webView.stage = null;
			super.hide();
			
		}
		
		override public function show():void 
		{
			_webView.stage = this.stage;
			super.show();
			
		}
		
		private function onEnterFrame(e:Event):void
		{
			if (!parent)
				return;
			var point:Point = new Point(this.x, this.y);
			
			var globalPoint:Point =parent.localToGlobal(point);
			
			_webView.viewPort = new Rectangle(globalPoint.x, globalPoint.y, webWidth, webHeight);
		}
		
		override protected function onRemove(e:Event):void 
		{
			_webView.stage = null;
			super.onRemove(e);
		}
		
		
		override public function destroy():void
		{
			removeEventListener(Event.ENTER_FRAME, onEnterFrame);
			
			if (_webView && _webView.stage)
			{
				_webView.stage = null;
				_webView.dispose();
			}
			
			_webView = null;
			
			super.destroy();
			
		}
		
		/* DELEGATE flash.media.StageWebView */
		
		public function loadString(text:String, mimeType:String = "text/html"):void 
		{
			_webView.loadString(text, mimeType);
		}
		
		public function loadURL(url:String):void
		{
			_webView.loadURL(url);
		}
		
		/* DELEGATE flash.media.StageWebView */
		
		public function historyBack():void 
		{
			_webView.historyBack();
		}
		
		public function historyForward():void 
		{
			_webView.historyForward();
		}
		
		/* DELEGATE flash.media.StageWebView */
		
		public function reload():void 
		{
			_webView.reload();
		}
		
		public function unload():void
		{
			
			
			//webview.loadURL(File.applicationStorageDirectory.resolvePath("temp.html").nativePath);
			_webView.loadURL (HtmlCreator.createFile("").nativePath);
		}
		

		
		public function get title():String 
		{
			return _webView.title;
		}
		
		/* DELEGATE flash.media.StageWebView */
		
		//override public function addEventListener(type:String, listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false):void 
		//{
			//_webView.addEventListener(type, listener, useCapture, priority, useWeakReference);
		//}
		//
		//override public function dispatchEvent(event:Event):Boolean 
		//{
			//return _webView.dispatchEvent(event);
		//}
		//
		//override public function hasEventListener(type:String):Boolean 
		//{
			//return _webView.hasEventListener(type);
		//}
		//
		//override public function removeEventListener(type:String, listener:Function, useCapture:Boolean = false):void 
		//{
			//_webView.removeEventListener(type, listener, useCapture);
		//}
		
		/* DELEGATE flash.media.StageWebView */
		
		public function get isHistoryBackEnabled():Boolean 
		{
			return _webView.isHistoryBackEnabled;
		}
		
		public function get isHistoryForwardEnabled():Boolean 
		{
			return _webView.isHistoryForwardEnabled;
		}
		
		public function get location():String
		{
			return _webView.location;
		}
		
		public function set location(url:String):void
		{
			_webView.loadURL(url);
		}
		
		//public function get webView():StageWebView 
		//{
			//return _webView;
		//}
		
	}

}