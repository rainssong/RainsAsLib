package
{
	import com.greensock.BlitMask;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	/**
	 * 
	 * @author Rainssong
	 * 2013-7-17
	 */
	public class CycleBitmap extends Bitmap
	{
		private var _scrollX:Number = 0;
		private var _scrollY:Number = 0;
		
		public function CycleBitmap(bitmapData:BitmapData = null, pixelSnapping:String = "auto", smoothing:Boolean = false)
		{
			var bmd:BitmapData = new BitmapData(bitmapData.width * 2, bitmapData.height * 2);
			bmd.copyPixels(bitmapData, new Rectangle(0, 0, bitmapData.width, bitmapData.height), new Point());
			bmd.copyPixels(bitmapData, new Rectangle(0, 0, bitmapData.width, bitmapData.height), new Point(bitmapData.width));
			bmd.copyPixels(bitmapData, new Rectangle(0, 0, bitmapData.width, bitmapData.height), new Point(0, bitmapData.height));
			bmd.copyPixels(bitmapData, new Rectangle(0, 0, bitmapData.width, bitmapData.height), new Point(bitmapData.width, bitmapData.height));
			
			super(bmd, pixelSnapping, smoothing);
			super.scrollRect = new Rectangle(0, 0, bitmapData.width, bitmapData.height)
		
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
		
		override public function get scrollRect():flash.geom.Rectangle
		{
			return new Rectangle(_scrollX, _scrollY, super.scrollRect.width, super.scrollRect.height);
		}
		
		override public function set scrollRect(value:Rectangle):void
		{
			value.x = value.x % (bitmapData.width >> 1);
			value.y = value.y % (bitmapData.height >> 1);
			if (value.x < 0)
				value.x += (bitmapData.width >> 1);
			if (value.y < 0)
				value.y += (bitmapData.height >> 1);
			
			_scrollX = value.x;
			_scrollY = value.y;
			super.scrollRect = value;
			
		}
	
	}

}