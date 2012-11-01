package com.assist.view
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

        public static function yellow(param1:String) : String
        {
            return format(param1, Yellow);
        }// end function

        public static function red(param1:String) : String
        {
            return format(param1, Red);
        }// end function

        public static function white(param1:String) : String
        {
            return format(param1, White);
        }// end function

        public static function green(param1:String) : String
        {
            return format(param1, Green);
        }// end function

        public static function blue(param1:String) : String
        {
            return format(param1, Blue);
        }// end function

        public static function orange(param1:String) : String
        {
            return format(param1, Orange);
        }// end function

        public static function blue2(param1:String) : String
        {
            return format(param1, Blue2);
        }// end function

        public static function yellow2(param1:String) : String
        {
            return format(param1, Yellow2);
        }// end function

        public static function format(param1:String, param2:uint = 0, param3:uint = 12, param4:String = "宋体", param5:Boolean = false, param6:Boolean = false, param7:Boolean = false, param8:String = null, param9:String = null) : String
        {
            if (param5)
            {
                param1 = "<b>" + param1 + "</b>";
            }// end if
            if (param6)
            {
                param1 = "<i>" + param1 + "</i>";
            }// end if
            if (param7)
            {
                param1 = "<u>" + param1 + "</u>";
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
            param1 = "<font" + _loc_10 + ">" + param1 + "</font>";
            if (param8)
            {
                param1 = "<a href=\"" + param8 + "\" target=\"_blank\">" + param1 + "</a>";
            }// end if
            if (param9)
            {
                param1 = "<p align=\"" + param9 + "\">" + param1 + "</p>";
            }// end if
            return param1;
        }// end function

    }
}
