package me.rainssong.events 
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Rainssong
	 */
	public class MouseInteractiveEvent extends ObjectEvent 
	{
	
		static public const SWIPE:String = "swipe";
		
		public function MouseInteractiveEvent(type:String,direction:String, bubbles:Boolean=false, cancelable:Boolean=false) 
		{ 
			super(type,direction, bubbles, cancelable);
			//this.direction = direction;
		} 
		
		public override function clone():Event 
		{ 
			return new MouseInteractiveEvent(type,direction, bubbles, cancelable);
		} 
		
		public override function toString():String 
		{ 
			return formatToString("MouseInteractiveEvent", "type","direction", "bubbles", "cancelable", "eventPhase"); 
		}
		
	
		
		public function get direction():String 
		{
			return data;
		}
		
		public function set direction(value:String):void 
		{
			data = value;
		}
	}
}