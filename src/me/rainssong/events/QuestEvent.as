package me.rainssong.events 
{
	import flash.events.Event;
	import me.rainssong.events.DataEvent;
	import me.rainssong.quest.VO.QuestModel;
	
	/**
	 * ...
	 * @author Rainssong
	 */
	public class QuestEvent extends Event 
	{
		static public const COMPLETE:String = "complete";

		private var _questModel:QuestModel;
		
		public function QuestEvent(type:String,questModel:QuestModel, bubbles:Boolean=false, cancelable:Boolean=false) 
		{ 
			super(type, bubbles, cancelable);
			_questModel = questModel;
		} 
		
		public override function clone():Event 
		{ 
			return new QuestEvent(type,_questModel, bubbles, cancelable);
		} 
		
		public override function toString():String 
		{ 
			return formatToString("QuestEvent", "type", "bubbles", "cancelable", "eventPhase"); 
		}
		
		public function get questModel():QuestModel 
		{
			return _questModel;
		}
		
	}
	
}