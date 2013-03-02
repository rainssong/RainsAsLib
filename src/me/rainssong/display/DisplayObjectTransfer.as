package me.rainssong.display 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.Loader;
	import flash.net.URLRequest;
	/**
	 * ...
	 * @author Rainssong
	 */
	public class DisplayObjectTransfer
	{
		static private var _loader:Loader;
		
		/**
		 * DisplayObject->DisplayObject;String->Loader;Class->new Class();BitmapData->Bitmap;
		 * @param	value
		 * @return	DisplayObject
		 */
		static public function transfer(value:*):DisplayObject
		{
			if (value is DisplayObject)
				return value;
			else if (value is String)
			{
				_loader = new Loader();
				_loader.load(new URLRequest(value))
				return _loader;
			}
			else if (value is Class)
			{
				var temp:* =  new value();
				if(temp is DisplayObject)
				return temp;
				else
				throw Error("can't transfer "+value);
			}
			else if (value is BitmapData)
			{
				return new Bitmap(value);
			}
			else
			{
				throw Error("can't transfer "+value);
			}
		}
		
		
		
	}

}