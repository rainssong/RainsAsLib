package  me.rainssong.events
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author rainssong
	 */
	public class DataEvent extends Event 
	{
		public var  data:*;
		
		public function DataEvent(type:String, data:*=null,bubbles:Boolean=false,cancelable:Boolean=false) 
		{
			super(type,bubbles,cancelable);
			this.data = data;
			
		}
		
	}

}