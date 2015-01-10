package me.rainssong.application
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.display.StageDisplayState;
	import flash.events.Event;
	import flash.net.SharedObject;
	import flash.net.URLLoader;
	import flash.system.Capabilities;
	import flash.utils.getDefinitionByName;
	import me.rainssong.manager.SharedObjectProxy;
	import me.rainssong.system.SystemCore;


/**
 * Application static property provider
 */
	public class ApplicationManager
	{
		static public const NORMAL_EDITION:String = "normalEdition";
		static public const AIR_DESKTOP_EDITION:String = "airDesktopEdition";
		static public const AIR_MOBILE_EDITION:String = "airMobileEdition";
		static public const TEST_EDITION:String = "testEdition";
		
		public static var edition:String = NORMAL_EDITION;
		static private var inited:Boolean = false;
		
		public static var stage:Stage
		public static var stageWidth:Number = 0;
		public static var stageHeight:Number = 0;
		
		
		public static function init(stage:Stage):void
		{
			ApplicationManager.stage = stage;
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
			stage.addEventListener(Event.RESIZE, onStageResize);
		}
		
		static private function onStageResize(e:Event):void 
		{
			stageWidth = stage.stageWidth;
			stageHeight = stage.stageHeight;
		}
		
		static public function set fullScreen(value:Boolean):void
		{
			if (value == fullScreen)
				return;
			if(value)
				stage.displayState  = StageDisplayState.FULL_SCREEN_INTERACTIVE;
			else
				stage.displayState = StageDisplayState.NORMAL;
		}
		
		static public function get fullScreen():Boolean
		{
			return stage.displayState == StageDisplayState.FULL_SCREEN || stage.displayState  == StageDisplayState.FULL_SCREEN_INTERACTIVE;
		}
		
		
		public static function get DEBUG_MODE():Boolean
		{
			try
			{
				trace(Object("").fuck);
			}
			catch (e:Error)
			{
				return true;
			}
			return false;
		}
		
		public static function get RELEAS_MODE():Boolean
		{
			return !DEBUG_MODE;
		}
		
		public static function get WEB_PLAYER():Boolean 
		{
			return Capabilities.playerType == "ActiveX" || Capabilities.playerType == "PlugIn";
		}
		
		public static function get STANDALONE_PLAYER():Boolean 
		{
			return Capabilities.playerType == "External" || Capabilities.playerType == "StandAlone";
		}
		
		public static function isNewVersion(newVer:String = "1.0", oldVer:String = ""):Boolean
		{
			var newArr:Array = newVer.split(".").concat("0","0","0")
		
			var oldArr:Array =	oldVer.split(".").concat("0","0","0");
			
			for (var i:int = 0; i < 3; i++)
			{
				if (Number(newArr[i]) > Number(oldArr[i]))
					return true;
			}
			return false;
		}
	}
}
