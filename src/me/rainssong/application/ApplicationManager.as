package me.rainssong.application
{
	
	
	//import flash.desktop.NativeApplication;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.net.SharedObject;
	import flash.net.URLLoader;
	import flash.system.Capabilities;
	import flash.utils.getDefinitionByName;


/**
 * Application static property provider
 */
	public class ApplicationManager
	{
		static public const NORMAL_EDITION:String = "normalEdition";
		static public const AIR_DESKTOP_EDITION:String = "airDesktopEdition";
		static public const AIR_MOBILE_EDITION:String = "airMobileEdition";
		static public const TEST_EDITION:String = "testEdition";
		
		private static var _version:String = "1.0";
		private static var _appName:String = "application";
		private static var _lastVersion:String = "0.0";
		public static var edition:String = NORMAL_EDITION;
		
		static private var inited:Boolean = false;
		
		
		private static function init(appName:String,version:String):void
		{
			_lastVersion ||= shardObject.data.version;
			shardObject.data.version = version;
			_appName = appName;
			shardObject.data.version = shardObject.data.version;
			shardObject.flush();
			
		}
		
		public static function get shardObject():SharedObject
		{
			//var NativeApplication:Class = getDefinitionByName("flash.desktop.NativeApplication") as Class;
			//try
			//{
				//_appName = NativeApplication.nativeApplication.applicationID;
				//
			//}
			//catch (e:Error)
			//{
			//
			//}
			return SharedObject.getLocal(_appName);
		}
		
		public static function get isDifferentVersion():Boolean
		{
			return _lastVersion != version;
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
		
		static public function get lastVersion():String 
		{
			return _lastVersion;
		}
		
		static public function get version():String 
		{
			var NativeApplication:Class = getDefinitionByName("flash.desktop.NativeApplication") as Class;
			
			try
			{
				var appDescriptor:XML = NativeApplication.nativeApplication.applicationDescriptor;
				var ns:Namespace = appDescriptor.namespace();
				
				_version = appDescriptor.ns::versionNumber;
			}
			catch (e:Error)
			{
				
			}
			return _version;
		}
		
		static public function set version(value:String):void 
		{
			_version = value;
			shardObject.data.version = value;
			shardObject.flush();
		}
		
		public static function isNewVersion(newVer:String = "1.0", oldVer:String = null):Boolean
		{
			var newArr:Array = newVer.split(".").concat("0","0","0")
			if (!oldVer) oldVer = version;
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
