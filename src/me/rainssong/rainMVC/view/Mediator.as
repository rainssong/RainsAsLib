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
		
		public function Mediator(name:String,viewComponent:DisplayObject) 
		{
			_name = name;
			_viewComponent = viewComponent;
			_viewComponent.addEventListener(Event.ADDED_TO_STAGE, onAdd);
			onRegister();
		}
		
		public function onRegister():void
		{
			
		}
		
		private function onAdd(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAdd);
			
		}
		
		
		public function onRemove():void
		{
			
		}
		
		public function destroy():void
		{
			
		}
		
		
		public function getViewComponent():DisplayObject
		{
			return viewComponent;
		}
		
		public function get name():String 
		{
			return _name;
		}
		
	}

}