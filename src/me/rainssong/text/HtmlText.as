package me.rainssong.text
{

    public class HtmlText extends Object
    {
        public static const Yellow:uint = 16776960;
        public static const Red:uint = 16711680;
        public static const White:uint = 16777215;
        public static const Green:uint = 65280;
        public static const Blue:uint = 255;
        public static const Orange:uint = 16225309;
        public static const Blue2:uint = 44783;
        public static const Yellow2:uint = 16773632;

        public function HtmlText()
        {
            return;
        }// end function

        public static function yellow(content:String) : String
        {
            return format(content, Yellow);
        }// end function

        public static function red(content:String) : String
        {
            return format(content, Red);
        }// end function

        public static function white(content:String) : String
        {
            return format(content, White);
        }// end function

        public static function green(content:String) : String
        {
            return format(content, Green);
        }// end function

        public static function blue(content:String) : String
        {
            return format(content, Blue);
        }// end function

        public static function orange(content:String) : String
        {
            return format(content, Orange);
        }// end function

        public static function blue2(content:String) : String
        {
            return format(content, Blue2);
        }// end function

        public static function yellow2(content:String) : String
        {
            return format(content, Yellow2);
        }// end function

        public static function format(content:String, color:uint = 0, size:uint = 12, font:String = null, bold:Boolean = false, italic:Boolean = false, underline:Boolean = false, href:String = null, align:String = null) : String
        {
            if (bold)
            {
                content = "<b>" + content + "</b>";
            }// end if
            if (italic)
            {
                content = "<i>" + content + "</i>";
            }// end if
            if (underline)
            {
                content = "<u>" + content + "</u>";
            }// end if
            var config:String="";
            if (font)
            {
                config = config + (" font=\"" + font + "\"");
            }// end if
            if (size > 0)
            {
                config = config + (" size=\"" + size + "\"");
            }// end if
            config = config + (" color=\"#" + color.toString(16) + "\"");
            content = "<font" + config + ">" + content + "</font>";
            if (href)
            {
                content = "<a href=\"" + href + "\" target=\"_blank\">" + content + "</a>";
            }// end if
            if (align)
            {
                content = "<p align=\"" + align + "\">" + content + "</p>";
            }// end if
            return content;
        }// end function

    }
}
