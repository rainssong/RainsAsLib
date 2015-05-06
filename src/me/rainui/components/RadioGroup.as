package me.rainui.components
{
	import adobe.utils.CustomActions;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.Shape;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	import flash.utils.Dictionary;
	import me.rainssong.math.ArrayCore;
	import me.rainssong.utils.Draw;
	import me.rainui.events.RainUIEvent;
	import me.rainui.RainTheme;
	import me.rainui.RainUI;
	
	/**
	 * ...
	 * @author Rainssong
	 */
	public class RadioGroup  extends EventDispatcher
	{
		//public var btnSkinClass:Class = Button;
		private var _radioBtnVec:Vector.<RadioButton> = new Vector.<RadioButton>();
		private var _index:int = -1;
		
		public function RadioGroup()
		{
			super();
		}
		
		public function get radioBtnVec():Vector.<RadioButton>
		{
			return _radioBtnVec;
		}
		
		public function set radioBtnVec(value:Vector.<RadioButton>):void
		{
			//_radioBtnVec = value;
			radioBtnVec.length = 0;
			for (var i:int = 0; i < value.length; i++) 
			{
				addButton(value[i]);
			}
		}
		
		public function addButton(radioButton:RadioButton):void
		{
			if (_radioBtnVec.indexOf(radioButton) == -1)
			{
				_radioBtnVec.push(radioButton);
				radioButton.addEventListener(RainUIEvent.SELECT, onSelect);
			}
		}
		
		public function removeButton(radioButton:RadioButton):void
		{
			if (_radioBtnVec.indexOf(radioButton) > -1)
			{
				_radioBtnVec.splice(_radioBtnVec.indexOf(radioButton),1);
				radioButton.removeEventListener(RainUIEvent.SELECT, onSelect);
			}
		}
		
		public function get index():int 
		{
			return _index;
		}
		
		public function set index(value:int):void 
		{
			if (value < 0)
				if( _radioBtnVec[_index])
					_radioBtnVec[_index].selected = false;
			else
				_radioBtnVec[value].selected = true;
			
			_index = value;
		}
		
		private function onSelect(e:RainUIEvent):void
		{
			var btn:RadioButton = e.currentTarget as RadioButton;
			
			var index:int = _radioBtnVec.indexOf(btn);
			
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
				for (var i:int = 0; i < _radioBtnVec.length; i++)
				{
					var btn:RadioButton = _radioBtnVec[i];
					if (i == _index)
						btn.selected = true;
					else
						btn.selected = false;
				}
			}
		}
	
	}

}