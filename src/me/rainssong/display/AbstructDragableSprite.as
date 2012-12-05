package me.rainssong.display

{
	import me.rainssong.events.DragEvent;
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	import me.rainssong.display.MySprite;
	import me.rainssong.utils.superTrace;
	
	/**
	 * ...
	 * @author rainssong
	 */
	[Event(name="startDrag",type="events.DragEvent")]
	[Event(name="stopDrag",type="events.DragEvent")]
	[Event(name="onDragging",type="events.DragEvent")]
	[Event(name="offDragging",type="events.DragEvent")]
	[Event(name="moveEnd",type="events.DragEvent")]
	
	public class AbstructDragableSprite extends MySprite implements IDragableView
	{
		private var _isDragging:Boolean = false;
		
		protected var _speedX:Number=0;
		protected var _lastX:Number;
		protected var _speedY:Number=0;
		protected var _lastY:Number;
		
		protected var _startX:Number;
		protected var _startY:Number;
		/**
		 * reduction of speed
		 */
		protected var _damping:Number = 0.8;
		
		
		public function AbstructDragableSprite()
		{
			super();
			//throw Error("Don't init this Abstruct Class")
		}
		
		override protected function onAdd(e:Event = null):void
		{
			
			super.onAdd(e);
			//addEventListener(MouseEvent.MOUSE_DOWN, startDragging);
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
		
		
		protected function onEnterFrame(e:Event):void
		{
			//_speedX *= _damping;
			//_speedY *= _damping;
			
			if (_isDragging)
			{
				//_speedX += stage.mouseX - _lastX;
				//_speedY += stage.mouseY - _lastY;
				//_lastX = stage.mouseX ;
				//_lastY = stage.mouseY;
				onDragging();
				dispatchEvent(new DragEvent(DragEvent.ON_DRAGGING));
			}
			else
			{
				offDragging();
				dispatchEvent(new DragEvent(DragEvent.OFF_DRAGGING));
			}
		}
		
		public function onDragging():void 
		{
			
		}
		
		public function offDragging():void
		{
			
		}
		
		public function startDragging(stageX:Number, stageY:Number):void
		{
			_isDragging = true;
			_startX =_lastX= stageX;
			_startY =_lastY = stageY;
			
			
			//_lastX = e.stageX;
			//_lastY = e.stageY;
			//_speedX = 0;
			//_speedY = 0;
			
			dispatchEvent(new DragEvent(DragEvent.START_DRAG));
			
		}
		
		public function stopDragging():void
		{
			_isDragging = false;
			//_lastY = NaN;
			//_lastX = NaN;
			
			//stage.removeEventListener(MouseEvent.MOUSE_UP, stopDragging);
			//stage.removeEventListener(MouseEvent.MOUSE_OUT, stopDragging);
			dispatchEvent(new DragEvent(DragEvent.STOP_DRAG));
		}
		
		public function get isDragging():Boolean
		{
			return _isDragging;
		}
		
		//public function get speedY():Number 
		//{
			//return _speedY;
		//}
		//
		//public function get speedX():Number 
		//{
			//return _speedX;
		//}
	}

}