package me.rainui
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.Shape;
	import flash.display.StageScaleMode;
	import flash.geom.ColorTransform;
	import flash.geom.Rectangle;
	import flash.system.Capabilities;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	import flash.utils.Dictionary;
	import me.rainssong.display.Scale9BitmapSprite;
	import me.rainssong.display.ScaleBitmap;
	import me.rainssong.manager.SystemManager;
	import me.rainssong.math.MathCore;
	import me.rainssong.system.SystemCore;
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
		
		static public const LIGHT_BLACK:uint = 0x434a54;
		
		static public const WHITE:uint = 0xFFFFFF;
		
		static public const WHITE_TEXT_FORMAT:String = "whiteTextFormat";
		static public const BLACK_TEXT_FORMAT:String = "blackTextFormat";
		static public const GRAY_TEXT_FORMAT:String = "grayTextFormat";
		
		static public const darkColorTrans:ColorTransform = new ColorTransform(0.7, 0.7, 0.7, 1, 0, 0, 0, 0);
		
		static private const grayTextFormat:TextFormat = new TextFormat("微软雅黑", 32, GRAY, null, null, null, null, null, TextFormatAlign.CENTER);
		static private const whiteTextFormat:TextFormat = new TextFormat("微软雅黑", 32, 0xffffff, null, null, null, null, null, TextFormatAlign.CENTER);
		static private const blackTextFormat:TextFormat = new TextFormat("微软雅黑", 32, 0, null, null, null, null, null, TextFormatAlign.CENTER);
		
		private var _configDic:Dictionary = new Dictionary();
		private var _skinDic:Dictionary = new Dictionary();
		
		public function RainTheme()
		{
			init();
		}
		
		public function init():void
		{
			//_configDic
			_skinDic["darkBlueRoundSkin"] = darkBlueRoundSkinFactory;
			_skinDic["darkBlueRoundFlatSkin"] = darkBlueRoundFlatSkinFactory;
			_skinDic["textInput"] = whiteRoundSkinFactory;
			_skinDic["list"] = whiteFlatSkinFactory;
			_skinDic["bg"] = whiteFlatSkinFactory;
			_skinDic["panelBg"] = lightBlackFlatSkinFactory;
			_skinDic["blueBg"] = blueFlatSkinFactory;
			_skinDic["component"] = whiteFlatSkinFactory;
			_skinDic["listItem"] = listItemSkinFactory;
			_skinDic["progressBar"] = blueFlatSkinFactory;
			_skinDic["progressBarBg"] = darkGrayFlatSkinFactory;
			_skinDic["buttonNormal"] = blueSkinFactory;
		}
		
		private function whiteFlatSkinFactory():DisplayObject
		{
			var shape:Shape = new Shape();
			shape.graphics.beginFill(RainTheme.WHITE, 1);
			//shape.graphics.lineStyle(4, 0x666666, 1);
			shape.graphics.drawRect(0, 0, 80, 80);
			
			shape.scale9Grid = new Rectangle(10, 10, 80 - 2 * 10, 80 - 2 * 10);
			return shape;
		}
		
		private function whiteSkinFactory():DisplayObject
		{
			var shape:Shape = new Shape();
			Draw.rect(shape, 0, 0, 100, 100, RainTheme.WHITE);
			Draw.rect(shape, 0, 96, 100, 4, RainTheme.GRAY);
			shape.scale9Grid = new Rectangle(4, 4, 92, 92);
			return shape;
		}
		
		private function listItemSkinFactory():DisplayObject
		{
			var shape:Shape = new Shape();
			Draw.rect(shape, 0, 0, 100, 100, RainTheme.WHITE);
			Draw.rect(shape, 0, 98, 100, 2, RainTheme.GRAY);
			shape.scale9Grid = new Rectangle(4, 4, 92, 92);
			return shape;
		}
		
		private function whiteRoundSkinFactory():DisplayObject
		{
			var shape:Shape = new Shape();
			shape.graphics.beginFill(RainTheme.WHITE, 1);
			shape.graphics.drawRoundRect(0, 0, 80, 80, 10, 10);
			shape.scale9Grid = new Rectangle(10, 10, 80 - 2 * 10, 80 - 2 * 10);
			return shape;
		}
		
		public function getConfigs(configName:String = "default"):Object
		{
			return _configDic[configName];
		}
		
		public function getSkin(skinName:String = "default"):DisplayObject
		{
			return _skinDic[skinName]();
		}
		
		public function getTextFormat(name:String = ""):TextFormat
		{
			var tf:TextFormat
			switch (name)
			{
				case "white": 
				case "button": 
				case WHITE_TEXT_FORMAT: 
					tf = ObjectCore.clone(whiteTextFormat);
					break;
				case "gray": 
				case GRAY_TEXT_FORMAT: 
					tf = ObjectCore.clone(grayTextFormat);
					break;
				case "black": 
				case "textInput": 
				case "label": 
				case BLACK_TEXT_FORMAT: 
					tf = ObjectCore.clone(blackTextFormat);
					break;
				default: 
					tf = ObjectCore.clone(whiteTextFormat);
			}
			if (RainUI.stage && RainUI.stage.scaleMode == StageScaleMode.NO_SCALE)
			{
				var l:Number = Math.min(RainUI.stageHeight, RainUI.stageWidth);
				tf.size = MathCore.floor(l / 20);
			}
			else
				tf.size = 24;
			return tf;
		}
		
		public function darkBlueRoundSkinFactory():DisplayObject
		{
			var shape:Shape = new Shape();
			Draw.drawGraphics(shape.graphics, shape.graphics.drawRoundRect, LIGHT_BLUE, 0, 0, 100, 100, 4, 4);
			Draw.drawGraphics(shape.graphics, shape.graphics.drawRoundRect, DARK_BLUE, 0, 0, 100, 96, 4, 4);
			shape.scale9Grid = new Rectangle(4, 4, 92, 92);
			return shape;
		}
		
		public function darkBlueSkinFactory():DisplayObject
		{
			var shape:Shape = new Shape();
			Draw.rect(shape, 0, 0, 100, 100, LIGHT_BLUE);
			Draw.rect(shape, 0, 0, 100, 96, DARK_BLUE);
			shape.scale9Grid = new Rectangle(4, 4, 92, 92);
			return shape;
		}
		
		public function lightBlackFlatSkinFactory():DisplayObject
		{
			var shape:Shape = new Shape();
			Draw.rect(shape, 0, 0, 100, 100, LIGHT_BLACK);
			shape.scale9Grid = new Rectangle(4, 4, 92, 92);
			shape.alpha = 0.8;
			return shape;
		}
		
		public function blueSkinFactory():DisplayObject
		{
			var shape:Shape = new Shape();
			Draw.rect(shape, 0, 0, 100, 100, RainTheme.BLUE);
			Draw.rect(shape, 0, 96, 100, 4, RainTheme.DARK_BLUE);
			shape.scale9Grid = new Rectangle(4, 4, 92, 92);
			return shape;
		}
		
		public function blueFlatSkinFactory():DisplayObject
		{
			var shape:Shape = new Shape();
			Draw.rect(shape, 0, 0, 100, 100, RainTheme.BLUE);
			shape.scale9Grid = new Rectangle(4, 4, 92, 92);
			return shape;
		}
		
		public function darkBlueRoundFlatSkinFactory():DisplayObject
		{
			var shape:Shape = new Shape();
			Draw.drawGraphics(shape.graphics, shape.graphics.drawRoundRect, DARK_BLUE, 0, 0, 100, 100, 4, 4);
			shape.scale9Grid = new Rectangle(4, 4, 92, 92);
			return shape;
		}
		
		public function darkGrayFlatSkinFactory():DisplayObject
		{
			var shape:Shape = new Shape();
			Draw.rect(shape, 0, 0, 100, 100, RainTheme.DARK_GRAY);
			shape.scale9Grid = new Rectangle(4, 4, 92, 92);
			return shape;
		}
	
	}

}