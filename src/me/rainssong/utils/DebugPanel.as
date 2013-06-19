package me.rainssong.utils
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
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
	
		public static const VERSION:String = "1.2";
		private static const INFORMATION:String = "DebugPanel" + VERSION + "\nF1:Help\nF4:Run/Stop\nF5:Refreash\nF6:Hide/Show";
		private static var _contentVec:Vector.<String> = new Vector.<String>();
		//public static var TransformGestureEvent:Class
		private static var _bg:Bitmap = new Bitmap(new BitmapData(100, 100, false, 0x00000000));
		
		/**
		 *
		 * @param	maxLine 最大行数
		 * @param	traceIt 是否同步Trace
		 */
		public function DebugPanel(maxLine:int = 10, traceIt:Boolean = false,width:Number=200)
		{
			super();
			
			if (_instance)
				return;
			
			_instance = this;
			//this.mouseChildren = false;
			_textField = new TextField();
			
			_maxLine = maxLine;
			_traceIt = traceIt;
			//_isWorking = true;
			
			//addChild(_bg);
			//_bg.alpha = 0.6;
			addChild(_textField);
			_textField.multiline = true;
			_textField.wordWrap = true
			_textField.background = true;
			_textField.backgroundColor = 0x444444;
			_textField.alpha = 0.6;
			_textField.textColor = 0xFFFFFF;
			_textField.selectable = false;
			_textField.mouseEnabled = false;
			_textField.height = Number(_textField.defaultTextFormat.size) * (_maxLine-1)+4;
			_textField.width = width;
			
			
			
			addEventListener(Event.ADDED_TO_STAGE, onAdd);
			addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
			addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
			addEventListener(MouseEvent.MOUSE_OUT, onMouseUp);
		
			print(INFORMATION);
		
			resize();
			//TransformGestureEvent = getDefinitionByName("flash.events.TransformGestureEvent") as Class;
			//if(TransformGestureEvent)
			//addEventListener(TransformGestureEvent.GESTURE_ZOOM, onZoom);
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
			if (!_instance)
				return;
			
			if (_traceIt)
				trace(_instance, arg);
			
			
			for (var i:int = 0; i < arg.length; i++)
			{
				_textField.htmlText = _textField.htmlText.concat(arg[i]);
			}
			_textField.scrollV = _textField.numLines;
			resize();
		}
		
		/**
		 * 自动调整宽高位置
		 */
		static protected function resize():void
		{
			
			if (!_instance.stage)
				return;
			
			//_bg.width = _textField.textWidth;
			//_bg.height = Math.min(_textField.textHeight, _textField.height);
			
			if (_instance.x + _instance.width < 0)
				_instance.x = 0;
			if (_instance.x > _instance.stage.stageWidth)
				_instance.x = _instance.stage.stageWidth - _instance.width;
			if (_instance.y + _instance.height < 0)
				_instance.y = 0;
			if (_instance.y > _instance.stage.stageHeight)
				_instance.y = _instance.stage.stageHeight - _instance.height;
		}
		
		public static function replace(... arg):void
		{
			if (!_instance)
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
			
		}
		
		private function onMouseDown(e:MouseEvent):void
		{
			startDrag();
			
		}
		
		private function onKeyDown(e:KeyboardEvent):void
		{
			switch (e.keyCode)
			{
				case Keyboard.F1: 
					print(INFORMATION);
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
			if (!_instance)
				return;
			_textField.text = "";
		
		}
	
	}

}