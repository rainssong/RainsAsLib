package me.rainssong.utils
{
	import flash.system.Capabilities;
	import flash.utils.setTimeout;
	/**
	 * ...
	 * @author Rainssong
	 */
	
	public function timeoutTrace(time:Number,...args):void
	{
		//if (Capabilities.isDebugger)
		try
		{
			var e:Error = new Error();
			var caller:String = "[" + e.getStackTrace().match(/[\w\/$]*\(\)/g)[1] + "]";
			//trace(caller, args);
			setTimeout(function():void { trace(caller, args) } );
		}
		catch(e:Error)
		{
			
		}
	}
	
	
}