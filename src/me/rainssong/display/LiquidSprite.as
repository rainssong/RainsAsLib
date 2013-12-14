package me.rainssong.display
{
	
	public class LiquidSprite extends SmartSprite
	{
		protected var _actualWidth:Number;
		protected var _actualHeight:Number;
		protected var _originalWidth:Number;
		protected var _originalHeight:Number;
		
		
		public function LiquidSprite(w:Number=0,h:Number=0)
		{
			super();
			
			_originalWidth = w;
			_originalHeight = h;
			_actualWidth =w;
			_actualHeight = h;
			//if (!_actualHeight)_actualHeight = super.height;
			//if (!_actualWidth)_actualWidth = super.width;
			//if (w || h) setSize(w, h);
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
		
		override public function set  scaleX (value:Number):void 
		{
			_actualWidth = _originalWidth * value;
		}
		
		override public function get scaleY():Number 
		{
			return _actualHeight/_originalHeight;
		}
		
		override public function set  scaleY (value:Number):void 
		{
			_actualWidth = _originalHeight * value;
		}
		
		override public function set scaleXY(value:Number):void 
		{
			scaleX = scaleY = value;
		}
		
		
		public function get minScale():Number
		{
			return scaleX > scaleY?scaleY:scaleX;
		}
		
		public function get maxScale():Number
		{
			return scaleX > scaleY?scaleX:scaleY;
		}
	}
}