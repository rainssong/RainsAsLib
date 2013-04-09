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
		
		public override function clone():Event
		{
			return new DataEvent(type,data, bubbles, cancelable);
		}
		
		public override function toString():String
		{
			
			return formatToString("DataEvent", "type","data", "bubbles", "cancelable", "eventPhase");
		}
	}

}