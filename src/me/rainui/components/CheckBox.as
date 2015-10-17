package me.rainui.components 
{
	import flash.events.MouseEvent;
	import me.rainui.events.RainUIEvent;
	/**
	 * ...
	 * @author Rainssong
	 */
	public class CheckBox extends Button 
	{
		
		public function CheckBox(text:String="",dataSource:Object=null) 
		{
			super(text,dataSource);
		}
		
		override protected function preinitialize():void 
		{
			super.preinitialize();
			_toggle = true;
		}
		
		override public function redraw():void 
		{
			super.redraw();
		}
		
	}

}