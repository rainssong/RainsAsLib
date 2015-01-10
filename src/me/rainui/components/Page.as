package me.rainui.components 
{
	import adobe.utils.CustomActions;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.Shape;
	import flash.events.Event;
	import flash.geom.Matrix;
	import me.rainssong.utils.Draw;
	import me.rainui.RainUI;
	/**
	 * ...
	 * @author Rainssong
	 */
	public class Page extends Container 
	{
		//public var btnSkinClass:Class = Button;
		
		public function Page() 
		{
			super();
			addEventListener(Event.ADDED_TO_STAGE, onAddToStage);
		}
		
		private function onAddToStage(e:Event):void 
		{
			stage.addEventListener(Event.RESIZE, onParentResize);
			removeEventListener(Event.ADDED_TO_STAGE, onAddToStage);
			this._height = RainUI.stageHeight;
			this._width = RainUI.stageWidth;
		}
		
		override protected function preinitialize():void 
		{
			super.preinitialize();
			this._height = 640;
			this._width = 480;
			//this.mouseEnabled = true;
			this.mouseChildren = true;
		}
		
		override protected function createChildren():void 
		{
			if (bgSkin == null) 
			{
				var shape:Shape = new Shape();
				Draw.rect(shape, 0, 0, 100, 100, 0xFFFFFF);
				bgSkin = shape;
			}
			callLater(redraw);
			
		}
		
		
		override public function resize():void 
		{
			_width = RainUI.stageWidth;
			_height = RainUI.stageHeight;
			super.resize();
		}
		
		
	}

}