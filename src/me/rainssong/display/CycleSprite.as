package   me.rainssong.display
{
	import flash.display.BitmapData;
	import flash.geom.Rectangle;
	import me.rainssong.display.TiledSprite;
	
	/**
	 * ...
	 * @author Rainssong
	 */
	public class CycleSprite extends TiledSprite 
	{
		private var _scrollX:Number;
		private var _scrollY:Number;
		
		public function CycleSprite(bitmapData:BitmapData, width:Number=0, height:Number=0) 
		{
			if (width <= 0) width = bitmapData.width;
			if (height <= 0) height = bitmapData.height;
			super(bitmapData, width, height);
			scrollRect = new Rectangle(0, 0, width, height);
		}
		
		override protected function redraw():void 
		{
			graphics.clear();
			graphics.beginBitmapFill(_bitmapData);
			graphics.drawRect(0, 0, _actucalWidth+_bitmapData.width, _actucalHeight+_bitmapData.height);
		}
		
		public function get scrollX():Number
		{
			return _scrollX;
		}
		
		public function set scrollX(value:Number):void
		{
			scrollRect = new Rectangle(value, scrollRect.y, scrollRect.width, scrollRect.height);
		}
		
		public function get scrollY():Number
		{
			return _scrollY;
		}
		
		public function set scrollY(value:Number):void
		{
			scrollRect = new Rectangle(scrollRect.x, value, scrollRect.width, scrollRect.height);
		}
		
		override public function get scrollRect():Rectangle
		{
			if (super.scrollRect)
			{
				var sr:Rectangle=super.scrollRect
				sr.x = _scrollX;
				sr.y = _scrollY;
				return sr;
			}
			else 
				return null;
		}
		
		override public function set scrollRect(value:Rectangle):void
		{
			
 			value.x = value.x % bitmapData.width ;
			value.y = value.y % bitmapData.height ;
			if (value.x < 0)
				value.x += bitmapData.width ;
			if (value.y < 0)
				value.y += bitmapData.height;
			
			_scrollX = value.x;
			_scrollY = value.y;
			
			if (value.width > _actucalWidth || value.height > _actucalHeight)
				redraw();
			super.scrollRect = value;
			
		}
	}

}