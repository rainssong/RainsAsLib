package me.rainssong.controls
{
	
	import com.greensock.TweenLite;
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
	import me.rainssong.utils.superTrace;
	
	/**
	 * ...
	 * @author rainssong
	 */
	public class ZoomBtn extends MyMovieClip
	{
		private const colorTrans:ColorTransform = new ColorTransform();
		private var _grayBitmap:Bitmap;
	
		private var _normalScaleX:Number;
		
		private var _normalScaleY:Number;
		public var zoomRate:Number = 1.5;
		
		public function ZoomBtn()
		{
			super();
			this.mouseChildren = false;
			_normalScaleX = this.scaleX;
			_normalScaleY = this.scaleY;
			
		}
		
		override protected function onAdd(evt:Event = null):void
		{
			super.onAdd(evt);
			this.addEventListener(MouseEvent.MOUSE_DOWN, downHandler);
			_grayBitmap = new Bitmap();
		}
		
		private function downHandler(e:MouseEvent):void
		{
			
			TweenLite.killTweensOf(this);
			
			TweenLite.to(this, 0.5, { scaleX:zoomRate * _normalScaleX, scaleY:zoomRate * _normalScaleY});
			
			stage.addEventListener(MouseEvent.MOUSE_UP, upHandler);
			//stage.addEventListener(MouseEvent.MOUSE_OUT, upHandler);
		}
		
		
		
		private function upHandler(e:MouseEvent):void
		{
			TweenLite.killTweensOf(this);
			TweenLite.to(this, 0.5, { scaleX:_normalScaleX, scaleY:_normalScaleY });
			
			//this.transform.colorTransform = colorTrans;
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