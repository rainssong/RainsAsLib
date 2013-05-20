package cn.flashk.controls.events
{
	import flash.events.Event;

	public class UIComponentEvent extends Event
	{
		public static const RESIZE:String = "resize";
		
		public function UIComponentEvent(type:String)
		{
			super(type);
		}
	}
}