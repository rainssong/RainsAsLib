package  me.rainssong.display
{
	import flash.display.BitmapData;
	import flash.geom.Matrix;
	/**
	 * ...
	 * @author Rainssong
	 */
	public class BitmapDataCore 
	{
		
		public function BitmapDataCore() 
		{
			
		}
		
		public static function resize(source:BitmapData,width:Number = 8, height:Number=8):BitmapData
		{
			var newData:BitmapData = new BitmapData(width,height);
			var matrix:Matrix = new Matrix();
			//缩小至 8x8
			matrix.scale(newData.width/source.width, newData.height/source.height);
			newData.draw(source,matrix);
 
			return newData;
		}
		
		public static function toGray(source:BitmapData):BitmapData
		{
			var result:BitmapData = new BitmapData(source.width,source.height);
			for(var i:int = 0; i < source.height; i++)
			{
				for(var j:uint = 0; j < source.width; j++)
				{
					var color:uint = source.getPixel(i, j);
					var red:uint = (color & 0xFF0000) >> 16;
					var green:uint = (color & 0x00FF00) >> 8;
					var blue:uint = (color & 0x0000FF) >> 0;
					//var bwColor:uint = (red + green + blue) / 3;
					var bwColor:uint = (red * 30 + green * 59 + blue * 11) / 100;
					// puts the average in each channel
					bwColor = (bwColor << 16) + (bwColor << 8) + bwColor; 
					result.setPixel(i, j, bwColor);
				}
			}
			return result;
		}
		
		public static function bmdToArr(bmd:BitmapData):Array
		{
			var arr:Array=[]
			for (var i:int = 0; i < bmd.height; i++ )
			{
				arr[i] = [];
				for (var j:int = 0; j < bmd.width; j++ )
				{
					arr[i][j] = bmd.getPixel32(i, j);
				}
			}
			return arr;
		}
		
		
		public static function arrToBmd(arr:Array):BitmapData
		{
			var bmd:BitmapData = new BitmapData(arr.length - 1, arr[0].length - 1, true);
			for (var i:int = 0; i < bmd.height; i++ )
			{
				for (var j:int = 0; j < bmd.width; j++ )
				{
					bmd.setPixel32(i, j,arr[i][j]);
				}
			}
			return bmd;
		}
		
	}

}