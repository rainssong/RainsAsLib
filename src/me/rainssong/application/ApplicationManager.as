package me.rainssong.application
{
	
	
	import flash.desktop.NativeApplication;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.net.SharedObject;
	import flash.net.URLLoader;
	import flash.system.Capabilities;
	import flash.utils.getDefinitionByName;
	import me.rainssong.manager.SharedObjectProxy;


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
		private static var _sharedObjectData:SharedObjectProxy=new SharedObjectProxy(NativeApplication.nativeApplication.applicationID);
		static private var inited:Boolean = false;
		
		
		public static function init():void
		{
			_sharedObjectData = new SharedObjectProxy(appId);
		}
		
		public static function get appId():String
		{
			return NativeApplication.nativeApplication.applicationID;
		}
		
		public static function get appXml():XML
		{
			return NativeApplication.nativeApplication.applicationDescriptor;
		}
		
		public static function get appNameSpace():Namespace
		{
			return appXml.namespace();
		}
		
		public static function get appVersion():String
		{
			return appXml.appNameSpace::versionNumber[0];
		}
		
		public static function get appName():String
		{
			return appXml.appNameSpace::filename[0];
		}
		
		static public function get lastVersion():String 
		{
			return _sharedObjectData["version"] as String;
		}
	
		static public function updateVersion():void 
		{
			_sharedObjectData["version"] = appVersion;
		}
		
		public static function get isDifferentVersion():Boolean
		{
			return lastVersion != appVersion;
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
		
		public static function get WEB_MODE():Boolean 
		{
			return Capabilities.playerType == "ActiveX" || Capabilities.playerType == "PlugIn";
			//return true;
		}
		
		public static function get WEB_PLAYER():Boolean 
		{
			return Capabilities.playerType == "ActiveX" || Capabilities.playerType == "PlugIn";
			//return true;
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
