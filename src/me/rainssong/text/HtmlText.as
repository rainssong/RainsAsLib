package me.rainssong.text
{
	
	public class HtmlText extends Object
	{
		public static const WHITE:uint = 0xffffff;
		public static const SILVER:uint = 0xc0c0c0;
		public static const GRAY:uint = 0x808080;
		public static const BLACK:uint = 0x000000;
		public static const RED:uint = 0xff0000;
		public static const MAROON:uint = 0x800000;
		public static const YELLOW:uint = 0xffff00;
		public static const OLIVE:uint = 0x808000;
		public static const LIME:uint = 0x00ff00;
		public static const GREEN:uint = 0x008000;
		public static const AQUA:uint = 0x00ffff;
		public static const TEAL:uint = 0x008080;
		public static const BLUE:uint = 0x0000ff;
		public static const NAVY:uint = 0x000080;
		public static const FUCHSIA:uint = 0xff00ff;
		public static const PURPLE:uint = 0x800080;
		static public const ORANGE:uint = 0xFF7F00;
		
		public function HtmlText()
		{
			return;
		} // end function
		
		public static function yellow(content:String):String
		{
			return format(content, YELLOW);
		} // end function
		
		public static function red(content:String):String
		{
			return format(content, RED);
		} // end function
		
		public static function white(content:String):String
		{
			return format(content, WHITE);
		} // end function
		
		public static function green(content:String):String
		{
			return format(content, GREEN);
		} // end function
		
		public static function blue(content:String):String
		{
			return format(content, BLUE);
		} // end function
		
		public static function orange(content:String):String
		{
			return format(content, ORANGE);
		} // end function
		
		public static function format(content:String, color:int = -1, size:int = -1, font:String = null, align:String = null, bold:Boolean = false, italic:Boolean = false, underline:Boolean = false, href:String = null):String
		{
			if (bold)
			{
				content = "<b>" + content + "</b>";
			} // end if
			if (italic)
			{
				content = "<i>" + content + "</i>";
			} // end if
			if (underline)
			{
				content = "<u>" + content + "</u>";
			} // end if
			var config:String = "";
			if (font)
			{
				config = config + (" font=\"" + font + "\"");
			} // end if
			if (size > 0)
			{
				config = config + (" size=\"" + size + "\"");
			} // end if
			if (color > 0)
			{
				config = config + (" color=\"#" + color.toString(16) + "\"");
			}
			content = "<font" + config + ">" + content + "</font>";
			if (href)
			{
				content = "<a href=\"" + href + "\" target=\"_blank\">" + content + "</a>";
			} // end if
			if (align)
			{
				content = "<p align=\"" + align + "\">" + content + "</p>";
			} // end if
			return content;
		} // end function
	
	}
}
