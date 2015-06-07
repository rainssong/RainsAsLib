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
	import me.rainui.RainTheme;
	import me.rainui.RainUI;
	
	
	/**
	 * @date 2015/5/25 19:17
	 * @author rainssong
	 * @blog http://blog.sina.com.cn/rainssong
	 * @homepage http://rainsgameworld.sinaapp.com
	 * @weibo http://www.weibo.com/rainssong
	 */
	public class ListExample extends Page 
	{
		public var list:List
		public function ListExample() 
		{
			super();
			
			RainUI.init(stage);
			
			list = new List(["1", "2", "3", "44444", "55555", "66666"], { parent:stage } );
			list.itemRender = ir;
			list.btnGroup.max = 3;
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
			return l;
		}
		
		
		
	}

}