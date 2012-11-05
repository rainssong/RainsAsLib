package 
{
	//import flash.desktop.NativeApplication;
	import flash.events.Event;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.filesystem.File;
	import flash.ui.Multitouch;
	import flash.ui.MultitouchInputMode;
	import me.rainssong.fileSystem.ResumeDownloader;
	
	
	
	/**
	 * ...
	 * @author rainssong
	 */
	public class Main extends Sprite 
	{
		
		public function Main():void 
		{
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			
			
			// touch or gesture?
			Multitouch.inputMode = MultitouchInputMode.TOUCH_POINT;
			
			
			// entry point
			var d:ResumeDownloader = new ResumeDownloader();
			d.download("http://sms.doctor120.net/ray/download/v15中文.zip", File.applicationDirectory.resolvePath("1.jpg").nativePath);
		}
		
		
		
	}
	
}