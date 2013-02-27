package 
{
	//import flash.desktop.NativeApplication;
	import flash.events.Event;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.ui.Multitouch;
	import flash.ui.MultitouchInputMode;
	import me.rainssong.display.SlideShow;
	
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
			
			var slideShow:SlideShow = new SlideShow();
			slideShow.slideContentArr=["http://pic2.aigou.com/upload/bbs/2008/01/27/93307038.jpg","http://pic2.aigou.com/upload/bbs/2008/01/27/19203395.jpg","http://pic2.aigou.com/upload/bbs/2008/01/28/59732431.jpg","http://b.zol-img.com.cn/desk/bizhi/image/2/1024x768/136194872883.jpg"]
			addChild(slideShow);
		}
		
		
		
	}
	
}