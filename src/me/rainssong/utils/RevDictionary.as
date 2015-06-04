package me.rainssong.utils
{
	import flash.utils.Dictionary;
	import flash.utils.flash_proxy;
	import flash.utils.Proxy;
	
	/**
	 * ...
	 * @author Rainssong
	 */
	
	use namespace flash_proxy;
	
	public dynamic class RevDictionary extends Proxy
	{
		 private var _dic:Dictionary;
		 private var _revDic:Dictionary;
		
		public function RevDictionary(weakKeys:Boolean=false)
		{
			_dic = new Dictionary(weakKeys);
			_revDic = new Dictionary(weakKeys);
		}
		
		public function setValue(key:*, value:*):void
		{
			_revDic[_dic[key]] = undefined;
			
			_dic[key] = value;
			
			_revDic[value] = key;
		}
		
		public function getKey(value:*):*
		{
			return _revDic[value] ;
		}
		
		public function getRevValue(value:*):*
		{
			return _revDic[value] ;
		}
		
		public function getValue(key:*):*
		{
			return _dic[key];
		}
		
		public function deleteKey(key:*):void
		{
			_dic[key] = undefined;
			_revDic[_dic[key]] = undefined;
		}
		
		public function deleteValue(value:*):void
		{
			_revDic[value] = undefined;
			_dic[_revDic[value]] = undefined;
		}
		
		override flash_proxy function deleteProperty(name:*):Boolean 
		{
			_revDic[_dic[name]] = undefined;
			_dic[name] = undefined;
			return true;
		}
		
		/**
		 * 注意：使用此方法将不支持复杂对象作为键
		 * @param	name
		 * @param	value
		 */
		override flash_proxy function setProperty(name:*, value:*):void 
		{
			powerTrace("注意：使用此方法将不支持复杂对象作为键");
			setValue(name, value);
		}
		
		
		 flash_proxy override function getProperty(name:*):*
		{
			powerTrace("注意：使用此方法将不支持复杂对象作为键");
			return _dic[name] ;
		}
		
	}

}