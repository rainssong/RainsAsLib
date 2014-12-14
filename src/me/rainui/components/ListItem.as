package me.rainui.components 
{
	import flash.display.Shape;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	import me.rainssong.utils.Draw;
	import me.rainui.RainTheme;
	/**
	 * ...
	 * @author Rainssong
	 */
	public class ListItem extends RadioButton 
	{
		
		public function ListItem(text:String="") 
		{
			super(text);
			
		} 
		
		override protected function createChildren():void 
		{
			var shape:Shape = new Shape();
			Draw.rect(shape, 0, 0, 100, 100, RainTheme.WHITE);
			Draw.rect(shape, 0, 98, 100, 2, RainTheme.LIGHT_GRAY);
			shape.scale9Grid = new Rectangle(2, 2, 96, 96);
			normalSkin = shape;
			
			super.createChildren();
			
			label.format = RainTheme.getTextFormat(RainTheme.GRAY_TEXT_FORMAT);
			label.align = "left";
			label.left =10;
			label.right = 10;
			
		}
		
		
		
	}

}