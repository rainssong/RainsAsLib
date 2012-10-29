package me.rainssong.application

import flash.display.Sprite;

public class ApplicationManager
{
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
}