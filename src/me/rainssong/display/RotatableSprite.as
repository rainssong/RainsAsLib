package
{
	
	import events.DragEvent;
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
	public class RotatableSprite extends AbstructDragableSprite implements IDragableView
	{
		//private var _downX:Number;
		//private var _downY:Number;
		private var _lastAngle:Number;
		private var _startAngle:Number
		
		//private var _lastRotation:Number;
		//private var _r:Number
		/**
		 * speed of rotation as angle
		 */
		private var _speedAngle:Number = 0;
		
		public function RotatableSprite()
		{
			super();
			this._damping = 0.95;
			//graphics.beginGradientFill(GradientType.LINEAR, [0xFF0000, 0x00FF00], [1, 1], [0, 255]);
			//graphics.drawCircle(0, 0, r);
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
			stage.removeEventListener(MouseEvent.MOUSE_OUT, onMouseUp);
		}
		
		override public function startDragging(stageX:Number,stageY:Number,drageRect:Rectangle=null):void
		{
			_lastAngle = angle(stage.mouseX,stage.mouseY);
			_startAngle =  angle(stage.mouseX,stage.mouseY)-this.rotation;
			super.startDragging(stageX,stageY,drageRect);
			
		}
		
		override public function onDragging():void
		{
			_speedAngle *= 0.6;
			this.rotation = angle(stage.mouseX,stage.mouseY)-_startAngle;
			var angleDistance:Number = angle(stage.mouseX,stage.mouseY) - _lastAngle;
			
			if (angleDistance >= 180)
				angleDistance = angleDistance-360;
			if (angleDistance <= -180)
				angleDistance = 360 + angleDistance;
			
			_speedAngle += angleDistance;
			_lastAngle = angle(stage.mouseX,stage.mouseY);
		}
		
		override public function offDragging():void
		{
			super.offDragging();
			_speedAngle *= this._damping;
			this.rotation += _speedAngle;
			
			if (Math.abs(_speedAngle) < 0.1)
			{
				_speedAngle = 0
				onMoveEnd();
				dispatchEvent(new DragEvent(DragEvent.MOVE_END));
			}
		}
		
		private function onMoveEnd():void 
		{
			
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
			stage.addEventListener(MouseEvent.MOUSE_OUT, onMouseUp);
			startDragging(e.stageX,e.stageX);
		}
		
		private function onMouseUp(e:MouseEvent):void
		{
			stage.removeEventListener(MouseEvent.MOUSE_UP, onMouseUp);
			stage.removeEventListener(MouseEvent.MOUSE_OUT, onMouseUp);
			stopDragging();
		}
	
	}

}