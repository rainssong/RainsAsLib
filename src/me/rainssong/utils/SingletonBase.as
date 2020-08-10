package me.rainssong.utils 
{
	
	/**
	 * @date 2019-01-07 19:38
	 * @author Rainssong
	 * @blog http://blog.sina.com.cn/rainssong
	 * @homepage http://rainsgameworld.sinaapp.com
	 * @weibo http://www.weibo.com/rainssong
	 */
	public class SingletonBase 
	{
		private static var _instance:SingletonBase;
		private var _createLock :Boolean = true;
		
		public static function getInstance():SingletonBase 
		{
			if (_instance == null)
			{
				_createLock = false;
				_instance = this;
				_createLock = true;
			}
			return _instance;
		}
		
		public function SingletonBase() 
		{
			if (_createLock)
				throw new Error("Singleton");
		}
		
	}

}