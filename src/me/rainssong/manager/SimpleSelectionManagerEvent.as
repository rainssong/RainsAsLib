package me.rainssong.manager
{
	import flash.events.Event;
	
	public class SimpleSelectionManagerEvent extends Event
	{
		public static const SELECT_OBJECT:String = "selectObject";
		
		public static const UNSELECT_OBJECT:String = "unselectObject";
		
		public var selectableObject:Object = null;
		
		public function SimpleSelectionManagerEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
		
		override public function clone():Event
		{
			var newEvent:SimpleSelectionManagerEvent = new SimpleSelectionManagerEvent(type, bubbles, cancelable);
			newEvent.selectableObject = selectableObject;
			
			return newEvent;
		}
	}
}