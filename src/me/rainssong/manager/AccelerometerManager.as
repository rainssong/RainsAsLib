package me.rainssong.manager
{
	import com.reintroducing.sound.SoundManager;
	import flash.events.AccelerometerEvent;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.sensors.Accelerometer;
	import flash.utils.getTimer;
	import me.rainssong.events.ObjectEvent;
	
	/**
	 * ...
	 * @author Rainssong
	 */
	public class AccelerometerManager extends EventDispatcher
	{
		//private const MIN_OFFSET:Number = 0.8;
		public var minSpeed:Number = 20;
		public var  minTime:Number = 70;  
		private var _accelerometer:Accelerometer;
		private var _lastTime:Number = 0;
		
		//private var shake_count:uint = 0;
		private var ax:Number;
		private var ay:Number;
		private var az:Number;
		
		/**
		 * 只检测一次
		 */
		public var autoStop:Boolean = false;
		/**
		 * 避免连续摇动
		 */
		public var autoClear:Boolean = true;
		
		public function AccelerometerManager():void
		{
			
			if (Accelerometer.isSupported)
			{
				ax = 0;
				ay = 0;
				az = 0;
				
				_accelerometer = new Accelerometer();
			}
			else
			{
				powerTrace("不支持重力感应")
			}
			// entry point
		}
		
		public function start():void
		{
			if (!Accelerometer.isSupported) return;
			if (!_accelerometer.hasEventListener(AccelerometerEvent.UPDATE))
			{
				ax = 0;
				ay = 0;
				az = 0;
				_lastTime = getTimer();
				_accelerometer.addEventListener(AccelerometerEvent.UPDATE, onUpdate);
			}
		}
		
		public function stop():void
		{
			if (!Accelerometer.isSupported) return;
			_accelerometer.removeEventListener(AccelerometerEvent.UPDATE, onUpdate);
		}
		
		private function onUpdate(e:AccelerometerEvent):void
		{
			//如果加速度值已经保存过了，则计算前后变化
			
			var duration:Number = getTimer()-_lastTime;
			_lastTime = getTimer();
			//if (duration < minTime)
				//return;
			
			var dx:Number = e.accelerationX - ax;
			var dy:Number = e.accelerationY - ay;
			var dz:Number = e.accelerationZ - az;
			
			ax = e.accelerationX;
			ay = e.accelerationY;
			az = e.accelerationZ;
			
			
			powerTrace(dx, dy, dz);
			
			var speed:Number = Math.sqrt(dx * dx + dy * dy + dz * dz) / duration * 1000;
			
			powerTrace(speed);
			
			//powerTrace(speed);
			
			if (speed > minSpeed)
				dispatchEvent(new AccelerometerEvent("shake", false, false, e.timestamp, dx, dy, dz));
			//当其中两个方向的加速度变化幅度都达到了指定值，即认为用户晃动了手机
			//if ((dx > MIN_OFFSET && dy > MIN_OFFSET) || (dx > MIN_OFFSET && dz > MIN_OFFSET) || (dy > MIN_OFFSET && dz > MIN_OFFSET))
			//{
				//shake_count++;
				//
				//if (shake_count >= 3)
				//{
					//
					//timer.start();
					//this.myapplication.manager_server.sandRequest("SHAKEGAME=" + shakeName + "&action=start");
					//dispatchEvent(new AccelerometerEvent("shake", false, false, e.timestamp, dx, dy, dz));
					//shake_count = 0;
				//
				//}
			//}
			//}
			//else
			//{
			//inited = true;
			//}
			//
			
			
			
			
		}
	
	}

}