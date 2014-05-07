package me.rainssong.utils
{
	import flash.utils.Dictionary;
	
	/**
	 * @version 2014-5-6
	 * @author rainssong
	 */
	public class ObjectPool
	{
		private static var _pool:Dictionary = new Dictionary(true);
		
		private var _template:Class;
		
		private var _list:Array;
		
		public function ObjectPool(value:Class)
		{
			_template = value;
			_list = new Array();
		}
		
		public function getObject(params:Array=null):Object
		{
			if (_list.length > 0)
			{
				return _list.shift();
			}
			return construct(_template, params);
		}
		
		public function returnObject(value:Object):void
		{
			_list.push(value);
		}
		
		public function dispose():void
		{
			_list = null;
			_template = null;
		}
		
		public static function getPool(value:Class):ObjectPool
		{
			if (!_pool[value])
			{
				_pool[value] = new ObjectPool(value);
			}
			return _pool[value];
		}
		
		public static function getObject(cls:Class,params:Array=null):Object
		{
			
			return getPool(cls).getObject();
		}
		
		public static function returnObject(value:Object):void
		{
			return getPool(value.constructor).returnObject(value);
		}
		
		public static function dispose(cls:Class=null):void
		{
			if (cls) getPool(cls).dispose();
			else _pool = new Dictionary(true);
		}
	}
}