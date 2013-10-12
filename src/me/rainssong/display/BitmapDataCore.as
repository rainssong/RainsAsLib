package me.rainssong.display
{
	import flash.display.BitmapData;
	import flash.display.IBitmapDrawable;
	import flash.display.MovieClip;
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
		
		public static function drawResizeBmd(source:IBitmapDrawable, width:int = 8, height:int = 8):BitmapData
		{
			
			var newData:BitmapData = new BitmapData(width, height, true, 0);
			var matrix:Matrix = new Matrix();
			matrix.scale(newData.width / source["width"], newData.height / source["height"]);
			newData.draw(source, matrix);
			
			return newData;
		}
		
		
		public static function drawScaleBmd(source:IBitmapDrawable,scaleX:Number=1,scaleY:Number=1):BitmapData
		{
			var bmd:BitmapData = new BitmapData(Math.round(source["width"]*scaleX), Math.round(source["height"]*scaleY), true, 0x00FFFFFF);
			bmd.draw(source,new Matrix(scaleX,0,0,scaleY,0,0));
			return bmd;
		}
		
		public static function toGray(source:BitmapData):BitmapData
		{
			var result:BitmapData = new BitmapData(source.width, source.height);
			result.lock()
			for (var i:int = 0; i < source.height; i++)
			{
				for (var j:uint = 0; j < source.width; j++)
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
			result.unlock();
			return result;
		}
		
		
		public static function bmdToArr(bmd:BitmapData):Array
		{
			var arr:Array = []
			for (var i:int = 0; i < bmd.height; i++)
			{
				arr[i] = [];
				for (var j:int = 0; j < bmd.width; j++)
				{
					arr[i][j] = bmd.getPixel32(j, i);
				}
			}
			return arr;
		}
		
		public static function arrToBmd(arr:Array,scale:Number=1):BitmapData
		{
			var bmd:BitmapData = new BitmapData(arr[0].length, arr.length,true, 0);
			for (var i:int = 0; i < bmd.height; i++)
			{
				for (var j:int = 0; j < bmd.width; j++)
				{
					if (arr[i][j])
						bmd.setPixel32(j, i, arr[i][j]);
				}
			}
			if (scale != 1) bmd=drawScaleBmd(bmd, scale, scale);
			return bmd;
		}
		
		
		/**
         * MovieClip to Vector.<BitmapData> 
         * @author xiaoyi
         */  
		public static function mcToBmdV(mc:MovieClip, useCenterTranslate:Boolean = false, xOffset:Number = 0, yOffset:Number = 0):Array
		{
			var result:Array = new Array();
			var bmd:BitmapData;
			for (var i:int = 1; i <= mc.totalFrames; i++)
			{
				mc.gotoAndStop(i);
				
				var m:Matrix = new Matrix();
				if (useCenterTranslate)
				{
					m.translate((mc.width + xOffset) / 2, (mc.height + yOffset) / 2);
				}
				
				bmd = new BitmapData(mc.width + xOffset, mc.height + yOffset, true, 0);
				bmd.draw(mc, m);
				result.push(bmd);
			}
			return result;
		}
	
	}

}