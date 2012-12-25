package me.rainssong.application
{
	
	import flash.desktop.NativeApplication;
	import flash.display.Sprite;
	import flash.net.SharedObject;
	import flash.net.URLLoader;
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
		private static var _lastVersion:String = "0.1";
		public static var edition:String = NORMAL_EDITION;
		
		static private var inited:Boolean = false;
		
		
		private static function init():void
		{
			var _lastVersion:Strin ||== SharedObject.getLocal(NativeApplication.nativeApplication.applicationID).version;
			
		}
		public static function get shardObject():SharedObject
		
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
		
		static public function get lastVersion():String 
		{
			return _lastVersion;
		}
		
		static public function get version():String 
		{
			var NativeApplication:Class = getDefinitionByName("flash.desktop.NativeApplication") as Class;
			try
			{
				_version = NativeApplication.nativeApplication.applicationDescriptor.version.toString();
			}
			catch (e:Error)
			{
				
			}
			return _version;
		}
		
		static public function set version(value:String):void 
		{
			_version = value;
		}
	}
}
