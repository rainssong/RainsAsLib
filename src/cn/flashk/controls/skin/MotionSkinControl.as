package cn.flashk.controls.skin 
{
	import cn.flashk.controls.managers.DefaultStyle;
	
	import flash.display.DisplayObject;
	import flash.display.InteractiveObject;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.MouseEvent;
	import flash.filters.DropShadowFilter;
	import flash.geom.ColorTransform;
	/**
	 * ...
	 * @author flashk
	 */
	public class MotionSkinControl 
	{
		public static var over:Array = [4, 8, 12,16, 20];
		public static var out:Array = [2,4,6,8,10,12,14,16,18,20];
		
		public var resetAlpha:Boolean = true;
		public var filtersDown:Array;
		private var eventDis:InteractiveObject;
		private var view:DisplayObject;
		private var index:int;
		private var isOutViewHide:Boolean = false;
		
		public function MotionSkinControl(eventDis:InteractiveObject,view:DisplayObject) 
		{
			this.eventDis = eventDis;
			this.view = view;
			eventDis.addEventListener(MouseEvent.MOUSE_OVER, startShowOver);
			eventDis.addEventListener(MouseEvent.MOUSE_OUT, startShowOut);
			eventDis.addEventListener(MouseEvent.MOUSE_DOWN, startShowDown);
			eventDis.addEventListener(MouseEvent.MOUSE_UP, startShowUp);
			
			var shadow:DropShadowFilter = new DropShadowFilter(0, 90, 0, 0.2, 4, 4, 1, 1, true);
			filtersDown = DefaultStyle.filters.slice(0);
			filtersDown.push(shadow);
		}
		public function setOutViewHide(isHide:Boolean):void {
			isOutViewHide = isHide;
		}
		private function startShowOver(event:MouseEvent):void {
			index = 0;
			eventDis.removeEventListener(Event.ENTER_FRAME, outMotion);
			eventDis.addEventListener(Event.ENTER_FRAME, overMotion);
		}
		private function startShowOut(event:MouseEvent):void {
			index = out.length - 1;
			view.filters = DefaultStyle.filters;
			eventDis.removeEventListener(Event.ENTER_FRAME, overMotion);
			eventDis.addEventListener(Event.ENTER_FRAME, outMotion);
		}
		private function startShowUp(event:MouseEvent):void {
			view.filters = DefaultStyle.filters;
			index = over.length - 1;
			view.transform.colorTransform = new ColorTransform(1, 1, 1, view.alpha, over[index]*1.5, over[index]*1.5, over[index]*1.5, 0);
		}
		private function startShowDown(event:MouseEvent):void {
			eventDis.removeEventListener(Event.ENTER_FRAME, outMotion);
			eventDis.removeEventListener(Event.ENTER_FRAME, overMotion);
			view.transform.colorTransform = new ColorTransform(1, 1, 1, view.alpha);
			view.filters = filtersDown;
		}
		private  function overMotion(event:Event):void {
			if (index > over.length - 1) {
				eventDis.removeEventListener(Event.ENTER_FRAME, overMotion);
			}else {
				view.transform.colorTransform = new ColorTransform(1, 1, 1, view.alpha, over[index]*1.5, over[index]*1.5, over[index]*1.5, 0);
				if (isOutViewHide == true) {
					view.alpha = (index+1) / over.length;
				}else {
					if(resetAlpha == true){
						view.alpha = 1;
					}
				}
			}
			index ++;
		}
		private  function outMotion(event:Event):void {
			if (index <0) {
				eventDis.removeEventListener(Event.ENTER_FRAME, outMotion);
			}else {
				view.transform.colorTransform = new ColorTransform(1, 1, 1,  view.alpha, out[index]*1.5, out[index]*1.5, out[index]*1.5, 0);
				if (isOutViewHide == true) {
					view.alpha = index / out.length;
				}else {
					if(resetAlpha == true){
						view.alpha = 1;
					}
				}
			}
			index --;
		}
	}

}