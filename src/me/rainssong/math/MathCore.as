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
		public static function getCycledNumber(number:Number, cycle:Number):Number
		{
			return (number % cycle + cycle) % cycle;
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
		
		
	
	}
}