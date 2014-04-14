package me.rainssong.manager
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.utils.Dictionary;
	/**
	 * ...
	 * @author Rainssong
	 */
	public class EnterFrameManager 
	{
		private var _target:DisplayObject;
		private var _frameCount:int = 0;
		private var _funDic:Dictionary ;
		private var _isPaused:Boolean ;
		
		public function EnterFrameManager(target:DisplayObject=null, autoStart:Boolean = false) 
		{
			init(target?target:new Sprite());
			if(autoStart)start();
		}
		
		public function init(target:DisplayObject):void
		{
			destroy();
			
			_funDic = new Dictionary();
			_frameCount = 0;
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
			_frameCount++;
			for ( var i:* in _funDic)
			{
				if (_funDic[i] == 1)
				{
					i();
					continue;
				}
				
				if (_frameCount % _funDic[i] == 0 )i();
			}
			
		}
		
		public function addFun(fun:Function, step:int = 1):void
		{
			_funDic[fun] = step;
			
		}
		
		public function removeFun(fun:Function):void
		{
			delete _funDic[fun];
		}
		
		public function clear():void
		{
			if(_target)
				_target.removeEventListener(Event.ENTER_FRAME, onEnterFrame);
			_funDic = null;
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
		
		public function get frameCount():int 
		{
			return _frameCount;
		}
		
	}

}