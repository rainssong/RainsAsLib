package com.kerry.effect {
	import flash.display.BitmapData;
	import flash.display.BitmapDataChannel;
	import flash.display.DisplayObject;
	import flash.filters.BevelFilter;
	import flash.filters.BitmapFilter;
	import flash.filters.BitmapFilterQuality;
	import flash.filters.BitmapFilterType;
	import flash.filters.BlurFilter;
	import flash.filters.ColorMatrixFilter;
	import flash.filters.ConvolutionFilter;
	import flash.filters.DisplacementMapFilter;
	import flash.filters.DisplacementMapFilterMode;
	import flash.geom.ColorTransform;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	/**
	 * PowerFilters 类提供便捷滤镜效果的类
	 * @author PhoenixKerry（http://blog.sina.com.cn/yyy98）
	 * @version 0.1
	 */
	public class PowerFilters {
		/**
		 * 为显示对象添加灰色滤镜
		 * @param source 显示对象
		 */
		public static function grayFilter(source:DisplayObject):void {
			source.filters = [getGrayFilter()];
		}
		
		/**
		 * 获取灰色滤镜
		 * @private
		 */
		private static function getGrayFilter():ColorMatrixFilter {
			var grayColorMat:Array =  [
								1/3, 1/3, 1/3, 0, 0,
								1/3, 1/3, 1/3, 0, 0,
								1/3, 1/3, 1/3, 0, 0,
								0, 0, 0, 1, 0 ];
			return new ColorMatrixFilter(grayColorMat);
		}
		
		/**
		 * 调整显示对象的亮度
		 * @param source 显示对象
		 * @param brightness [亮度] 默认值 100
		 */
		public static function lightingFilter(source:DisplayObject, brightness:Number = 100):void {
			var matrix:Array =  [
								1, 0, 0, 0, brightness,
								0, 1, 0, 0, brightness,
								0, 0, 1, 0, brightness,
								0, 0, 0, 1, 0 ];
			source.filters = [new ColorMatrixFilter(matrix)];
		}
		
		/**
		 * 为显示对象添加模糊滤镜
		 * @param source 显示对象
		 * @param blurX X轴模糊度
		 * @param blurY Y轴模糊度
		 */
		public static function blurFilter(source:DisplayObject, blurX:Number = 5, blurY:Number = 5):void {
			source.filters = [new BlurFilter(blurX, blurY, BitmapFilterQuality.HIGH)];
		}
		
		/**
		 * 为显示对象添加凸起边框滤镜
		 * @param	source 显示对象
		 * @param	distance 距离
		 * @param	angleInDegrees 角度
		 */
		public static function raiseFilter(source:DisplayObject, distance:Number = 5, angleInDegrees:Number = 45):void {
			var highlightColor:Number = 0xCCCCCC;
			var highlightAlpha:Number = 0.8;
			var shadowColor:Number = 0x808080;
			var shadowAlpha:Number = 0.8;
			var blurX:Number = 5;
			var blurY:Number = 5;
			var strength:Number = 5;
			var quality:Number = BitmapFilterQuality.HIGH;
			var type:String = BitmapFilterType.INNER;
			var knockout:Boolean = false;
			source.filters = [new BevelFilter(
																	  distance,
																	   angleInDegrees,
																	   highlightColor,
																	   highlightAlpha,
																	   shadowColor,
																	   shadowAlpha,
																	   blurX,
																	   blurY,
																	   strength,
																	   quality,
																	   type,
																	   knockout)
											];
		}
		
		/**
		 * 为显示对象添加浮雕滤镜
		 * @param source 显示对象
		 * @param angle 浮雕角度
		 */
		public static function embossFilter(source:DisplayObject, angle:uint = 315):void {
			var radian:Number = angle * Math.PI / 180;
			var pi4:Number = Math.PI / 4;
			var clamp:Boolean = false;
			var clampColor:Number = 0xFF0000;
			var clampAlpha:Number = 256;
			var bias:Number = 128;
			var preserveAlpha:Boolean = false;
			var matrix:Array = [ Math.cos(radian + pi4) * 256, Math.cos(radian + 2 * pi4) * 256, Math.cos(radian + 3 * pi4) * 256,
			                     Math.cos(radian) * 256, 0, Math.cos(radian + 4 * pi4) * 256,
			                     Math.cos(radian - pi4) * 256, Math.cos(radian - 2 * pi4) * 256, Math.cos(radian - 3 * pi4) * 256 ];
			var matrixCols:Number = 3;
			var matrixRows:Number = 3;
			source.filters = [new ConvolutionFilter(matrixCols, matrixRows, matrix, matrix.length, bias, preserveAlpha, clamp, clampColor, clampAlpha), getGrayFilter()];
		}
		
		/**
		 * 为显示对象添加锐化滤镜
		 * @param	source 显示对象
		 * @param	sharp 锐化值
		 */
		public static function sharpenFilter(source:DisplayObject, sharp:Number = 10):void {
			var matrix:Array = [ 0, 0, 0, 0, 0, 0, 0, 0, 0 ];
			matrix[1] = matrix[3] = matrix[5] = matrix[7] = -sharp;
			matrix[4] = 1 + sharp * 4;
			source.filters = [new ConvolutionFilter(3, 3, matrix)];
		}
		
		/**
		 * 为显示对象添加老照片滤镜
		 * @param	source 显示对象
		 */
		public static function oldPictureFilter(source:DisplayObject):void {
			var matrix:Array = new Array();
			matrix = matrix.concat([0.94, 0, 0, 0, 0]);
			matrix = matrix.concat([0, 0.9, 0, 0, 0]);
			matrix = matrix.concat([0, 0, 0.8, 0, 0]);
			matrix = matrix.concat([0, 0, 0, 0.8, 0]);
			source.filters = [new ColorMatrixFilter(matrix), getGrayFilter()];
		}
		
		/**
		 * 为显示对象添加扩散滤镜
		 * @param	source 显示对象
		 * @param	scaleX X轴比例
		 * @param	scaleY Y轴比例
		 */
		public static function diffuseFilter(source:DisplayObject, scaleX:Number = 5, scaleY:Number = 5):void {
			var componentX:Number = 1;
			var componentY:Number = 1;
			var color:Number = 0x000000;
			var alpha:Number = 0x000000;
			
			var tempBitmap:BitmapData =new BitmapData(source.width, source.height, true, 0x00FFFFFF);
			tempBitmap.noise(888888);
			
			source.filters = [new DisplacementMapFilter(tempBitmap, new Point(0, 0),componentX, componentY, scaleX, scaleY, DisplacementMapFilterMode.COLOR, color, alpha)];
		}
		
		/**
		 * 为显示对象添加水纹滤镜
		 * @param	source 显示对象
		 * @param scaleX X轴比例
		 * @param scaleY Y轴比例
		 */
		public static function waterColorFilter(source:DisplayObject, scaleX:Number = 5, scaleY:Number = 5):void {
			var componentX:Number = 1;
			var componentY:Number = 1;
			var color:Number = 0x000000;
			var alpha:Number = 0x000000;
			
			var tempBitmap:BitmapData = new BitmapData(source.width,source.height, true, 0x00FFFFFF);
			tempBitmap.perlinNoise(3, 3, 1, 1, false, true, 1, false);
			
			source.filters = [new DisplacementMapFilter(tempBitmap, new Point(0, 0),componentX, componentY, scaleX, scaleY, DisplacementMapFilterMode.COLOR, color, alpha)];
		}
		
		/**
		 * 调整显示对象的 R、G、B 通道的饱和度
		 * @param	source 显示对象
		 * @param	r 红色通道
		 * @param	g 绿色通道
		 * @param	b 蓝色通道
		 */
		public static function saturation(source:DisplayObject, r:Number = 1, g:Number = 1, b:Number = 1):void {
			var matrix:Array = new Array();
			matrix = matrix.concat([r, 0, 0, 0, 0]);
			matrix = matrix.concat([0, g, 0, 0, 0]);
			matrix = matrix.concat([0, 0, b, 0, 0]);
			matrix = matrix.concat([0, 0, 0, 1, 0]);
			source.filters = [new ColorMatrixFilter(matrix)];
		}
		
		/**
		 * 调整显示对象的 R、G、B 通道的曲线
		 * @param	source 显示对象
		 * @param	r 红色通道
		 * @param	g 绿色通道
		 * @param	b 蓝色通道
		 */
		public static function colorTrans(source:DisplayObject, r:Number = 0, g:Number = 0, b:Number = 0):void {
			var colorTransform:ColorTransform = new ColorTransform();
			colorTransform.redOffset = r;
			colorTransform.greenOffset = g;
			colorTransform.blueOffset = b;
			source.transform.colorTransform = colorTransform;
		}
		
		/**
		 * 为 BitmapData 对象添加噪点
		 * @param	source BitmapData 对象
		 * @param	degree 数量 [0 - 255]
		 */
		public static function noiseFilter(source:BitmapData, degree:Number = 128):void {
			for (var i:uint = 0; i < source.height; i++) {
				for (var j:uint = 0; j < source.width; j++) {
					var noise:int = int (Math.random() * degree * 2) - degree;
					var color:uint = source.getPixel(j, i);
					var r:uint = (color & 0xFF0000) >> 16;
					var g:uint = (color & 0x00FF00) >> 8;
					var b:uint = color & 0x0000FF;
					r = r + noise < 0 ? 0 : r + noise > 255 ? 255: r + noise;
					g = g + noise < 0 ? 0 : g +noise > 255 ? 255: g + noise;
					b = b + noise < 0 ? 0 : b + noise > 255 ? 255 : b + noise;
					source.setPixel(j, i, r * 65536 + g * 256 + b);
				}
			}
		}
		
		/**
		 * 为 BitmapData 对象添加素描效果
		 * @param	source BitmapData 对象
		 * @param	threshold 阈值 [0 - 100]
		 */
		public static function sketchFilter(source:BitmapData, threshold:Number = 30):void {
			for (var i:uint = 0; i < source.height - 1; i++) {
				for (var j:uint = 0; j < source.width - 1; j++) {
					var color:uint = source.getPixel(j, i);
					var gray1:uint = (color & 0xFF0000) >> 16;
					color = source.getPixel(j + 1, i + 1);
					var gray2:uint = (color & 0xFF0000) >> 16;
					if (Math.abs(gray1 - gray2) >= threshold) {
						source.setPixel(j, i, 0x222222);
					} else {
						source.setPixel(j, i, 0xFFFFFF);
					}
				}
			}
			
			for (i = 0; i < source.height; i++) {
				source.setPixel(source.width - 1, i, 0xFFFFFF);
			}
			
			for (i = 0; i< source.width; i++) {
				source.setPixel(i, source.height - 1, 0xFFFFFF);
			}
		}
		
		/**
		 * 为 BitmapData 对象添挤压滤镜
		 * @param	source BitmapData 对象
		 * @param	degree 数量
		 */
		public static function pinchFilter(source:BitmapData, degree:Number = 16):void {
			var midx:int = int(source.width / 2);
			var midy:int = int(source.height / 2);
			
			for (var i:uint = 0; i < source.height - 1; i++) {
				for (var j:uint = 0; j < source.width - 1; j++) {
					var offsetX:int = j - midx;
					var offsetY:int = i - midy;
					var radian:Number = Math.atan2(offsetY, offsetX);
					var radius:Number = Math.sqrt(offsetX * offsetX + offsetY * offsetY);
					radius = Math.sqrt(radius) * degree;
					
					var x:int = int(radius * Math.cos(radian)) + midx;
					var y:int = int(radius * Math.sin(radian)) + midy;
					
					if (x < 0) {
						x = 0;
					} else if (x >= source.width) {
						x = source.width - 1;
					}
					
					if (y < 0) {
						y = 0;
					} else if (y >= source.height) {
						y = source.height - 1;
					}
					
					var color:uint = source.getPixel(x, y);
					var r:uint = (color & 0xFF0000) >> 16;
					var g:uint = (color & 0x00FF00) >> 8;
					var b:uint = color & 0x0000FF;
					source.setPixel(j, i, r * 65536 + g * 256 + b);
				}
			}
		}
		
		/**
		 * 为 BitmapData 对象添加照明效果
		 * @param	source BitmapData 对象
		 * @param	power 照明强度 [0 - 255]
		 * @param	posx X比例坐标[0 - 1]
		 * @param	posy Y比例坐标 [0 - 1]
		 * @param	radius 照明半径
		 */
		public static function illuminateFilter(source:BitmapData, power:Number = 128, posx:Number = 0.5, posy:Number = 0.5, radius:Number = 0):void {
			var midx:uint = int(source.width * posx);
			var midy:uint = int(source.height * posy);
			if (radius == 0) {
				radius = Math.sqrt(midx * midx + midy * midy);
				if (radius == 0) {
					radius = Math.sqrt(source.width * source.width / 4 + source.height * source.height / 4);
				}
			}
			
			radius = Math.floor(radius);
			var sr:int = radius * radius;
			for (var y:uint = 0; y < source.height; y++) {
				for (var x:uint = 0; x < source.width; x++) {
					var sd:Number = (x - midx) * (x - midx) + (y - midy) * (y - midy);
					if (sd < sr) {
						var color:uint = source.getPixel(x, y);
						var r:uint = (color & 0xFF0000) >> 16;
						var g:uint = (color & 0x00FF00) >> 8;
						var b:uint = color & 0x0000FF;
						var distance:Number = Math.sqrt(sd);
						var brightness:int = int(power * (radius - distance) / radius);
						r = r + brightness > 255?255:r + brightness;
						g = g + brightness > 255?255:g + brightness;
						b = b + brightness > 255?255:b + brightness;
						source.setPixel(x, y, r * 65536 + g * 256 + b);
					}
				}
			}
		}
		
		/**
		 * 为 BitmapData 对象添加马赛克效果
		 * @param	source BitmapData 对象
		 * @param	block 马赛克大小[1 - 32]
		 */
		public static function mosaicFilter(source:BitmapData, block:Number = 6):void {
			for (var y:uint = 0; y < source.height; y += block) {
				for (var x:uint = 0; x < source.width; x += block) {
					var sumr:uint = 0;
					var sumg:uint = 0;
					var sumb:uint = 0;
					var product:uint = 0;
					
					for (var j:uint = 0; j < block; j++) {
						for (var i:uint = 0; i < block; i++) {
							if (x + i < source.width && y + j < source.height) {
								var color:uint = source.getPixel(x + i, y + j);
								var r:uint = (color & 0xff0000) >> 16;
								var g:uint = (color & 0x00ff00) >> 8;
								var b:uint = color & 0x0000ff;
								sumr += r;
								sumg += g;
								sumb += b;
								product++;
							}
						}
					}
					
					var br:int = int(sumr / product);
					var bg:int = int(sumg / product);
					var bb:int = int(sumb / product);
					
					for (j = 0; j < block; j++) {
						for (i = 0; i < block; i++) {
							if (x + i < source.width && y + j < source.height) {
								source.setPixel(x + i, y + j, br * 65536 + bg * 256 + bb);
							}
						}
					}
				}
			}
		}
		
		/**
		 * 为 BitmapData 对象添加油画效果（该效果渲染速度较慢）
		 * @param	source BitmapData 对象
		 * @param	brushSize 画笔大小 [1 - 8]
		 * @param	coarseness 颗粒大小 [1 - 255]
		 */
		public static function oilPaintingFilter(source:BitmapData, brushSize:Number = 1, coarseness:Number = 32):void {
			var arraylen:Number = coarseness + 1;
			
			var countIntensity:Array = new Array();
			var redAverage:Array = new Array();
			var greenAverage:Array = new Array();
			var blueAverage:Array = new Array();
			var alphaAverage:Array = new Array();
			
			for (var y:uint = 0; y < source.height; y++) {
				var top:Number = y - brushSize;
				var bottom:Number = y + brushSize + 1;
				if (top < 0) {
					top = 0;
				}
				if (bottom >= source.height) {
					bottom = source.height - 1;
				}
				for (var x:uint = 0; x < source.width; x++) {
					var left:Number = x - brushSize;
					var right:Number = x + brushSize + 1;
					if (left < 0) {
						left = 0;
					}
					if (right >= source.width) {
						right = source.width;
					}
					for (var i:uint = 0; i < arraylen; i++) {
						countIntensity[i] = 0;
						redAverage[i] = 0;
						greenAverage[i] = 0;
						blueAverage[i] = 0;
						alphaAverage[i] = 0;
					}
					for (var j:uint = top; j < bottom; j++) {
						for (i = left; i < right; i++) {
							var color:uint = source.getPixel(i, j);
							var gray:uint = (color & 0xff0000) >> 16;
							color = source.getPixel32(i, j);
							var a:uint = color >> 24 & 0xFF;
							var r:uint = color >> 16 & 0xFF;
							var g:uint = color >> 8 & 0xFF;
							var b:uint = color & 0xFF;
							var intensity:uint = int(coarseness * gray / 255);
							countIntensity[intensity]++;
							redAverage[intensity] += r;
							greenAverage[intensity] += g;
							blueAverage[intensity] += b;
							alphaAverage[intensity] += a;
						}
					}
					var closenIntensity:Number = 0;
					var maxInstance:Number = countIntensity[0];
					for (i = 1; i < arraylen; i++) {
						if (countIntensity[i] > maxInstance) {
							closenIntensity = i;
							maxInstance = countIntensity[i];
						}
					}
					a = int(alphaAverage[closenIntensity] / maxInstance);
					r = int(redAverage[closenIntensity] / maxInstance);
					g = int(greenAverage[closenIntensity] / maxInstance);
					b = int(blueAverage[closenIntensity] / maxInstance);
					source.setPixel32(x, y, a * 16777216 + r * 65536 + g * 256 + b);
				}
			}
		}
		
		/**
		 * 将 BitmapData 对象中阈值大于 threshold 参数的像素变为透明像素
		 * @param	source BitmapData 对象
		 * @param	threshold 阈值
		 */
		public static function thresholdFilter(source:BitmapData, threshold:uint = 128):void {
			var rect:Rectangle = new Rectangle(0, 0, source.width, source.height);
			var threshold:uint = threshold < 0 ? 0: threshold > 255 ? 255: threshold;
			var thre:uint =  255 * 0xFFFFFF + threshold * 0xFFFF + threshold * 0xFF + threshold;
			var color:uint = 0x00FFFFFF;
			var maskColor:uint = 0xFFFFFFFF;
			source.threshold(source, rect, new Point(0, 0), ">", thre, color, maskColor, false);
		}
		
		/**
		 * 该方法将显示对象的所有滤镜清空
		 */
		public static function removeAllFilters(displayObject:DisplayObject):void {
			displayObject.filters = [];
		}
		
		/**
		 * 为位图数据对象添加位图滤镜
		 * @private
		 * @param	bitmapData 位图数据对象
		 * @param	filter 位图滤镜
		 */
		private static function applyFilter(bitmapData:BitmapData, filter:BitmapFilter):void {
			bitmapData.applyFilter(
				bitmapData,
				bitmapData.rect,
				new Point(),
				filter
			);
		}
		
	}
}