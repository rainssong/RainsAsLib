package cn.flashk.events
{
	import flash.events.Event;

	public class MovieEvent extends Event
	{
		public static const BACK_PLAY_ENDED:String = "backPlayEnded";
		public static const PLAY_ENDED:String = "playEnded";
		
		public function MovieEvent(type:String)
		{
			super(type);
		}
	}
}