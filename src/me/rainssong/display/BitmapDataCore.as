package me.rainssong.display
{
	import flash.display.BitmapData;
	import flash.display.IBitmapDrawable;
	import flash.display.MovieClip;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import me.rainssong.math.MathCore;
	
	/**
	 * ...
	 * @author Rainssong
	 */
	public class BitmapDataCore
	{
		
		public function BitmapDataCore()
		{
		
		}
		
		/**获取9宫格拉伸位图数据*/

		public static function scale9Bmd(bmd:BitmapData, rect:Rectangle, width:int, height:int):BitmapData
		{
			i
			
			if (bmd.width == width && bmd.height == height)
			{
				return bmd;
			}
			
			var m:Matrix = new Matrix();
			var newRect:Rectangle = new Rectangle();
			var clipRect:Rectangle = new Rectangle();
			var grid:Rectangle = rect
			
			
			width = width > 1 ? width : 1;
			height = height > 1 ? height : 1;
			

			var gw:Number = grid.width;
			var gh:Number = grid.height;
			
			var newBmd:BitmapData = new BitmapData(width, height, bmd.transparent, 0x00000000);
			//如果目标大于九宫格，则进行9宫格缩放，否则直接缩放
			if (width > (bmd.width-gw) && height > (bmd.height-gh))
			{
				var rows:Array = [0, grid.top, grid.bottom, bmd.height];
				var cols:Array = [0, grid.left, grid.right, bmd.width];
				var newRows:Array = [0, grid.top, height - (bmd.height - grid.bottom), height];
				var newCols:Array = [0, grid.left, width - (bmd.width - grid.right), width];
				for (var i:int = 0; i < 3; i++)
				{
					for (var j:int = 0; j < 3; j++)
					{
						
						MathCore.setRect(newRect, {x:cols[i], y:rows[j], width:cols[i + 1] - cols[i], height:rows[j + 1] - rows[j]});
						MathCore.setRect(clipRect, {x:newCols[i], y:newRows[j], width:newCols[i + 1] - newCols[i], height:newRows[j + 1] - newRows[j]});
						m.identity();
						m.a = clipRect.width / newRect.width;
						m.d = clipRect.height / newRect.height;
						m.tx = clipRect.x - newRect.x * m.a;
						m.ty = clipRect.y - newRect.y * m.d;
						newBmd.draw(bmd, m, null, null, clipRect, true);
						
					}
					//return newBmd;
				}
			}
			else
			{
				//m.identity();
				//m.scale(width / bmd.width, height / bmd.height);
				//MathCore.setRect(grid, {x:0, y:0, width:width, height:height});
				newBmd = drawResizeBmd(bmd, width, height);
				
				//newBmd.draw(bmd, m, null, null, grid, true);
			}
			return newBmd;
		}
		
		/**创建切片资源*/
		public static function createClips(bmd:BitmapData, xNum:int, yNum:int):Vector.<BitmapData>
		{
			if (bmd == null)
			{
				return null;
			}
			var clips:Vector.<BitmapData> = new Vector.<BitmapData>();
			var width:int = Math.max(bmd.width / xNum, 1);
			var height:int = Math.max(bmd.height / yNum, 1);
			var point:Point = new Point();
			for (var i:int = 0; i < yNum; i++)
			{
				for (var j:int = 0; j < xNum; j++)
				{
					var item:BitmapData = new BitmapData(width, height);
					item.copyPixels(bmd, new Rectangle(j * width, i * height, width, height), point);
					clips.push(item);
				}
			}
			return clips;
		}
		
		public static function drawResizeBmd(source:IBitmapDrawable, width:int = 8, height:int = 8):BitmapData
		{
			
			var newData:BitmapData = new BitmapData(width, height, true, 0);
			var matrix:Matrix = new Matrix();
			matrix.scale(newData.width / source["width"], newData.height / source["height"]);
			newData.draw(source, matrix);
			
			return newData;
		}
		
		public static function drawScaleBmd(source:IBitmapDrawable, scaleX:Number = 1, scaleY:Number = 1):BitmapData
		{
			var bmd:BitmapData = new BitmapData(Math.round(source["width"] * scaleX), Math.round(source["height"] * scaleY), true, 0x00FFFFFF);
			bmd.draw(source, new Matrix(scaleX, 0, 0, scaleY, 0, 0));
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
		
		public static function arrToBmd(arr:Array, scale:Number = 1):BitmapData
		{
			var bmd:BitmapData = new BitmapData(arr[0].length, arr.length, true, 0);
			for (var i:int = 0; i < bmd.height; i++)
			{
				for (var j:int = 0; j < bmd.width; j++)
				{
					if (arr[i][j])
						bmd.setPixel32(j, i, arr[i][j]);
				}
			}
			if (scale != 1)
				bmd = drawScaleBmd(bmd, scale, scale);
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