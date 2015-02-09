package me.rainssong.application
{
	
	
	import flash.desktop.NativeApplication;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.display.StageDisplayState;
	import flash.net.SharedObject;
	import flash.net.URLLoader;
	import flash.system.Capabilities;
	import flash.utils.getDefinitionByName;
	import me.rainssong.manager.SharedObjectProxy;
	import me.rainssong.system.SystemCore;


/**
 * Application static property provider
 */
	public class AirManager
	{
		private static var _sharedObjectData:SharedObjectProxy=new SharedObjectProxy(NativeApplication.nativeApplication.applicationID);
		
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
		
	}
}
