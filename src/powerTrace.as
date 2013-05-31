package 
{
	import flash.system.Capabilities;
	/**
	 * ...
	 * @author Rainssong
	 */
	
	public function powerTrace(... args):void
	{
		//if (Capabilities.isDebugger)
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