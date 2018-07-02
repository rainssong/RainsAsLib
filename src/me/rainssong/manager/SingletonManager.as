package me.rainssong.manager
{
	import br.com.stimuli.loading.BulkLoader;
	import me.rainssong.utils.construct;

	import flash.net.SharedObject;
	import flash.utils.Dictionary;
	
	import me.rainssong.manager.EventBus;
	import me.rainssong.utils.getSingleton;
	
	/**
	 * ...
	 * @author Rainssong
	 */
	public class SingletonManager
	{
		private static var _dictionary:Dictionary = new Dictionary();
		private static var _so:SharedObjectProxy =new  SharedObjectProxy();
		
		public function SingletonManager()
		{
		
		}
		
		public static function getSingleton(Type:Class, params:Array = null):*
		{
			return me.rainssong.utils.getSingleton(Type,params);
		}
		
		public static function get eventBus():EventBus
		{
			return getSingleton(EventBus);
		}
		
		
		public static function get bulkLoader():BulkLoader
		{
			return getSingleton(BulkLoader) as BulkLoader;
		}
		
		
		public static function get sharedObject():SharedObjectProxy
		{
			return _so;
		}
		
		
		CONFIG::air
		public static function get downloadManager():DownloadManager
		{
			return SingletonManager.getSingleton(DownloadManager) as DownloadManager;
		}
	
		
	}

}