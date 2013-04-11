package me.rainssong.font
{
	import flash.display.Sprite;
	import flash.text.Font;

	public class MSYH extends Sprite 
	{
		[Embed(systemFont="微软雅黑", fontName="MSYH", mimeType="application/x-font-truetype", embedAsCFF="false" )] 
		static public var MSYH_FONT : Class;
		
		public static function register():void
		{
			Font.registerFont(MSYH_FONT);
		}
	}
}