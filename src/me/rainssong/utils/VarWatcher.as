package me.rainssong.utils
{
	import flash.utils.flash_proxy;
	import flash.utils.Proxy;
	
	public dynamic  class VarWatcher extends Proxy
	{
		private var _watchHashTable:Object = {};
		private var _obj:Object;
		
		public function VarWatcher(obj:*)
		{
			_obj = obj;
		}
		
		public function watch(prop:String, callBackFunc:Function, arg:* = null):void
		{
			_watchHashTable[prop] = {};
			_watchHashTable[prop].prop = prop;
			_watchHashTable[prop].oldV=flash_proxy::getProperty(prop);
			_watchHashTable[prop].newV = null;
			_watchHashTable[prop].callBackFunc = callBackFunc;
			_watchHashTable[prop].arg = arg;
		}
		
		override flash_proxy function callProperty(methodName:*, ... args):*
		{
			return _obj[methodName].apply(_obj, args);
		}
		
		override flash_proxy function getProperty(name:*):*
		{
			//trace("getProperty");
			return _obj[name];
		}
		
		override flash_proxy function setProperty(name:*, value:*):void
		{
			//trace("setProperty");
			if (_watchHashTable[name] != undefined && value != _watchHashTable[name].oldV)
			{
				_watchHashTable[name].newV = value;
				_watchHashTable[name].oldV = _watchHashTable[name].callBackFunc.apply(null, [_watchHashTable[name].prop, _watchHashTable[name].oldV, _watchHashTable[name].newV, _watchHashTable[name].arg]);
			}
			_obj[name] = value;
		}
	
	}
}