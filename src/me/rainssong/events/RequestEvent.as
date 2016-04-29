package me.rainssong.events 
{
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	/**
	 * ...
	 * @author rainssong
	 */
	public class RequestEvent extends ObjectEvent 
	{
		public var url:String;
		static public const COMPLETE:String = Event.COMPLETE;
		
		public function RequestEvent(type:String,url:String="", data:*=null, bubbles:Boolean=false, cancelable:Boolean=false) 
		{
			super(type, data, bubbles, cancelable);
			this.url = url;
		}
		
	}

}