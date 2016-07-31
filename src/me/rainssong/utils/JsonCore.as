package me.rainssong.utils
{
	
	/**
	 * @date 2016/4/7 21:18
	 * @author rainssong
	 * @blog http://blog.sina.com.cn/rainssong
	 * @homepage http://rainsgameworld.sinaapp.com
	 * @weibo http://www.weibo.com/rainssong
	 */
	public class JsonCore
	{
		
		public function JsonCore() 
		{
			
		}
		
		static public function getValue(json:*, expression:String):*
		{
			if (json == null || json=="")
			{
				return null;
			}
			
			var obj:Object 
			
			if (json is String)
			{
				try 
				{
					obj = JSON.parse(json);
				}
				catch (e:Error)
				{
					return null;
				}
			}
			
			var arr:Array = expression.split(".");
			
			var result:*= obj;
			
			for (var i:int = 0; i < arr.length; i++) 
			{
				result = result[arr[i]];
				if (result == null)
					return result;
			}
			
			return result;
			
		}
		
	}

}