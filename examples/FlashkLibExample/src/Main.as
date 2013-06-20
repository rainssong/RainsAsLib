package 
{
	//import flash.desktop.NativeApplication;
	import cn.flashk.controls.Button;
	import cn.flashk.video.VideoDisplay;
	import flash.events.Event;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.ui.Multitouch;
	import flash.ui.MultitouchInputMode;
	
	/**
	 * ...
	 * @author Rainssong
	 */
	public class Main extends Sprite 
	{
		private var _btn1:Button = new Button();
		private var _video:VideoDisplay = new VideoDisplay();
		public function Main():void 
		{
			
			stage.scaleMode = StageScaleMode.SHOW_ALL;
			// touch or gesture?
			Multitouch.inputMode = MultitouchInputMode.TOUCH_POINT;
			
			// entry point
			
			
		}
	}
	
}