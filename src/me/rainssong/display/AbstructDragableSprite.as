package me.rainssong.display

{
	import flash.geom.Point;
	import me.rainssong.events.DragEvent;
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	import me.rainssong.display.MySprite;
	
	/**
	 * ...
	 * @author rainssong
	 */
	[Event(name="startDrag",type="events.DragEvent")]
	[Event(name="stopDrag",type="events.DragEvent")]
	[Event(name="onDragging",type="events.DragEvent")]
	[Event(name="offDragging",type="events.DragEvent")]
	[Event(name="moveEnd",type="events.DragEvent")]
	
	public class AbstructDragableSprite extends SmartSprite implements IDragableView
	{
		private var _isDragging:Boolean = false;
		
		protected var _speedX:Number=0;
		protected var _lastX:Number;
		protected var _speedY:Number=0;
		protected var _lastY:Number;
		
		protected var _startX:Number;
		protected var _startY:Number;
		
		protected var _changeMouseChildren:Boolean = false;
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
			if (Point.distance(new Point(_startX, _startY), new Point(stage.mouseX, stage.mouseY)) > 5)
			{
				if (mouseChildren)
				{
					this.mouseChildren = false;
					_changeMouseChildren = true;
				}
				
			}
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
			if (_changeMouseChildren)
			{
				
				this.mouseChildren = _changeMouseChildren;
				_changeMouseChildren = false;
			}
			
			
		
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