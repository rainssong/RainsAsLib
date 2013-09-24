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
		
		flash_proxy override function setProperty(name:*, value:*):void
		{
			_revDic[_dic[name]] = undefined;
			
			_dic[name] = value;
			
			_revDic[value] = name;
		}
		
		override flash_proxy function deleteProperty(name:*):Boolean 
		{
			_revDic[_dic[name]] = undefined;
			_dic[name] = undefined;
			return true;
		}
		
		 flash_proxy override function getProperty(name:*):*
		{
			return _dic[name] ;
		}
		
		public function getRevValue(name:*):*
		{
			return _revDic[name] ;
		}
	
	}

}