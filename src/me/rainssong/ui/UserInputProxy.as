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
	 * 本抽象类封装设备输入，将输入数据统一为InputMeta类型。需要自行增加功能和事件。
	 * 接口：控制键是否按下，控制点的当前位置，角度（比如重力）, 当前力度
	 * 事件：按下，抬起，移动，力度
	 *
	 * @author Rainssong
	 */
	public class UserInputProxy extends EventDispatcher
	{	
		protected var _isStopped:Boolean = false
		
		protected var _inputDic:Dictionary = new Dictionary();
		
		protected var _target:InteractiveObject;
		
		public function UserInputProxy(target:InteractiveObject, autoStart:Boolean = true)
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
		
		public function getInput(name:String = "default"):InputMeta
		{
			return _inputDic[name] as InputMeta;
		}
		
		public function get target():InteractiveObject
		{
			return _target;
		}
		
		public function isActive(key:* = 0):Boolean
		{
			return _inputDic[key].isActive as Boolean;
		}
		
		public function isActive(key:* = 0):Boolean
		{
			return !_inputDic[key].isActive as Boolean;
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