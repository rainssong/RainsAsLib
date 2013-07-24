package me.rainssong.controls
{
	
	import cn.flashk.controls.support.BitmapDataText;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.IBitmapDrawable;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.filters.ColorMatrixFilter;
	import flash.geom.ColorTransform;
	import flash.display.MovieClip;
	import me.rainssong.display.BitmapDataCore;
	import me.rainssong.display.MyMovieClip;
	import me.rainssong.display.SmartSprite;
	
	/**
	 * ...
	 * @author rainssong
	 */
	public class LowLightBtn extends SmartSprite
	{
		private const darkColorTrans:ColorTransform = new ColorTransform(0.7, 0.7, 0.7, 1, 0, 0, 0, 0)
		private const normalColorTrans:ColorTransform = new ColorTransform()
		
		public function LowLightBtn(view:DisplayObject = null )
		{
			super();
			this.mouseChildren = false;
			if (view) addChild(new Bitmap(BitmapDataCore.drawScaleBmd(view)));
		}
		
		override protected function onAdd(evt:Event = null):void
		{
			super.onAdd(evt);
			this.addEventListener(MouseEvent.MOUSE_DOWN, downHandler);
		}
		
		private function downHandler(e:MouseEvent):void
		{
			gotoDownFrame();
			stage.addEventListener(MouseEvent.MOUSE_UP, upHandler);
			//stage.addEventListener(MouseEvent.MOUSE_OUT, upHandler);
		}
		
		public function gotoDownFrame():void
		{
			this.transform.colorTransform = darkColorTrans;
		}
		
		private function upHandler(e:MouseEvent):void
		{
			this.transform.colorTransform = normalColorTrans;
		}
		
		override public function disable():void
		{
			super.disable();
			
			this.filters=[ new ColorMatrixFilter([.33,.33,.33,0,0,.33,.33,.33,0,0,.33,.33,.33,0,0,0,0,0,1,0])]
		}
		
		override public function enable():void
		{
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