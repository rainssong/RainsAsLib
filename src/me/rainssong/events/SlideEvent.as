package  me.rainssong.events
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author rainssong
	 */
	public class SlideEvent extends MyEvent 
	{
		
		static public const ROLL_TO:String = "rollTo";
		static public const ROLL_NEXT:String = "rollNext";
		static public const ROLL_PREV:String = "rollPrev";
		static public const ROLL_COMPLETE:String = "rollComplete";
		static public const START_ROLL:String = "startRoll";
		
		public function SlideEvent(type:String, data:*=null,bubbles:Boolean=false,cancelable:Boolean=false) 
		{
			super(type, data, bubbles, cancelable);
		}
		
	}

}