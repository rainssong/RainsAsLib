package   me.rainssong.math
{
	/**
	 * ...
	 * @author Rainssong
	 */
	public class ArrayCore 
	{
		
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
	}

}