package me.rainssong.utils
{
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.text.TextField;
	import flash.ui.Keyboard;
	import me.rainssong.application.ApplicationBase;
	import me.rainssong.application.ApplicationManager;
	
	/**
	 * ...
	 * @author rainssong
	 */
	public class DebugText extends TextField
	{
		private static var _instance:DebugText;
		private static var _maxLine:int;
		
		public function DebugText(maxLine:int = 4)
		{
			super();
			
			if (_instance)
				return;
			
			_instance = this;
			_maxLine = maxLine;
			this.height = 0;
			this.mouseEnabled = false;
			this.background = true;
			this.backgroundColor = 0x000000;
			this.alpha = 0.3;
			this.textColor = 0xFFFFFF;
			
			addEventListener(Event.ADDED_TO_STAGE, onAdd);
		}
		
		public static function trace(... arg):void
		{
			if (!_instance)
				return;
			
			if (_instance.numLines > _maxLine)
			{
				_instance.replaceText(0, _instance.getLineOffset(1), "");
			}
			_instance.appendText(arg.toString() + "\n");
			_instance.height = _instance.textHeight + 6;
			_instance.width = _instance.textWidth + 6;
		}
		
		private function onAdd(e:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAdd);
			this.stage.addChild(_instance);
			this.stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
		}
		
		private function onKeyDown(e:KeyboardEvent):void
		{
			switch (e.keyCode)
			{
				case Keyboard.F5: 
					_instance.text = "";
					_instance.height = 0;
					_instance.width = 0;
					break;
				case Keyboard.F6: 
					_instance.visible = !_instance.visible;
					break;
			}
		}
	
	}

}