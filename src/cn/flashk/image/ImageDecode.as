package cn.flashk.image
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.events.Event;
	import flash.utils.ByteArray;

	public class ImageDecode
	{
		private var ldr:Loader;
		private var callFun:Function;
		
		public function ImageDecode(data:ByteArray,callBackFun:Function)
		{
			callFun = callBackFun;
			ldr = new Loader();
			ldr.contentLoaderInfo.addEventListener(Event.INIT,callBack);
			ldr.loadBytes(data);
		}
		public static function toBitmapData(data:ByteArray):Loader{
			var ldr2:Loader = new Loader();
			ldr2.loadBytes(data);
			return ldr2;
		}
		private function callBack(event:Event):void{
			callFun(ldr.content as Bitmap);
			ldr.contentLoaderInfo.removeEventListener(Event.INIT,callBack);
			
			ldr.unload();
			ldr = null;
			callFun = null;
		}
		public function clear():void{
			Bitmap(ldr.content).bitmapData.dispose();
			try
			{
				ldr.unloadAndStop();
			} 
			catch(e:Error) 
			{
				
			}
		}
	}
}