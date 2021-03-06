﻿package me.rainssong.utils
{
	
	/**
	 * ...
	 * @author Rainssong
	 */
	public class StringCore
	{
		/**
		 * 换行符
		 */
		public static const NEW_LINE:String = "\r\n";
		
		public static const NEW_LINE_R:String = "\r";
		
		public static const NEW_LINE_N:String = "\n";
		
		/**
		 * Tab
		 */
		public static const TAB:String = "\t";
		
		/**
		 * 行分割符
		 */
		public static const LINE_SEPARATOR:String = " -------------------------------------------------------------------------------------------------- /";
		
		/**
		 * 一个字节所能表示的最大的无符号整数
		 */
		public static const BYTE_MAX:uint = 255;
		
		/**
		 * 两个字节所能表示的最大无符号整数
		 */
		public static const SHORT_MAX:uint = 65535;
		
		/**
		 * 所能使用的最大端口号
		 */
		public static const PORT_MAX:uint = SHORT_MAX;
		
		/**
		 * int类型占用的字节数
		 */
		public static const INT_BYTE_SIZE:uint = 4;
		
		/**
		 * uint类型占用的字节数
		 */
		public static const UINT_BYTE_SIZE:uint = 4;
		
		/**
		 * float类型占用的字节数
		 */
		public static const FLOAT_BYTE_SIZE:uint = 4;
		
		/**
		 * double类型占用的字节数
		 */
		public static const DOUBLE_BYTE_SIZE:uint = 8;
		
		public function StringCore()
		{
		
		}
		
		/**
		 *
		 * @param	str String to sort
		 * @param	args Sort params
		 * @return String after sort
		 * @copy Array
		 */
		public static function sort(str:String, ... args):String
		{
			var resortArr:Array = str.split("");
			powerTrace("old resortArr:" + resortArr);
			resortArr.sort.apply(null, args);
			powerTrace("new resortArr:" + resortArr);
			return String(resortArr);
		}
		
		/**
		 * null or ""
		 * @param	str
		 * @return
		 */
		public static function isEmpty(str:String):Boolean
		{
			if (str == null)
			{
				return true;
			}
			return !str.length;
		}
		
		public function isBlank(s:String = null):Boolean
		{
			var str:String = trim(s);
			var i:int = 0;
			if (str.length == 0)
			{
				return true;
			}
			while (i < str.length)
			{
				if (str.charCodeAt(0) != 32)
				{
					return false;
				}
				i++;
			}
			return true;
		}
		
		public static function isEmail(email:String):Boolean
		{
			var pattern:RegExp = /^[A-Z0-9._%+-]+@(?:[A-Z0-9-]+\.)+[A-Z]{2,4}$/i;
			return email.match(pattern) != null;
		}
		
		/**
		 * Validate as "http://" or "https://".
		 */
		public static function isURL(str:String):Boolean
		{
			return (str.substring(0, 7) == "http://" || str.substring(0, 8) == "https://");
		}
		
		public static function getDomain(str:String):String
		{
			var baseUrl:String = str.split("://")[1].split("/")[0];
			return (baseUrl.substr(0, 4) == "www.") ? baseUrl.substr(4) : baseUrl;
		}
		
		public static function deleteProtocol(url:String):String
		{
			return url.replace(/[a-zA-z]+:\/\//, "");
		}
		
		public static function getFileName(url:String):String
		{
			// Find the location of the period.
			var fullName:String = url.substr(url.lastIndexOf('/') + 1);
			var extensionIndex:Number = fullName.lastIndexOf('.');
			if (extensionIndex == -1)
			{
				// Oops, there is no period. Just return the filename.
				return fullName;
			}
			else
			{
				return fullName.substr(0, extensionIndex);
			}
		}
		
		public static function getExtension(url:String):String
		{
			var result:String = url.split(".").pop();
			result = result.split("?")[0];
			return result;
		}
		
		public static function wordCount(str:String):uint
		{
			if (str == null)
			{
				return 0;
			}
			return str.match(/\b\w+\b/g).length;
		} // end function
		
		public static function trimLeft(str:String):String
		{
			if (str == null)
			{
				return "";
			}
			return str.replace(/^\s+/, "");
		} // end function
		
		public static function trimRight(str:String):String
		{
			if (str == null)
			{
				return "";
			}
			return str.replace(/\s+$/, "");
		} // end function
		
		public static function trim(str:String):String
		{
			if (str == null)
			{
				return "";
			}
			return str.replace(/^\s+|\s+$/g, "");
		} // end function
		
		/**
		 *
		 * @param	str
		 * @return the content between tags
		 */
		public static function stripTags(str:String):String
		{
			if (str == null)
			{
				return "";
			}
			return str.replace(/<\/?[^>]+>/igm, "");
		} // end function
		
		public static function isNumeric(str:String):Boolean
		{
			if (str == null)
			{
				return false;
			}
			var exp:RegExp = /^[-+]?\d*\.?\d+(?:[eE][-+]?\d+)?$/;
			return exp.test(str);
		} // end function
		
		public static function reverseWords(str:String):String
		{
			if (str == null)
			{
				return "";
			}
			return str.split(/\s+/).reverse().join("");
		} // end function
		
		public static function reverse(str:String):String
		{
			if (str == null)
			{
				return "";
			}
			return str.split("").reverse().join("");
		} // end function
		
		static public function webToLocal(url:String):String
		{
			return url.split("://").pop().replace(":", "//");
		}
		
		static public function getRandomChinese():String
		{
			var charNumber:int = int(Math.random() * (0x9000 - 0x5000)) + 0x5000;
			return (String.fromCharCode(charNumber));
		}
		
		static public function toNumber(str:String):Number
		{
			return Number(str.replace(/\D/g, ""));
		}
		
		static public function toPercent(num:Number):String
		{
			var str=Number(num*100).toFixed(1);
			str+="%";
			return str;
		}

		
		//public static function getFileName(url:String):String
		//{
		//return url.split(/[\\/] / ).slice( -1)[0];
		//}
		
		/**
		 *  Substitutes "{n}" tokens within the specified string
		 *  with the respective arguments passed in.
		 *
		 *  Note that this uses String.replace and "$" can have special
		 *  meaning in the argument strings escape by using "$$".
		 *
		 *  @param str The string to make substitutions in.
		 *  This string can contain special tokens of the form
		 *  <code>{n}</code>, where <code>n</code> is a zero based index,
		 *  that will be replaced with the additional parameters
		 *  found at that index if specified.
		 *
		 *  @param rest Additional parameters that can be substituted
		 *  in the <code>str</code> parameter at each <code>{n}</code>
		 *  location, where <code>n</code> is an integer (zero based)
		 *  index value into the array of values specified.
		 *  If the first parameter is an array this array will be used as
		 *  a parameter list.
		 *  This allows reuse of this routine in other methods that want to
		 *  use the ... rest signature.
		 *  For example <pre>
		 *     public function myTracer(str:String, ... rest):void
		 *     {
		 *         label.text += StringUtil.substitute(str, rest) + "\n";
		 *     } </pre>
		 *
		 *  @return New string with all of the <code>{n}</code> tokens
		 *  replaced with the respective arguments specified.
		 *
		 *  @example
		 *
		 *  var str:String = "here is some info '{0}' and {1}";
		 *  trace(StringUtil.substitute(str, 15.4, true));
		 *
		 *  // this will output the following string:
		 *  // "here is some info '15.4' and true"
		 *
		 *  @langversion 3.0
		 *  @playerversion Flash 9
		 *  @playerversion AIR 1.1
		 *  @productversion Flex 3
		 */
		public static function format(str:String, ... rest):String
		{
			if (str == null)
				return '';
			
			// Replace all of the parameters in the msg string.
			var len:uint = rest.length;
			var args:Array;
			if (len == 1 && rest[0] is Array)
			{
				args = rest[0] as Array;
				len = args.length;
			}
			else
			{
				args = rest;
			}
			
			for (var i:int = 0; i < len; i++)
			{
				str = str.replace(new RegExp("\\{" + i + "\\}", "g"), args[i]);
			}
			
			return str;
		}
		
	}
}