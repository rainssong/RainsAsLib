package  
{
	import flash.utils.*;
	import flash.display.Sprite;
	import me.rainui.*;
	import me.rainui.components.*;
	import model.*;
	
	
	/**
	 * @date 2015/7/11 16:49
	 * @author rainssong
	 * @blog http://blog.sina.com.cn/rainssong
	 * @homepage http://rainsgameworld.sinaapp.com
	 * @weibo http://www.weibo.com/rainssong
	 */
	public class UITest extends Sprite 
	{
		
		
		
		public function UITest() 
		{
			
			setTimeout(init,200);
		}
		
		private function init():void 
		{
			//RainUI.init(stage)
			stage.addChild(new ButtonTest);
		}
		
		
		
		
		
	}

}