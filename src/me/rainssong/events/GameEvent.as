package me.rainssong.events
{
	import flash.events.Event;
	import me.rainssong.events.DataEvent;
	
	/**
	 * ...
	 * @author Rainssong
	 */
	public class GameEvent extends ApplicationEvent
	{
		static public const GAME_START:String = "gameStart";
		static public const GAME_OVER:String = "gameOver";
		static public const SUBMIT_SCORE:String = "submitScore";
		static public const SHOW_HIGH_SCORE:String = "showHighScore";
		static public const LOAD:String = "load";
		static public const SAVE:String = "save";
		static public const RESET:String = "reset";
		static public const RESUME:String = "resume";
		static public const PAUSE:String = "pause";
		static public const REPLAY:String = "replay";
		
		static public const LOAD_COMPLETE:String = "loadComplete";
		static public const SAVE_COMPLETE:String = "saveComplete";
		
		static public const WIN:String = "win";
		static public const LOSE:String = "lose";
		static public const NEXT_LEVEL:String = "nextLevel";
	
		
		public function GameEvent(type:String,data:*=null, bubbles:Boolean = false, cancelable:Boolean = false)
		{
			super(type,data, bubbles, cancelable);
		}
		
		public override function clone():Event
		{
			return new GameEvent(type,data, bubbles, cancelable);
		}
		
		public override function toString():String
		{
			return formatToString("GameEvent","data", "type", "bubbles", "cancelable", "eventPhase");
		}
	
	}

}