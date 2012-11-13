package me.rainssong.utils
{
	/**
	 * ...
	 * @author Rainssong
	 */
	
	public function superTrace(... args):void
	{
		var e:Error = new Error();
		var caller:String = "[" + e.getStackTrace().match(/[\w\/$]*\(\)/g)[1] + "]";
		trace(caller,args);
	}
}