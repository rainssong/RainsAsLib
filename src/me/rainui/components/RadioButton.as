package me.rainui.components 
{
	import flash.events.MouseEvent;
	import me.rainui.events.RainUIEvent;
	/**
	 * ...
	 * @author Rainssong
	 */
	public class RadioButton extends Button 
	{
		
		public function RadioButton(text:String="",dataSource:Object=null) 
		{
			super(text,dataSource);
		}
		
		override protected function preinitialize():void 
		{
			super.preinitialize();
			_toggle = true;
		}
		
		override protected function onClick(e:MouseEvent):void 
		{
			if ((_toggle == false && _selected) || _disabled)
			{
				return;
			}
			if (_toggle && !_selected)
			{
				selected = true;
				callLater(redraw);
			} 
			
		}
		
		
		
	}

}