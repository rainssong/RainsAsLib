package me.rainssong.media
{
	import flash.display.DisplayObjectContainer;
	import flash.events.Event;
	import flash.filesystem.File;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.media.StageWebView;
	import me.rainssong.display.MySprite;
	
	/**
	 * ...
	 * @author Rainssong
	 */
	public class RainStageWebView extends MySprite
	{
		
		
		public var webWidth:Number;
		public var webHeight:Number;
		private var _webView:StageWebView
		
		public function RainStageWebView(width:Number = 800, height:Number = 600)
		{
			super();
			_webView = new StageWebView();
			webWidth= width;
			webHeight = height;
			
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
		
		override protected function onAdd(e:Event = null):void 
		{
			super.onAdd(e);
			_webView.stage = this.stage;
		}
		
		private function onEnterFrame(e:Event):void
		{
			if (!parent)
				return;
			var point:Point = new Point(this.x, this.y);
			
			var globalPoint:Point =parent.localToGlobal(point);
			
			_webView.viewPort = new Rectangle(globalPoint.x, globalPoint.y, webWidth, webHeight);
		}
		
		public function loadURL(url:String):void
		{
			_webView.loadURL(url);
		}
		
		override public function destroy():void
		{
			removeEventListener(Event.ENTER_FRAME, onEnterFrame);
			_webView.stage = null;
			_webView.dispose();
			_webView = null;
			super.destroy();
			
		}
	}

}