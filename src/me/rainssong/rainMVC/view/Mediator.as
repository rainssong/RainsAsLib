package me.rainssong.rainMVC.view
{
	import flash.display.DisplayObject;
	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.net.URLLoader;
	import flash.utils.Timer;
	
	/**
	 * ...
	 * @author Rainssong
	 */
	public class Mediator extends EventDispatcher
	{
		private var _name:String;
		public var autoDestroy:Boolean = true;
		protected var _viewComponent:DisplayObject;
		private var _listenerArr:Array = [];
		
		public function Mediator(viewComponent:DisplayObject)
		{
			//_name = name;
			_viewComponent = viewComponent;
			
			onRegister();
		}
		
		protected function onRegister():void
		{
			if (_viewComponent.stage)
				onAdd();
			else
				_viewComponent.addEventListener(Event.ADDED_TO_STAGE, onAdd);
			
			_viewComponent.addEventListener(Event.REMOVED_FROM_STAGE, onRemove);
		}
		
		protected function onAdd(e:Event = null):void
		{
			_viewComponent.removeEventListener(Event.ADDED_TO_STAGE, onAdd);
		
		}
		
		protected function onRemove(e:Event = null):void
		{
			if (autoDestroy)
				destroy();
		}
		
		public function destroy():void
		{
			_viewComponent.removeEventListener(Event.REMOVED_FROM_STAGE, onRemove);
			removeListeners();
			deleteVars();
		}
		
		private function removeListeners():void
		{
			for (var i:int = 0; i < _listenerArr.length; i++)
			{
				
				removeEventListener(_listenerArr[i][0], _listenerArr[i][1], _listenerArr[i][2]);
			}
			_listenerArr = null;
		}
		
		private function deleteVars():void
		{
			for (var v:String in this)
			{
				delete this[v];
			}
		}
		
		override public function addEventListener(type:String, listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false):void
		{
			_listenerArr.push([type, listener, useCapture]);
			super.addEventListener(type, listener, useCapture, priority, useWeakReference);
		}
		
		public function get viewComponent():DisplayObject 
		{
			return _viewComponent;
		}
	
		//public function get name():String 
		//{
		//return _name;
		//}
	
	}

}