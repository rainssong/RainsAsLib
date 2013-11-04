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
	 * 接口：控制键是否按下，控制点的当前位置，角度（比如重力）, 当前力度
	 * 事件：按下，抬起，移动，力度
	 *
	 * @author Rainssong
	 */
	public class UserControllerBase extends EventDispatcher
	{
		//private var _target:InteractiveObject;
		
		protected var _isStopped:Boolean = false
		protected var _keyDic:Dictionary = new Dictionary();
		//protected var _localX:Number = 0;
		//protected var _localY:Number = 0;
		protected var _points:Dictionary = new Dictionary();
		
		protected var _target:InteractiveObject;
		
		public function UserControllerBase(target:InteractiveObject, autoStart:Boolean = true)
		{
			super(null);
			_target = target;
			if (autoStart)
				start();
		}
		
		public function start():void
		{
			_isStopped = false;
		}
		
		public function stop():void
		{
			_isStopped = true;
		}
		
		public function getLocalX(name:String = "default"):Number
		{
			if (_points[name])
				return _points[name].x;
			else
				return 0;
		}
		
		public function getLocalY(name:String = "default"):Number
		{
			if (_points[name])
				return _points[name].y;
			else
				return 0;
		}
		
		public function getLocalZ(name:String = "default"):Number
		{
			if (_points[name])
				return _points[name].z;
			else
				return 0;
		}
		
		public function getStageX(name:String = "default"):Number
		{
			return 0;
		}
		
		public function getStageY(name:String = "default"):Number
		{
			return 0;
		}
		
		public function getStageZ(name:String = "default"):Number
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