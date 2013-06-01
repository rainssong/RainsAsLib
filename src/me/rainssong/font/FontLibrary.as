package me.rainssong.font
{
	import flash.display.Sprite;
	import flash.text.Font;

	public class FontLibrary
	{
		[Embed(source="msyh.ttf", fontName="微软雅黑", mimeType="application/x-font-truetype", embedAsCFF="false" )] 
		static public var MSYH_FONT : Class;
		
		/**
		 * 华文行楷
		 */
		[Embed(source="STXINGKA.TTF", fontName="华文行楷", mimeType="application/x-font-truetype", embedAsCFF="false" )] 
		static public var HWXK_FONT : Class;
	}
}