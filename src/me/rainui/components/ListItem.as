package me.rainui.components 
{
	import flash.display.Shape;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	import me.rainssong.utils.Align;
	import me.rainssong.utils.Draw;
	import me.rainui.events.RainUIEvent;
	import me.rainui.RainTheme;
	import me.rainui.RainUI;
	/**
	 * ...
	 * @author Rainssong
	 */
	public class ListItem extends RadioButton 
	{
		
		public function ListItem(text:String="",dataSource:Object=null) 
		{
			super(text,dataSource);
		} 
		
		override protected function createChildren():void 
		{
			//if (_normalSkin == null)
				//_normalSkin = RainUI.getSkin("listItem");
			
			super.createChildren();
			
			label.format = RainUI.getTextFormat(RainTheme.GRAY_TEXT_FORMAT);
			label.align = Align.LEFT;
			label.left =10;
			label.right = 10;
			
			//selectHandler = onSelect;
			//unselectHandler = onUnselect;
		}
		
		//private function onSelect(e:RainUIEvent=null):void 
		//{
			//label.color = RainTheme.LIGHT_BLACK;
		//}
		//
		//private function onUnselect(e:RainUIEvent=null):void 
		//{
			//label.color=RainTheme.GRAY;
		//}
		
		
		
		
		
	}

}