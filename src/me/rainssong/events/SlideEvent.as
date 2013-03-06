package  me.rainssong.events
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author rainssong
	 */
	public class SlideEvent extends DataEvent 
	{
		
		static public const ROLL_TO:String = "rollTo";
		static public const ROLL_NEXT:String = "rollNext";
		static public const ROLL_PREV:String = "rollPrev";
		static public const ROLL_COMPLETE:String = "rollComplete";
		static public const START_ROLL:String = "startRoll";
		static public const ALREADY_LAST_PAGE:String = "alreadyLastPage";
		static public const ALREADY_FIRST_PAGE:String = "alreadyFirstPage";
		static public const PUSH_SLIDE:String = "pushSlide";
		static public const CLICK_SLIDE:String = "clickSlide";
		static public const LOCK:String = "lock";
		static public const UNLOCK:String = "unlock";
		static public const ROLLING:String = "rolling";
		
		public function SlideEvent(type:String, data:*=null,bubbles:Boolean=false,cancelable:Boolean=false) 
		{
			super(type, data, bubbles, cancelable);
		}
		
	}

}