package me.rainssong.manager
{
	//import com.codeTooth.actionscript.dependencyInjection.core.Item;
	//import com.codeTooth.actionscript.lang.exceptions.NullPointerException;
	//import com.codeTooth.actionscript.lang.utils.destroy.DestroyUtil;
	//import com.codeTooth.actionscript.lang.utils.destroy.IDestroy;
	
	import flash.events.IEventDispatcher;
	import flash.utils.Dictionary;
	import me.rainssong.utils.DestroyUtil;
	import me.rainssong.utils.ObjectCore;

	public class ListenerManager
	{
		private var _target:IEventDispatcher = null;
		
		private var _items:Vector.<Item> = null;
		
		public function ListenerManager(target:IEventDispatcher)
		{
			if(target == null)
			{
				throw new Error("Null input target parameter.");
			}
			
			_target = target;
			_items = new Vector.<Item>();
		}
		
		public function getTarget():IEventDispatcher
		{
			return _target;
		}
		
		public function addListener(type:String, listener:Function, useCapture:Boolean, priority:int = 0, useWeakReference:Boolean = false):void
		{
			var item:Item = new Item();
			item.type = type;
			item.listener = listener;
			item.useCapture = useCapture;
			_items.push(item);
			_target.addEventListener(type, listener, useCapture, priority, useWeakReference);
		}
		
		public function removeListener(type:String, listener:Function, useCapture:Boolean = false):Boolean
		{
			for each(var item:Item in _items)
			{
				if(item.type == type && item.listener == listener && item.useCapture == useCapture)
				{
					_target.removeEventListener(item.type, item.listener, item.useCapture);
					delete _items[type];
					item.destroy();
					return true;
				}
			}
			
			return false;
		}
		
		public function removeAllListeners():void
		{
			for each(var item:Item in _items)
			{
				_target.removeEventListener(item.type, item.listener, item.useCapture);
			}
			DestroyUtil.destroyVector(_items);
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


//import com.codeTooth.actionscript.lang.utils.destroy.IDestroy;

class Item
{
	public var type:String = null;
	
	public var listener:Function = null;
	
	public var useCapture:Boolean = false;
	
	public function destroy():void
	{
		type = null;
		listener = null;
	}
}