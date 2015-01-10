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
		private var _stepDic:Dictionary ;
		private var _paramsDic:Dictionary ;
		private var _isPaused:Boolean ;
		
		public function EnterFrameManager(target:DisplayObject=null, autoStart:Boolean = false) 
		{
			init(target?target:new Sprite());
			if(autoStart)start();
		}
		
		public function init(target:DisplayObject):void
		{
			destroy();
			
			_stepDic = new Dictionary();
			_paramsDic = new Dictionary();
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
			for ( var i:Function in _stepDic)
			{
				if (_stepDic[i] == 1)
				{
					if (_paramsDic[i]!=null) i.apply(this, _paramsDic[i]);
					else i();
					continue;
				}
				
				if (_frameCount % _stepDic[i] == 0 )
					if (_paramsDic[i]) i.apply(this, _paramsDic[i]);
					else i();
			}
			
		}
		
		public function addFun(fun:Function, step:int = 1,...params):void
		{
			_stepDic[fun] = step;
			_paramsDic[fun] = params;
			
		}
		
		public function removeFun(fun:Function):void
		{
			delete _stepDic[fun];
		}
		
		public function clear():void
		{
			if(_target)
				_target.removeEventListener(Event.ENTER_FRAME, onEnterFrame);
			_stepDic = null;
			_paramsDic = null;
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