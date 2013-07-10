package 
{
	import flash.system.Capabilities;
	/**
	 * @author Rainssong
	 * 2013-6-4
	 */
	
	 /**
	  * trace并输出本语句所在类/函数
	  * @param	args 
	  */
	public function powerTrace(...args):void
	{
		if (Capabilities.isDebugger)
		{
			var e:Error = new Error();
			var caller:String = "[" + e.getStackTrace().match(/[\w\/$]*\(\)/g)[1] + "]";
			trace(caller, args);
		}
	}
}