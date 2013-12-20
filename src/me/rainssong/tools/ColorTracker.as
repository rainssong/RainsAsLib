package me.rainssong.tools
{
	import flash.display.BitmapData;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import me.rainssong.math.MathCore;
	import me.rainssong.utils.Color;
	
	/**
	 * ...
	 * @author Rainssong
	 */
	public class ColorTracker
	{
		private var _bmd:BitmapData;
		private var _trackPoints:Vector.<Point>;
		private var _trackPoint:Point;
		private var _color:uint;
		
		private var _rect:Rectangle;
		
		public function ColorTracker(bmd:BitmapData = null, color:uint = 0x000000)
		{
			if (bmd)
			{
				_bmd = bmd;
				_rect = new Rectangle(_bmd.width, bmd.height)
			}
			
			_color = color;
		
		}
		
		public function get color():uint
		{
			return _color;
		}
		
		public function set color(value:uint):void
		{
			_color = value;
		}
		
		public function get bmd():BitmapData
		{
			return _bmd;
		}
		
		public function set bmd(value:BitmapData):void
		{
			_bmd = value;
			if(bmd)
				_rect = new Rectangle(_bmd.width, bmd.height)
		}
		
		public function get trackPoints():Vector.<Point>
		{
			track();
			return _trackPoints;
		}
		
		public function get trackPoint():Point
		{
			track();
			if (_trackPoints.length > 5)
				return MathCore.averagePoint(_trackPoints);
			else
				return null;
		}
		
		public function get rect():Rectangle
		{
			return _rect;
		}
		
		public function set rect(value:Rectangle):void
		{
			_rect = value;
		}
		
		private function track():void
		{
			if (bmd == null)
				return;
			
			_trackPoints = new Vector.<Point>();
			var w:Number = _bmd.width;
			var h:Number = _bmd.height;
			
			_rect.x = bmd.width;
			_rect.y = bmd.height;
			_rect.width = 0;
			_rect.height = 0;
			
			for (var i:int = 0; i < w; i += 8)
			{
				for (var ii:int = 0; ii < h; ii += 8)
				{
					//var color:uint = _bmd.getPixel(i, ii);
					
					if (Color.isSimilar(_bmd.getPixel(i, ii), _color, 40) && Color.isSimilar(_bmd.getPixel(i + 2, ii), _color, 40) && Color.isSimilar(_bmd.getPixel(i, ii + 2), _color, 40) && Color.isSimilar(_bmd.getPixel(i + 2, ii + 2), _color, 40))
					{
						_trackPoints.push(new Point(i, ii))
						
						if (_rect.x > i)
							_rect.x = i;
						if (_rect.width < (i - _rect.x))
							_rect.width = i - _rect.x;
						if (_rect.y > ii)
							_rect.y = ii;
						if (_rect.height < (ii - _rect.y))
							_rect.height = ii - _rect.y;
						
						if (_trackPoints.length > 2000)
						{
							_trackPoints = new Vector.<Point>();
							return;
						}
					}
				}
			}
		}
		
		public function destroy():void
		{
			_bmd.dispose();
			_trackPoints = null;
		}
	}

}