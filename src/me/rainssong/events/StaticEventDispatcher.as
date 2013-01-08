package me.rainssong.events
{
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	/**
	 * ...
	 * @author Rainssong
	 */
	public class StaticEventDispatcher
	{
		
		private static var _eventDispacher:EventDispatcher = new EventDispatcher();
		
		//private static var _eventDispatcher:EventDispatcher = new EventDispatcher();
		
		public function StaticEventDispatcher()
		{
		
		}
		
		public static function addEventListener(type:String, listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false):void
		{
			_eventDispacher.addEventListener(type, listener, useCapture, priority, useWeakReference);
		}
		
		public static function hasEventListener(type:String):Boolean
		{
			return _eventDispacher.hasEventListener(type);
		}
		
		public static function removeEventListener(type:String, listener:Function, useCapture:Boolean = false):void
		{
			_eventDispacher.removeEventListener(type, listener, useCapture);
		}
		
		public static function dispatchEvent(event:Event):Boolean
		{
			return _eventDispacher.dispatchEvent(event);
		}
		
		static public function get eventDispacher():EventDispatcher
		{
			return _eventDispacher;
		}
	
	}

}