package  me.rainssong.controls
{
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import me.rainssong.controls.MyRadioBtn;

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