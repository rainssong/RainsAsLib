package  me.rainssong.events
{
	import flash.events.Event;
	import me.rainssong.events.DataEvent;
	
	/**
	 * ...
	 * @author rainssong
	 */
	public class DragEvent extends Event 
	{
		static public const STOP_DRAG:String = "stopDrag";
		static public const START_DRAG:String = "startDrag";
		static public const OFF_DRAGGING:String = "offDragging";
		static public const ON_DRAGGING:String = "onDragging";
		static public const MOVE_END:String = "moveEnd";
		private var _speedX:Number;
		private var _speedY:Number;
		public function DragEvent(type:String, speedX:Number = 0, speedY:Number = 0 , bubbles:Boolean = false, cancelable:Boolean = false) 
		{
			_speedX = speedX;
			_speedY = speedY;
			super(type, bubbles, cancelable);
		}
		
		public function get speedX():Number 
		{
			return _speedX;
		}
		
		public function get speedY():Number 
		{
			return _speedY;
		}
		
	}

}