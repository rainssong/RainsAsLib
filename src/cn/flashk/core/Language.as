package cn.flashk.core
{
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;

	/**
	 * 此类提供了语言包的功能
	 */ 
	public class Language
	{
		private static var ins:Language;
		
		private static var xml:XML;
		private var uldr:URLLoader;
		
		public function Language()
		{
		}
		public static function getInstance():Language{
			if(ins == null){
				ins = new Language();
			}
			return ins;
		}
		public function load(file:String):void{
			uldr = new URLLoader();
			uldr.addEventListener(Event.COMPLETE,init);
			uldr.load(new URLRequest(file));
		}
		/**
		 * 通过指定的ID code获取对应的字符串
		 */ 
		public static function getStringByCode(code:int):String{
			var str:String;
			str = xml.child("c"+String(code)).toString();
			return str;
		}
		private function init(event:Event):void{
			xml = new XML(uldr.data);
		}
	}
}