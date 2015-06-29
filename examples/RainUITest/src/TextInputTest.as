package 
{
	import flash.display.Shape;
	import flash.geom.Rectangle;
	import me.rainssong.utils.Align;
	import me.rainssong.utils.Color;
	import me.rainssong.utils.Draw;
	import me.rainui.components.List;
	import me.rainui.components.ListItem;
	import me.rainui.components.Page;
	import me.rainui.components.ScrollContainer;
	import me.rainui.components.ScrollText;
	import me.rainui.components.TextArea;
	import me.rainui.components.TextInput;
	import me.rainui.RainTheme;
	import me.rainui.RainUI;
	
	
	/**
	 * @date 2015/5/25 19:17
	 * @author rainssong
	 * @blog http://blog.sina.com.cn/rainssong
	 * @homepage http://rainsgameworld.sinaapp.com
	 * @weibo http://www.weibo.com/rainssong
	 */
	public class TextInputTest extends Page 
	{
		public var ti:TextInput
		public function TextInputTest() 
		{
			super();
			
			RainUI.init(stage);
			
			
			ti = new TextInput("text", { parent:stage } );
		}
		
		
		
		
	}

}