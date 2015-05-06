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
		private var _label:Label;
		
		public function Header()
		{
			super();
		}
		
		override protected function preinitialize():void
		{
			super.preinitialize();
			this._percentWidth = 1;
			this._top = 0;
			this._height = 80;
			this._mouseEnabled = false;
			this._mouseChildren = true;
		}
		
		override protected function createChildren():void
		{
			if (_bgSkin == null)
			{
				var shape:Shape = new Shape();
				Draw.rect(shape, 0, 0, 100, 100, RainTheme.BLUE);
				Draw.rect(shape, 0, 96, 100, 4, RainTheme.DARK_BLUE);
				shape.scale9Grid = new Rectangle(4, 4, 92, 92);
				_bgSkin = shape;
				addChild(_bgSkin);
			}
			
			if (_label == null)
			{
				_label = new Label("");
				addChild(_label);
				_label.centerX = 0;
				_label.centerY = 0;
				_label.format = RainUI.getTextFormat(RainTheme.WHITE_TEXT_FORMAT);
				_label.align = TextFormatAlign.CENTER;
				_label.autoSize = true;
			}
			
			super.createChildren();
		}
		
		override protected function initialize():void
		{
			super.initialize();
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
		
		public function get label():Label 
		{
			return _label;
		}
		
		public function set label(value:Label):void 
		{
			_label = value;
		}
	
	}

}