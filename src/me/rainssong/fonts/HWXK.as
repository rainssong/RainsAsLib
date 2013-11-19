package me.rainssong.fonts
{
	import flash.display.Sprite;
	import flash.text.Font;

	public class HWXK extends Sprite 
	{
		[Embed(source="../../../../assets/fonts/STXINGKA.TTF", fontName="华文行楷", mimeType="application/x-font-truetype", embedAsCFF="false" )] 
		static public var HWXK_FONT : Class;
		
		public function HWXK()
		{
			Font.registerFont(HWXK_FONT);
		}
	}
}