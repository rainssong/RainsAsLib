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

		
		static public function get isAndroid():Boolean
		{
			if (Capabilities.os.toLocaleLowerCase().match("android"))
				return true;
			else return false;
		}
		
		//TIP：always true if is air developing
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
		}
		
		public static function get isStandAlonePlayer():Boolean 
		{
			return Capabilities.playerType == "External" || Capabilities.playerType == "StandAlone" || Capabilities.playerType == "Desktop";
		}
		
		
		
	}

}