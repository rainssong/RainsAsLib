package me.rainssong.display
{
	
	public class LiquidSprite extends SmartSprite
	{
		private var _liquidWidth:Number;
		private var _liquidHeight:Number;
		
		public function LiquidSprite()
		{
			super();
			_liquidWidth = super.width;
			_liquidHeight = super.height;
			
		}
		
		override public function get width():Number 
		{
			return _liquidWidth;
		}
		
		override public function set width(value:Number):void 
		{
			_liquidWidth = value;
		}
		
		override public function get height():Number 
		{
			return _liquidHeight;
		}
		
		override public function set height(value:Number):void 
		{
			_liquidHeight = value;
		}
	}
}