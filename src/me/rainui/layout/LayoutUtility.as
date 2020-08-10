package me.rainui.layout 
{
	import me.rainssong.utils.Directions;
	
	/**
	 * @date 2019-01-02 15:19
	 * @author Rainssong
	 * @blog http://blog.sina.com.cn/rainssong
	 * @homepage http://rainsgameworld.sinaapp.com
	 * @weibo http://www.weibo.com/rainssong
	 */
	public class LayoutUtility 
	{
		
		public function LayoutUtility() 
		{
			
		}
		
		public static function GetMinSize(rect:DisplayObject , axis:Directions):Number
        {
            if (axis == Directions.HORIZONTAL)
                return GetMinWidth(rect);
            return GetMinHeight(rect);
        }

        public static function GetPreferredSize(rect:DisplayObject , axis:Directions):Number
        {
            if (axis == Directions.HORIZONTAL)
                return GetPreferredWidth(rect);
            return GetPreferredHeight(rect);
        }

        public static function GetFlexibleSize(rect:DisplayObject , axis:Directions):Number
        {
            if (axis == Directions.HORIZONTAL)
                return GetFlexibleWidth(rect);
            return GetFlexibleHeight(rect);
        }

        //public static function GetMinWidth(rect:DisplayObject ):Number
        //{
            //return GetLayoutProperty(rect, e => e.minWidth, Directions.HORIZONTAL);
        //}
//
        //public static function GetPreferredWidth(rect:DisplayObject ):Number
        //{
            //return Mathf.Max(GetLayoutProperty(rect, e => e.minWidth,  Directions.HORIZONTAL), GetLayoutProperty(rect, e => e.preferredWidth, 0));
        //}

        public static function GetFlexibleWidth(rect:DisplayObject ):Number
        {
            return rect.width;
        }
//
        //public static function GetMinHeight(rect:DisplayObject ):Number
        //{
            //return GetLayoutProperty(rect, e => e.minHeight,  Directions.HORIZONTAL);
        //}
//
        //public static function GetPreferredHeight(rect:DisplayObject ):Number
        //{
            //return Mathf.Max(GetLayoutProperty(rect, e => e.minHeight,  Directions.HORIZONTAL), GetLayoutProperty(rect, e => e.preferredHeight, 0));
        //}

        public static function GetFlexibleHeight(rect:DisplayObject ):Number
        {
            return rect.height;
        }


		
	}

}