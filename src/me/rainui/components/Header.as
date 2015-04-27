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
		private var _index:int = -1;
		public var label:Label;
		
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
			
			if (label == null)
			{
				label = new Label("");
				addChild(label);
				label.centerX = 0;
				label.centerY = 0;
				
				//FIX ME
				label.format = RainUI.getTextFormat(RainTheme.WHITE_TEXT_FORMAT);
				//else
					//label.format = RainUI.whiteTextFormat;
				
				label.align = TextFormatAlign.CENTER;
				label.autoSize = true;
			}
			
			super.createChildren();
		}
		
		override protected function initialize():void
		{
			super.initialize();
		}
		
		override public function resize():void
		{
			super.resize();
			//if (bgSkin)
			//{
				//bgSkin.width = _width;
				//bgSkin.height = _height;
			//}
		}
		
		override public function get bgSkin():DisplayObject
		{
			return super.bgSkin;
		}
		
		override public function set bgSkin(value:DisplayObject):void
		{
			super.bgSkin = value;
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