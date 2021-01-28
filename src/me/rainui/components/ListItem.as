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
			
			if (label == null)
			{
				label = new Label();
				label.color = RainTheme.GRAY;
				label.align = Align.LEFT;
				
				label.centerX = 0;
				label.centerY = 0;
				label.autoSize = true;
				label.size = RainUI.scale * 32;
				label.color = 0;
				label.left =10;
				label.right = 10;
				
				addChild(_label);
			}
				
			if (_normalSkin == null)
			{
				_normalSkin = RainUI.getSkin("buttonNormal");
				addChildAt(_normalSkin,0);
				this._width = 200*RainUI.scale;
				this._height = 60*RainUI.scale;
			}
			else if(isNaN(_width))
			{
				this._width = _normalSkin.width;
				this._height = _normalSkin.height;
			}
			
			super.createChildren();
			
			
			
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