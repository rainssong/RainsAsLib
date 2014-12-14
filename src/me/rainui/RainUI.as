package me.rainui
{
	import flash.display.Bitmap;
	import flash.display.DisplayObject;
	import flash.display.Stage;
	import flash.display.StageScaleMode;
	import flash.display.StageAlign;
	import flash.events.Event;
	import flash.geom.ColorTransform;
	import flash.system.Capabilities;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	import me.rainssong.system.SystemCore;
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
		static public var stageRoximativeWidth:Number=0;
		public static var theme:RainTheme
		
		public static var render:RenderManager
		
		
		static public var darkColorTrans:ColorTransform = new ColorTransform(0.7, 0.7, 0.7, 1, 0, 0, 0, 0);
		
		
		public function RainUI()
		{
			
		}
		
		public static function init(stage:Stage,theme:RainTheme=null):void
		{
			RainUI.stage = stage;
			
			if (SystemCore.isWindows)
			{
				stageWidth = stage.fullScreenWidth;
				stageHeight = stage.fullScreenHeight;
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
		
		static private function onStageResize(e:Event):void 
		{
			stageWidth = stage.fullScreenWidth;
			stageHeight = stage.fullScreenHeight;
			stageRoximativeHeight = Math.round(stageHeight / 500) * 500;
			stageRoximativeWidth = Math.round(stageWidth / 500) * 500;
		}
		

	}

}