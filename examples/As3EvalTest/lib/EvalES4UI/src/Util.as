package
{
	import com.hurlant.test.ILogger;
	
	/**
	 * ESC can't handle dotted packages well yet.
	 * Make testing easier by having a package-less class with a few static functions in it.
	 * 
	 *  
	 * @author henri
	 * 
	 */
	public class Util
	{
		static private var _logger:ILogger = null;
		static public function set logger(value:ILogger):void {
			_logger = value;
		}
		
		public static function print(...args):void {
			var s:String = args.join(" - ");
			if (_logger!=null) {
				_logger.print(s);
			} 
			trace(s);
		}

	}
}