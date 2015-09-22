package me.rainui.components 
{
	import me.rainui.RainUI;
	
	/**
	 * @date 2015/9/19 15:06
	 * @author rainssong
	 * @blog http://blog.sina.com.cn/rainssong
	 * @homepage http://rainsgameworld.sinaapp.com
	 * @weibo http://www.weibo.com/rainssong
	 */
	public class Panel extends Container 
	{
		
		public function Panel(dataSource:Object=null) 
		{
			super(dataSource);
		}
		
		override protected function createChildren():void 
		{
			_bgSkin = RainUI.getSkin("panelBg");
			super.createChildren();
		}
		
	}

}