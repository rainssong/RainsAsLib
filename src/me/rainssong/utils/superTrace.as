package me.rainssong.utils
{
	/**
	 * ...
	 * @author Rainssong
	 */
	
	public function superTrace(... args):void
	{
		var e:Error = new Error();
		for (var i:int = 0; i < args.length; i++)
		{
			trace("[" + e.getStackTrace().match(/[A-z\/]*\(\)/g)[1] + "]" + typeof(args[i]) + ":" + args[i]);
		}
	}
}