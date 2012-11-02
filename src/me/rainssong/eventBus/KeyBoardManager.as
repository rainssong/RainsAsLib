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
		private static var _keyDictionary:Dictionary;
		
		public static function startListen(displayObj:DisplayObject)
		{
			if (displayObj.stage)
			{
				if (_keyDictionary = null)_keyDictionary = new Dictionary();
				_stage = displayObj.stage;
				_stage.addEventListener(KeyboardEvent.KEY_DOWN, keyDown);
				_stage.addEventListener(KeyboardEvent.KEY_UP, keyUp);
			}
			else
			{
				throw Error(this+"stage not found!");
			}
		}
		
		public static function stopListen():void
		{
			_keyDictionary = new Dictionary();
			_stage = null;
			_stage.removeEventListener(KeyboardEvent.KEY_DOWN,onKeyDown);
			_stage.removeEventListener(KeyboardEvent.KEY_UP,onKeyUp);
		}
		
		public static function keyIsDown(keycode:uint):Boolean
		{
			return _keyDictionary[e.keyCode]?true:false;
		}
		
		private static function onKeyDown(e:KeyboardEvent):void
		{
			_keyDictionary[e.keyCode] = true;
		}
		
		private static function onKeyUp(evt:KeyboardEvent):void
		{
			_keyDictionary[e.keyCode] = false;
		}
		
		
		
	
	}

}