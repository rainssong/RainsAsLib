package me.rainssong.math
{
	import flash.display.SimpleButton;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import me.rainssong.utils.ObjectCore;
	
	public final class MathCore
	{
		static public const DEGREE_RADIAN_RATIO:Number = 180/Math.PI;
		static public const RADIAN_DEGREE_RATIO:Number = Math.PI/180;
		
		public static function getRandomNumber(min:Number, max:Number):Number
		{
			return Math.random() * (max - min) + min;
		}
		
		public static function getRandomInt(min:int, max:int):int
		{
			return Math.floor(Math.random() * (max - min+1) + min);
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
			if (isNaN(min))
				min = -Infinity;
			if (isNaN(max))
				max = Infinity;
			
			return Math.max(min, Math.min(number, max));
		}
		
		/**
		 * 值在circle内循环，算角度时可用
		 * @param	number
		 * @param	cycle
		 * @return
		 */
		public static function getCycledNumber(number:Number, a:Number, b:Number = 0):Number
		{
			var min:Number = Math.min(a, b);
			var max:Number = Math.max(a, b);
			var distance:Number = max - min;
			var value:Number = number % distance;
			while (value < min)
				value += distance;
			while (value > max)
				value -= distance;
			return value;
		}
		
		public static function stepRadian(targetRadian:Number, currentRadian:Number, step:Number = Math.PI / 180, absolute:Boolean = true):Number
		{
			//return stepDegree(targetRadian * MathCore.DEGREE_RADIAN_RATIO, currentRadian * MathCore.DEGREE_RADIAN_RATIO, absolute?step*MathCore.DEGREE_RADIAN_RATIO:step, absolute);
			var distance:Number = targetRadian - currentRadian;
				
			while (distance >= Math.PI)
				distance = distance-Math.PI*2;
			while (distance <= -Math.PI)
				distance = Math.PI*2 + distance;

			if(absolute)
				distance = getRangedNumber(distance, -step, step);
			else
				distance = step * distance;
			
			return currentRadian+distance;
		}
		
		public static function stepDegree(tagertDegree:Number,currentDegree:Number,step:Number=1,absolute:Boolean=true):Number
		{
			var degreeDistance:Number = tagertDegree - currentDegree;
				
			while (degreeDistance >= 180)
				degreeDistance = degreeDistance-360;
			while (degreeDistance <= -180)
				degreeDistance = 360 + degreeDistance;

			if(absolute)
				degreeDistance = getRangedNumber(degreeDistance, -step, step);
			else
				degreeDistance = step * degreeDistance;
			
			return currentDegree+degreeDistance;
		}
		
		public static function stepNumber(target:Number,current:Number,stepValue:Number=1,stepPercent:Number=0,minDis:Number=1):Number
		{
			var dis:Number = target - current;
			stepValue *= dis > 0?1: -1;
			var step:Number = dis * stepPercent + stepValue;
			if ((dis-step)<=minDis && (dis-step)>=-minDis)
				return target;
			else
				return current+step;
		}
		
		public static function smartAtan2(y:Number,x:Number):Number
		{
			if (x == 0) x = 0.0001;
			return Math.atan2(y, x);
		}
		
		/**设置rect，兼容player10*/
		public static function setRect(rect:Rectangle, paramObj:Object = null):Rectangle
		{
			ObjectCore.setData(rect, paramObj)
			return rect;
		}
		
		/**
		 * 计算objTarget相对于objOrigin的弧度
		 * @param	objOrigin
		 * @param	objTarget
		 * @return
		 */
		public static function getPointRadians(objTarget:*, objOrigin:* = null):Number
		{
			if (objOrigin == null)
				objOrigin = new Point();
			if (objTarget == null)
				objTarget = new Point();
			
			if (objTarget.x - objOrigin.x == 0)
			{
				if (objTarget.y - objOrigin.y > 0)
					return Math.PI / 2;
				else if (objTarget.y - objOrigin.y == 0)
					return 0;
				else
					return -Math.PI / 2;
			}
			else
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
		
		public static function isEven(number:Number):Boolean
		{
			
			return (number & 1) == 0;
		}
		
		public static function averagePoint(points:Vector.<Point>):Point
		{
			if (!points.length)
				return null;
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
		 * 获得包含多个举行的一个更大的矩形
		 *
		 * @param rects
		 *
		 * @return
		 */
		//public static function getBoundsRect(rects:Vector.<Rectangle>):Rectangle
		//{
		//if(rects == null)
		//{
		//return null;
		//}
		//else
		//{
		//var rect:Rectangle = null;
		//var length:uint = rects.length;
		//for(var i:uint = 0; i < length; i++)
		//{
		//var newRect:Rectangle = getBoundsRect(rect, rects[i]);
		//rect = newRect == null ? null : newRect.clone();
		//}
		//
		//return rect;
		//}
		//}
		
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
				if (rect1.x <= rect2.x)
				{
					if (xDist <= rect1.width)
					{
						xOK = true;
					}
				}
				else
				{
					if (-xDist <= rect2.width)
					{
						xOK = true;
					}
				}
				
				if (xOK)
				{
					var yDist:Number = rect2.y - rect1.y;
					if (rect1.y <= rect2.y)
					{
						if (yDist <= rect1.height)
						{
							return true;
						}
					}
					else
					{
						if (-yDist <= rect2.height)
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