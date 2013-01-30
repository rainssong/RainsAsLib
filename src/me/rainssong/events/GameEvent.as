package me.rainssong.events
{
	import flash.events.Event;
	import me.rainssong.events.MyEvent;
	
	/**
	 * ...
	 * @author Rainssong
	 */
	public class GameEvent extends Event
	{
		static public const GAME_START:String = "gameStart";
		
		static public const GAME_OVER:String = "gameOver";
		
		static public const SUBMIT_SCORE:String = "submitScore";
		
		static public const SHOW_HIGH_SCORE:String = "showHighScore";
		static public const LOAD:String = "load";
		static public const SAVE:String = "save";
		static public const RESET:String = "reset";
	
		
		public function GameEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false)
		{
			super(type, bubbles, cancelable);
		
		}
		
		public override function clone():Event
		{
			return new GameEvent(type, bubbles, cancelable);
		}
		
		public override function toString():String
		{
			return formatToString("GameEvent", "type", "bubbles", "cancelable", "eventPhase");
		}
	
	}

}