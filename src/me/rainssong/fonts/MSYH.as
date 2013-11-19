package me.rainssong.fonts
{
	import flash.display.Sprite;
	import flash.text.Font;

	public class MSYH extends Sprite 
	{
		[Embed(source="../../../../assets/fonts/msyh.ttf", fontName="微软雅黑", mimeType="application/x-font-truetype", embedAsCFF="false" )] 
		static public var MSYH_FONT : Class;
		
		public function MSYH()
		{
			Font.registerFont(MSYH_FONT);
		}
	}
}