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
	import flash.text.TextFormatAlign;
	import me.rainssong.utils.Draw;
	import me.rainui.events.RainUIEvent;
	import me.rainui.RainTheme;
	import me.rainui.RainUI;
	
	/**
	 * ...
	 * @author Rainssong
	 */
	public class Header extends Container
	{
		//public var btnSkinClass:Class = Button;
		private var _index:int = -1;
		public var label:Label;
		
		public function Header()
		{
			super();
		}
		
		override protected function preinitialize():void
		{
			super.preinitialize();
			this.percentWidth = 1;
			this._top = 0;
			this._height = 80;
			this.mouseEnabled = false;
			this.mouseChildren = true;
		}
		
		override protected function createChildren():void
		{
			if (_bgSkin == null)
			{
				var shape:Shape = new Shape();
				Draw.rect(shape, 0, 0, 100, 100,RainTheme.BLUE);
				Draw.rect(shape, 0, 96, 100, 4, RainTheme.DARK_BLUE);
				shape.scale9Grid = new Rectangle(4, 4, 92, 92);
				bgSkin = shape;
			}
			redraw();
			
			if (label == null)
				label = new Label("");
			
			addChild(label);
			label.centerX = 0;
			label.centerY = 0;
			label.format = RainTheme.getTextFormat(RainTheme.WHITE_TEXT_FORMAT);
			label.align = TextFormatAlign.CENTER;
			label.autoSize = true;
			//label.borderVisible = true;
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
		
	
		
		
		public function set index(value:int):void 
		{
			_index = value;
		}
		
		/* DELEGATE me.rainui.components.Label */
		
		public function get text():String 
		{
			return label.text;
		}
		
		public function set text(value:String):void 
		{
			label.text = value;
		}
	
	}

}