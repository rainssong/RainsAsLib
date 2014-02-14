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

		/**
		 * 
		 * @param	content  
		 * @param	params  bold:Boolean  italic:Boolean underline:Boolean font:String=null size:int  color:uint href:String align:String="left"/"center"/"right"
		 * 
		 * @return htmlText
		 */
		public static function format(content:String, params:Object = null):String
		{
			if (!params)
				return content;
			if (params.bold)
			{
				content = "<b>" + content + "</b>";
			} // end if
			if (params.italic)
			{
				content = "<i>" + content + "</i>";
			} // end if
			if (params.underline)
			{
				content = "<u>" + content + "</u>";
			} // end if
			var config:String = "";
			if (params.font)
			{
				config = config + (" font=\"" +params.font + "\"");
			} // end if
			if (params.size)
			{
				config = config + (" size=\"" + params.size + "\"");
			} // end if
			if (params.color)
			{
				config = config + (" color=\"#" + params.color.toString(16) + "\"");
			}
			content = "<font" + config + ">" + content + "</font>";
			if (params.href)
			{
				content = "<a href=\"" + params.href + "\" target=\"_blank\">" + content + "</a>";
			} // end if
			if (params.align)
			{
				content = "<p align=\"" + params.align + "\">" + content + "</p>";
			} // end if
			return content;
		} // end function
	
	}
}
