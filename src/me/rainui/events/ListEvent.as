
package me.rainui.events {
	import flash.events.Event;
	import me.rainssong.events.ObjectEvent;
	
	/**UI事件类*/
	public class ListEvent extends RainUIEvent {
		static public const UPDATE_ITEM:String = "updateItem";
		
		public function ListEvent(type:String, data:*, bubbles:Boolean = false, cancelable:Boolean = false) {
			super(type, data, bubbles, cancelable);
		}
		
		override public function clone():Event {
			return new RainUIEvent(type,data, bubbles, cancelable);
		}
	}
}