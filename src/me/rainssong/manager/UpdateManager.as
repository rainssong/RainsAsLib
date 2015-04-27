package me.rainssong.manager
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.utils.Dictionary;
	import flash.utils.getTimer;
	/**
	 * ...
	 * @author Rainssong
	 */
	public class UpdateManager 
	{
		private var _target:DisplayObject;
		//private var _startTime:Number = 0;
		private var _lastTime:Number = 0;
		private var _currentTime:Number = 0;
		private var _functionDic:Dictionary ;
		private var _isPaused:Boolean ;
		private var _timeDelta:Number=0;
		
		public function UpdateManager(target:DisplayObject=null, autoStart:Boolean = false) 
		{
			init(target?target:new Sprite());
			if(autoStart)start();
		}
		
		public function init(target:DisplayObject):void
		{
			destroy();
			
			_functionDic = new Dictionary();
			//_startTime = 0;
			_lastTime = getTimer();
			_currentTime = getTimer();
			_isPaused= true;
			_target = target;
		}
		
		public function start():void
		{
			_target.addEventListener(Event.ENTER_FRAME, onEnterFrame);
			_isPaused = false;
		}
		
		public function pause():void
		{
			_target.removeEventListener(Event.ENTER_FRAME, onEnterFrame);
			_isPaused = true;
		}
		
		public function onEnterFrame(e:Event):void
		{
			_currentTime = new Date().time;
			_timeDelta = (_currentTime - _lastTime) * 0.001;
			_lastTime = _currentTime;
			
			for ( var i:Function in _functionDic)
			{
				 i.apply(this, [_timeDelta]);
			}
		}
		
		public function addFun(fun:Function):void
		{
			_functionDic[fun] = "function";
		}
		
		public function removeFun(fun:Function):void
		{
			delete _functionDic[fun];
		}
		
		public function clear():void
		{
			if(_target)
				_target.removeEventListener(Event.ENTER_FRAME, onEnterFrame);
			_functionDic = null;
			_isPaused = true;
		}
		
		public function destroy():void 
		{
			clear();
			_target = null;
		}
		
		
		public function isPaused():Boolean
		{
			return _isPaused;
		}
		
	}

}