package me.rainssong.display 
{
	import flash.events.Event;
	import flash.events.MouseEvent;
	import me.rainssong.display.AbstructDragableSprite;
	import me.rainssong.events.DragEvent;
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
			
		}
		
		override protected function onAdd(e:Event = null):void 
		{
			super.onAdd(e);
			addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
			
		}
		
		protected function onMouseDown(e:MouseEvent):void 
		{
			stage.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
			startDragging(e.stageX, e.stageY);
			
		}
		
		protected function onMouseUp(e:MouseEvent):void 
		{
			if(stage)
 			{
				stage.removeEventListener(MouseEvent.MOUSE_UP, onMouseUp);
				stopDragging();
			}
		}
		
		override protected function onRemove(e:Event):void 
		{
			stage.removeEventListener(MouseEvent.MOUSE_UP, onMouseUp);
			super.onRemove(e);
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
			//this.x += _speedX;
			//this.y += _speedY;
		}
		
		override public function stopDragging():void 
		{
			super.stopDragging();
			stage.removeEventListener(MouseEvent.MOUSE_UP, stopDragging);
		
		}
		
		
	}

}