package cn.flashk.controls.support 
{
	import cn.flashk.controls.RadioButton;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	/**
	 * RadioButtonGroup 类将一组 RadioButton 组件定义为单个组件。 选中一个单选按钮后，不能再选中同一组中的其它单选按钮。 
	 * @author flashk
	 */
	public class RadioButtonGroup extends EventDispatcher
	{
		private static var groups:Object = new Object();
		private var radios:Array = new Array();
		private var _selecttion:RadioButton;
		private var _name:String;
		
		public function RadioButtonGroup(name:String) 
		{
			_name = name;
		}
		/**
		 * 检索对指定单选按钮组的引用。
		 */ 
		public static function getGroup(name:String):RadioButtonGroup {
			if (groups[name] == null) {
				groups[name] = new RadioButtonGroup(name);
			}
			return groups[name];
		}
		/**
		 * 获取单选按钮的实例名称。
		 */ 
		public function get name():String{
			return _name;
		}
		/**
		 * 获取此单选按钮组中的单选按钮数。
		 */ 
		public function get numRadioButtons():uint {
			return radios.length;
		}
		/**
		 * 获取或设置对当前从单选按钮组中选择的单选按钮的引用。
		 */ 
		public function get selection():RadioButton {
			return _selecttion;
		}
		public function set selection(value:RadioButton):void {
			setOneSelect({currentTarget:value});
		}
		/**
		 * 获取或设置所选单选按钮的 value 属性。
		 */ 
		public function get selectedData():Object {
			return _selecttion.value;
		}
		public function set selectedData(value:Object):void {
			for (var i:int = 0; i < radios.length; i++) 
			{
				if (radios[i].value == value) {
					setOneSelect({currentTarget:radios[i]});
				}
			}
		}
		/**
		 * 向内部单选按钮数组添加一个单选按钮，以用于单选按钮组索引，这样可允许在单选按钮组中单独选择一个单选按钮。
		 */ 
		public function addRadioButton(radioButton:RadioButton):void {
			if (getRadioButtonIndex(radioButton) == -1) {
				radios.push(radioButton);
				radioButton.addEventListener(Event.CHANGE, setOneSelect);
			}
		}
		/**
		 * 返回指定 RadioButton 实例的索引。
		 */ 
		public function getRadioButtonIndex(radioButton:RadioButton):int {
			var index:int = -1;
			for (var i:int = 0; i < radios.length; i++) 
			{
				if (radios[i] == radioButton) {
					index = i;
				}
			}
			
			return index;
		}
		/**
		 * 从内部单选按钮列表中清除 RadioButton 实例。
		 */ 
		public function removeRadioButton(radioButton:RadioButton):void {
			radioButton.removeEventListener(Event.CHANGE, setOneSelect);
			for (var i:int = 0; i < radios.length; i++) 
			{
				if (radios[i] == radioButton) {
					radios.splice(i, 1);
				}
			}
		}
		private function setOneSelect(event:Object):void {
			var tar:RadioButton = event.currentTarget as RadioButton;
			_selecttion = tar;
			if (tar.selected == false) {
				return;
			}
			for (var i:int = 0; i < radios.length; i++) 
			{
				if (radios[i] != event.currentTarget) {
					RadioButton(radios[i]).selected = false;
				}
			}
		}
	}

}