package me.rainssong.events 
{
	/**
	 * ...
	 * @author rainssong
	 */
	public class RequestEvent extends ObjectEvent 
	{
		public var url:String;
		public function RequestEvent(type:String,url:String="", data:*=null, bubbles:Boolean=false, cancelable:Boolean=false) 
		{
			super(type, data, bubbles, cancelable);
			
		}
		
	}

}