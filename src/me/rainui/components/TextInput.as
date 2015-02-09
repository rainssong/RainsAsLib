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
	import flash.text.TextFieldType;
	import me.rainssong.utils.Color;
	import me.rainssong.utils.Draw;
	import me.rainui.RainTheme;
	
	/**当用户输入文本时调度*/
	[Event(name="textInput",type="flash.events.TextEvent")]
	
	/**输入框*/
	public class TextInput extends Label
	{
		static public var defaultBgSkinRender:Function = getDefaultBgSkin;
		
		public function TextInput(text:String = "", skinName:String = null)
		{
			super(text, skinName);
		}
		
		override protected function preinitialize():void 
		{
			super.preinitialize();
			_autoSize = false;
			//mouseEnabled = true;
		}
		
		override protected function createChildren():void
		{
			super.createChildren();
			if (this.bgSkin == null)
			{
				bgSkin = getDefaultBgSkin();
			}
			redraw();
		}
		
		override protected function initialize():void
		{
			super.initialize();
			
			selectable = true;
			textField.type = TextFieldType.INPUT;
			textField.autoSize = "none";
			
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
			text = textField.text;
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
		
		static public function getDefaultBgSkin():DisplayObject
		{
			var shape:Shape = new Shape();
			shape.graphics.beginFill(RainTheme.DARK_BLUE,0.8);
			//shape.graphics.lineStyle(4, 0x666666, 1);
			shape.graphics.drawRoundRect(0, 0, 80, 80,10, 10);
			shape.scale9Grid = new Rectangle(10, 10, 80 - 2 * 10 , 80 - 2 * 10);
			return shape;
		}
	}
}