package me.rainssong.utils
{

	
	/**
	 * ...
	 * @author Rainssong
	 */
	public class StringCore
	{
		
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
			superTrace("old resortArr:" + resortArr);
			resortArr.sort.apply(null, args);
			superTrace("new resortArr:" + resortArr);
			return String(resortArr);
		}
		
		public static function isEmpty(str:String) : Boolean
        {
            if (str == null)
            {
                return true;
            }
            return !str.length;
        }
		
		
		
		public static function deleteProtocol(url:String):String
		{
			return url.replace(/[a-zA-z]+:\/\//, "");
		}
		
		public static function getFileName( url:String ):String {
			// Find the location of the period.
			var extensionIndex:Number = filename.lastIndexOf( '.' );
			if ( extensionIndex == -1 ) {
				// Oops, there is no period. Just return the filename.
				return filename;
			} else {
				return filename.substr( 0, extensionIndex );
			} 
		}
		
		public static function getExtension(url:String):String
		{
			return url.split(".").slice(-1)[0];
		}
		
		//static public function webToLocal(url:String):String
		//{
			//return FileCore.File ? FileCore.File.applicationStorageDirectory.resolvePath(StringCore.deleteProtocol(url)).nativePath : null;
		//}
		
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
		
		public static function isNumeric(str:String) : Boolean
        {
            if (str == null)
            {
                return false;
            }
            var exp:RegExp = /^[-+]?\d*\.?\d+(?:[eE][-+]?\d+)?$/;
            return exp.test(str);
        }// end function
		
		 public static function reverseWords(str:String) : String
        {
            if (str == null)
            {
                return "";
            }
            return str.split(/\s+/).reverse().join("");
        }// end function
		
		 public static function reverse(str:String) : String
        {
            if (str == null)
            {
                return "";
            }
            return str.split("").reverse().join("");
        }// end function

		
		//public static function getFileName(url:String):String
		//{
		//return url.split(/[\\/] / ).slice( -1)[0];
		//}
	}
}