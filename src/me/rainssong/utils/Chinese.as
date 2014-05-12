package me.rainssong.utils
{
	import flash.utils.ByteArray;
	
	/**
	 * 模块功能：
	 * 修改时间：2010-11-16 下午03:08:25
	 * 程序编制：
	 * trace(Chinese.convertChar("中国人").toUpperCase(), Chinese.convertString("中国人"));
	 //--
	 var arr1:Array = ["中国人", "日本人", "韩国人"];
	 trace(arr1);
	 //trace(Chinese.sort(arr1));
	 var arr2:Array = [{label:"中国人2"}, {label:"日本人2"}, {label:"韩国人2"}];
	 trace(arr2);
	 trace(Chinese.sort(arr2, "label"));
	 *
	 */
	public class Chinese
	{
		public function Chinese()
		{
			throw new Error("单例...");
			
		}
		
		/**
		 * 获取一串中文的拼音字母
		 * @param chinese Unicode格式的中文字符串
		 * @return 
		 * 
		 */  
		public static function convertString(chinese:String):String
		{
			var len:int = chinese.length;
			var ret:String = "";
			for (var i:int = 0; i < len; i++)
			{
				ret += convertChar(chinese.charAt(i));
			}
			return ret;
		}
		
		/**
		 * 获取中文第一个字的拼音首字母
		 * @param chineseChar
		 * @return 
		 * 
		 */  
		public static function convertChar(chineseChar:String):String
		{
			var bytes:ByteArray = new ByteArray
			bytes.writeMultiByte(chineseChar.charAt(0), "cn-gb");
			var n:int = bytes[0] << 8;
			n += bytes[1];
			if (isIn(0xB0A1, 0xB0C4, n))
				return "a";
			if (isIn(0XB0C5, 0XB2C0, n))
				return "b";
			if (isIn(0xB2C1, 0xB4ED, n))
				return "c";
			if (isIn(0xB4EE, 0xB6E9, n))
				return "d";
			if (isIn(0xB6EA, 0xB7A1, n))
				return "e";
			if (isIn(0xB7A2, 0xB8c0, n))
				return "f";
			if (isIn(0xB8C1, 0xB9FD, n))
				return "g";
			if (isIn(0xB9FE, 0xBBF6, n))
				return "h";
			if (isIn(0xBBF7, 0xBFA5, n))
				return "j";
			if (isIn(0xBFA6, 0xC0AB, n))
				return "k";
			if (isIn(0xC0AC, 0xC2E7, n))
				return "l";
			if (isIn(0xC2E8, 0xC4C2, n))
				return "m";
			if (isIn(0xC4C3, 0xC5B5, n))
				return "n";
			if (isIn(0xC5B6, 0xC5BD, n))
				return "o";
			if (isIn(0xC5BE, 0xC6D9, n))
				return "p";
			if (isIn(0xC6DA, 0xC8BA, n))
				return "q";
			if (isIn(0xC8BB, 0xC8F5, n))
				return "r";
			if (isIn(0xC8F6, 0xCBF0, n))
				return "s";
			if (isIn(0xCBFA, 0xCDD9, n))
				return "t";
			if (isIn(0xCDDA, 0xCEF3, n))
				return "w";
			if (isIn(0xCEF4, 0xD188, n))
				return "x";
			if (isIn(0xD1B9, 0xD4D0, n))
				return "y";
			if (isIn(0xD4D1, 0xD7F9, n))
				return "z";
			return "\0";
		}
		
		private static function isIn(from:int, to:int, value:int):Boolean
		{
			return ((value >= from) && (value <= to));
		}
		
		/**
		 * 是否为中文 
		 * @param chineseChar
		 * @return 
		 * 
		 */  
		public static function isChinese(chineseChar:String):Boolean
		{
			if (convertChar(chineseChar) == "\0")
			{
				return false;
			}
			return true;
		}
		
		/**
		 * 中文排序 
		 * @param arr 列表数组
		 * @param key 键名(键值数组时使用)
		 * @return 
		 * 
		 */  
		public static function sort(arr:Array, key:String = ""):Array
		{
			var byte:ByteArray = new ByteArray();
			var sortedArr:Array = [];
			var returnArr:Array = [];
			var item:*;
			for each (item in arr)
			{
				if (key == "")
				{
					byte.writeMultiByte(String(item).charAt(0), "gb2312");
				}
				else
				{
					byte.writeMultiByte(String(item[key]).charAt(0), "gb2312");
				} 
			}
			byte.position = 0;
			var len:int = byte.length / 2;
			for (var i:int = 0; i < len; i++)
			{
				sortedArr[sortedArr.length] = {a: byte[i * 2], b: byte[i * 2 + 1], c: arr[i]};
			}
			sortedArr.sortOn(["a", "b"], [Array.DESCENDING | Array.NUMERIC]);
			for each (var obj:Object in sortedArr)
			{
				returnArr[returnArr.length] = obj.c;
			}
			return returnArr;
		}
	}
}