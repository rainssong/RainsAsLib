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
				
				return new value();
			}
			else if (value is BitmapData)
			{
				return new Bitmap(value);
			}
			else
			{
				throw Error("can't transfer"+value);
			}
		}
		
		
		
	}

}