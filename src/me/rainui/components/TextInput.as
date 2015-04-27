/**
 * Morn UI Version 2.1.0623 http://www.mornui.com/
 * Feedback yungzhu@gmail.com http://weibo.com/newyung
 */
package me.rainui.components
{
	import flash.display.DisplayObject;
	import flash.display.Shape;
	import flash.events.Event;
	import flash.events.TextEvent;
	import flash.geom.Rectangle;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFieldType;
	import me.rainssong.utils.Align;
	import me.rainssong.utils.Color;
	import me.rainssong.utils.Draw;
	import me.rainui.RainTheme;
	import me.rainui.RainUI;
	
	/**当用户输入文本时调度*/
	[Event(name="textInput",type="flash.events.TextEvent")]
	
	/**输入框*/
	public class TextInput extends Label
	{
		//static public var defaultBgSkinRender:Function = getDefaultBgSkin;
		
		public function TextInput(text:String = "", dataSource:Object = null)
		{
			super(text, dataSource);
		}
		
		override protected function preinitialize():void 
		{
			super.preinitialize();
			_autoSize = false;
			//mouseEnabled = true;
		}
		
		override protected function createChildren():void
		{
			if (_bgSkin == null)
			{
				_bgSkin = RainUI.getSkin("textInput");
			}
			super.createChildren();
			
			redraw();
		}
		
		override protected function initialize():void
		{
			super.initialize();
			
			selectable = true;
			textField.type = TextFieldType.INPUT;
			//textField.autoSize = TextFieldAutoSize.LEFT;
			_contentAlign = Align.LEFT;
			_autoSize = false;
			textField.addEventListener(Event.CHANGE, onTextFieldChange);
			textField.addEventListener(TextEvent.TEXT_INPUT, onTextFieldTextInput);
		}
		

		
		public function get type():String
		{
			return textField.type
		}
		
		public function set  type(value:String):void
		{
			textField.type = value;
		}
		
		private function onTextFieldTextInput(e:TextEvent):void
		{
			dispatchEvent(e);
		}
		
		protected function onTextFieldChange(e:Event):void
		{
			callLater(redraw);
			sendEvent(Event.CHANGE);
		}
		
		override public function resize():void
		{
			super.resize();
		
		}
		
		/**指示用户可以输入到控件的字符集*/
		public function get restrict():String
		{
			return textField.restrict;
		}
		
		public function set restrict(value:String):void
		{
			textField.restrict = value;
		}
		
		/**是否可编辑*/
		public function get editable():Boolean
		{
			return textField.type == TextFieldType.INPUT;
		}
		
		public function set editable(value:Boolean):void
		{
			textField.type = value ? TextFieldType.INPUT : TextFieldType.DYNAMIC;
		}
		
		/**最多可包含的字符数*/
		public function get maxChars():int
		{
			return textField.maxChars;
		}
		
		public function set maxChars(value:int):void
		{
			textField.maxChars = value;
		}
		
	}
}