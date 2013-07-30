package me.rainssong.display
{
	
	public class LiquidSprite extends SmartSprite
	{
		protected var _actualWidth:Number;
		protected var _actualHeight:Number;
		protected var _originalWidth:Number;
		protected var _originalHeight:Number;
		
		
		public function LiquidSprite()
		{
			super();
			_originalWidth=_actualWidth = super.width;
			_originalHeight=_actualHeight = super.height;
		}
		
		public function setSize(w:Number=NaN, h:Number=NaN):void
		{
			if (!w) w = _actualWidth;
			else _actualWidth=w;
			if (!h) h = _actualHeight;
			else _actualHeight = h;
		}
		
		override public function get width():Number 
		{
			return _actualWidth;
		}
		
		override public function set width(value:Number):void 
		{
			setSize(value);
		}
		
		override public function get height():Number 
		{
			return _actualHeight;
		}
		
		override public function set height(value:Number):void 
		{
			setSize(NaN, value);
		}
		
		override public function get scaleX():Number 
		{
			return _actualWidth/_originalWidth;
		}
		
		override public function get scaleY():Number 
		{
			return _actualHeight/_originalHeight;
		}
		
		public function get minScale():Number
		{
			return Math.min(scaleX, scaleY);
		}
		
		public function get maxScale():Number
		{
			return Math.max(scaleX, scaleY);
		}
		
	}
}