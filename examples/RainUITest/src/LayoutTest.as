package  
{
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.utils.setTimeout;
	import me.rainui.RainUI;
	import me.rainui.components.Button;
	import me.rainui.components.Page;
	import me.rainui.components.TextArea;

	
	/**
	 * @date 2015/7/11 16:49
	 * @author rainssong
	 * @blog http://blog.sina.com.cn/rainssong
	 * @homepage http://rainsgameworld.sinaapp.com
	 * @weibo http://www.weibo.com/rainssong
	 */
	public class LayoutTest extends Sprite 
	{
		
		private var _yesButton:Button
		private var _noButton:Button
		
		
		
		public function LayoutTest() 
		{
			
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			
			
			
			//loadData() ;
			setTimeout(init, 100);
			
		}
		
		
		
		protected function init():void 
		{
			RainUI.init(this.stage);
			
			var _container:Page=new Page({parent:stage})
			
			_yesButton = new Button("导出", { parent:_container, right:20, top:80} );
			_noButton = new Button("关闭", { parent:_container, right:20, bottom:20} );
			
			
		}
		
	}

}