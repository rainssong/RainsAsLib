package me.rainssong.application

import flash.display.Sprite;
import flash.net.URLLoader;


/**
 * Application static property provider
 */
public class ApplicationManager
{

    private static var _version:String="1.0";
	
	public static function isDebugMode():Boolean
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