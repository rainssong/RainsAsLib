package me.rainssong.display
{
	
	public class LiquidSprite extends SmartSprite
	{
		protected var _actualWidth:Number;
		protected var _actualHeight:Number;
		
		public function LiquidSprite()
		{
			super();
			_actualWidth = super.width;
			_actualHeight = super.height;
			
		}
		
		public function setSize(w:Number=NaN, h:Number=NaN):void
		{
			if (w)w = _actualWidth;
			if (h)h = _actualHeight;
			
			
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
	}
}