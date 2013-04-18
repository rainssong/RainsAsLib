package me.rainssong.display 
{
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	/**
	 * 原来的拖动可以完全被代替
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
			//startDrag();
		}
		
		override public function onMouseUp(e:MouseEvent):void 
		{
			super.onMouseUp(e);
			//stopDrag();
		}
		
		override protected function onInteracting():void 
		{
			super.onInteracting();
			this.x += _speedX;
			this.y += _speedY;
		}
		
		
		public function get isDragging():Boolean
		{
			return _isInteracting; 
		}
	}
}