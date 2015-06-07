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
	public class TextAreaTest extends Page 
	{
		public var ta:TextArea
		public function TextAreaTest() 
		{
			super();
			
			RainUI.init(stage);
			
			//ta = new TextArea("123456\rkkkkkkk\r我日我日我日我日我日我日我日我日我日我日我日\rasdfghjklqwertyuiop", { parent:stage } );
			new ScrollText("123456\rkkkkkkk\r我日我日我日我日我日我日我日我日我日我日我日\rasdfghjklqwertyuiop", { parent:stage } );
			//new ScrollContainer(null, { parent:stage } );
			//var _textInput:TextInput = new TextInput("123");
			//_textInput.width = 300;
			//_textInput.height = 200;
			//_textInput.align = Align.TOP_LEFT;
			//_textInput.autoSize = false;
			//_textInput.wordWrap = true;
			//_textInput.multiline = true;
			////_textInput.bgSkin.alpha = 0;
			//_textInput.borderVisible = true;
			//stage.addChild(_textInput);
			//list.itemRender = ir;
			//list.btnGroup.max = 3;
		}
		
		
		
		
	}

}