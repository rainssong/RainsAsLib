package   me.rainssong.display
{
	import flash.display.BitmapData;
	import me.rainssong.display.SmartSprite;
	
	/**
	 * ...
	 * @author Rainssong
	 */
	public class TiledSprite extends SmartSprite 
	{
		protected var _bitmapData:BitmapData;
		protected var _actucalWidth:Number;
		protected var _actucalHeight:Number;
		
		public function TiledSprite(bitmapData:BitmapData,width:Number=100,height:Number=100) 
		{
			_bitmapData = bitmapData;
			_actucalWidth = width;
			_actucalHeight = height;
			redraw();
		}
		
		protected function redraw():void 
		{
			graphics.clear();
			graphics.beginBitmapFill(_bitmapData);
			graphics.drawRect(0, 0, _actucalWidth, _actucalHeight);
		}
		
		override public function get width():Number 
		{
			return _actucalWidth
		}
		
		override public function set width(value:Number):void 
		{
			_actucalWidth = value;
			redraw();
		}
		
		override public function get height():Number 
		{
			return _actucalHeight;
		}
		
		override public function set height(value:Number):void 
		{
			_actucalHeight = value;
			redraw();
		}
		
		public function get bitmapData():BitmapData 
		{
			return _bitmapData;
		}
		
		public function set bitmapData(value:BitmapData):void 
		{
			_bitmapData = value;
			graphics.beginBitmapFill(_bitmapData);
			redraw();
		}
		
	}

}