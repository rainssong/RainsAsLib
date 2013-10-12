package   me.rainssong.ui
{
	import flash.display.DisplayObject;
	import flash.display.InteractiveObject;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.utils.Dictionary;
	
	/**
	 * ...
	 * @author Rainssong
	 */
	public class UserControllerBase extends EventDispatcher 
	{
		//private var _target:InteractiveObject;
		
		protected var _isStopped:Boolean = false
		protected var _gripDic:Dictionary = new Dictionary();
		protected var _localX:Number = 0;
		protected var _localY:Number = 0;
		protected var _isGripped:Boolean = false;
		protected var _target:InteractiveObject;
		
		
		
		public function UserControllerBase(target:InteractiveObject) 
		{
			super(null);
			_target = target;
		}
		
		public function start():void
		{
			_isStopped = false;
		}
		
		public function stop():void
		{
			_isStopped = true;
		}
		
		public function get localX():Number 
		{
			return _localX;
		}
		
		public function get localY():Number 
		{
			return _localY;
		}
		
		public function get target():InteractiveObject 
		{
			return _target;
		}
		
		public function isGriped(key:String = null):Boolean
		{
			if (!key)
				return _isGripped;
			else
				return _gripDic[key] as Boolean;
		}
		
		public function isReleased(key:String = null):Boolean
		{
			if (!key)
				return !_isGripped;
			else
				return !_gripDic[key] as Boolean;
		}
		
		
		public function get hasController():Boolean
		{
			return true;
		}
	}

}