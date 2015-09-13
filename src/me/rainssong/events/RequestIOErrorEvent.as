package me.rainssong.events 
{
	import flash.events.IOErrorEvent;
	
	/**
	 * ...
	 * @author rainssong
	 */
	public class RequestIOErrorEvent extends IOErrorEvent 
	{
		public var url:String;
		public function RequestIOErrorEvent(type:String,url:String, bubbles:Boolean=false, cancelable:Boolean=false, text:String="", id:int=0) 
		{
			super(type, bubbles, cancelable, text, id);
		}
		
	}

}