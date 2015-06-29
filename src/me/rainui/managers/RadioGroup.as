package me.rainui.managers
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
	import me.rainui.components.Button;
	import me.rainui.events.RainUIEvent;
	import me.rainui.RainTheme;
	import me.rainui.RainUI;
	
	/**
	 * ...
	 * @author Rainssong
	 */
	public class RadioGroup extends ToggleGroup
	{
		private var _index:int = -1;
		
		public function RadioGroup()
		{
			super();
			_max = 1;
			_min = 1;
		}
		
		public function get index():int
		{
			return _index;
		}
		
		public function set index(value:int):void
		{
			if (_index == value)
			{
				return;
			}
			else
			{
				_index = value;
				for (var i:int = 0; i < _btnVec.length; i++)
				{
					var btn:Button = _btnVec[i];
					if (i == _index)
						btn.selected = true;
					else
						btn.selected = false;
				}
				dispatchEvent(new RainUIEvent(RainUIEvent.CHANGE, value));
			}
			
			dispatchEvent(new RainUIEvent(RainUIEvent.SELECT, value));
		
		}
		
		override protected function onSelect(e:RainUIEvent):void
		{
			var btn:Button = e.currentTarget as Button;
			
			var i:int = _btnVec.indexOf(btn);
			
			index = i;
			
			super.onSelect(e);
		}
		
		override protected function onChange(e:RainUIEvent):void 
		{
			//super.onChange(e);
			//
			//var btn:Button = e.currentTarget as Button;
			//if (indexs.length > _max)
				//btn.selected = false;
			//if (indexs.length <_min)
				//btn.selected = true;
				
			//dispatchEvent(new RainUIEvent(RainUIEvent.CHANGE, _index));
		}
	
	}

}