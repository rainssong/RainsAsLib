package me.rainssong.utils
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.ui.Keyboard;
	
	/**
	 * ...
	 * @author rainssong
	 */
	public class DebugPanel extends Sprite
	{
		private static var _instance:DebugPanel;
		private static var _textField:TextField;
		private static var _maxLine:int;
		private static var _traceIt:Boolean
		private static var _isWorking:Boolean;
		public static const VERSION:String = "1.1";
		private static const INFORMATION:String = "DebugText" + VERSION + "\nF4:Run/Stop\nF5:Refreash\nF6:Hide/Show";
		
		public function DebugPanel(maxLine:int = 5, traceIt:Boolean = false)
		{
			super();
			
			if (_instance)
				return;
			
			_instance = this;
			this.mouseChildren = false;
			_textField = new TextField();
			
			addChild(_textField);
			_maxLine = maxLine;
			_isWorking = true;
			_traceIt = traceIt;
			
			_textField.height = 0;
			_textField.background = true;
			_textField.backgroundColor = 0x000000;
			_textField.alpha = 0.3;
			_textField.textColor = 0xFFFFFF;
			_textField.selectable = false;
			addEventListener(Event.ADDED_TO_STAGE, onAdd);
			addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
			addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
			addEventListener(MouseEvent.MOUSE_OUT, onMouseUp);
			addEventListener(MouseEvent.CLICK, onClick);
			print(INFORMATION);
		}
		
		public static function print(...arg):void
		{
			if (!_instance || !_isWorking)
				return;
			
			var caller:String = "[" + new Error().getStackTrace().match(/[\w\/$]*\(\)/g)[1] + "]";
			if (_traceIt) trace(caller, arg);
			_textField.appendText(arg.toString() + "\n");
			
			if (_textField.numLines > _maxLine)
			{
				_textField.replaceText(0, _textField.getLineOffset(_textField.numLines - _maxLine), "");
			}
			
			_textField.height = _textField.textHeight + 6;
			_textField.width = _textField.textWidth + 6;
		}
		
		private function onAdd(e:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAdd);
			this.stage.addChild(_instance);
			this.stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
		}
		
		private function onMouseUp(e:MouseEvent):void 
		{
			stopDrag()
			removeEventListener(MouseEvent.CLICK, onClick);
		}
		
		private function onMouseDown(e:MouseEvent):void 
		{
			startDrag();
			removeEventListener(MouseEvent.CLICK, onClick);
		}
		
		private function onClick(e:MouseEvent):void 
		{
			_isWorking = !_isWorking;
		}
		
		private function onKeyDown(e:KeyboardEvent):void
		{
			switch (e.keyCode)
			{
				case Keyboard.F1: 
					print(INFORMATION);
					break;
				case Keyboard.F4: 
					_isWorking = !_isWorking;
					break;
				case Keyboard.F5: 
					_textField.text = "";
					_textField.height = 0;
					_textField.width = 0;
					break;
				case Keyboard.F6: 
					this.mouseEnabled = _instance.visible = !_instance.visible;
					break;
			}
		}
	
	}

}