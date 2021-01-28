package me.rainui
{
	import flash.display.Bitmap;
	import flash.display.DisplayObject;
	import flash.display.Shape;
	import flash.display.Stage;
	import flash.display.StageAlign;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	import flash.geom.ColorTransform;
	import flash.geom.Rectangle;
	import flash.system.Capabilities;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	import me.rainssong.math.MathCore;
	import me.rainssong.utils.Color;
	import me.rainssong.utils.Draw;
	import me.rainui.managers.BackManager;
	import me.rainui.managers.RenderManager;
	
	/**
	 * ...
	 * @author Rainssong
	 */
	public class RainUI
	{
		public static var stage:Stage
		public static var stageWidth:Number = 0;
		public static var stageHeight:Number = 0;
		static public var stageRoximativeHeight:Number = 0;
		static public var stageRoximativeWidth:Number = 0;
		static private var _theme:RainTheme
		
		public static var render:RenderManager = new RenderManager();
		
		static public var darkColorTrans:ColorTransform = new ColorTransform(0.7, 0.7, 0.7, 1, 0, 0, 0, 0);
		
		static public const grayTextFormat:TextFormat = new TextFormat("微软雅黑", 32, 0xb4b4b4, null, null, null, null, null, TextFormatAlign.CENTER);
		static public const whiteTextFormat:TextFormat = new TextFormat("微软雅黑", 32, 0xffffff, null, null, null, null, null, TextFormatAlign.CENTER);
		static public const blackTextFormat:TextFormat = new TextFormat("微软雅黑", 32, 0, null, null, null, null, null, TextFormatAlign.CENTER);
		
		static public var designHeight:Number = 768;
		static public var designWidth:Number = 1024;
		
		
		static public var designDPI:Number = 321;
		static public var currentDPI:Number =  Capabilities.screenDPI;
		
		static public var dispatcher:EventDispatcher = new EventDispatcher();
		
		public function RainUI()
		{
			
		}
		
		public static function init(stage:Stage, theme:RainTheme = null):void
		{
			RainUI.stage = stage;
			
			//if (SystemCore.isWindows)
			//{
				//stageWidth = stage.stageWidth;
				//stageHeight = stage.stageHeight;
				
				
			//}
			//else
			//{
				//BUG:在横向设备上，宽高错误
				//stageWidth = Capabilities.screenResolutionX;
				//stageHeight = Capabilities.screenResolutionY;
			//}
			
			onStageResize();
			
			RainUI.render.renderED = stage;
			RainUI.theme = theme;
			
			
			stage.addEventListener(Event.RESIZE, onStageResize,true,64);
			stage.addEventListener(KeyboardEvent.KEY_DOWN, onKey);
		
		}
		
		static private function onKey(e:KeyboardEvent):void 
		{
			switch (e.keyCode)
			{
				case Keyboard.BACK:
						e.preventDefault();
						BackManager.runLast();
						break;
			}
		}
		
		static public function getSkin(name:String):DisplayObject
		{
			if (theme == null)
				return defaultSkinFactory();
			return theme.getSkin(name);
		}
		
		static public function getTextFormat(name:String = ""):TextFormat
		{
			if (theme == null)
				return defaultTextFormatFactory();
			
			return theme.getTextFormat(name);
		}
		
		static private function onStageResize(e:Event=null):void
		{
			stageWidth = stage.stageWidth;
			stageHeight = stage.stageHeight;
			stageRoximativeHeight = Math.round(stageHeight / 500) * 500;
			stageRoximativeWidth = Math.round(stageWidth / 500) * 500;
			
			//currentDPI=Capabilities.screenDPI / RainUI.stage.contentsScaleFactor;
		}
		
		static public function get stageMinLength():Number
		{
			return stageWidth > stageHeight?stageHeight:stageWidth;
		}
		
		static public function get stageMaxLength():Number
		{
			return stageWidth > stageHeight?stageWidth:stageHeight;
		}
		
		static public function get widthScale():Number
		{
			if (_theme)
				return _theme.widthScale;
			return 1
		}
		
		static public function get heightScale():Number
		{
			if (_theme)
				return _theme.heightScale;
			return 1
		}
		
		static public function get minScale():Number
		{
			if (_theme)
				return _theme.minScale;
			return 1
		}
		
		static public function get maxScale():Number
		{
			if (_theme)
				return _theme.maxScale;
			return 1
		}
		
		public static function defaultSkinFactory():DisplayObject
		{
			var shape:Shape = new Shape();
			shape.graphics.lineStyle(1, 0);
			shape.graphics.beginFill(RainTheme.WHITE, 1);
			shape.graphics.drawRoundRect(0, 0, 40, 40, 10, 10);
			shape.scale9Grid = new Rectangle(10, 10, 40 - 2 * 10, 40 - 2 * 10);
			return shape;
		}
		
		public static function defaultTextFormatFactory():TextFormat
		{
			return new TextFormat(null, 32, 0);
		}
		
		public static var tabletScreenMinimumInches:Number = 5;
		public static var screenPixelWidth:Number = NaN;
		public static var screenPixelHeight:Number = NaN;
		
		public static function isTablet(stage:Stage):Boolean
		{
			const screenWidth:Number = isNaN(screenPixelWidth) ? stage.fullScreenWidth : screenPixelWidth;
			const screenHeight:Number = isNaN(screenPixelHeight) ? stage.fullScreenHeight : screenPixelHeight;
			return (Math.max(screenWidth/currentDPI, screenHeight) / currentDPI) >= tabletScreenMinimumInches;
		}
		public static function isPhone(stage:Stage):Boolean
		{
			return !isTablet(stage);
		}
		public static function screenInchesX(stage:Stage):Number
		{
			const screenWidth:Number = isNaN(screenPixelWidth) ? stage.fullScreenWidth : screenPixelWidth;
			return screenWidth / currentDPI;
		}
		public static function screenInchesY(stage:Stage):Number
		{
			const screenHeight:Number = isNaN(screenPixelHeight) ? stage.fullScreenHeight : screenPixelHeight;
			return screenHeight / currentDPI;
		}
		
		public static function get scale():Number
		{
			if (RainUI.theme)
				return RainUI.theme.scale;
			return 1;
		}
		
		static public function get theme():RainTheme 
		{
			return _theme;
		}
		
		static public function set theme(value:RainTheme):void 
		{
			_theme = value;
			if (theme && !theme.initilaized)
				theme.init();
		}
	
	}

}