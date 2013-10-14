package me.rainssong.ui
{
	import flash.display.DisplayObject;
	import flash.display.InteractiveObject;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.geom.Point;
	import flash.geom.Vector3D;
	import flash.utils.Dictionary;
	
	/**
	 * ...
	 * @author Rainssong
	 */
	public class UserControllerBase extends EventDispatcher
	{
		//private var _target:InteractiveObject;
		
		protected var _isStopped:Boolean = false
		protected var _keyDic:Dictionary = new Dictionary();
		//protected var _localX:Number = 0;
		//protected var _localY:Number = 0;
		protected var _points:Vector.<Vector3D> = new Vector.<Vector3D>();
		
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
		
		public function getLocalX(index:int=0):Number
		{
			if (_points[index])
				return _points[index].x;
			else
				return 0;
		}
		
		public function getLocalY(index:int=0):Number
		{
			if (_points[index])
				return _points[index].y;
			else
				return 0;
		}
		
		public function getLocalZ(index:int=0):Number
		{
			if (_points[index])
				return _points[index].z;
			else
				return 0;
		}
		
		public function getStageX(index:int=0):Number
		{
			return 0;
		}
		
		public function getStageY(index:int=0):Number
		{
			return 0;
		}
		
		public function getStageZ(index:int=0):Number
		{
			return 0;
		}
		
		public function get target():InteractiveObject
		{
			return _target;
		}
		
		public function isGriped(key:* = 0):Boolean
		{
			return _keyDic[key] as Boolean;
		}
		
		public function isReleased(key:* = 0):Boolean
		{
			return !_keyDic[key] as Boolean;
		}
		
		public function get hasController():Boolean
		{
			return true;
		}
		
		/**
		 * rotation as radians
		 */
		public function get rotation():Number
		{
			return 0
		}
	}

}