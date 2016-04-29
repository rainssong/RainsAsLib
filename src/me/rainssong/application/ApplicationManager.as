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
	import me.rainssong.manager.SystemManager;
	import me.rainssong.system.SystemCore;


/**
 * Application static property provider
 */
	public class ApplicationManager
	{
		static public const NORMAL_EDITION:String = "NormalEdition";
		static public const DESKTOP_EDITION:String = "DesktopEdition";
		static public const MOBILE_EDITION:String = "MobileEdition";
		static public const TEST_EDITION:String = "TestEdition";
		static public const ALPHA_EDITION:String = "AlphaEdition";
		static public const BETA_EDITION:String = "BetaEdition";
		static public const TRIAL_EDITION:String = "TrialEdition";
		static public const FREE_EDITION:String = "FreeEdition";
		
		public static var edition:String = NORMAL_EDITION;
		static private var inited:Boolean = false;
		
		public static var stage:Stage
		public static var stageWidth:Number = 0;
		public static var stageHeight:Number = 0;
		
		protected static var _version:String = null;
		
		
		public static function init(stage:Stage):void
		{
			ApplicationManager.stage = stage;
			//if (SystemCore.isWindows)
			//{
				//stageWidth = stage.fullScreenWidth;
				//stageHeight = stage.fullScreenHeight;
			//}
			//else
			//{
				//stageWidth = Capabilities.screenResolutionX;
				//stageHeight = Capabilities.screenResolutionY;
			//}
			onStageResize();
			stage.addEventListener(Event.RESIZE, onStageResize);
		}
		
		static private function onStageResize(e:Event=null):void 
		{
			stageWidth = stage.stageWidth;
			stageHeight = stage.stageHeight;
		}
		
		static public function set fullScreen(value:Boolean):void
		{
			if (value == fullScreen)
				return;
			if (SystemManager.isWebPlayer)
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
		
		static public function get version():String 
		{
			if(_version!=null)
			return _version;
			else
			{
				CONFIG::air
				{
					return AirManager.appVersion;
				}
				return "1.0.0";
			}
			
		}
		
		static public function set version(value:String):void 
		{
			_version = value;
		}
		
		public static function isNewVersion(newVer:String = "1.0", oldVer:String = ""):Boolean
		{
			var newArr:Array = newVer.split(".").concat("0","0","0","0")
		
			var oldArr:Array =	oldVer.split(".").concat("0","0","0","0")
			
			for (var i:int = 0; i < 4; i++)
			{
				if (Number(newArr[i]) > Number(oldArr[i]))
					return true;
			}
			return false;
		}
		
		public static function versionCompair(oldVer:String, newVer:String):int
		{
			var newArr:Array = newVer.split(".").concat("0","0","0","0")
		
			var oldArr:Array =	oldVer.split(".").concat("0","0","0","0");
			
			for (var i:int = 0; i < 4; i++)
			{
				if (Number(newArr[i]) > Number(oldArr[i]))
					return 1;
				else if (Number(newArr[i]) < Number(oldArr[i]))
					return -1;
				else
					continue;
			}
			return 0;
		}
	}
}
