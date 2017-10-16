package 
{
	import flash.display.Shape;
	import flash.geom.Rectangle;
	import flash.utils.setTimeout;
	import me.rainssong.utils.Align;
	import me.rainssong.utils.Color;
	import me.rainssong.utils.Draw;
	import me.rainui.components.List;
	import me.rainui.components.ListItem;
	import me.rainui.components.Page;
	import me.rainui.data.ListCollection;
	import me.rainui.events.RainUIEvent;
	import me.rainui.RainTheme;
	import me.rainui.RainUI;
	
	
	/**
	 * @date 2015/5/25 19:17
	 * @author rainssong
	 * @blog http://blog.sina.com.cn/rainssong
	 * @homepage http://rainsgameworld.sinaapp.com
	 * @weibo http://www.weibo.com/rainssong
	 */
	public class ListTest extends Page 
	{
		public var list:List
		public function ListTest() 
		{
			super();
			
			RainUI.init(stage);
			
			setTimeout(init,200)
		}
		
		private function init():void 
		{
			//list = new List(["1", "2", "3", "44444", "55555", "66666", "66666", "66666", "66666", "66666", "66666", "66666"], { parent:stage } );
			list = new List(null, { parent:stage } );
			list.itemRender = ir;
			
			list.btnGroup.max = 1;
			list.addEventListener(RainUIEvent.CHANGE, onChange);
			
			//addChild(new ListItem("122112"));
			
			setTimeout(function() { list.items =new ListCollection( ["1", "2", "3", "44444", "55555", "66666", "66666", "66666", "66666", "66666", "66666", "66666"]); }, 1000);
		}
		
		private function onChange(e:RainUIEvent):void 
		{
			powerTrace("change");
		}
		
		public function ir():ListItem
		{
			var l:ListItem = new ListItem();
			var shape:Shape = new Shape();
			Draw.rect(shape, 0, 0, 100, 100, RainTheme.WHITE);
			//Draw.rect(shape, 0, 0, 100, 2, RainTheme.GRAY);
			Draw.rect(shape, 0, 98, 100, 2, RainTheme.GRAY);
			shape.scale9Grid = new Rectangle(4, 4, 92, 92);
			
			l.normalSkin = shape;
			l.label.color = Color.rgb( 77, 77, 77);
			l.label.centerX = 0;
			l.label.centerY = 0;
			l.label.size = 44;
			
			l.unselectHandler = null;
			return l;
		}
		
		
		
	}

}