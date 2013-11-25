package me.rainssong.display
{
	import flash.events.Event;
	import flash.events.FocusEvent;
	import flash.events.GestureEvent;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	import me.rainssong.display.SmartSprite;
	import me.rainssong.events.MouseInteractiveEvent;
	import me.rainssong.utils.Directions;
	
	/**
	 * 主动侦听鼠标事件，滑动手势，记录速度
	 * 
	 * @author Rainssong
	 */
	public class MouseInteractiveSprite extends SmartSprite
	{
		private var _isDragging:Boolean;
		private var _lockCenter:Boolean;
		private var _dragBounds:Rectangle=null;
		
		protected var _isInteracting:Boolean = false;
		protected var _speedX:Number = 0;
		protected var _lastX:Number;
		protected var _speedY:Number = 0;
		protected var _lastY:Number;
		
		protected var _startX:Number;
		protected var _startY:Number;
		
		/**
		 * reduction of speed
		 */
		//protected var _damping:Number = 0.8;
		
		[Event(name="swipe",type="me.rainssong.events.MouseInteractiveEvent")]
		
		public function MouseInteractiveSprite()
		{
			super();
		}
		
		override protected function onAdd(e:Event = null):void
		{
			super.onAdd(e);
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
			addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
		}
		
		public function onMouseDown(e:MouseEvent):void
		{
			stage.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
			stage.addEventListener(MouseEvent.RELEASE_OUTSIDE, onMouseUp);
			//stage.addEventListener(FocusEvent.FOCUS_OUT, onMouseUp);
			
			_isInteracting = true;
			
			_startX = stage.mouseX;
			_startY = stage.mouseY;
			_lastX = stage.mouseX;
			_lastY = stage.mouseY;
			_speedX = 0;
			_speedY = 0;
		}
		
		public function onMouseUp(e:MouseEvent):void
		{
			stage.removeEventListener(MouseEvent.MOUSE_UP, onMouseUp);
			stage.removeEventListener(MouseEvent.RELEASE_OUTSIDE, onMouseUp);
			//stage.removeEventListener(FocusEvent.FOCUS_OUT, onMouseUp);
			_isInteracting = false;
			
			_speedX += stage.mouseX - _lastX;
			_speedY += stage.mouseY - _lastY;
			_lastX = stage.mouseX;
			_lastY = stage.mouseY;
			
			if (_speedX > 30)
				dispatchEvent(new MouseInteractiveEvent(MouseInteractiveEvent.SWIPE, Directions.RIGHT));
			if (_speedX < -30)
				dispatchEvent(new MouseInteractiveEvent(MouseInteractiveEvent.SWIPE, Directions.LEFT));
			if (_speedY > 30)
				dispatchEvent(new MouseInteractiveEvent(MouseInteractiveEvent.SWIPE, Directions.DOWN));
			if (_speedY < -30)
				dispatchEvent(new MouseInteractiveEvent(MouseInteractiveEvent.SWIPE, Directions.UP));
		
		}
		
		private function onEnterFrame(e:Event):void
		{
			if (_isInteracting)
			{
				onInteracting();
			}
			else
			{
				offInteracting();
			}
		}
		
		protected function offInteracting():void
		{
		
		}
		
		/**
		 * update speed value & last location
		 */
		protected function onInteracting():void
		{
			_speedX = stage.mouseX - _lastX;
			_speedY = stage.mouseY - _lastY;
			_lastX = stage.mouseX;
			_lastY = stage.mouseY;
			if (_isDragging)
			{
				this.x += _speedX;
				this.y += _speedY;
			}
		}
		
		//public function offDrag():void 
		//{
		//
		//}
		//
		//public function onDrag():void 
		//{
		//
		//}
		
		override public function startDrag(lockCenter:Boolean = false, bounds:Rectangle = null):void
		{
			_lockCenter = lockCenter;
			_dragBounds = bounds;
			_isDragging = true;
		}
		
		override public function stopDrag():void
		{
			_isDragging = false;
		}
		
		
		public function get isInteracting():Boolean
		{
			return _isInteracting;
		}
		
		public function get isDragging():Boolean 
		{
			return _isDragging;
		}
	
	}

}