package game 
{
	
	/**
	 * ...
	 * @author Rainssong
	 */
	public interface IGame 
	{
		public function start():void
		public function end():void
		public function pause():void
		public function resume():void
		public function get isPaused():Boolean
	}
	
}