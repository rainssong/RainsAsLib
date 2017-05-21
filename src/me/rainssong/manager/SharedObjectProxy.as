package me.rainssong.manager 
{
	import flash.net.SharedObject;
	import flash.utils.flash_proxy;
	import flash.utils.Proxy;
	import me.rainssong.utils.ObjectCore;
	
	/**
	 * ...
	 * @author Rainssong
	 * @timeStamp 2014/1/20 16:09
	 * @blog http://blog.sina.com.cn/rainssong
	 */
	 public class SharedObjectProxy extends Proxy 
	{
		private var _so:SharedObject
		public function SharedObjectProxy(name:String="default") 
		{
			_so = SharedObject.getLocal(name);
			
		}
		
		//override flash_proxy function setProperty(name:*, value:*):void 
		//{
			//_so.data[name] = value;
			//_so.flush();
		//}
		
		public function setData(name:*, value:*):void 
		{
			_so.data[name] = value;
			_so.flush();
		}
		
		//override flash_proxy function getProperty(name:*):* 
		//{
			//return _so.data[name] ;
		//}
		 
		public function getData(name:*):* 
		{
			return _so.data[name] ;
		}
		
		//override flash_proxy function deleteProperty(name:*):Boolean 
		//{
			//delete _so.data[name];
			//_so.flush();
			//return super.flash_proxy::deleteProperty("name");
		//}
		
		public function deleteData(name:*):void 
		{
			delete _so.data[name];
			_so.flush();
		}
		
		/* DELEGATE flash.net.SharedObject */
		
		public function clear():void 
		{
			_so.clear();
		}
		
		public function close():void 
		{
			_so.close();
		}
		
		public function flush(minDiskSpace:int = 0):String 
		{
			return _so.flush(minDiskSpace);
		}
		
		public function get data():Object 
		{
			return _so.data;
		}
		
		public function packageData(...rest):Object
		{
			var result:Object = { };
			for (var i:int = 0; i < rest.length; i++) 
			{
				result[rest[i]] = ObjectCore.clone(data[rest[i]]);
			}
			
			return result;
		}
		
		public function unpackageData(pack:Object):void
		{
			if (pack as Object)
			{
				for (var item:String in pack) 
				{
					data[item] = pack[item];
				}
			}
		}
		
		
		
		
	}

}