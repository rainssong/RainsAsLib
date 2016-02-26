package me.rainssong.manager
{
	import flash.display.DisplayObject;
	import flash.display.Stage;
	import flash.events.EventDispatcher;
	import flash.events.FocusEvent;
	import flash.events.IEventDispatcher;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	import flash.utils.Dictionary;
	
	/**
	 * TODO:增加参数选择keydown还是keyup，支持通配符
	 * @author Rainssong
	 */
	public class KeyboardManager
	{
		private static var _stage:Stage;
		private static var _keyDictionary:Dictionary=new Dictionary();
		private static var _funDictionary:Dictionary=new Dictionary();
		
		public static function startListen(displayObj:DisplayObject):void
		{
			if (displayObj.stage)
			{
				//if (_keyDictionary = null)_keyDictionary = new Dictionary();
				//if (_funDictionary = null)_funDictionary = new Dictionary();
				_stage = displayObj.stage;
				_stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
				_stage.addEventListener(KeyboardEvent.KEY_UP, onKeyUp);
				_stage.addEventListener(FocusEvent.FOCUS_OUT, onFocusOut);
			}
			else
			{
				throw Error(displayObj+" stage not found!");
			}
		}
		
		static private function onFocusOut(e:FocusEvent):void 
		{
			allKeyUp();
		}
		
		public static function stopListen():void
		{
			_keyDictionary = new Dictionary();
			_stage.removeEventListener(KeyboardEvent.KEY_DOWN,onKeyDown);
			_stage.removeEventListener(KeyboardEvent.KEY_UP, onKeyUp);
			_stage.removeEventListener(FocusEvent.FOCUS_OUT, onFocusOut);
			_stage = null;
			
		}
		
		public static function regFunction(fun:Function, keyCode:uint):void
		{
			if(_funDictionary[keyCode]){
				throw new Error("重复对"+String(keyCode)+"进行按键注册方法可能造成管理混乱，请将同一按键执行的动作放置于一个统一的方法中");
			}
			if (!_stage)
			{
				throw new Error("start listen first!");
			}
			_funDictionary[keyCode] = fun;
		}
		
		public static function unregFunction(keyCode:uint):void
		{
			_funDictionary[keyCode] = null;
		}
		public static function unregAllFunction():void
		{
			_funDictionary = new Dictionary();
		}
		
		
		public static function keyIsDown(keyCode:uint):Boolean
		{
			return _keyDictionary[keyCode]?true:false;
		}
		
		public static function keyUp(keyCode:uint):void
		{
			_keyDictionary[keyCode] = false;
		}
		
		public static function allKeyUp():void
		{
			_keyDictionary = new Dictionary();
		}
		
		private static function onKeyDown(e:KeyboardEvent):void
		{
			_keyDictionary[e.keyCode] = true;
			if (_funDictionary[e.keyCode])
				_funDictionary[e.keyCode]();
		}
		
		private static function onKeyUp(e:KeyboardEvent):void
		{
			_keyDictionary[e.keyCode] = false;
		}
	
	}

}