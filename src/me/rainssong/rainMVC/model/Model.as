package me.rainssong.rainMVC.model 
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	/**
	 * ...
	 * @author rainsong
	 */
	[Event(name = "change", type = "flash.events.Event")]
	dynamic public class Model  extends EventDispatcher
	{
		public var data:Object;
		
		public function Model() 
		{
			
		}
		
		
		
	}

}