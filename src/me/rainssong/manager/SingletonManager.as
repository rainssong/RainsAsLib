package me.rainssong.manager
{
	import br.com.stimuli.loading.BulkLoader;
	import flash.net.SharedObject;
	import flash.utils.Dictionary;
	
	import me.rainssong.manager.EventBus;
	
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
		
		public static function get eventBus():EventBus
		{
			return getSingleton(EventBus);
		}
		
		
		public static function get bulkLoader():BulkLoader
		{
			return getSingleton(BulkLoader) as BulkLoader;
		}
		
		
		public static function get sharedObject():SharedObject
		{
			return SharedObject.getLocal("");
		}
		
	}

}