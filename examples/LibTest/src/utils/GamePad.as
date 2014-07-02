package utils
{
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.GameInputEvent;
	import flash.ui.GameInput;
	import flash.ui.GameInputControl;
	import flash.ui.GameInputDevice;
	/**
	 * ...
	 * @author Mike
	 */
	public class GamePad 
	{
		
		private static var mGameInput:GameInput;
		private static var mDevice:GameInputDevice;
		
		public static function init():void
		{
			if (!mGameInput)
			{
				mGameInput = new GameInput();
				mGameInput.addEventListener(GameInputEvent.DEVICE_ADDED, onAdd);
			}
		}
		
		private static function onAdd(gie:GameInputEvent):void
		{
			if (GameInput.numDevices > 0)
			{
				if (!mDevice)
				{
					mDevice = GameInput.getDeviceAt(0);
					mDevice.enabled = true;
				}
			}
		}
		
		public static function isButtonDown(buttonCode:int):Boolean
		{
			if (!mDevice) return false;
			try {
				var c:GameInputControl = mDevice.getControlAt(buttonCode);
				return (c.value == 1) || (c.value == -1);
			} catch (e:Error)
			{
				mDevice = null;
			}
			return false;
		}
		
		public static function getValue(buttonCode:int):Number
		{
			if (!mDevice) return 0;
			try {
				var c:GameInputControl = mDevice.getControlAt(buttonCode);
				return c.value;
			} catch (e:Error)
			{
				mDevice = null;
			}
			return 0;
		}
		
	}

}