package me.rainssong.utils 
{
	
	/**
	 * @date 2015/1/13 1:28
	 * @author Rainssong
	 * @blog http://blog.sina.com.cn/rainssong
	 * @homepage http://rainsgameworld.sinaapp.com
	 * @weibo http://www.weibo.com/rainssong
	 */
	public class Handler extends Object 
	{
		public var func:Function;
		public var params:Array;
		
		public function Handler(func:Function,params:Array=null) 
		{
			this.func = func;
			this.params = params;
		}
		
	}

}