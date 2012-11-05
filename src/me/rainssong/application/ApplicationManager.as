package me.rainssong.application

import br.com.stimuli.loading.BulkLoader;
import flash.display.Sprite;
import flash.net.URLLoader;

public class ApplicationManager
{

    private static var version:Number;

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