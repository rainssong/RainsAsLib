package me.rainssong.display
{
	
	import com.greensock.TweenLite;
	import me.rainssong.events.DragEvent;
	import flash.display.GradientType;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	
	import me.rainssong.utils.DebugPanel;
	
	/**
	 * ...
	 * @author rainssong
	 */
	public class MouseRotatableSprite extends AbstructDragableSprite implements IDragableView
	{
		//private var _downX:Number;
		//private var _downY:Number;
		protected var _lastAngle:Number;
		protected var _startAngle:Number
		
		//private var _currentAngle:Number
		
		//private var _lastRotation:Number;
		//private var _r:Number
		/**
		 * speed of rotation as angle
		 */
		protected var _speedAngle:Number = 0;
	
		
		public function MouseRotatableSprite()
		{
			super();
			this._damping = 0.95;
			//_currentAngle = this.rotation;
		}
		
		override protected function onAdd(e:Event = null):void
		{
			super.onAdd(e);
			addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
		}
		
		override public function stopDragging():void
		{
			super.stopDragging();
			stage.removeEventListener(MouseEvent.MOUSE_UP, onMouseUp);
			//stage.removeEventListener(MouseEvent.MOUSE_OUT, onMouseUp);
		}
		
		override public function startDragging(stageX:Number,stageY:Number):void
		{
			_lastAngle = angle(stage.mouseX,stage.mouseY);
			//_startAngle =  angle(stage.mouseX,stage.mouseY)-this.rotation;
			_startAngle =  angle(stage.mouseX,stage.mouseY)-this.rotation;
			super.startDragging(stageX, stageY);
		}
		
		override public function onDragging():void
		{
			super.onDragging();
			//_speedAngle *= 0.6;
			this.rotation = angle(stage.mouseX,stage.mouseY)-_startAngle;
			var angleDistance:Number = angle(stage.mouseX,stage.mouseY) - _lastAngle;
			
			if (angleDistance >= 180)
				angleDistance = angleDistance-360;
			if (angleDistance <= -180)
				angleDistance = 360 + angleDistance;
			
			_lastAngle = angle(stage.mouseX, stage.mouseY);
			_speedAngle = angleDistance;
		}
		
		
		
		
		public function angle(stageX:Number,stageY:Number ):Number
		{
			var centerPoint:Point = new Point(this.x, this.y);
			//var globaleCenterPoint:Point = localToGlobal(centerPoint);
			var _angle:Number = Math.atan2(stageY - centerPoint.y, stageX - centerPoint.x) * 180 / Math.PI;
			
			return _angle;
		}
		
		
		private function onMouseDown(e:MouseEvent):void
		{
			stage.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
			//stage.addEventListener(MouseEvent.MOUSE_OUT, onMouseUp);
			startDragging(e.stageX,e.stageY);
		}
		
		private function onMouseUp(e:MouseEvent):void
		{
			stage.removeEventListener(MouseEvent.MOUSE_UP, onMouseUp);
			//stage.removeEventListener(MouseEvent.MOUSE_OUT, onMouseUp);
			stopDragging();
		}
	
	}

}