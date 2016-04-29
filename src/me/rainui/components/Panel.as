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
		
		override protected function preinitialize():void 
		{
			if(isNaN(_width))
				_width = 400 * RainUI.scale;
			if(isNaN(_height))
			_height = 200*RainUI.scale;
			super.preinitialize();
		}
		
		override protected function createChildren():void 
		{
			_bgSkin = RainUI.getSkin("panelBg");
			super.createChildren();
		}
		
	}

}