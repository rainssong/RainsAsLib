package me.rainssong.math
{
	import flash.net.registerClassAlias;
	import flash.text.engine.ElementFormat;
	import flash.utils.Dictionary;
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;
	import me.rainssong.utils.construct;
	import me.rainssong.utils.ObjectCore;
	
	/**
	 * ...
	 * @author Rainssong
	 */
	public class ArrayCore
	{
		public static const LOWER_CASE_LETTER_ARR:Array = ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z"];
		public static const UPPER_CASE_LETTER_ARR:Array = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"];
		public static const UPPER_CASE_LETTER_INDEX_DIC:Object = {"A": 1, "B": 2, "C": 3, "D": 4, "E": 5, "F": 6, "G": 7, "H": 8, "I": 9, "J": 10, "K": 11, "L": 12, "M": 13, "N": 14, "O": 15, "P": 16, "Q": 17, "R": 18, "S": 19, "T": 20, "U": 21, "V": 22, "W": 23, "X": 24, "Y": 25, "Z": 26};
		
		public function ArrayCore()
		{
		
		}
		
		/**
		 * it's more faster than origin concat
		 * @param	arr1
		 * @param	arr2
		 * @return
		 */
		public static function concat(arr1:Array, arr2:Array):Array
		{
			var arr:Array = arr1.slice();
			arr.push.apply(null, arr2);
			return arr;
		}
		
		public static function getIntArray(start:int = 0, end:int = 100):Array
		{
			var arr:Array = [];
			for (var i:int = start; start < end ? (i <= end) : (i >= end); start < end ? i++ : i--)
			{
				arr.push(i)
			}
			return arr;
		}
		
		public static function getContentArray(content:*, length:uint = 0):Array
		{
			var arr:Array = [];
			if (length == 0)
				return arr;
			
			for (var i:int = 0; i < length; i++)
			{
				arr.push(content);
			}
			return arr;
		}
		
		/**
		 *
		 * @param	target Object
		 * @param	fun String or Function
		 */
		static public function forEach(target:Object, fun:*):void
		{
			for each (var t:* in target)
			{
				t[fun]();
			}
		}
		
		/**
		 * Make Copy And Randomize an Array/Vector
		 * @param arr Array or Vector
		 * @return Randomized Array
		 */
		
		public static function getRandomizedArray(arr:*):*
		{
			var outputArr:* = arr.slice();
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
		
		/**
		 * 冒泡乱序，轻度打乱数组
		 * @param	arr
		 * @param	times
		 * @return
		 */
		public static function getLightRandomizedArray(arr:Array, times:int = 1):Array
		{
			var outputArr:Array = arr.slice();
			var length:int = outputArr.length
			for (var i:int = 0; i < length - 1; i++)
			{
				if (Math.random() > 0.5)
				{
					var temp:* = outputArr[i];
					outputArr[i] = outputArr[i + 1];
					outputArr[i + 1] = temp;
				}
			}
			return outputArr;
		}
		
		public static function switchElements(arr:Array, index1:int, index2:int):void
		{
			var elementA:Object = arr[index1];
			arr[index1] = arr[index2];
			arr[index2] = elementA;
		}
		
		public static function sum(arr:*):Number
		{
			var nSum:Number = 0;
			for (var i:Number = 0; i < arr.length; i++)
			{
				if (typeof(arr[i]) == "number")
				{
					nSum += arr[i];
				}
			}
			return nSum;
		}
		
		public static function average(aArray:Array):Number
		{
			return sum(aArray) / aArray.length;
		}
		
		public static function max(arr:Array):Number
		{
			var aCopy:Array = arr.concat();
			aCopy.sort(Array.NUMERIC);
			var nMaximum:Number = Number(aCopy.pop());
			return nMaximum;
		}
		
		public static function min(arr:Array):Number
		{
			var aCopy:Array = arr.concat();
			aCopy.sort(Array.NUMERIC);
			var nMinimum:Number = Number(aCopy.shift());
			return nMinimum;
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
		
		//public static function switchElements(aArray:Array, nIndexA:Number, nIndexB:Number):void 
		//{
		//var oElementA:Object = aArray[nIndexA];
		//var oElementB:Object = aArray[nIndexB];
		//aArray.splice(nIndexA, 1, oElementB);
		//aArray.splice(nIndexB, 1, oElementA);
		//}
		
		public static function arrayToVector(array:Array):Vector.<*>
		{
			return Vector.<*>(array);
		}
		
		//public static function isVector(obj:*):Boolean
		//{
		//return obj.constructor.toString().search("Vector") >= 0;
		//}
		
		public static function isVector(value:*):Boolean
		{
			return value && (value is Vector.<*> || value is Vector.<int> || value is Vector.<uint> || value is Vector.<Number>);
		}
		
		public static function fillWith(aov:*, element:*, transfer:Boolean = true, params:Array = null):void
		{
			try
			{
				var i:int = 0;
				if (transfer && element is Class)
				{
					for (i = 0; i < aov.length; i++)
						aov[i] = construct(element, params);
				}
				else if (transfer && element is Function)
				{
					for (i = 0; i < aov.length; i++)
						aov[i] = element.apply(null, params)
				}
				else
				{
					for (i = 0; i < aov.length; i++)
						aov[i] = element;
				}
			}
			catch (e:Error)
			{
				powerTrace("failed!");
			}
		}
		
		/**
		 * get common elements
		 * @param	array1
		 * @param	array2
		 * @return
		 */
		public static function intersect(array1:Array, array2:Array):Array
		{
			var results:Array = [];
			
			for (var i:int = 0, l:int = array1.length; i < l; i++)
			{
				var item1:* = array1[i];
				
				for (var ii:int = 0, ll:int = array2.length; ii < ll; ii++)
				{
					var item2:* = array2[ii];
					
					if (item1 == item2)
					{
						results.push(item1);
						break;
					}
				}
			}
			
			return results;
		}
		
		/**
		 * subtract array2 from array1
		 * @param	array1
		 * @param	array2
		 * @return
		 */
		public static function subtract(array1:Array, array2:Array):Array
		{
			var results:Array = [];
			
			for (var i:int = 0, l:int = array1.length; i < l; i++)
			{
				var item1:* = array1[i];
				var exist:Boolean = false;
				
				for (var ii:int = 0, ll:int = array2.length; ii < ll; ii++)
				{
					var item2:* = array2[ii];
					
					if (item1 == item2)
					{
						exist = true;
						break;
					}
				}
				
				if (exist)
				{
					continue;
				}
				
				results.push(item1);
			}
			
			return results;
		}
		
		/**
		 * delete empty elements from array
		 * @param	array
		 * @return
		 */
		public static function compress(array:Array):Array
		{
			var result:Array = [];
			
			for (var i:int = 0, l:int = array.length; i < l; i++)
			{
				var item:* = array[i];
				
				switch (item)
				{
					case undefined: 
					case null: 
					case "": 
					{
						continue;
					}
				}
				
				result.push(item);
			}
			
			return result;
		}
		
		public static function equals(array1:*, array2:*):Boolean
		{
			
			if (array1 == array2)
					return true;
					
			if (array1.length != array2.length)
			{
				return false;
			}
			
			for (var i:int = 0, l:int = array1.length; i < l; i++)
			{
				if (array1[i] !== array2[i])
				{
					return false;
				}
			}
			
			return true;
		}
		
		public static function merge(arr1:Array, arr2:Array):Array
		{
			var arr:Array = arr1.slice();
			for (var i:int = 0; i < arr2.length; i++)
			{
				if (arr.indexOf(arr2[i]) >= 0)
					continue;
				else
					arr.push(arr2[i]);
			}
			
			return arr;
		}
		
		/**
		 * select String to get stringArr. select arr to get  objectArr
		 * @param	param
		 * @param	arr
		 * @return
		 */
		public static function select(param:*, objectArr:Array):Array
		{
			var result:Array = [];
			
			for (var i:int = 0; i < objectArr.length; i++)
			{
				
				if (param is String)
				{
					result[i] = objectArr[i][param];
				}
				if (param is Array)
				{
					result[i] = {};
					for (var j:int = 0; j < param.length; j++)
					{
						result[i][param[j]] = objectArr[i][param[j]];
					}
				}
			}
			return result;
		}
		
		static public function removeByElement(arr:Array, element:Object):void
		{
			if (arr.indexOf(element) > -1)
				arr.splice(arr.indexOf(element), 1);
		}
		
		static public function clone(aov:*):*
		{
			if (isVector(aov))
			{
				var className:String = getQualifiedClassName(aov);
				var cls:Class
				try
				{
					cls = getDefinitionByName(className) as Class;
				}
				catch (e:Error)
				{
					return null;
				}
				registerClassAlias(className, cls);
				
				var v:* = new cls;
				
				for (var i:int = 0; i < aov.length; i++)
				{
					v.push(aov[i]);
				}
				return v;
			}
			else if (aov is Array)
			{
				var a:Array = [];
				for (i = 0; i < aov.length; i++)
				{
					a.push(aov[i]);
				}
				return a;
			}
			else
			{
				throw new Error("param is not Array or Vector:" + aov);
			}
		}
	
	}

}