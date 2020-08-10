package me.rainssong.geom 
{
	
	/**
	 * @date 2018-12-21 16:24
	 * @author Rainssong
	 * @blog http://blog.sina.com.cn/rainssong
	 * @homepage http://rainsgameworld.sinaapp.com
	 * @weibo http://www.weibo.com/rainssong
	 */
	public class GeomCore 
	{
		
		public function GeomCore() 
		{
			
		}
		
		
				
		/**设置rect，兼容player10*/
		public static function setRect(rect:Rectangle, x:Number = 0, y:Number = 0, width:Number = 0, height:Number = 0):Rectangle {
			rect.x = x;
			rect.y = y;
			rect.width = width;
			rect.height = height;
			return rect;
		}
		
	}

}