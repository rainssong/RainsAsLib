package me.rainssong.utils
{
	import flash.utils.getTimer;
	
	/**
	 * ...
	 * @author Rainssong
	 */
	public class LocalTimer
	{
		private var _startTime:int;
		private var _pauseTime:int=0;
		private var _pauseStartTime:int
		private var _isPaused:Boolean = true;
		
		public function LocalTimer()
		{
			
		}
		
		public function start():void
		{
			resume();
		}
		
		public function resume():void
		{
			_startTime ||= getTimer();
			if(_pauseStartTime)
				_pauseTime += getTimer() - _pauseStartTime;
			_isPaused = false;
		}
		
		public function pause():void
		{
			_pauseStartTime = getTimer();
			_isPaused = true;
		}
		
		
		public function stop():void
		{
			pause();
			_startTime = undefined;
			_pauseStartTime = undefined;
		}
		
		/**
		 * get total time as ms
		 */
		public function get time():int
		{
			_startTime ||= getTimer();
			var result:int= getTimer() - _startTime-_pauseTime;
			return result;
		}
		
		public function get isPaused():Boolean 
		{
			return _isPaused;
		}
		
		
		
	
	}

}