package me.rainssong.display 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import me.rainssong.display.AbstructDragableSprite;
	import me.rainssong.events.DragEvent;
	import me.rainssong.utils.Draw;
	import me.rainssong.utils.superTrace;
	
	/**
	 * Out-of-date
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
			startDragging(e.stageX, e.stageY);
			
		}
		
		protected function onMouseUp(e:MouseEvent):void 
		{
			super.stopDragging();
			if(stage)
 			{
				stopDragging();
			}
			
		
		}
		
		override protected function onRemove(e:Event):void 
		{
			stage.removeEventListener(MouseEvent.MOUSE_UP, onMouseUp);
			stage.removeEventListener(MouseEvent.ROLL_OUT, onMouseUp);
			super.onRemove(e);
		}
		
		override public function startDragging(stageX:Number, stageY:Number):void 
		{
			
			super.startDragging(stageX, stageY);
			stage.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
			stage.addEventListener(MouseEvent.ROLL_OUT, onMouseUp);
			_speedX = 0;
			_speedY = 0;
		}
		
		override public function onDragging():void 
		{
			super.onDragging();
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
			
			stage.removeEventListener(MouseEvent.MOUSE_UP, onMouseUp);
			stage.removeEventListener(MouseEvent.ROLL_OUT, onMouseUp);
		}
		
		
	}

}