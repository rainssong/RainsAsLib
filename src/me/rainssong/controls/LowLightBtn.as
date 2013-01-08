package me.rainssong.controls
{
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.filters.ColorMatrixFilter;
	import flash.geom.ColorTransform;
	import flash.display.MovieClip;
	import me.rainssong.display.MyMovieClip;
	
	/**
	 * ...
	 * @author rainssong
	 */
	public class LowLightBtn extends MyMovieClip
	{
		private const colorTrans:ColorTransform = new ColorTransform();
		private var _grayBitmap:Bitmap;
		
		public function LowLightBtn()
		{
			super();
			this.mouseChildren = false;
		}
		
		override protected function onAdd(evt:Event = null):void
		{
			super.onAdd(evt);
			this.addEventListener(MouseEvent.MOUSE_DOWN, downHandler);
			_grayBitmap = new Bitmap();
		}
		
		private function downHandler(e:MouseEvent):void
		{
			gotoDownFrame();
			stage.addEventListener(MouseEvent.MOUSE_UP, upHandler);
			//stage.addEventListener(MouseEvent.MOUSE_OUT, upHandler);
		}
		
		public function gotoDownFrame():void
		{
			var temp:ColorTransform = new ColorTransform(0.7, 0.7, 0.7, 1, 0, 0, 0, 0);
			this.transform.colorTransform = temp;
		}
		
		private function upHandler(e:MouseEvent):void
		{
			this.transform.colorTransform = colorTrans;
		}
		
		override public function disable():void
		{
			super.disable();
			
			this.filters=[ new ColorMatrixFilter([.33,.33,.33,0,0,.33,.33,.33,0,0,.33,.33,.33,0,0,0,0,0,1,0])]
			
			this.mouseEnabled = false;
		}
		
		override public function enable():void
		{
			super.enable();
			this.filters = [];
			this.mouseEnabled = true;
		
		}
	
		//private function removeAt():void 
//		{
//			stage.removeEventListener(MouseEvent.MOUSE_UP, upHandler);
//			stage.removeEventListener(MouseEvent.MOUSE_OUT, upHandler);
//			
//			super.removeAt();
//		}
	
	}

}