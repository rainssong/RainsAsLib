package  
{
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;

	/**
	 * ...
	 * @author rainsong
	 */
	public class MyRadioButtonGroup
	{
		public static const Selected:String = "selected";
		public static var selection:MyRadioBtn;
		
		public static var dispatcher:EventDispatcher = new EventDispatcher();
		
	}

}