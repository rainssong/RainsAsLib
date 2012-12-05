package me.rainssong.display 
{
	import flash.events.MouseEvent;
	import me.rainssong.display.AbstructDragableSprite;
	import me.rainssong.utils.superTrace;
	
	/**
	 * ...
	 * @author Rainssong
	 */
	public class MouseDragableSprite extends AbstructDragableSprite 
	{
		
		public function MouseDragableSprite() 
		{
			super();
			addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown );
		}
		
		private function onMouseDown(e:MouseEvent):void 
		{
			stage.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
			startDragging(e.stageX, e.stageY);
		}
		
		private function onMouseUp(e:MouseEvent):void 
		{
			stage.removeEventListener(MouseEvent.MOUSE_UP, onMouseUp);
			stopDragging();
			
		}
		
		override public function startDragging(stageX:Number, stageY:Number):void 
		{
			super.startDragging(stageX, stageY);
			_speedX = 0;
			_speedY = 0;
		}
		
		override public function onDragging():void 
		{
			_speedX = stage.mouseX - _lastX;
			_speedY = stage.mouseY - _lastY;
			_lastX = stage.mouseX ;
			_lastY = stage.mouseY;
		}
		
		override public function stopDragging():void 
		{
			superTrace(_speedX);
			super.stopDragging();
			stage.removeEventListener(MouseEvent.MOUSE_UP, stopDragging);
		}
		
		
	}

}