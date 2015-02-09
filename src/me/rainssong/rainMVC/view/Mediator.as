package me.rainssong.rainMVC.view
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.net.URLLoader;
	import flash.utils.Timer;
	import me.rainssong.utils.objToCode;
	
	/**
	 * ...
	 * @author Rainssong
	 */
	public class Mediator
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
			
			if (_viewComponent.stage)
				onAdd();
			else
				_viewComponent.addEventListener(Event.ADDED_TO_STAGE, onAdd);
			
			_viewComponent.addEventListener(Event.REMOVED_FROM_STAGE, onRemove);
		}
		
		protected function onRegister():void
		{
			
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
		
		public function remove():void
		{
			if (_viewComponent.parent)
				_viewComponent.parent.removeChild(_viewComponent);
		}
		
		public function destroy():void
		{
			_viewComponent.removeEventListener(Event.REMOVED_FROM_STAGE, onRemove);
			removeViewListeners();
			deleteVars();
		}
		
		private function removeViewListeners():void
		{
			for (var i:int = 0; i < _listenerArr.length; i++)
			{
				removeViewListener(_listenerArr[i].type,_listenerArr[i].listener, _listenerArr[i].useCapture);
			}
			_listenerArr = null;
		}
		
		private function deleteVars():void
		{
			//useless
			
			for (var v:* in this)
			{
				trace(this,"~~~~~~~~~~~~~~~");
				delete this[v];
			}
			//for each(var v:* in this)
			//{
				//v = null;
			//}
			//objToCode
			
		}
		
		public function addViewLisenter(type:String, listener:Function, useCapture:Boolean=false, priority:int=0, useWeakReference:Boolean=false):void
		{
			var params:Object;
			var i:int = _listenerArr.length;
			while (i--)
			{
				params = _listenerArr[i];
				if (params.type == type
					&& params.listener == listener
					&& params.useCapture == useCapture
				)
				return;
			}
			
			params = {
					type: type,
					listener: listener,
					useCapture: useCapture
				};
			_listenerArr.push(params);
			
			
			_viewComponent.addEventListener(type, listener, useCapture, priority, useWeakReference);
		}
		
		public function removeViewListener(type:String, listener:Function, useCapture:Boolean=false):void
		{
		
			var params:Object;
			var i:int = _listenerArr.length;
			while (i--)
			{
				params = _listenerArr[i];
				if (params.type == type
					&& params.listener == listener
					&& params.useCapture == useCapture
					)
				{
					_viewComponent.removeEventListener(type, listener, useCapture);
					_listenerArr.splice(i, 1);
					return;
				}
			}
		}
		
		/* DELEGATE flash.display.DisplayObject */
		
		public function get stage():flash.display.Stage 
		{
			return _viewComponent.stage;
		}
		
		protected function addChild(child:DisplayObject) : DisplayObject 
		{
			if (_viewComponent is DisplayObjectContainer)
			{
				DisplayObjectContainer(_viewComponent).addChild(child);
				return child;
			}
			return null;
		}
		
		protected function addChildAt(child:DisplayObject,index:int) : DisplayObject 
		{
			if (_viewComponent is DisplayObjectContainer)
			{
				DisplayObjectContainer(_viewComponent).addChildAt(child,index);
				return child;
			}
			return null;
		}
		
		protected function removeChild(child:DisplayObject) : void 
		{
			if (_viewComponent is DisplayObjectContainer)
			{
				DisplayObjectContainer(_viewComponent).removeChild(child);
			}
		}
		
		protected function removeChildAt(index:int) : void 
		{
			if (_viewComponent is DisplayObjectContainer)
			{
				DisplayObjectContainer(_viewComponent).removeChildAt(index);
			
			}
		
		}
		
		protected function removeChildren() : void 
		{
			if (_viewComponent is DisplayObjectContainer)
			{
				DisplayObjectContainer(_viewComponent).removeChildren();
				
			}
		
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