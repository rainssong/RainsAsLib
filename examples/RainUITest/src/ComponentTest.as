package 
{
	import flash.display.Sprite;
	import me.rainui.components.Button;
	import me.rainui.components.Label;
	import me.rainui.components.List;
	import me.rainui.components.ScrollText;
	import me.rainui.RainTheme;
	import me.rainui.RainUI;
	
	
	/**
	 * @date 2015/12/4 5:32
	 * @author rainssong
	 * @blog http://blog.sina.com.cn/rainssong
	 * @homepage http://rainsgameworld.sinaapp.com
	 * @weibo http://www.weibo.com/rainssong
	 */
	public class ComponentTest extends Sprite
	{
		
		public function ComponentTest() 
		{
			super();
			RainUI.currentDPI = 326;
			RainUI.init(stage,new RainTheme);
			
			
			new Button("button", { parent:this, x:50, y:100 } );
			new Label("label", { parent:this, x:50, y:200 } );
			new List([1,2,3,4,5,6] ,{ parent:this, x:50, y:300 } );
			new ScrollText("卧槽卧槽卧槽卧槽卧槽卧槽卧\n槽卧槽卧\n槽卧槽卧槽卧槽卧槽\n\n卧槽卧槽卧槽卧槽卧槽卧槽卧槽卧槽卧槽卧槽卧槽卧槽卧槽卧槽",{ parent:this, x:400, y:100 } );
		}
		
	}

}