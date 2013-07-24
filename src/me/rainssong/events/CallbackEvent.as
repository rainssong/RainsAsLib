package  me.rainssong.events
{
	import flash.events.Event;
	
	/**
	 * Use this event when u just want to call some function
	 * @author rainssong
	 */
	public class CallbackEvent extends Event 
	{
		public var  func:Function;
		public var params:Array;
		
		public function CallbackEvent(type:String, func:Function,params:Array=null,bubbles:Boolean=false,cancelable:Boolean=false) 
		{
			super(type,bubbles,cancelable);
			this.func = func;
			this.params = params;
		}
		
		public override function clone():Event
		{
			return new ObjectEvent(type,data, bubbles, cancelable);
		}
		
		public override function toString():String
		{
			return formatToString("CallbackEvent", "type","data", "bubbles", "cancelable", "eventPhase");
		}
	}

}