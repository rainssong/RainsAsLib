package cn.flashk.events
{
	import flash.events.Event;
	import flash.net.URLLoader;

	public class LoaderManagerEvent extends Event
	{
		public static const COMPLETE:String =  "complete";
		
		private var _fileURL:String;
		private var _typeName:String;
		private var _uldr:URLLoader;
		
		public function LoaderManagerEvent(type:String,fileURLStr:String,typeNameStr:String,uldr:URLLoader)
		{
			_fileURL = fileURLStr;
			_typeName = typeNameStr;
			_uldr = uldr;
			
			super(type);
			
		}
		public function get fileURL():String{
			return _fileURL;
		}
		public function get typeName():String{
			return _typeName;
		}
		public function get data():*{
			return _uldr.data;
		}
		public function get URLLoaderInstance():URLLoader{
			return _uldr;
		}
	}
}