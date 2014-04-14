package com.kerry.effect {
	import flash.display.Sprite;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Shape;
	import flash.events.Event;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import flash.filters.GlowFilter;
	
	/**
	 * Light 类用于生成闪电效果
	 * @author PhoenixKerry（http://blog.sina.com.cn/yyy98）
	 * @version 0.1
	 */
	public class Light extends Sprite {
		private var minDistance:Number;
		private var minRadius:Number;
		private var maxRadius:Number;
		private var maxAngle:Number;
		private var lineWidth:Number;
		private var startPoint:Point;
		private var endPoint:Point;
		
		private var timer:Timer;
		private var step:int = 1;
		private var segments:int;
		private var main_shape:Shape;
		
		 /**
		  * @param	startPoint 闪电的起点
		  * @param	endPoint 闪电的终点
		  * @param	lineWidth 闪电主干的粗度
		  * @param	minDistance 最小分段距离
		  * @param	minRadius 随机点处最小随机半径
		  * @param	maxRadius 随机半径的最大增加范围
		  * @example 以下是该类的使用范例代码，生成“闪点暴”效果：
			<listing version="3.0">
			var thunderTimer:Timer = new Timer(200);
			thunderTimer.start();
			thunderTimer.addEventListener(TimerEvent.TIMER, thunderOut);

			private function thunderOut(e:TimerEvent):void {
				var startPoint:Point = new Point(Math.random() * stage.stageWidth, 0);
				var endPoint:Point = new Point(Math.random() * stage.stageWidth, Math.random() * stage.stageHeight);
				var light:Light = new Light(startPoint, endPoint, 2);
				addChild(light);
			}</listing>
		  */
		public function Light(startPoint:Point, endPoint:Point, lineWidth:Number = 1, minDistance:Number = 30, minRadius:Number = 2, maxRadius:Number = 4) {
			this.startPoint = startPoint;
			this.endPoint = endPoint;
			this.lineWidth = lineWidth;
			this.minDistance = minDistance;
			this.minRadius = minRadius;
			this.maxRadius = maxRadius;
			
			segments = Math.floor(Point.distance(startPoint, endPoint) / minDistance);
			if (step < segments) {
				main_shape = new Shape();
				main_shape.filters = [new GlowFilter(0xdc1ad5, 1, 32, 32, 4)];
				addChild(main_shape);
				addEventListener(Event.ENTER_FRAME, onDrawingLight);
			}
		}
		
		/**
		 * @private 绘制闪电
		 */
		private function onDrawingLight(e:Event):void {
			if (step < segments) {
				drawLight(startPoint, endPoint);
			} else {
				timer = new Timer(80, 5);
				timer.start();
				timer.addEventListener(TimerEvent.TIMER, flashLight);
				timer.addEventListener(TimerEvent.TIMER_COMPLETE, onTimerComplete);
				removeEventListener(Event.ENTER_FRAME, onDrawingLight);
			}
		}
		
		/**
		 * @private
		 */
		private function onTimerComplete(e:TimerEvent):void {
			this.parent.removeChild(this);
		}
		
		/**
		 * @private
		 */
		private function flashLight(event:TimerEvent):void {
			main_shape.visible = !main_shape.visible;
		}
		
		/**
		 * @private
		 */
		private function drawLight(startPoint:Point,endPoint:Point):void {
			main_shape.graphics.clear();
			main_shape.graphics.moveTo(startPoint.x, startPoint.y);
			main_shape.graphics.lineStyle(lineWidth + (segments - step), 0xFFFFFF);
			
			var angle:Number = Math.atan2((endPoint.y - startPoint.y), (endPoint.x - startPoint.x));
			
			// 生成闪电的主干
			for (var i:int = 0; i < step; i++) {
				var temp_radius:Number = minRadius + Math.random() * maxRadius;
				var temp_angle:Number = angle + (Math.random() * 2 - 1) * Math.PI;
				
				var startX:Number = startPoint.x + (endPoint.x - startPoint.x) / segments * (i + 1) + temp_radius * Math.cos(temp_angle);
				var startY:Number = startPoint.y + (endPoint.y - startPoint.y) / segments * (i + 1) + temp_radius * Math.sin(temp_angle);
				
				// 有机率产生闪电分支
				if (Math.random() < .05 && step > 3) {
					var temp_angleRandom:Number = angle + (Math.random() - 1 / 2) * Math.PI / 2;
					var temp_radiusRandom:Number = Math.random() * 150 + 100;
					var temp_startPoint:Point = new Point(startX, startY);
					var temp_endPoint:Point = new Point(
						temp_startPoint.x + temp_radiusRandom * Math.cos(temp_angleRandom),
						temp_startPoint.y + temp_radiusRandom * Math.sin(temp_angleRandom));
					addChild(new Light(temp_startPoint, temp_endPoint, Math.random() * lineWidth / 2));
				}
				main_shape.graphics.lineTo(startX, startY);
			}
			
			step++;
		}
		
	}
}