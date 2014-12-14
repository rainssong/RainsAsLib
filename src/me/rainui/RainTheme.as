package me.rainui
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.Shape;
	import flash.geom.ColorTransform;
	import flash.geom.Rectangle;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	import flash.utils.Dictionary;
	import me.rainssong.display.Scale9BitmapSprite;
	import me.rainssong.display.ScaleBitmap;
	import me.rainssong.utils.Draw;
	import me.rainssong.utils.ObjectCore;
	import me.rainui.components.Button;
	
	/**
	 * ...
	 * @author Rainssong
	 */
	public class RainTheme
	{
		static public const LIGHT_BLUE:uint = 0x4FC1E9;
		static public const DARK_BLUE:uint = 0x3BAFDA;
		static public const BLUE:uint = 0x48b7e0;
		
		static public const LIGHT_READ:uint = 0xed5565;
		static public const LIGHT_GREEN:uint = 0xa0d468;
		
		static public const LIGHT_GRAY:uint = 0xe3e4e8
		static public const GRAY:uint = 0xb4b4b4;
		static public const DARK_GRAY:uint = 0x989898;
		
		static public const WHITE:uint = 0xFFFFFF;
		
		static public var darkColorTrans:ColorTransform = new ColorTransform(0.7, 0.7, 0.7, 1, 0, 0, 0, 0);
		
		static private var grayTextFormat:TextFormat = new TextFormat(null, 32, GRAY, null, null, null, null, null, TextFormatAlign.CENTER);
		
		static private var whiteTextFormat:TextFormat = new TextFormat(null, 32, 0xffffff, null, null, null, null, null, TextFormatAlign.CENTER);
		static private var blackTextFormat:TextFormat = new TextFormat(null, 32, 0, null, null, null, null, null, TextFormatAlign.CENTER);
		
		static public const WHITE_TEXT_FORMAT:String = "whiteTextFormat";
		static public const BLACK_TEXT_FORMAT:String = "blackTextFormat";
		static public const GRAY_TEXT_FORMAT:String = "grayTextFormat";
		
		private var _skinSetDic:Dictionary = new Dictionary();
		private var _skinDic:Dictionary = new Dictionary();
		
		public function RainTheme()
		{
			init();
		}
		
		public function init():void
		{
			//_skinDic["btnDarkBlueNormalSkin"] = btnDarkBlueNormalSkin;
			//_skinDic["darkBlueSkin"] = darkBlueSkin;
		
		}
		
		public function getSkinSet(skinSetName:String = "default"):Object
		{
			return _skinSetDic[skinSetName];
		}
		
		public function getSkin(skinName:String = "default"):DisplayObject
		{
			return _skinDic[skinName];
		}
		
		public function get darkBlueRoundSkin():DisplayObject
		{
			var shape:Shape = new Shape();
			
			Draw.drawGraphics(shape.graphics, shape.graphics.drawRoundRect, LIGHT_BLUE, 0, 0, 100, 100, 4, 4);
			Draw.drawGraphics(shape.graphics, shape.graphics.drawRoundRect, DARK_BLUE, 0, 0, 100, 96, 4, 4);
			shape.scale9Grid = new Rectangle(4, 4, 92, 92);
			return shape;
		}
		
		public function get darkBlueSkin():DisplayObject
		{
			var shape:Shape = new Shape();
			
			Draw.rect(shape, 0, 0, 100, 100, LIGHT_BLUE);
			Draw.rect(shape, 0, 0, 100, 96, DARK_BLUE);
			shape.scale9Grid = new Rectangle(4, 4, 92, 92);
			return shape;
		}
		
		public function get bgBlueSkin():DisplayObject
		{
			var shape:Shape = new Shape();
			Draw.rect(shape.graphics, 0, 0, 100, 100, BLUE);
			shape.scale9Grid = new Rectangle(4, 4, 92, 92);
			return shape;
		}
		
		public static function getTextFormat(name:String = ""):TextFormat
		{
			switch (name)
			{
				case WHITE_TEXT_FORMAT: 
					return ObjectCore.clone(whiteTextFormat);
					break;
				case GRAY_TEXT_FORMAT: 
					return ObjectCore.clone(grayTextFormat);
					break;
				case BLACK_TEXT_FORMAT: 
					return ObjectCore.clone(blackTextFormat);
					break;
				default: 
					return ObjectCore.clone(whiteTextFormat);
			}
		}
	
	}

}