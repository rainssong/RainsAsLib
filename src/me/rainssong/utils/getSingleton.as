package me.rainssong.utils 
{
	import me.rainssong.utils.construct;
	/**
	 * ...
	 * @author Rainssong
	 * @timeStamp 2014/1/20 15:59
	 * @blog http://blog.sina.com.cn/rainssong
	 */
		
		
		public function getSingleton(type:Class, params:Array = null):*
		{
			_dictionary[type] ||=  construct( type, params );
			return _dictionary[type];
		}

}
import flash.utils.Dictionary;

var _dictionary:Dictionary = new Dictionary();