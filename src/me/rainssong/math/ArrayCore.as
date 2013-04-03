package   me.rainssong.math
{
	/**
	 * ...
	 * @author Rainssong
	 */
	public class ArrayCore 
	{
		public static const LOWER_CASE_LETTER_ARR:Array =["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z"];
		public static const UPPER_CASE_LETTER_ARR:Array =["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"];
		
		public function ArrayCore() 
		{
			
		}
		
		public static function getIntArray(start:int=0, end:int=100):Array
		{
			var arr:Array = [];
			for (var i:int = start; i <= end; i++ )
			{
				arr.push(i)
			}
			
			return arr;
		}
		
		/**
		 * Randomize an Array/Vector
		 * @param arr Array or Vector
		 * @return Randomized Array
		 */
		
		public static function getRandomizedArray(arr:*):Array
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
		
		
		public static function vectorToArray(vector:*):Array
		{
			var array:Array = new Array();
			var callback:Function = function(item:*, index:int, vector:*):Boolean
			{
				array.push(item);
				return true;
			}
			vector.every(callback);
			return array;
		}
		

		public static function arrayToVector(array:Array):Vector.<*>
		{
			var vec:Vector.<*>=new Vector.<*>();
			vec.push.apply(null, array);
			return vec;
		}
	}

}