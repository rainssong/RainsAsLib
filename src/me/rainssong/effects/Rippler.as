package me.rainssong.effects {
	import flash.display.BitmapData;
	import flash.display.BitmapDataChannel;
	import flash.display.BlendMode;
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.filters.ConvolutionFilter;
	import flash.filters.DisplacementMapFilter;
	import flash.geom.ColorTransform;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	/**
	* Rippler 类为显示对象上加入水波效果
	* @author PhoenixKerry（http://blog.sina.com.cn/yyy98）
	* @version 0.2
	*/
	public class Rippler {
		private var source:DisplayObject;
		
		private var buffer1:BitmapData;
		private var buffer2:BitmapData;
		private var defData:BitmapData;
		
		private var fullRect:Rectangle;
		private var drawRect:Rectangle;
		private var origin:Point = new Point();
		
		private var filter:DisplacementMapFilter;
		private var expandFilter:ConvolutionFilter;
		private var colourTransform:ColorTransform;
		
		private var matrix:Matrix;
		private var scaleInv:Number;

		/**
		* @param source 将要加入水波效果的显示对象
		* @param strength 水波运动的强度
		* @param scale 波纹的大小
		* @example 以下是该类的使用范例代码，实现水波纹效果：
		<listing version="3.0">
		// 创建一个 Rippler 实例于 source 上，强度为 60 并且体积为
		// source 可以是舞台上的任意显示对象，如 Bitmap 或 MovieClip
		var rippler : Rippler = new Rippler(source, 60, 6);

		// 在(100, 50) 的位置上创建一个大小为 20，透明度为 1 的水波
		rippler.drawRipple(100, 50, 20, 1);
		</listing>
		*/
		public function Rippler(source:DisplayObject, strength:Number, scale:Number = 2) {
			var correctedScaleX : Number;
			var correctedScaleY : Number;
			
			this.source = source;
			scaleInv = 1 / scale;
			
			buffer1 = new BitmapData(source.width * scaleInv, source.height * scaleInv, false, 0x000000);
			buffer2 = new BitmapData(buffer1.width, buffer1.height, false, 0x000000);
			defData = new BitmapData(source.width, source.height);
			
			correctedScaleX = defData.width / buffer1.width;
			correctedScaleY = defData.height / buffer1.height;
			
			fullRect = new Rectangle(0, 0, buffer1.width, buffer1.height);
			drawRect = new Rectangle();
			
			filter = new DisplacementMapFilter(buffer1, origin, BitmapDataChannel.BLUE, BitmapDataChannel.BLUE, strength, strength, "wrap");
			source.filters = [filter];
			
			source.addEventListener(Event.ENTER_FRAME, handleEnterFrame);
			expandFilter = new ConvolutionFilter(3, 3, [0.5, 1, 0.5, 1, 0, 1, 0.5, 1, 0.5], 3);
			colourTransform = new ColorTransform(1, 1, 1, 1, 127, 127, 127);
			matrix = new Matrix(correctedScaleX, 0, 0, correctedScaleY);
		}

		/**
		* 在 source 显示对象上的某一点上泛起水波
		* @param x 水波起点的 X 坐标
		* @param y 水波起点的 Y 坐标
		* @param size 第一次冲击时水波的直径
		* @param alpha 第一次冲击时水波的 alpha 值
		*/
		public function drawRipple(x:int, y:int, size:int, alpha:Number):void {
			var half : int = size >> 1;
			var intensity : int = (alpha * 0xff & 0xff) * alpha;
			
			drawRect.x = ( -half + x) * scaleInv;
			drawRect.y = ( -half + y) * scaleInv;
			drawRect.width = drawRect.height = size * scaleInv;
			buffer1.fillRect(drawRect, intensity);
		}
		
		/**
		* 返回实际的水波位图数据
		*/
		public function getRippleImage():BitmapData {
			return defData;
		}
		
		/**
		* 删除所有该实例所占用的内存资源，必须在销毁该实例之前调用该方法
		*/
		public function destroy():void {
			buffer1.dispose();
			buffer2.dispose();
			defData.dispose();
			source.removeEventListener(Event.ENTER_FRAME, handleEnterFrame);
		}
		
		/**
		* @private
		*/
		private function handleEnterFrame(e:Event):void {
			var temp:BitmapData = buffer2.clone();
			buffer2.applyFilter(buffer1, fullRect, origin, expandFilter);
			buffer2.draw(temp, null, null, BlendMode.SUBTRACT, null, false);
			defData.draw(buffer2, matrix, colourTransform, null, null, true);
			filter.mapBitmap = defData;
			source.filters = [filter];
			temp.dispose();
			switchBuffers();
		}
		
		/**
		* @private
		*/
		private function switchBuffers():void {
			var temp:BitmapData;
			temp = buffer1;
			buffer1 = buffer2;
			buffer2 = temp;
		}
	}
	
}