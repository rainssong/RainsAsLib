package
{
	import flash.display.DisplayObject;
	import flash.display.Stage;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.events.KeyboardEvent;
	import flash.utils.Dictionary;
	
	/**
	 * ...
	 * @author Rainssong
	 */
	public class KeyBoardManager
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
			}
			else
			{
				throw Error(displayObj+" stage not found!");
			}
		}
		
		public static function stopListen():void
		{
			_keyDictionary = new Dictionary();
			_stage = null;
			_stage.removeEventListener(KeyboardEvent.KEY_DOWN,onKeyDown);
			_stage.removeEventListener(KeyboardEvent.KEY_UP,onKeyUp);
		}
		
		public static function regFunction(fun:Function, keyCode:uint):void
		{
			if(_funDictionary[keyCode]){
				throw new Error("重复对"+String(keyCode)+"进行按键注册方法可能造成管理混乱，请将同一按键执行的动作放置于一个统一的方法中");
			}
			_funDictionary[keyCode] = fun;
		}
		
		
		public static function keyIsDown(keyCode:uint):Boolean
		{
			return _keyDictionary[keyCode]?true:false;
			
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
		
		public function clear(keyCode:uint=0):void
		{
			if(keyCode>0)
				_keyDictionary[keyCode] = false;
			else
					_keyDictionary = new Dictionary();
		}
		
		
	
	}

}