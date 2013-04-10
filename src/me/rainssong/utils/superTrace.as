package me.rainssong.utils
{
	import flash.system.Capabilities;
	/**
	 * ...
	 * @author Rainssong
	 */
	
	public function superTrace(... args):void
	{
		if (Capabilities.isDebugger)
		{
			var e:Error = new Error();
			var caller:String = "[" + e.getStackTrace().match(/[\w\/$]*\(\)/g)[1] + "]";
			trace(caller, args);
		}
	}
}