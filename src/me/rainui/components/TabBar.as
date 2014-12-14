package me.rainui.components
{
	import adobe.utils.CustomActions;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.Shape;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	import me.rainssong.utils.Draw;
	import me.rainui.events.RainUIEvent;
	import me.rainui.RainTheme;
	import me.rainui.RainUI;
	
	/**
	 * ...
	 * @author Rainssong
	 */
	public class TabBar extends Container
	{
		//public var btnSkinClass:Class = Button;
		private var _itemData:Array;
		private var _btnVec:Vector.<TabButton>;
		private var _index:int = -1;
		
		public function TabBar()
		{
			super();
		}
		
		override protected function preinitialize():void
		{
			super.preinitialize();
			this.percentWidth = 1;
			this._bottom = 0;
			this._height = 100;
			this.mouseEnabled = false;
			this.mouseChildren = true;
		}
		
		override protected function createChildren():void
		{
			if (bgSkin == null)
			{
				var shape:Shape = new Shape();
				Draw.rect(shape, 0, 0, 100, 100,RainTheme.BLUE);
				Draw.rect(shape, 0, 96, 100, 4, RainTheme.DARK_BLUE);
				shape.scale9Grid = new Rectangle(4, 4, 92, 92);
				bgSkin = shape;
			}
			redraw();
		}
		
		override protected function initialize():void 
		{
			super.initialize();
			
		}
		
		override public function resize():void
		{
			super.resize();
			if (bgSkin)
			{
				bgSkin.width = _width;
				bgSkin.height = _height;
			}
		}
		
		public function get btnVec():Vector.<TabButton>
		{
			return _btnVec;
		}
		
		public function set btnVec(value:Vector.<TabButton>):void
		{
			_btnVec = value;
			for (var i:int = 0; i < value.length; i++)
			{
				var btn:TabButton = value[i];
				btn.name = "item" + value.length;
				
				btn.percentHeight = 1;
				btn.percentWidth = 1 / value.length;
				btn.percentLeft = i / value.length;
				btn.addEventListener(RainUIEvent.SELECT, onSelect);
				//btn.resize();
				addChild(btn);
				
			}
			resize();
		}
		
		public function get index():int 
		{
			return _index;
		}
		
		public function set index(value:int):void 
		{
			_index = value;
			_btnVec[value].selected = true;
		}
		
		private function onSelect(e:RainUIEvent):void
		{
			var btn:TabButton=e.currentTarget as TabButton
			
			var index:int = _btnVec.indexOf(btn);
			
			select(index);
		}
		
		public function select(value:int):void
		{
			sendEvent(RainUIEvent.SELECT, value);
			if (_index == value)
			{
				
			}
			else
			{
				_index = value;
				sendEvent(RainUIEvent.CHANGE, value);
				for (var i:int = 0; i < _btnVec.length; i++)
				{
					var btn:Button = _btnVec[i];
					if (i == _index)
						btn.selected = true;
					else
						btn.selected = false;
				}
			}
		}
	
	}

}