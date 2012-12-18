package  me.rainssong.system
{
	import flash.system.Capabilities;
	/**
	 * ...
	 * @author Rainssong
	 */
	public class SystemManager 
	{
		
		public function SystemManager() 
		{
			throw Error(this+"static class!");
		}
		
		static public function get isWindows():Boolean
		{
			if (Capabilities.os.match("Windows"))
				return true;
			else return false;
			
		}
		
		static public function get isIOS():Boolean
		{
			if (Capabilities.os.match("iPhone"))
				return true;
			else return false;
			
		}
		
	}

}