package me.rainssong.utils
{
	import flash.utils.Dictionary;
	
	/**
	 * ...
	 * @author Rainssong
	 */
	public class SingletonManager
	{
		private static var _dictionary:Dictionary = new Dictionary();
		
		public function SingletonManager()
		{
		
		}
		
		public static function getSingleton(Type:Class):*
		{
			_dictionary[Type] ||= new Type();
			return _dictionary[Type] as Type;
		}
	
	}

}