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
		
		public static var render:RenderManager
		
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
			
			if (SystemCore.isWindows)
			{
				stageWidth = stage.stageWidth;
				stageHeight = stage.stageHeight;
			}
			else
			{
				stageWidth = Capabilities.screenResolutionX;
				stageHeight = Capabilities.screenResolutionY;
			}
			
			stageRoximativeHeight = Math.round(stageHeight / 100) * 100;
			stageRoximativeWidth = Math.round(stageWidth / 100) * 100;
			
			RainUI.render = new RenderManager();
			RainUI.theme = theme;
			
			stage.addEventListener(Event.RESIZE, onStageResize);
		
			//stage.frameRate = Config.frameRate;
			//stage.scaleMode = StageScaleMode.NO_SCALE
			//stage.align = StageAlign.TOP_LEFT;
			//stage.tabChildren = false;
		
			//stage.addChild(dialog);
			//stage.addChild(tip);
			//stage.addChild(log);
		
		}
		
		static public function getSkin(name:String):DisplayObject
		{
			if (theme)
				return theme.getSkin(name);
			else
			{
				var shape:Shape = new Shape();
				switch (name)
				{
					case "textInput": 
					case "textIArea": 
						shape.graphics.beginFill(RainTheme.WHITE, 1);
						//shape.graphics.lineStyle(4, 0x666666, 1);
						shape.graphics.drawRoundRect(0, 0, 80, 80, 10, 10);
						shape.scale9Grid = new Rectangle(10, 10, 80 - 2 * 10, 80 - 2 * 10);
						return shape;
						break;
					case "buttonNormal":
						Draw.rect(shape, 0, 0, 100, 100, RainTheme.BLUE);
						Draw.rect(shape, 0, 96, 100, 4, RainTheme.DARK_BLUE);
						shape.scale9Grid = new Rectangle(4, 4, 92, 92);
						shape.name = "normalSkin";
						return shape;
						break;
					default:
				
				}
				return shape;
			}
		}
		
		static public function getTextFormat(name:String = ""):TextFormat
		{
			if (theme)
				return theme.getTextFormat(name);
			else
			{
				var tf:TextFormat
				switch (name)
				{
					case "label":
					case "textInput":
						tf = new TextFormat("微软雅黑", null, Color.Black);
						break;
					case "button":
						tf = new TextFormat("微软雅黑", null, Color.White);
						break;
					default: 
						tf = new TextFormat("微软雅黑", null, Color.Black);
				}
				
				if (RainUI.stage)
				{
					
					var l:Number = Math.min(RainUI.stageHeight, RainUI.stageWidth);
					tf.size = MathCore.floor(l / 20);
				}
				else
				{
					tf.size = 24;
				}
				return tf;
			}
		}
		
		static private function onStageResize(e:Event):void
		{
			stageWidth = stage.stageWidth;
			stageHeight = stage.stageHeight;
			stageRoximativeHeight = Math.round(stageHeight / 500) * 500;
			stageRoximativeWidth = Math.round(stageWidth / 500) * 500;
		}
	
	}

}