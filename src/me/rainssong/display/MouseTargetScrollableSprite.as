package me.rainssong.display
{
	
	import com.greensock.TweenLite;
	import me.rainssong.events.DragEvent;
	import flash.display.GradientType;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import me.rainssong.math.MathCore;
	
	
	import me.rainssong.utils.DebugPanel;
	
	/**
	 * ...
	 * @author rainssong
	 */
	public class MouseTargetScrollableSprite extends MouseDragableSprite implements IDragableView
	{
		
		//private var _downX:Number;
		//private var _downY:Number;
		
		
		//private var _currentAngle:Number
		
		//private var _lastRotation:Number;
		//private var _r:Number
		/**
		 * speed of rotation as angle
		 */
		public var xScorllable:Boolean=true;
		public var yScorllable:Boolean=true;;
		public var partWidth:Number = 100;
		public var partHeight:Number = 100;
		private var _rect:Rectangle = new Rectangle(0, 0, 1000, 1000);
		public var a:Number = 60;
		
		public function MouseTargetScrollableSprite()
		{
			super();
			
			//_currentAngle = this.rotation;
		}
		
		override public function stopDragging():void
		{
			super.stopDragging();
			
			
			//stage.removeEventListener(MouseEvent.MOUSE_UP, onMouseUp);
			
			var tergetIndexX:int = currentIndexX;
			var tergetIndexY:int = currentIndexY;
			if (xScorllable)	tergetIndexX= (currentIndexX+Math.floor(Math.abs(_speedX*30) * _speedX / a/partWidth));
			if (yScorllable) 	tergetIndexY= (currentIndexY+Math.floor(Math.abs(_speedY*30) * _speedY / a/partHeight));
			//var tergetY:Number = MathCore.getRangedNumber(Math.round(Math.abs(_speedY*30) * _speedY / a/partWidth)*partWidth,rect.y,rect.y+rect.height);
			//var tx:Number = (tergetX - this.x) / _speedX/30;
			var targetX:Number = MathCore.getRangedNumber(tergetIndexX * partWidth + rect.x, rect.x, rect.x + rect.width);
			var targetY:Number = MathCore.getRangedNumber(tergetIndexY * partHeight + rect.y, rect.y, rect.y + rect.height);
			TweenLite.to(this, 0.8, { x: targetX,y: targetY } );
			//if (yScorllable)	TweenLite.to(this, 0.8, {  } );
			
		}
		
		override public function startDragging(stageX:Number,stageY:Number):void
		{
			super.startDragging(stageX, stageY);
			TweenLite.killTweensOf(this)
		}
		
		override public function onDragging():void
		{
			super.onDragging();
			
			//_speedAngle *= 0.6;
			if(xScorllable)this.x += _speedX;
			if(yScorllable)this.y += _speedY;
			//this.y += _speedY;
			
		}
		
		override public function offDragging():void 
		{
			super.offDragging();
			
		}
		
		
		public function get currentIndexX():int
		{
			return  Math.round((this.x - rect.x) / partWidth);
		}
		
		public function get currentIndexY():int
		{
			return   Math.round((this.y - rect.y) / partHeight);
		}
		
		public function get rect():Rectangle 
		{
			//this.graphics.beginFill(0x000000, 0);
			return _rect;
		}
		
		public function set rect(value:Rectangle):void 
		{
			_rect = value;
		}

		//private function onMouseDown(e:MouseEvent):void
		//{
			//stage.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
			//stage.addEventListener(MouseEvent.MOUSE_OUT, onMouseUp);
			//startDragging(e.stageX,e.stageY);
		//}
		//
		//private function onMouseUp(e:MouseEvent):void
		//{
			//stage.removeEventListener(MouseEvent.MOUSE_UP, onMouseUp);
			//stage.removeEventListener(MouseEvent.MOUSE_OUT, onMouseUp);
			//stopDragging();
		//}
	
	}

}