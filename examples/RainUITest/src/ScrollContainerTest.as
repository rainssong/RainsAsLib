package 
{
	import flash.display.DisplayObject;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.display.StageScaleMode;
	import flash.geom.Rectangle;
	import flash.utils.setTimeout;
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
	public class ScrollContainerTest extends Sprite 
	{
		[Embed(source = "../../../embeds/rain_logo.png")]
		public static const ImgClass:Class
		public var sc:ScrollContainer
		
		public function ScrollContainerTest() 
		{
			super();
			
			//stage.scaleMode=StageScaleMode.NO_SCALE
			
			RainUI.init(stage);
			
			
			//sc.borderVisible = true;
			
			setTimeout(init,500)
		}
		
		private function init():void 
		{
			//var p:Page = new Page( { parent:stage } );
			//p.borderVisible = true;
			
			
			sc = new ScrollContainer(new ImgClass() as DisplayObject, { parent:this } );
			sc.width = 600;
			sc.height = 400;
			sc.borderVisible = true;
		}
		
		
		
		
	}

}