package  me.rainssong.tools
{
	import flash.display.BitmapData;
	import flash.geom.Point;
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
		public function ColorTracker(bmd:BitmapData,color:uint=0x000000) 
		{
			_bmd = bmd;
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
		}
		
		public function get trackPoints():Vector.<Point> 
		{
			track();
			return _trackPoints;
		}
		
		public function get trackPoint():Point 
		{
			track();
			if(_trackPoints.length>5)
				return MathCore.averagePoint(_trackPoints);
			else
				return null;
		}
		
		private function track():void
		{
			_trackPoints = new Vector.<Point>();
			var w:Number = _bmd.width;
			var h:Number = _bmd.height;
			
			for (var i:int = 0; i < w; i += int(w/30))
			{
				for (var ii:int = 0; ii < h; ii += int(h/30))
				{
					var color:uint = _bmd.getPixel(i, ii);
					
					if (Color.isSimilar(color, _color, 40))
					{
						_trackPoints.push(new Point(i, ii))
					}
				}
			}
		}
	}

}