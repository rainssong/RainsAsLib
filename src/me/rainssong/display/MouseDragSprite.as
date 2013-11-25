package me.rainssong.display 
{
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	/**
	 * 
	 * @author Rainssong
	 */
	public class MouseDragSprite extends MouseInteractiveSprite 
	{
		
		public function MouseDragSprite() 
		{
			super();
			
		}
		
		override public function onMouseDown(e:MouseEvent):void 
		{
			super.onMouseDown(e);
			startDrag();
		}
		
		override public function onMouseUp(e:MouseEvent):void 
		{
			super.onMouseUp(e);
			stopDrag();
		}
		
		override protected function onInteracting():void 
		{
			super.onInteracting();
		}
		
		override public function get isDragging():Boolean
		{
			return _isInteracting; 
		}
	}

}