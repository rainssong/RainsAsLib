/**
 * Morn UI Version 2.1.0623 http://www.mornui.com/
 * Feedback yungzhu@gmail.com http://weibo.com/newyung
 */
package me.rainui.components {
	import flash.display.Shape;
	import flash.events.Event;
	import flash.events.TextEvent;
	import flash.geom.Rectangle;
	import flash.text.TextFieldType;
	import me.rainssong.utils.Draw;
	
	/**当用户输入文本时调度*/
	[Event(name="textInput",type="flash.events.TextEvent")]
	
	/**输入框*/
	public class TextInput extends Label {
		
		public function TextInput(text:String = "", skinName:String = null) {
			super(text,skinName);
		}
		
		override protected function createChildren():void 
		{
			super.createChildren();
			if (this.bgSkin == null)
			{
				var shape:Shape = new Shape();
				shape.graphics.lineStyle(3, 0x666666, 1);
				shape.graphics.drawRoundRect(0, 0, this._width, this._height, 10, 10);
				shape.scale9Grid = new Rectangle(10, 10, this._width-2*10, this._height-2*10);
				bgSkin = shape;
			}
			redraw();
		}
		
		override protected function initialize():void {
			super.initialize();
			
			selectable = true;
			textField.type = TextFieldType.INPUT;
			textField.autoSize = "none";
			textField.addEventListener(Event.CHANGE, onTextFieldChange);
			textField.addEventListener(TextEvent.TEXT_INPUT, onTextFieldTextInput);
		}
		
		private function onTextFieldTextInput(e:TextEvent):void {
			dispatchEvent(e);
		}
		
		protected function onTextFieldChange(e:Event):void {
			text = textField.text;
		}
		
		override public function resize():void 
		{
			super.resize();
			
		}
		
		/**指示用户可以输入到控件的字符集*/
		public function get restrict():String {
			return textField.restrict;
		}
		
		public function set restrict(value:String):void {
			textField.restrict = value;
		}
		
		/**是否可编辑*/
		public function get editable():Boolean {
			return textField.type == TextFieldType.INPUT;
		}
		
		public function set editable(value:Boolean):void {
			textField.type = value ? TextFieldType.INPUT : TextFieldType.DYNAMIC;
		}
		
		/**最多可包含的字符数*/
		public function get maxChars():int {
			return textField.maxChars;
		}
		
		public function set maxChars(value:int):void {
			textField.maxChars = value;
		}
	}
}