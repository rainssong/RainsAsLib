package  me.rainssong.controls
{
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import me.rainssong.controls.MCRadioBtn;

	/**
	 * ...
	 * @author rainsong
	 */
	public class MyRadioButtonGroup
	{
		static public const DEFAULT_GROUP:String = "defaultGroup";
		
		
		protected static var _selection:MCRadioBtn;
		
		protected static var buttons:Array = [];
		
		public static function addBtn(btn:MCRadioBtn):void
		{
			buttons.push(btn);
			if (btn.selected) { selection = btn; }
		
		}
		
		public static function removeBtn(btn:MCRadioBtn):void 
		{
			var i:int = buttons.indexOf(btn);
			if (i != -1) {
				buttons.splice(i, 1);
			}
			if (_selection == btn) { _selection = null; }
		}
		
		protected static function clear(btn:MCRadioBtn):void
		{
			for(var i:uint = 0; i < buttons.length; i++)
			{
				if(buttons[i] != btn && buttons[i].groupName == btn.groupName)
				{
					buttons[i].selected = false;
				}
			}
		}
		
		static public function get selection():MCRadioBtn 
		{
			return _selection;
		}
		
		static public function set selection(value:MCRadioBtn):void 
		{
			clear(value);
			_selection = value;
		}
		
		public function get numRadioButtons():int {
			return buttons.length;
		}
		
	}
}