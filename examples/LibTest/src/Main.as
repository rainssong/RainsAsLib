package 
{
	//import flash.desktop.NativeApplication;
	import flash.events.Event;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.geom.Rectangle;
	import flash.ui.Multitouch;
	import flash.ui.MultitouchInputMode;
	import me.rainssong.application.ApplicationBase;
	import me.rainssong.application.ApplicationManager;
	import me.rainssong.utils.superTrace;
	
	import me.rainssong.display.MouseDragSprite;
	import me.rainssong.events.MouseInteractiveEvent;
	
	/**
	 * 
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
			
			var temp:MouseDragSprite = new MouseDragSprite();
			temp.graphics.beginFill(0x000000);
			temp.graphics.drawRect(0, 0, 200, 200);
			addChild(temp);
			temp.addEventListener(MouseInteractiveEvent.SWIPE,onSwipe);
		}
		
		private function onSwipe(e:MouseInteractiveEvent):void 
		{
			superTrace(e.direction);
		}
		
	
		
	}
	
}