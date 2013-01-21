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
			resortArr.sort.apply(null,args);
			superTrace("new resortArr:" + resortArr);
			return String(resortArr);
		}
		
	}

}