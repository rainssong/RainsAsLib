package  me.rainssong.controls
{
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import me.rainssong.controls.MyRadioBtn;

	/**
	 * ...
	 * @author rainsong
	 */
	public class MyRadioButtonGroup
	{
		static public const DEFAULT_GROUP:String = "defaultGroup";
		
		
		protected static var _selection:MyRadioBtn;
		
		protected static var buttons:Array = [];
		
		public static var addBtn(btn:MyRadioBtn):void
		{
			buttons.push(btn);
			if (radioButton.selected) { selection = btn; }
		
		}
		
		public static function removeBtn(btn:MyRadioBtn):void 
		{
			var i:int = getRadioButtonIndex(btn);
			if (i != -1) {
				buttons.splice(i, 1);
			}
			if (_selection == radioButton) { _selection = null; }
		}
		
		protected static function clear(btn:MyRadioBtn):void
		{
			for(var i:uint = 0; i < buttons.length; i++)
			{
				if(buttons[i] != btn && buttons[i].groupName == btn.groupName)
				{
					buttons[i].selected = false;
				}
			}
		}
		
		static public function get selection():MyRadioBtn 
		{
			return _selection;
		}
		
		static public function set selection(value:MyRadioBtn):void 
		{
			clear(value);
			_selection = value;
		}
		
		public function get numRadioButtons():int {
			return buttons.length;
		}
		
	}
}