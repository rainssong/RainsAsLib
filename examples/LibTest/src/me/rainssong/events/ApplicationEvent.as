package me.rainssong.events 
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Rainssong
	 */
	public class ApplicationEvent extends Event 
	{
		
		static public const INIT:String = "init";
		static public const LOGIN:String = "Login";
		static public const LOGOUT:String = "Logout";
		static public const EXIT:String = "exit";
		
		public function ApplicationEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false) 
		{
			super(type, bubbles, cancelable);
		}
		
	}

}