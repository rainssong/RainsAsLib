package me.rainssong.events 
{
	import flash.events.Event;
	import me.rainssong.events.DataEvent;
	
	/**
	 * ...
	 * @author Rainssong
	 */
	public class QuestEvent extends Event 
	{
		static public const COMPLETE:String = "complete";
		private var _isRight:Boolean;
		
		public function QuestEvent(type:String,isRight:Boolean=false, bubbles:Boolean=false, cancelable:Boolean=false) 
		{ 
			super(type, bubbles, cancelable);
			_isRight = isRight;
		} 
		
		public override function clone():Event 
		{ 
			return new QuestEvent(type,isRight, bubbles, cancelable);
		} 
		
		public override function toString():String 
		{ 
			return formatToString("QuestEvent", "type", "bubbles", "cancelable", "eventPhase"); 
		}
		
		public function get isRight():Boolean 
		{
			return _isRight;
		}
		
	}
	
}