package  
{
	import com.greensock.TweenLite;
	import me.rainssong.display.MouseRotatableSprite;
	import me.rainssong.utils.superTrace;
	
	/**
	 * ...
	 * @author Rainssong
	 */
	public class TargetRotatableSprite extends MouseRotatableSprite 
	{
		private var _numPart:int = 0;
		private var _partAngle:Number;
		public function TargetRotatableSprite(numPart:int=1) 
		{
			super();
			_numPart = numPart;
			_partAngle = 360 / _numPart;
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
			var _index:int = _targetAngle > 0?Math.round(_targetAngle / _partAngle):Math.round(_targetAngle / _partAngle);
			//superTrace("_index", _index);
			TweenLite.to(this, 0.4, { rotation:_index * _partAngle } );
			//superTrace("_targetAngle", _index * _partAngle);
			//superTrace("_______________________________")
		}
		
		public function get numPart():int 
		{
			return _numPart;
		}
		
		public function get index():int
		{
			var answer:int = Math.floor(rotation / _partAngle);
			return answer;
		}
	}

}