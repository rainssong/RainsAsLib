package me.rainssong.utils
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	
	import flash.text.TextField;
	import flash.ui.Keyboard;
	import flash.utils.getDefinitionByName;
	import flash.utils.setTimeout;
	
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
		public static const VERSION:String = "1.2";
		private static const INFORMATION:String = "DebugPanel" + VERSION + "\nF1:Help\nF4:Run/Stop\nF5:Refreash\nF6:Hide/Show";
		private static var _contentVec:Vector.<String> = new Vector.<String>();
		public static var TransformGestureEvent:Class
		
		/**
		 * 
		 * @param	maxLine 最大行数
		 * @param	traceIt 是否同步Trace
		 */
		public function DebugPanel(maxLine:int = 10, traceIt:Boolean = false)
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
			_textField.multiline = true;
			_textField.background = true;
			_textField.backgroundColor = 0x444444;
			_textField.alpha = 0.6;
			_textField.textColor = 0xFFFFFF;
			_textField.selectable = false;
			
			TransformGestureEvent = getDefinitionByName("flash.events.TransformGestureEvent") as Class;
			
			addEventListener(TransformGestureEvent.GESTURE_ZOOM, onZoom);
			addEventListener(Event.ADDED_TO_STAGE, onAdd);
			addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
			addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
			addEventListener(MouseEvent.MOUSE_OUT, onMouseUp);
			addEventListener(MouseEvent.CLICK, onClick);
			print(INFORMATION);
		}
		
		private function onZoom(e:*):void
		{
			var target:DisplayObject = e.target as DisplayObject;
		
			
			target.scaleX *= e.scaleX;
			target.scaleX = target.scaleX < 0.3 ? 0.3 : target.scaleX;
			target.scaleY *= e.scaleY;
			target.scaleY = target.scaleY < 0.3 ? 0.3 : target.scaleY;
			resize();
		}
		
		public static function print(... arg):void
		{
			if (!_instance || !_isWorking)
				return;
			
			var caller:String = "[" + new Error().getStackTrace().match(/[\w\/$]*\(\)/g)[1] + "]";
			if (_traceIt)
				trace(caller, arg);
			
			_contentVec.push(arg.toString() + "\n");
			if (_contentVec.length > _maxLine)
				_contentVec.shift();
			_textField.htmlText = "";
			
			for (var i:int = 0; i < _contentVec.length; i++)
			{
				_textField.htmlText = _textField.htmlText.concat(_contentVec[i]);
			}
			//if (_textField.numLines > _maxLine)
			//{
			//_textField.replaceText(0, _textField.getLineOffset(_textField.numLines - _maxLine + 1), "");
			//_textField.setSelection(0, _textField.getLineOffset(_textField.numLines - _maxLine + 1));
			//
			//
			//_textField.text = _textField.text.substr(_textField.text.indexOf(_textField.getLineText(2)));
			//
			//}
			
			resize();
		}
		
		/**
		 * 自动调整宽高位置
		 */
		static protected function resize():void
		{
			
			
			_textField.wordWrap = false;
			if (_instance.stage && _textField.textWidth >= _instance.stage.stageWidth)
			{
				_textField.width = _instance.stage.stageWidth;
				_textField.wordWrap = true;
			}
			//else if (_instance.stage && _textField.textWidth < _instance.stage.stageWidth - 20)
			//{
			//_textField.wordWrap = false;
			//}
			_textField.height = _textField.textHeight + 6;
			_textField.width = Math.max(_textField.textWidth + 6);
			
			if (!_instance.stage)
				return;
			if (_instance.x + _instance.width < 0)
				_instance.x = 0;
			if (_instance.x > _instance.stage.stageWidth)
				_instance.x = _instance.stage.stageWidth-_instance.width;
			if (_instance.y + _instance.height < 0)
				_instance.y = 0;
			if (_instance.y >_instance.stage.stageHeight)
				_instance.y = _instance.stage.stageHeight-_instance.height;
			
			
		}
		
		public static function replace(... arg):void
		{
			if (!_instance || !_isWorking)
				return;
			clear();
			print(arg);
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
					clear();
					break;
				case Keyboard.F6: 
					this.mouseEnabled = _instance.visible = !_instance.visible;
					break;
			}
		}
		
		static public function clear():void
		{
			if (!_instance || !_isWorking)
				return;
			_textField.text = "";
			_textField.height = 0;
			_textField.width = 0;
		}
	
	}

}