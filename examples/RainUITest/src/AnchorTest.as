package 
{
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.utils.setTimeout;
	import me.rainui.RainTheme;
	import me.rainui.RainUI;
	import me.rainui.components.Button;
	import me.rainui.components.Page;
	import me.rainui.utils.ScaleMethod;
	
	
	/**
	 * @date 2016/5/1 0:35
	 * @author rainssong
	 * @blog http://blog.sina.com.cn/rainssong
	 * @homepage http://rainsgameworld.sinaapp.com
	 * @weibo http://www.weibo.com/rainssong
	 */
	public class AnchorTest extends Sprite 
	{
		
		private var _page:Page
		private var _btn:Button
		private var _btn2:Button
		
		public function AnchorTest() 
		{
			super();
			
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT
			
			RainUI.designDPI = 90;
			RainUI.init(stage, new RainTheme(ScaleMethod.WIDTH));
			
			
			//sc.borderVisible = true;
			
			setTimeout(init,500)
		}
		
		private function init():void 
		{
			var p:Page = new Page( { parent:stage } );
		
			p.addChild(_btn = new Button("hi"));
			p.addChild(_btn2 = new Button("hi"));
			_btn.dotWidth = 120;
			_btn.dotHeight = 50
			
			_btn2.top = 100;
			_btn2.percentWidth = 1;
			_btn2.percentHeight = 1;
			_btn2.widthAnchorDisplayObject = _btn;
			_btn2.heightAnchorDisplayObject = _btn;
			
		}
		
	}

}