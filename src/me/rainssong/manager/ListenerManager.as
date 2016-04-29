package me.rainssong.manager
{
	
	
	import flash.events.IEventDispatcher;
	import flash.utils.Dictionary;
	import me.rainssong.model.ListenerModel;
	import me.rainssong.utils.DestroyUtil;
	import me.rainssong.utils.ObjectCore;

	public class ListenerManager
	{
		private var _target:IEventDispatcher = null;
		
		private var _items:Vector.<ListenerModel>
		
		public function ListenerManager(target:IEventDispatcher)
		{
			if(target == null)
			{
				throw new Error("Null input target parameter.");
			}
			
			_target = target;
			_items = new Vector.<ListenerModel>
		}
		
		public function getTarget():IEventDispatcher
		{
			return _target;
		}
		
		public function createListener(type:String, listener:Function, useCapture:Boolean=false, priority:int = 0, useWeakReference:Boolean = false):ListenerModel
		{
			var item:ListenerModel = new ListenerModel(_target, type, listener, useCapture, priority, useCapture);
			
			_items.push(item);
			
			return item;
		}
		
		public function getListener(type:String, listener:Function, useCapture:Boolean = false):ListenerModel
		{
			for (var i:int = _items.length - 1; i >= 0;i-- ) 
			{
				var item:ListenerModel = _items[i]
				if(item.type == type && item.listener == listener && item.useCapture == useCapture)
				{
					return item;
				}
			}
			return null;
		}
		
		public function addListener(type:String, listener:Function, useCapture:Boolean=false, priority:int = 0, useWeakReference:Boolean = false):void
		{
			createListener(type, listener, useCapture, priority, useCapture).add();
		}
		
		public function removeListener(type:String, listener:Function, useCapture:Boolean = false):Boolean
		{
			var lm:ListenerModel = getListener(type, listener, useCapture)
			if (lm != null)
			{
				lm.remove();
				return true
			}
			else
				return false;
		}
		
		public function removeAllListeners():void
		{
			for each(var item:ListenerModel in _items)
			{
				item.remove()
			}
			_items.length = 0;
			//DestroyUtil.destroyVector(_items);
			
		}
		
		
		public function destroy():void
		{
			if(_items != null)
			{
				removeAllListeners();
				_items = null;
				_target = null;
			}
		}
	}
}