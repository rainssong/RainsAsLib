package me.rainssong.utils
{
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	public function delayFunction(func:Function, params:Array = null, delay:int = 100, repeat:int = 1):void
	{
		var _func:Function = func;
		var _timer:Timer = new Timer(delay,repeat);
		_timer.addEventListener(TimerEvent.TIMER, _func=function():void
			{
				func.apply(null, params);
				if (_timer.currentCount == repeat)
				{
					_timer.removeEventListener(TimerEvent.TIMER, _func);
					_timer = null;
				}
			});
		
		_timer.start();
	}
}