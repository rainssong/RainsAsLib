package com.codeTooth.actionscript.algorithm.pathSearching.base
{
	import com.codeTooth.actionscript.lang.exceptions.IllegalOperationException;
	
	/**
	 * 寻路方向
	 */
	public class SearchingDirection
	{
		//---------------------------------------------------------------------------------------------------------------------------------------------------
		// 常量
		//---------------------------------------------------------------------------------------------------------------------------------------------------
		
		/**
		 * 全方向
		 */
		public static const ALL:SearchingDirection = createInstance(ALL_STRING);
		public static const ALL_STRING:String = "all";
		
		/**
		 * 八方向
		 */
		public static const EIGHT:SearchingDirection = createInstance(EIGHT_STRING);
		public static const EIGHT_STRING:String = "eight";
		
		/**
		 * 四方向
		 */
		public static const FOUR:SearchingDirection = createInstance(FOUR_STRING);
		public static const FOUR_STRING:String = "four";
		
		/**
		 * 通过字符串形式获得寻路方向对象
		 * 
		 * @param	str
		 * 
		 * @return	没有找到返回null
		 */
		public static function getSearchingDirectionByString(str:String):SearchingDirection
		{
			return str == ALL_STRING ? ALL : 
				str == EIGHT_STRING ? EIGHT : 
				str == FOUR_STRING ? FOUR : null;
		}
		
		//---------------------------------------------------------------------------------------------------------------------------------------------------
		// 静态创建
		//---------------------------------------------------------------------------------------------------------------------------------------------------
		
		private var _type:String = null;
		
		public function SearchingDirection(type:String)
		{
			if (!_allowInstance)
			{
				throw new IllegalOperationException("Cannot create instance");
			}
			_type = type;
		}
		
		public function toString():String
		{
			return _type;
		}
		
		private static var _allowInstance:Boolean = false;
		
		private static function createInstance(type:String):SearchingDirection
		{
			_allowInstance = true;
			var instance:SearchingDirection = new SearchingDirection(type);
			_allowInstance = false;
			
			return instance;
		}
	}
}