package me.rainssong.utils
{
	/**
	 * 旧版不再更新，推荐使用powerTrace
	 * @author Rainssong
	 * 2013-6-4
	 */
	
	public function superTrace(... args):void
	{
		try
		{
			var e:Error = new Error();
			var caller:String = "[" + e.getStackTrace().match(/[\w\/$]*\(\)/g)[1] + "]";
			trace(caller, args);
		}
		catch(e:Error)
		{
			
		}
	}
}