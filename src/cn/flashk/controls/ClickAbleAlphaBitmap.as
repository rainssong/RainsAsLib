package cn.flashk.controls 
{
	import cn.flashk.controls.events.ClickAbleAlphaBitmapEvent;
	import cn.flashk.controls.support.UIComponent;
	import cn.flashk.conversion.ColorConversion;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	/**
	 * ClickAbleAlphaBitmap 用来为一个png透明图片创建点击，使透明区域点击无效。
	 *  
	 * @langversion ActionScript 3.0
	 * @playerversion Flash 9.0
	 * 
	 * @see cn.flashk.controls.support.UIComponent
	 * 
	 * @author flashk
	 */
	public class ClickAbleAlphaBitmap extends UIComponent
	{
		protected var bd:BitmapData;
		protected var bp:Bitmap;
		protected var _checkPointAlpha:uint = 128;
		protected var _ableHandCursor:Boolean = false;
		protected var lastIsAlpah:Boolean = true;
		protected var _filters:Array = [];
		
		public function ClickAbleAlphaBitmap() 
		{
			bp = new Bitmap();
			this.addChild(bp);
			this.addEventListener(MouseEvent.CLICK, checkClickAlpha);
			this.addEventListener(MouseEvent.MOUSE_MOVE, checkHand);
			this.addEventListener(MouseEvent.MOUSE_OUT, showOut);
		}
		public function get isMouseOnNoAlphaPixel():Boolean {
			var color:uint = bd.getPixel32(this.mouseX, this.mouseY);
			var a:uint = ColorConversion.getAlphaFromeARGB(color);
			if (a < _checkPointAlpha) {
				return false;
			}
			return true;
		}
		public function set bitmapData(data:BitmapData):void {
			bd = data;
			bp.bitmapData = bd;
		}
		public function set ableHandCursor(value:Boolean):void {
			_ableHandCursor = value;
			if (_ableHandCursor == true) {
				checkHand();
			}else {
				this.buttonMode = false;
				this.useHandCursor = false;
			}
		}
		public function get ableHandCursor():Boolean {
			return _ableHandCursor;
		}
		public function set checkPointAlpha(value:uint):void {
			_checkPointAlpha = value;
		}
		public function get checkPointAlpha():uint {
			return _checkPointAlpha;
		}
		public function set overFilters(value:Array):void {
			_filters = value;
		}
		public function get overFilters():Array {
			return _filters;
		}
		protected function checkClickAlpha(event:MouseEvent):void {
			if (isMouseOnNoAlphaPixel == true) {
				this.dispatchEvent(new Event(ClickAbleAlphaBitmapEvent.NO_ALPHA_CLICK));
			}else {
				this.dispatchEvent(new Event(ClickAbleAlphaBitmapEvent.ALPHA_CLICK));
			}
		}
		protected function checkHand(event:MouseEvent = null):void {
			var isOn:Boolean = isMouseOnNoAlphaPixel;
			if (isOn != lastIsAlpah) {
				if (isOn == true) {
					onNoAlphaOver();
				}else {
					onNoAlphaOut();
				}
			}
			if (isOn == true && _ableHandCursor == true) {
				this.buttonMode = true;
				this.useHandCursor = true;
			}else {
				this.buttonMode = false;
				this.useHandCursor = false;
			}
			lastIsAlpah = isOn;
		}
		protected function onNoAlphaOver():void {
			this.filters = _filters;
			this.dispatchEvent(new Event(ClickAbleAlphaBitmapEvent.NO_ALPHA_OVER));
		}
		protected function onNoAlphaOut():void {
			this.filters = [];
			this.dispatchEvent(new Event(ClickAbleAlphaBitmapEvent.NO_ALPHA_OUT));
		}
		protected function showOut(event:MouseEvent):void {
			this.filters = [];
		}
	}

}