package me.rainui
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.Shape;
	import flash.display.StageScaleMode;
	import flash.events.Event;
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
	import me.rainssong.utils.Draw;
	import me.rainssong.utils.ObjectCore;
	import me.rainui.components.Button;
	import me.rainui.components.Label;
	import me.rainui.components.List;
	import me.rainui.events.RainUIEvent;
	import me.rainui.utils.ScaleMethod;
	
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
		static public const BLACK:uint = 0;
		
		static public const WHITE:uint = 0xFFFFFF;
		
		static public const WHITE_TEXT_FORMAT:String = "whiteTextFormat";
		static public const BLACK_TEXT_FORMAT:String = "blackTextFormat";
		static public const GRAY_TEXT_FORMAT:String = "grayTextFormat";
		
		static public const darkColorTrans:ColorTransform = new ColorTransform(0.7, 0.7, 0.7, 1, 0, 0, 0, 0);
		protected var _initilaized:Boolean= false;
		
		static private const grayTextFormat:TextFormat = new TextFormat("微软雅黑", 32, GRAY, null, null, null, null, null, TextFormatAlign.CENTER);
		static private const whiteTextFormat:TextFormat = new TextFormat("微软雅黑", 32, 0xffffff, null, null, null, null, null, TextFormatAlign.CENTER);
		static private const blackTextFormat:TextFormat = new TextFormat("微软雅黑", 32, BLACK, null, null, null, null, null, TextFormatAlign.CENTER);
		
		private var _configDic:Dictionary = new Dictionary();
		private var _skinDic:Dictionary = new Dictionary();
		
		protected var primaryTextFormat:TextFormat;
		protected var disabledTextFormat:TextFormat;
		protected var lightTextFormat:TextFormat;
		
		
		protected var gridSize:Number;
		protected var smallGutterSize:Number;
		protected var gutterSize:Number;
		protected var smallControlSize:Number;
		protected var controlSize:Number;
		protected var popUpFillSize:Number;
		protected var wideControlSize:Number;
		protected var borderSize:Number;
		protected var simpleScrollBarThumbSize:Number;
		protected var calloutBackgroundMinSize:Number;
		protected var calloutBorderPaddingSize:Number;
		protected var controlWidth:Number;
		protected var controlHeight:Number;
		protected var fontSize:Number;
	
		//none dpiScale widthScale heightScale minScale maxScale 
		protected var _scaleMethod:String = ScaleMethod.DPI;
		
		protected var _dpiScale:Number = 1;
		protected var _widthScale:Number = 1;
		protected var _heightScale:Number = 1;
		protected var _minScale:Number = 1;
		protected var _maxScale:Number = 1;
		
		protected var _scale:Number = 1;
		protected var _textScale:Number = 1;
		
		static public var designWidth:Number = 1024;
		static public var designHeight:Number = 768;
		
		
		public function RainTheme(scaleMethod:String="dpi")
		{
			_scaleMethod = scaleMethod;
			
		}
		
		public function init():void
		{
			if (_initilaized)
				return;
			
			_initilaized = true;
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
			
			
			calcScale();
			initStyle();
			initDimensions();
			initFonts()
			
			
			if (RainUI.stage)
				RainUI.stage.addEventListener(Event.RESIZE, onStageResize);
		}
		
		private function onStageResize(e:Event):void 
		{
			calcScale();
		}
		
		protected function initDimensions():void
		{
			this.gridSize = Math.round(88 * this.scale);
			this.smallGutterSize = Math.round(11 * this.scale);
			this.gutterSize = Math.round(22 * this.scale);
			this.controlSize = Math.round(60 * this.scale);
			this.controlWidth = Math.round(200 * this.scale);
			this.controlHeight = Math.round(60 * this.scale);
			this.smallControlSize = Math.round(32 * this.scale);
			this.popUpFillSize = Math.round(552 * this.scale);
			this.wideControlSize = this.gridSize * 3 + this.gutterSize * 2;
			this.borderSize = Math.round(4 * this.scale);
			this.simpleScrollBarThumbSize = Math.round(8 * this.scale);
			this.calloutBackgroundMinSize = Math.round(11 * this.scale);
			this.calloutBorderPaddingSize = -Math.round(8 * this.scale);
		}
		
		protected function initFonts():void
		{
			//since it's a pixel font, we want a multiple of the original size,
			//which, in this case, is 8.
			this.fontSize = Math.max(4, Math.round(32 * this._textScale));
			//this.largeFontSize = Math.max(4, roundToNearest(32 * this.scale, 8));
			//this.smallFontSize = Math.max(4, roundToNearest(16 * this.scale, 8));
			//this.inputFontSize = 26 * this.stageTextScale;

			this.primaryTextFormat = new TextFormat("微软雅黑,Helvetica", this.fontSize, BLACK);
			this.disabledTextFormat = new TextFormat("微软雅黑,Helvetica", this.fontSize, GRAY);
			this.lightTextFormat = new TextFormat("微软雅黑,Helvetica", this.fontSize, WHITE);
			
			
			
			//this.centeredTextFormat = new TextFormat("微软雅黑", this.fontSize, BLACK,TextFormatAlign.CENTER);
			//this.centeredDisabledTextFormat = new BitmapFontTextFormat(FONT_NAME, this.fontSize, DISABLED_TEXT_COLOR, TextFormatAlign.CENTER);
			//this.headingTextFormat = new BitmapFontTextFormat(FONT_NAME, this.largeFontSize, PRIMARY_TEXT_COLOR);
			//this.headingDisabledTextFormat = new BitmapFontTextFormat(FONT_NAME, this.largeFontSize, DISABLED_TEXT_COLOR);
			//this.detailTextFormat = new BitmapFontTextFormat(FONT_NAME, this.smallFontSize, PRIMARY_TEXT_COLOR);
			//this.detailDisabledTextFormat = new BitmapFontTextFormat(FONT_NAME, this.smallFontSize, DISABLED_TEXT_COLOR);
//
			//var scrollTextFontList:String = "PF Ronda Seven,Roboto,Helvetica,Arial,_sans";
			//this.scrollTextTextFormat = new TextFormat(scrollTextFontList, this.fontSize, PRIMARY_TEXT_COLOR);
			//this.scrollTextDisabledTextFormat = new TextFormat(scrollTextFontList, this.fontSize, DISABLED_TEXT_COLOR);
		}
		
		protected function initStyle():void 
		{
			Button.defaultStyleFactory = buttonStyleFactory;
			List.defaultStyleFactory = listStyleFactory;
			Label.defaultStyleFactory=labelStyleFactory
		}
		
		protected function labelStyleFactory(com:Label):void
		{
			//com.width = 200*RainUI.scale;
			//com.height = 60*RainUI.scale;
			com.format = ObjectCore.clone(primaryTextFormat);
		}
		
		public function buttonStyleFactory(comp:Button):void 
		{
			//不能修改皮肤，除非因为存在用户定义好的情况
			//comp.normalSkin = blueSkinFactory();
			if (comp.label == null)
			{
				comp.label = new Label();
				comp.label.centerX = 0;
				comp.label.centerY = 0;
				comp.label.autoSize = true;
				comp.label.size = RainUI.scale * 32;
				comp.label.color = 0xffffff;
				
			}
		}
		
		public function listStyleFactory(comp:List):void 
		{
			//comp.bgSkin = whiteFlatSkinFactory();
			//comp.width = controlWidth;
			//comp.height = controlHeight;
		}
		
		protected function calcScale():void
		{
			
			if (RainUI.stage == null || RainUI.stage.scaleMode != StageScaleMode.NO_SCALE)
			{
				this._textScale = 1;
				this._scale = 1;
				return;
			}
			
			this._dpiScale = RainUI.currentDPI/RainUI.designDPI;
			this._widthScale =  RainUI.stageWidth/RainTheme.designWidth;
			this._heightScale =  RainUI.stageHeight/RainUI.designHeight;
			this._maxScale =  Math.max(_widthScale, _heightScale);
			this._minScale =   Math.min(_widthScale, _heightScale);
			
			var scale:Number = _scale;
			
			switch (_scaleMethod) 
			{
				case ScaleMethod.DPI:
					scale = this._dpiScale ;
					
				break;
				case ScaleMethod.WIDTH:
					scale = this._widthScale ;
				break;
				case ScaleMethod.HEIGHT:
					scale = this._heightScale ;
				break;
				case ScaleMethod.MAX_LENGTH:
					scale = this._maxScale ;
				break;
				case ScaleMethod.MIN_LENGTH:
					scale = this._minScale ;
				break;
				default:
			}
			
			if (scale != _scale)
			{
				this._scale = scale;
				RainUI.dispatcher.dispatchEvent(new RainUIEvent(RainUIEvent.SCALE_CHANGE, _scale));
			}
			
			this._textScale = this._scale / RainUI.stage.contentsScaleFactor;
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
			shape.scaleX = shape.scaleY = _scale;
			return shape;
		}
		
		private function listItemSkinFactory():DisplayObject
		{
			var shape:Shape = new Shape();
			Draw.rect(shape, 0, 0, 100, 100, RainTheme.WHITE);
			Draw.rect(shape, 0, 98, 100, 2, RainTheme.GRAY);
			shape.scale9Grid = new Rectangle(4, 4, 92, 92);
			shape.scaleX = shape.scaleY = _scale;
			return shape;
		}
		
		private function whiteRoundSkinFactory():DisplayObject
		{
			var shape:Shape = new Shape();
			shape.graphics.beginFill(RainTheme.WHITE, 1);
			shape.graphics.drawRoundRect(0, 0, 80, 80, 10, 10);
			shape.scale9Grid = new Rectangle(10, 10, 80 - 2 * 10, 80 - 2 * 10);
			shape.scaleX = shape.scaleY = _scale;
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
					tf = new TextFormat("微软雅黑", 32, GRAY, null, null, null, null, null, TextFormatAlign.CENTER);
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
			shape.scaleX = shape.scaleY = _scale;
			return shape;
		}
		
		public function darkBlueSkinFactory():DisplayObject
		{
			var shape:Shape = new Shape();
			Draw.rect(shape, 0, 0, 100, 100, LIGHT_BLUE);
			Draw.rect(shape, 0, 0, 100, 96, DARK_BLUE);
			shape.scale9Grid = new Rectangle(4, 4, 92, 92);
			shape.scaleX = shape.scaleY = _scale;
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
			shape.scaleX = shape.scaleY = _scale;
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
		
		public function get scale():Number 
		{
			return _scale;
		}
		
		public function get initilaized():Boolean
		{
			return _initilaized;
		}
		
		public function get widthScale():Number 
		{
			return _widthScale;
		}
		
		public function get heightScale():Number 
		{
			return _heightScale;
		}
		
		public function get minScale():Number 
		{
			return _minScale;
		}
		
		public function get maxScale():Number 
		{
			return _maxScale;
		}
		
		public function set scale(value:Number):void 
		{
			_scale = value;
		}
	
	}

}