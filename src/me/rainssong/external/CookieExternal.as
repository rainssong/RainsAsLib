package me.rainssong.external
{
	
	/**
	 * @date 2015/6/6 22:54
	 * @author rainssong
	 * @blog http://blog.sina.com.cn/rainssong
	 * @homepage http://rainsgameworld.sinaapp.com
	 * @weibo http://www.weibo.com/rainssong
	 */
	public class CookieExternal
	{
		
		public function CookieExternal()
		{
		
		}
		
		static public function getCookie(cookieName:String):String
		{
			var r:String = "";
			var search:String = cookieName + "=";
			var js:String = "function get_cookie(){return document.cookie;}";
			var o:Object = ExternalInterface.call(js);
			var cookieVariable:String = o.toString();
			
			if (cookieVariable.length > 0)
			{
				var offset:int = cookieVariable.indexOf(search);
				if (offset != -1)
				{
					offset += search.length;
					var end:int = cookieVariable.indexOf(";", offset);
					if (end == -1)
						end = cookieVariable.length;
					r = unescape(cookieVariable.substring(offset, end));
				}
			}
			return r;
		}
		
		static public function setCookie(cookieName:String, cookieValue:String):void
		{
			var js:String = "function sc(){";
			js += "var c = escape('" + cookieName + "') + '=' + escape('" + cookieValue + "') + '; path=/';";
			js += "document.cookie = c;";
			js += "}";
			ExternalInterface.call(js);
		}
	
	}
}