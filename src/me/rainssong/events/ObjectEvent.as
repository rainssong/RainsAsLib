package  me.rainssong.events
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author rainssong
	 */
	public class ObjectEvent extends Event 
	{
		//static public const SUCCESS:String = "unselect";
		//static public const FAILED:String = "unselect";
		//static public const UNSELECT:String = "unselect";
		//static public const UNSELECT:String = "unselect";
		static public const UNSELECT:String = "unselect";
		public var  data:*;
		
		
		public function ObjectEvent(type:String, data:*=null,bubbles:Boolean=false,cancelable:Boolean=false) 
		{
			super(type,bubbles,cancelable);
			this.data = data;
		}
		
		public override function clone():Event
		{
			return new ObjectEvent(type,data, bubbles, cancelable);
		}
		
		public override function toString():String
		{
			
			return formatToString("ObjectEvent", "type","data", "bubbles", "cancelable", "eventPhase");
		}
	}

}