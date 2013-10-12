package  me.rainssong.events
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Rainssong
	 */
	public class UserControlEvent extends Event 
	{
		static public const CONTROLLER_GRIP:String = "controllerGrip";
		static public const CONTROLLER_RELEASE:String = "controllerRelease";
		static public const CONTROLLER_MOVE:String = "controllerMove";
		static public const CONTROLLER_SELECT:String = "controllerSelect";
		static public const COMMAND_LEFT:String = "commandLeft";
		static public const COMMAND_RIGHT:String = "commandRight";
		static public const COMMAND_UP:String = "commandUp";
		static public const COMMAND_DOWN:String = "commandDown";
		static public const COMMAND_ZOOM:String = "commandZoom";
		static public const COMMAND_ROTATE:String = "commandRotate";
		private var _power:Number = null;
		private var _localX:Number=null;
		private var _localY:Number = null;
		private var _id:String = null;
		
		
		public function UserControlEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false,id:String=null, localX:Number=null, localY:Number=null,power:Number=null) 
		{
			super(type, bubbles, cancelable);
			_power = power;
			_localX = localX;
			_localY = localY;
			_id=id
		}
		
		public function get power():Number 
		{
			return _power;
		}
		
		public function set power(value:Number):void 
		{
			_power = value;
		}
		
		public function get localX():Number 
		{
			return _localX;
		}
		
		public function set localX(value:Number):void 
		{
			_localX = value;
		}
		
		public function get localY():Number 
		{
			return _localY;
		}
		
		public function set localY(value:Number):void 
		{
			_localY = value;
		}
		
		public function get id():String 
		{
			return _id;
		}
		
		public function set id(value:String):void 
		{
			_id = value;
		}
		
	}

}