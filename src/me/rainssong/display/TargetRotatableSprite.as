package  me.rainssong.display
{
	import com.greensock.TweenLite;
	import flash.events.Event;
	import me.rainssong.display.MouseRotatableSprite;
	
	/**
	 * ...
	 * @author Rainssong
	 */
	public class TargetRotatableSprite extends MouseRotatableSprite 
	{
		public var numPart:int = 0;
		//private var _partAngle:Number;
		private var _lastIndex:int = 0;
		public function TargetRotatableSprite(numPart:int=1) 
		{
			super();
			this.numPart = numPart;
			
			this._damping = 0.8;
		}
		
		override public function startDragging(stageX:Number, stageY:Number):void 
		{
			super.startDragging(stageX, stageY);
			TweenLite.killTweensOf(this);
		}
		
		override public function stopDragging():void 
		{
			super.stopDragging();
			var _angleDistance:Number = _speedAngle / (1 - _damping);
			//superTrace("_angleDistance", _angleDistance);
			var _targetAngle:Number = rotation + _angleDistance;
			//superTrace("_targetAngle", _targetAngle);
			//var _partAngle:Number = 360 / numPart;
			//var _index:int = _targetAngle > 0?Math.round(_targetAngle / partAngle):Math.round(_targetAngle / _partAngle);
			
			rollTo(getIndexByDegree(_targetAngle));
			
		}
		
		override protected function onEnterFrame(e:Event):void 
		{
			super.onEnterFrame(e);
			if (index != _lastIndex)
			{
				dispatchEvent(new Event(Event.CHANGE));
				_lastIndex = index;
			}
		}
		
		public function get index():int
		{
			var tempRotation:Number = rotation + 180 / numPart;
			tempRotation = tempRotation >= 0?tempRotation:tempRotation + 360;
			var answer:int = Math.floor(tempRotation / 360 * numPart);
			
			return answer;
		}
		
		public function rollTo(index:int):void
		{
			TweenLite.to(this, 0.4, { rotation:index * partAngle } );
			//var _partAngle:Number = 360 / numPart;
			//TweenLite.to(this, 0.4, { rotation:index * _partAngle } );
		}
		
		public function getIndexByDegree(degree:Number):int
		{
			return degree > 0?Math.round(degree / partAngle):Math.round(degree / partAngle);
		}
		
		public function get partAngle():Number
		{
			return 360 / numPart;
		}
		
	}

}