package cn.flashk.controls.events
{
	import flash.events.Event;

	public class AlertCloseEvent extends Event
	{
		private var _index:uint;
		private var _label:String;
		
		public function AlertCloseEvent(type:String,index:uint,label:String)
		{
			super(type);
			_index = index;
			_label = label;
		}
		public function get clickButtonIndex():uint{
			return _index;
			
		}
		public function get clickButtonLabel():String{
			return _label;
		}
	}
}