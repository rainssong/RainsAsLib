package  me.rainssong.display
{
	import me.rainssong.display.MouseRotatableSprite;
	
	/**
	 * ...
	 * @author Rainssong
	 */
	public class SpeedRotatableSprite extends MouseRotatableSprite 
	{
		
		public function SpeedRotatableSprite() 
		{
			super();
			
		}
		
		override public function offDragging():void
		{
			super.offDragging();
			//var a:Number;
			//if(_speedAngle>1)
			//a = -1;
			//else if (_speedAngle < -1)
			//a = 1;
			//else
			//a=0
			//
			//_speedAngle += a;
			_speedAngle *=this._damping
			
			this.rotation += _speedAngle;
			
			
			if (Math.abs(_speedAngle) < 0.1 && _speedAngle!=0)
			{
				_speedAngle = 0
				//onMoveEnd();
				//dispatchEvent(new DragEvent(DragEvent.MOVE_END));
			}
		}
		
	}

}