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
	import me.rainssong.net.ResumeDownloader;
	
	
	
	/**
	 * ...
	 * @author rainssong
	 */
	public class ResumeDownloaderTest extends Sprite 
	{
		
		public function ResumeDownloaderTest():void 
		{
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			
			
			// touch or gesture?
			Multitouch.inputMode = MultitouchInputMode.TOUCH_POINT;
			
			
			// entry point
			var d:ResumeDownloader = new ResumeDownloader();
			d.download("www.baidu.com", File.applicationDirectory.resolvePath("1.jpg").nativePath);
		}
		
		
		
	}
	
}