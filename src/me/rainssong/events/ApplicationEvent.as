package me.rainssong.events 
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Rainssong
	 */
	public class ApplicationEvent extends DataEvent 
	{
		
		static public const INIT:String = "init";
		static public const LOGIN:String = "Login";
		static public const LOGOUT:String = "Logout";
		static public const EXIT:String = "exit";
		
		public function ApplicationEvent(type:String,data:*=null, bubbles:Boolean=false, cancelable:Boolean=false) 
		{
			super(type,data, bubbles, cancelable);
		}
		
		public override function clone():Event
		{
			return new ApplicationEvent(type,data, bubbles, cancelable);
		}
		
		public override function toString():String
		{
			
			return formatToString("ApplicationEvent", "type","data", "bubbles", "cancelable", "eventPhase");
		}
		
	}

}