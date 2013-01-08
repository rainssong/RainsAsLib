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

        public static function format(content:String, param2:uint = 0, param3:uint = 12, param4:String = "宋体", param5:Boolean = false, param6:Boolean = false, param7:Boolean = false, param8:String = null, param9:String = null) : String
        {
            if (param5)
            {
                content = "<b>" + content + "</b>";
            }// end if
            if (param6)
            {
                content = "<i>" + content + "</i>";
            }// end if
            if (param7)
            {
                content = "<u>" + content + "</u>";
            }// end if
            var _loc_10:String;
            if (param4)
            {
                _loc_10 = _loc_10 + (" font=\"" + param4 + "\"");
            }// end if
            if (param3 > 0)
            {
                _loc_10 = _loc_10 + (" size=\"" + param3 + "\"");
            }// end if
            _loc_10 = _loc_10 + (" color=\"#" + param2.toString(16) + "\"");
            content = "<font" + _loc_10 + ">" + content + "</font>";
            if (param8)
            {
                content = "<a href=\"" + param8 + "\" target=\"_blank\">" + content + "</a>";
            }// end if
            if (param9)
            {
                content = "<p align=\"" + param9 + "\">" + content + "</p>";
            }// end if
            return content;
        }// end function

    }
}
