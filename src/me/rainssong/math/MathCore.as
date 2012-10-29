package me.rainssong.math
{
	
	public class MathCore extends Math
	{
		public static function getRandomArray(arr:Array):Array
		{
			return [];
		}
		
		public static function getRangeNumber(value:Number, min:Number = -Infinity, max:Number = Infinity):Number
		{
			return 0;
		}
		
		public static function getIntArray(startInt:int=0,endInt:int=99):Array
		{
			var outArr:Array = [];
			while (startInt<=endInt)
			{
				outArr.push(startInt);
				startInt++;
			}
			
		}
	
	}
}