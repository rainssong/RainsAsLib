package me.rainssong.system
{
	import flash.system.Capabilities;
	
	/**
	 * ...
	 * @author Rainssong
	 */
	public class SystemCore
	{
		
		public function SystemCore()
		{
			throw Error(this + "static class!");
		}
		
		static public function get isWindows():Boolean
		{
			if (Capabilities.os.match("Windows"))
				return true;
			else
				return false;
		
		}
		
		static public function get isIOS():Boolean
		{
			if (Capabilities.os.match("iPhone"))
				return true;
			else
				return false;
		
		}
		
		static public function get isMac():Boolean
		{
			if (Capabilities.os.match("Mac OS"))
				return true;
			else
				return false;
		
		}
		
		static public function gc():void
		{
			try
			{
				new LocalConnection().connect("gc");
				new LocalConnection().connect("gc");
			}
			catch (error:Error)
			{
					trace("Force gc!!!");
			}
		}
	
	}

}