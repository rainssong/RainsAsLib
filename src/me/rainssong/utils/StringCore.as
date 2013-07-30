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
		public static function sort(str:String,...args):String
		{
			var resortArr:Array = str.split("");
			superTrace("old resortArr:" + resortArr);
			resortArr.sort.apply(null, args);
			superTrace("new resortArr:" + resortArr);
			return String(resortArr);
		}
		
		public static function deleteProtocol(url:String):String
		{
			return url.replace(/[a-zA-z]+:\/\// , "");
		}
		
		public static function getExtension(url:String):String
		{
			return url.split("." ).slice( -1)[0];
		}
		
		public static function getFileName(url:String):String
		{
			return url.split(/[\\/] / ).slice( -1)[0];
		}
	}
}