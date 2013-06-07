package  me.rainssong.manager
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
			if (Capabilities.os.match("iPhone") || Capabilities.os.match("iPad") )
				return true;
			else return false;
		}
			
		public static function get isDebugMode():Boolean
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
		
		public static function get isReleaseMode():Boolean
		{
			return !isDebugMode;
		}
		
		public static function get isWebPlayer():Boolean 
		{
			return Capabilities.playerType == "ActiveX" || Capabilities.playerType == "PlugIn";
			//return true;
		}
		
		public static function get isStandlonePlayer():Boolean 
		{
			return Capabilities.playerType == "External" || Capabilities.playerType == "StandAlone";
		}
		
		
		
	}

}