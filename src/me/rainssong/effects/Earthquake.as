package com.kerry.effect {
	import flash.display.DisplayObject;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	/**
	* Earthquake 类为显示对象提供震动效果动画
	* @author PhoenixKerry（http://blog.sina.com.cn/yyy98）
	* @version 0.2
	*/
	public class Earthquake {
		private var source:DisplayObject;
		private var originalX:Number;
		private var originalY:Number;
		
		private var timer:Timer;
		private var intensity:Number
		
		/**
		 * @param	source 将要加入震动效果的显示对象
		 */
		public function Earthquake(source:DisplayObject) {
			this.source = source;
		}
		 
		/**
		 * 启用震动效果
		 * @param	intensity 震动强度
		 * @param	times 震动次数
		 * @param	intervalSeconds 间隔时间
		 */
		public function quake(intensity:Number = 10, times:uint = 5, intervalSeconds:Number = 0.05):void {
			this.intensity = intensity;
			originalX = source.x;
			originalY = source.y;
			
			timer = new Timer(intervalSeconds * 1000, times);
			timer.addEventListener(TimerEvent.TIMER, onQuake);
			timer.addEventListener(TimerEvent.TIMER_COMPLETE, rest);
			timer.start();
		}
		
		/**
		 * @private
		 */
		private function onQuake( event:TimerEvent ): void {
			source.x = originalX + Math.random() * intensity;
			source.y = originalY + Math.random() * intensity;
		}
		
		/**
		 * @private
		 */
		private function rest(e:TimerEvent): void {
			source.x = originalX;
			source.y = originalY;
		}
		
	}
}