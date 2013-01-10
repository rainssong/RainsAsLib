package me.rainssong.rainMVC.view 
{
	import flash.display.DisplayObject;
	import flash.events.Event;
	/**
	 * ...
	 * @author Rainssong
	 */
	public class Mediator 
	{
		private var _name:String;
		protected var _viewComponent:DisplayObject;
		
		public function Mediator(viewComponent:DisplayObject) 
		{
			//_name = name;
			_viewComponent = viewComponent;
			
			onRegister();
		}
		
		public function onRegister():void
		{
			if (_viewComponent.stage)
			onAdd();
			else
			_viewComponent.addEventListener(Event.ADDED_TO_STAGE, onAdd);
			
			
			_viewComponent.addEventListener(Event.REMOVED_FROM_STAGE, onRemove);
		}
		
		public function onAdd(e:Event=null):void 
		{
			_viewComponent.removeEventListener(Event.ADDED_TO_STAGE, onAdd);
			
		}
		
		
		public function onRemove(e:Event=null):void
		{
			
		}
		
		public function destroy():void
		{
			_viewComponent.removeEventListener(Event.REMOVED_FROM_STAGE, onRemove);
		}
		
		
		public function getViewComponent():DisplayObject
		{
			return _viewComponent;
		}
		
		public function get name():String 
		{
			return _name;
		}
		
	}

}