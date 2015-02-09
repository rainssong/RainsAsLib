package me.rainui.components
{
	import flash.display.Shape;
	import flash.geom.Rectangle;
	import me.rainssong.utils.Draw;
	import me.rainui.RainTheme;
	
	/**
	 * ...
	 * @author Rainssong
	 */
	public class TabButton extends RadioButton
	{
		
		public function TabButton(text:String = "")
		{
			super(text);
		}
		
		override protected function preinitialize():void 
		{
			super.preinitialize();
			
		}
		
		override protected function createChildren():void
		{
			var shape:Shape = new Shape();
			Draw.rect(shape, 0, 0, 100, 100, RainTheme.BLUE);
			Draw.rect(shape, 0, 96, 100, 4, RainTheme.DARK_BLUE);
			Draw.rect(shape, 0, 0,2, 100,RainTheme.DARK_BLUE);
			Draw.rect(shape, 98, 0, 2, 100, RainTheme.DARK_BLUE);
			shape.scale9Grid = new Rectangle(4, 4, 92, 92);
			_normalSkin = shape;
			
			super.createChildren();
			
			
		}
	
	}

}