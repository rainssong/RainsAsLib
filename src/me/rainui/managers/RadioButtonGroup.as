package me.rainui.managers 
{
	import flash.events.EventDispatcher;
	import me.rainui.components.Button;
	import me.rainui.components.RadioButton;
	import me.rainui.events.RainUIEvent;
	/**
	 * 过时,用RadioGroup代替
	 * @author Rainssong
	 */
	public class RadioButtonGroup  extends EventDispatcher
	{
		private var _group:Vector.<RadioButton> = new Vector.<RadioButton>();
		private var _index:int = -1;
		
		public function RadioButtonGroup() 
		{
			
		}
		
		public function get group():Vector.<RadioButton> 
		{
			return _group;
		}
		
		public function set group(value:Vector.<RadioButton>):void 
		{
			for each (var item:RadioButton in _group) 
			{
				item.removeEventListener(RainUIEvent.SELECT, onSelect);
			}
				_group = value;
			for (var i:int = 0; i < value.length; i++) 
			{
				_group[i].addEventListener(RainUIEvent.SELECT, onSelect);
			}
		}
		
		public function get index():int 
		{
			return _index;
		}
		
		public function set index(value:int):void 
		{
			_index = value;
			if (_group.length>value)
				_group[value].selected = true;
		}
		
		private function onSelect(e:RainUIEvent):void
		{
			var btn:RadioButton=e.currentTarget as RadioButton
			
			var index:int = _group.indexOf(btn);
			
			select(index);
		}
		
		public function select(value:int):void
		{
			dispatchEvent(new RainUIEvent(RainUIEvent.SELECT, value));
			if (_index == value)
			{
				
			}
			else
			{
				_index = value;
				dispatchEvent(new RainUIEvent(RainUIEvent.CHANGE, value));
				for (var i:int = 0; i < _group.length; i++)
				{
					var btn:Button = _group[i];
					if (i == _index)
						btn.selected = true;
					else
						btn.selected = false;
				}
			}
		}
		
		
		
	}

}