package me.rainssong.display
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
		private var _originBmd:BitmapData
		private var _scrollX:Number = 0;
		private var _scrollY:Number = 0;
		
		public function CycleBitmap(bitmapData:BitmapData = null, pixelSnapping:String = "auto", smoothing:Boolean = false)
		{
			_originBmd = bitmapData;
			super(_originBmd, pixelSnapping, smoothing);
			//super.scrollRect = new Rectangle(0, 0, _originBmd.width, _originBmd.height);
			//if (_originBmd)
				//scrollRect = new Rectangle(0, 0, _originBmd.width, _originBmd.height);
		}
		
	
		
		public function drawBigBmd():BitmapData 
		{   
			if (!_originBmd) return null;
			var bmd:BitmapData = new BitmapData(_originBmd.width * 2, _originBmd.height * 2);
			bmd.copyPixels(_originBmd, new Rectangle(0, 0, _originBmd.width, _originBmd.height), new Point());
			bmd.copyPixels(_originBmd, new Rectangle(0, 0, _originBmd.width, _originBmd.height), new Point(_originBmd.width));
			bmd.copyPixels(_originBmd, new Rectangle(0, 0, _originBmd.width, _originBmd.height), new Point(0, _originBmd.height));
			bmd.copyPixels(_originBmd, new Rectangle(0, 0, _originBmd.width, _originBmd.height), new Point(_originBmd.width, _originBmd.height));
			return bmd;
		}
		
		public function get scrollX():Number
		{
			return _scrollX;
		}
		
		override public function get bitmapData():BitmapData 
		{
			return _originBmd;
		}
		
		override public function set bitmapData(value:BitmapData):void 
		{
			if (_originBmd == value) return;
			_originBmd = value;
			if (value == null)
			{
				super.bitmapData = value;
				return;
			}
			
			_originBmd = value;
			super.bitmapData=drawBigBmd();
			if (!scrollRect)
				scrollRect = new Rectangle(0, 0, _originBmd.width, _originBmd.height);
			
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
			if(super.scrollRect)
				return new Rectangle(_scrollX, _scrollY, super.scrollRect.width, super.scrollRect.height);
			else 
				return null;
		}
		
		override public function set scrollRect(value:Rectangle):void
		{
			
			value.x = value.x % _originBmd.width ;
			value.y = value.y % _originBmd.height ;
			if (value.x < 0)
				value.x += _originBmd.width ;
			if (value.y < 0)
				value.y += _originBmd.height;
			
			_scrollX = value.x;
			_scrollY = value.y;
			super.scrollRect = value;
			
		}
	
	}

}