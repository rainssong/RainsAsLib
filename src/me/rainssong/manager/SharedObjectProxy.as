package me.rainssong.manager 
{
	import flash.net.SharedObject;
	import flash.utils.flash_proxy;
	import flash.utils.Proxy;
	
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
		
		override flash_proxy function setProperty(name:*, value:*):void 
		{
			_so.data[name] = value;
			_so.flush();
		}
		
		public function setData(name:*, value:*):void 
		{
			_so.data[name] = value;
			_so.flush();
		}
		
		override flash_proxy function getProperty(name:*):* 
		{
			return _so.data[name] ;
		}
		 
		public function getData(name:*):* 
		{
			return _so.data[name] ;
		}
		
		override flash_proxy function deleteProperty(name:*):Boolean 
		{
			delete _so.data[name];
			_so.flush();
			return super.flash_proxy::deleteProperty("name");
		}
		
		flash_proxy function deleteData(name:*):Boolean 
		{
			delete _so.data[name];
			_so.flush();
			return _so.data.flash_proxy::deleteProperty("name");
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
		
		
		
		
	}

}