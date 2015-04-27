package me.rainssong.manager 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.utils.getTimer;
	import flash.utils.Timer;
	
	/**
	 * 执行器循环
	 */
	public class Loop
	{
		/**
		 * 构造函数
		 * 
		 * @param	frameRate 帧频
		 */
		public function Loop() 
		{
			initializeEngine();
			initializeExecutes();
		}
		
		//------------------------------------------------------------------------------------------------------------------------------
		// Execute
		//------------------------------------------------------------------------------------------------------------------------------
		
		private var _executes:Vector.<ILoopExecute> = null;
		
		private var _numExecutes:int = 0;
		
		/**
		 * 执行器数量
		 */
		public function get numberExecutes():int
		{
			return _numExecutes;
		}
		
		/**
		 * 获得所有的执行器。仅提供遍历操作，不能修改该集合
		 * 
		 * @return
		 */
		public function getExecutes():Vector.<ILoopExecute>
		{
			return _executes;
		}
		
		/**
		 * 添加一个执行器
		 * 
		 * @param	execute 指定的要添加的执行器。如果是 null，则不会被添加进去。
		 * 
		 * @return 返回被添加的执行器。如果返回 null，则表示没有添加成功。
		 */
		public function addExecute(execute:ILoopExecute):ILoopExecute
		{
			if (execute != null)
			{
				_executes.push(execute);
				_numExecutes++;
			}
			
			return execute;
		}
		
		/**
		 * 删除一个执行器
		 * 
		 * @param	execute 指定要删除的执行器
		 * 
		 * @return 返回被删除的执行器。如果返回 null，表示没有找到指定的执行器
		 */
		public function removeExecute(execute:ILoopExecute):ILoopExecute
		{
			var exe:ILoopExecute = null;
			if(execute != null)
			{
				for (var i:int = 0; i < _numExecutes; i++)
				{
					if (_executes[i] == execute)
					{
						exe = execute;
						_executes.splice(i, 1);
						_numExecutes--;
						break;
					}
				}
			}
			
			return exe;
		}
		
		/**
		 * 判断是否包含了指定的执行器
		 * 
		 * @param	execute
		 * 
		 * @return
		 */
		public function contains(execute:ILoopExecute):Boolean
		{
			for each(var aExecute:ILoopExecute in _executes)
			{
				if (aExecute == execute)
				{
					return true;
				}
			}
			
			return false;
		}
		
		private function initializeExecutes():void
		{
			_executes = new Vector.<ILoopExecute>();
		}
		
		private function destroyExecutes():void
		{
			if (_executes != null)
			{
				DestroyUtil.destroyVector(_executes);
				_executes = null;
			}
		}
		
		//------------------------------------------------------------------------------------------------------------------------------
		// Timer
		//------------------------------------------------------------------------------------------------------------------------------
		
		private var _engine:Sprite = null;
		
		private var _enabled:Boolean = true;
		
		private var _prevTime:int = 0;
		
		/**
		 * @private
		 */
		public function set enabled(bool:Boolean):void
		{
			_enabled = bool;
		}
		
		/**
		 * 是否运行
		 */
		public function get enabled():Boolean
		{
			return _enabled;
		}
		
		private function loopHandler(event:Event):void
		{
			var time:int = getTimer();
			if (_enabled)
			{
				var execute:ILoopExecute;
				for (var i:int = 0; i < _numExecutes; i++)
				{
					execute = _executes[i];
					if (execute.complete)
					{
						_executes.splice(i, 1);
						_numExecutes--;
						i--;
					}
					else
					{
						execute.loopExecute(time, _prevTime);
					}
				}
			}
			_prevTime = time;
		}
		
		private function initializeEngine():void
		{
			_engine = new Sprite();
			_engine.addEventListener(Event.ENTER_FRAME, loopHandler);
		}
		
		private function destroyEngine():void
		{
			if (_engine != null)
			{
				_engine.removeEventListener(Event.ENTER_FRAME, loopHandler);
				_engine = null;
			}
		}
		
		//------------------------------------------------------------------------------------------------------------------------------
		// 实现 IDestroy 接口
		//------------------------------------------------------------------------------------------------------------------------------
		
		/**
		 * @inheritDoc
		 */
		public function destroy():void
		{
			destroyEngine();
			destroyExecutes();
		}
		
	}

}