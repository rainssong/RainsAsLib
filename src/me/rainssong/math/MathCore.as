package me.rainssong.math
{
	import flash.display.SimpleButton;
	
	public class MathCore extends Math
	{
		/**
		* Randomize an Array/Vector
		* @param arr Array or Vector
		* @return randomedVector
		*/
		public static function getRandomizedArray(arr:Array):Array
		{
			var outputArr:Array = arr.slice();
			var i:int = outputArr.length;
			var temp:*;
			var indexA:int;
			var indexB:int;
			
			while (i)
			{
				indexA = i - 1;
				indexB = Math.floor(Math.random() * i);
				i--;
				if (indexA == indexB)
					continue;
				temp = outputArr[indexA];
				outputArr[indexA] = outputArr[indexB];
				outputArr[indexB] = temp;
			}
			
			return outputArr;
		}
		
		public static function getRandomNumber(min:Number = -Infinity, max:Number = Infinity):Number
		{
			return random() * (max - min) + min;
		}
		
		public static function getIntArray(startInt:int = 0, endInt:int = 99):Array
		{
			var outArr:Array = [];
			while (startInt <= endInt)
			{
				outArr.push(startInt);
				startInt++;
			}
			return outArr;
		}
		
		public static function getRangedNumber(number:Number, min:Number, max:Number):Number
		{
			if (number > max) number = max;
			if (number < min) number = min;
			return number;
		}
	
	}
}