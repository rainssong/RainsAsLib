package me.rainui
{
	import flash.display.Bitmap;
	import flash.display.DisplayObject;
	import flash.display.Shape;
	import flash.display.Stage;
	import flash.display.StageScaleMode;
	import flash.display.StageAlign;
	import flash.events.Event;
	import flash.geom.ColorTransform;
	import flash.geom.Rectangle;
	import flash.system.Capabilities;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	import me.rainssong.math.MathCore;
	import me.rainssong.system.SystemCore;
	import me.rainssong.utils.Color;
	import me.rainssong.utils.Draw;
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
		public static var theme:RainTheme
		
		public static var render:RenderManager = new RenderManager();
		
		static public var darkColorTrans:ColorTransform = new ColorTransform(0.7, 0.7, 0.7, 1, 0, 0, 0, 0);
		
		static public const grayTextFormat:TextFormat = new TextFormat("微软雅黑", 32, 0xb4b4b4, null, null, null, null, null, TextFormatAlign.CENTER);
		static public const whiteTextFormat:TextFormat = new TextFormat("微软雅黑", 32, 0xffffff, null, null, null, null, null, TextFormatAlign.CENTER);
		static public const blackTextFormat:TextFormat = new TextFormat("微软雅黑", 32, 0, null, null, null, null, null, TextFormatAlign.CENTER);
		
		public function RainUI()
		{
			
		}
		
		public static function init(stage:Stage, theme:RainTheme = null):void
		{
			RainUI.stage = stage;
			
			//if (SystemCore.isWindows)
			//{
				stageWidth = stage.stageWidth;
				stageHeight = stage.stageHeight;
			//}
			//else
			//{
				//BUG:在横向设备上，宽高错误
				//stageWidth = Capabilities.screenResolutionX;
				//stageHeight = Capabilities.screenResolutionY;
			//}
			
			//stageRoximativeHeight = Math.round(stageHeight / 100) * 100;
			//stageRoximativeWidth = Math.round(stageWidth / 100) * 100;
			onStageResize();
			
			RainUI.render.renderED = stage;
			RainUI.theme = theme;
			
			stage.addEventListener(Event.RESIZE, onStageResize);
		
		}
		
		static public function getSkin(name:String):DisplayObject
		{
			if (theme == null)
			{
				theme = new RainTheme();
			}
			return theme.getSkin(name);
		}
		
		static public function getTextFormat(name:String = ""):TextFormat
		{
			if (theme == null)
				theme = new RainTheme();
				
			return theme.getTextFormat(name);
		}
		
		static private function onStageResize(e:Event=null):void
		{
			stageWidth = stage.stageWidth;
			stageHeight = stage.stageHeight;
			stageRoximativeHeight = Math.round(stageHeight / 500) * 500;
			stageRoximativeWidth = Math.round(stageWidth / 500) * 500;
		}
		
		static public function get stageMinLength():Number
		{
			return stageWidth > stageHeight?stageHeight:stageWidth;
		}
		
		static public function get stageMaxLength():Number
		{
			return stageWidth > stageHeight?stageWidth:stageHeight;
		}
		
		public static function defaultSkinFactory():DisplayObject
		{
			var shape:Shape = new Shape();
			shape.graphics.lineStyle(1, 0);
			shape.graphics.beginFill(RainTheme.WHITE, 1);
			shape.graphics.drawRoundRect(0, 0, 80, 80, 10, 10);
			shape.scale9Grid = new Rectangle(10, 10, 80 - 2 * 10, 80 - 2 * 10);
			return shape;
		}
	
	}

}