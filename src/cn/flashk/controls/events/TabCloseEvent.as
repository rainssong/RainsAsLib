package cn.flashk.controls.events
{
	import flash.events.Event;

	public class TabCloseEvent extends Event
	{
		public static const TAB_CLOSE:String = "tabClose";
		
		private var _tabIndex:uint;
		private var _label:String;
		
		public function TabCloseEvent(type:String,tabIndex:uint,labelName:String)
		{
			super(type);
			_tabIndex = tabIndex;
			_label = labelName;
		}
		public function get index():uint{
			return _tabIndex;
		}
		public function get label():String{
			return _label;
		}
	}
}