package 
{
	//import flash.desktop.NativeApplication;
	import flash.events.Event;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.ui.Multitouch;
	import flash.ui.MultitouchInputMode;
	import me.rainssong.application.ApplicationBase;
	import me.rainssong.application.ApplicationManager;
	
	/**
	 * ...
	 * @author Rainssong
	 */
	public class Main extends Sprite 
	{
		
		public function Main():void 
		{
			
			stage.scaleMode = StageScaleMode.SHOW_ALL;
			// touch or gesture?
			Multitouch.inputMode = MultitouchInputMode.TOUCH_POINT;
			
			// entry point
			
			
		}
		
		
		
	}
	
}