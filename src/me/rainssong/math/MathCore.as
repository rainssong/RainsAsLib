package me.rainssong.math
{
	import flash.display.SimpleButton;
	import flash.geom.Point;
	
	public final class MathCore
	{
		
		public static function getRandomNumber(min:Number, max:Number):Number
		{
			return Math.random() * (max - min) + min;
		}
		
		public static function getRandomInt(min:int, max:int):int
		{
			return Math.round(Math.random() * (max - min) + min);
		}
		
		/**
		 * 得到一个顺序整数组成的数组
		 * @param	startInt 起始值
		 * @param	endInt 结束值
		 * @return 整数组成的数组
		 */
		public static function getIntVector(startInt:int = 0, endInt:int = 99):Vector.<int>
		{
			var outArr:Vector.<int> = new Vector.<int>();
			var isPlus:Boolean = startInt < endInt ? true : false;
			while (startInt <= endInt)
			{
				outArr.push(startInt);
				startInt += isPlus ? 1 : -1;
			}
			return outArr;
		}
		
		public static function getRangedNumber(number:Number, min:Number, max:Number = Infinity):Number
		{
			if (min > max)
			{
				var tmp:Number = min;
				min = max;
				max = tmp;
			}
			
			return Math.max(min, Math.min(number, max));
		}
		
		/**
		 * 值在0-circle内循环，算角度时可用
		 * @param	number
		 * @param	cycle
		 * @return
		 */
		public static function getCycledNumber(number:Number, a:Number, b:Number=0):Number
		{
			var min:Number = Math.min(a, b);
			var max:Number = Math.max(a, b);
			var distance:Number=max - min;
			var value:Number = number % distance;
			if(value<min)value += distance;
			if(value>max)value -= distance;
			return value;
		}
		
		/**
		 * 计算objTarget相对于objOrigin的弧度
		 * @param	objOrigin
		 * @param	objTarget
		 * @return
		 */
		public static function getPointRadians(objOrigin:*, objTarget:*):Number
		{
			return Math.atan2(objTarget.y - objOrigin.y, objTarget.x - objOrigin.x)
		}
		
		public static function radiansToDegree(radians:Number):Number
		{
			return radians / Math.PI * 180;
		}
		
		public static function degreeToRadians(degree:Number):Number
		{
			return degree * Math.PI / 180;
		}
		
		public static function randomSelect(aov:*):*
		{
			return aov[int(aov.length * Math.random())];
		}
		
		public static function isEven( number:Number ):Boolean {
			
			return (number & 1) == 0;
		}
		
		public static function averagePoint(points:Vector.<Point>):Point
		{	
			if (!points.length) return null;
			var point:Point = new Point();
			
			for each (var p:Point in points)
			{
				point.x += p.x;
				point.y += p.y;
			}
			point.x /= points.length;
			point.y /= points.length;
			return point;
		}
		
		/**
		 * 获得包含多个举行的一个更大的举行
		 * 
		 * @param rects
		 * 
		 * @return 
		 */
		public static function getBoundsRect(rects:Vector.<Rectangle>):Rectangle
		{
			if(rects == null)
			{
				return null;
			}
			else
			{
				var rect:Rectangle = null;
				var length:uint = rects.length;
				for(var i:uint = 0; i < length; i++)
				{
					var newRect:Rectangle = getBoundsRectangle(rect, rects[i]);
					rect = newRect == null ? null : newRect.clone();
				}
					
				return rect;
			}
		}
		
		/**
		 * 判断联个矩形是否相交
		 * 
		 * @param	rect1
		 * @param	rect2
		 * 
		 * @return
		 */
		public static function rectHitTest(rect1:Rectangle, rect2:Rectangle):Boolean
		{
			if (rect1 == null || rect2 == null)
			{
				return false;
			}
			else
			{
				var xOK:Boolean = false;
				var xDist:Number = rect2.x - rect1.x;
				if(rect1.x <= rect2.x)
				{
					if(xDist <= rect1.width)
					{
						xOK = true;
					}
				}
				else
				{
					if(-xDist <= rect2.width)
					{
						xOK = true;
					}
				}
				
				if(xOK)
				{
					var yDist:Number = rect2.y - rect1.y;
					if(rect1.y <= rect2.y)
					{
						if(yDist <= rect1.height)
						{
							return true;
						}
					}
					else
					{
						if(-yDist <= rect2.height)
						{
							return true;
						}
					}
				}
				
				return false;
			}
		}
		
		
	
	}
}