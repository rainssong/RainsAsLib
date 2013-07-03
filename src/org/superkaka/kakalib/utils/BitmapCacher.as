package org.superkaka.kakalib.utils 
{
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.geom.Transform;
	import org.superkaka.kakalib.struct.BitmapFrameInfo;
	import org.superkaka.kakalib.struct.GridBitmapDataInfo;
	/**
	 * 位图缓存类
	 * @author ｋａｋａ
	 */
	public class BitmapCacher
	{
		
		static private var pot:Point = new Point();
		
		/**
		 * 缓存单张位图
		 * @param	source			要被绘制的目标对象
		 * @param	transparent	是否透明
		 * @param	fillColor			填充色
		 * @param	scale				绘制的缩放值
		 * @return
		 */
		static public function cacheBitmap(source:DisplayObject, transparent:Boolean = true, fillColor:uint = 0x00000000, scale:Number = 1):BitmapFrameInfo
		{
			
			var rect:Rectangle = source.getBounds(source);
			var x:int = Math.round(rect.x * scale);
			var y:int = Math.round(rect.y * scale);
			
			//防止 "无效的 BitmapData"异常
			if (rect.isEmpty())
			{
				rect.width = 1;
				rect.height = 1;
			}
			
			var bitData:BitmapData = new BitmapData(Math.ceil(rect.width * scale), Math.ceil(rect.height * scale), transparent, fillColor);
			bitData.draw(source, new Matrix(scale, 0, 0, scale, -x, -y), null, null, null, true);
			
			//剔除边缘空白像素
			var realRect:Rectangle = bitData.getColorBoundsRect(0xFF000000, 0x00000000, false);
			
			if (!realRect.isEmpty() && (bitData.width != realRect.width || bitData.height != realRect.height))
			{
				
				var realBitData:BitmapData = new BitmapData(realRect.width, realRect.height, transparent, fillColor);
				realBitData.copyPixels(bitData, realRect, pot);
				
				bitData.dispose();
				bitData = realBitData;
				x += realRect.x;
				y += realRect.y;
				
			}
			
			var bitInfo:BitmapFrameInfo = new BitmapFrameInfo();
			bitInfo.x = x;
			bitInfo.y = y;
			bitInfo.bitmapData = bitData;
			
			return bitInfo;
		}
		
		/**
		 * 缓存位图动画
		 * @param	mc				要被绘制的影片剪辑
		 * @param	transparent	是否透明
		 * @param	fillColor			填充色
		 * @param	scale				绘制的缩放值
		 * @return
		 */
		static public function cacheBitmapMovie(source:DisplayObject, transparent:Boolean = true, fillColor:uint = 0x00000000, scale:Number = 1):Vector.<BitmapFrameInfo>
		{
			
			var v_bitInfo:Vector.<BitmapFrameInfo>;
			
			var mc:MovieClip = source as MovieClip;
			
			if (mc == null)
			{
				
				v_bitInfo = new Vector.<BitmapFrameInfo>(1, true);
				
				v_bitInfo[0] = cacheBitmap(source, transparent, fillColor, scale);
				
			}
			else
			{
				
				var i:int = 0;
				var c:int = mc.totalFrames;
				
				mc.gotoAndStop(1);
				
				v_bitInfo = new Vector.<BitmapFrameInfo>(c, true);
				
				while (i < c)
				{
					
					v_bitInfo[i] = cacheBitmap(mc, transparent, fillColor, scale);
					
					var list_childMC:Array = searchChild(mc, MovieClip);
					
					mc.nextFrame();
					
					var j:int = 0;
					var k:int = list_childMC.length;
					while (j < k) 
					{
						
						var childMC:MovieClip = list_childMC[j];
						childMC.nextFrame();
						
						j++;
					}
					
					i++;
				}
				
			}
			
			return v_bitInfo;
		}
		
		/**
		 * 缓存元件360度动画
		 * @param	mc				要被绘制的影片剪辑
		 * @param	transparent	是否透明
		 * @param	fillColor			填充色
		 * @return
		 */
		static public function cacheBitmapRotation(mc:DisplayObject, transparent:Boolean = true, fillColor:uint = 0x00000000):Vector.<BitmapFrameInfo>
		{
			
			var i:int = 0;
			var c:int = 360;
			
			var v_bitInfo:Vector.<BitmapFrameInfo> = new Vector.<BitmapFrameInfo>(c, true);
			
			///记录源对象的属性
			var parent:DisplayObjectContainer = mc.parent;
			var transform:Transform = mc.transform;
			
			
			var container:Sprite = new Sprite();
			container.addChild(mc);
			
			mc.x = 0;
			mc.y = 0;
			
			while (i < c)
			{
				mc.rotation = i;
				v_bitInfo[i] = cacheBitmap(container, transparent, fillColor);
				i++;
			}
			
			///恢复源对象的属性
			if (parent != null)
			{
				parent.addChild(mc);
			}
			
			mc.transform = transform;
			
			return v_bitInfo;
		}
		
		/**
		 * 根据指定的尺寸拆分图片缓存成位图数据二维数组
		 * @param	source					要被绘制的目标对象
		 * @param	gridWidth				格子宽
		 * @param	gridHeight				格子高
		 * @param	transparent			是否透明
		 * @param	fillColor					填充色
		 * @param	scale						绘制的缩放值
		 * @return
		 */
		static public function cacheGridBitmap(source:DisplayObject, gridWidth:int, gridHeight:int, transparent:Boolean = true, fillColor:uint = 0x00000000, scale:Number = 1):GridBitmapDataInfo
		{
			
			var rect:Rectangle = source.getBounds(source);
			
			var width:int = (rect.width + Math.round(rect.x)) * scale;
			var height:int = (rect.height + Math.round(rect.y)) * scale;
			
			var rowCount:int = Math.ceil(height / gridHeight);
			var columnCount:int = Math.ceil(width / gridWidth);
			
			var row:int = 0;
			var gridArr:Array = new Array(rowCount);
			
			while (row < rowCount)
			{
				
				var column:int = 0;
				var columnArr:Array = new Array(columnCount);
				gridArr[row] = columnArr;
				
				while (column < columnCount)
				{
					
					var bitData:BitmapData = new BitmapData(gridWidth, gridHeight, transparent, fillColor);
					bitData.draw(source, new Matrix(scale, 0, 0, scale, -gridWidth * column, -gridHeight * row), null, null, null, true);
					
					columnArr[column] = bitData;
					
					column++;
					
				}
				
				row++;
				
			}
			
			var gridBitDataInfo:GridBitmapDataInfo = new GridBitmapDataInfo();
			gridBitDataInfo.row = rowCount;
			gridBitDataInfo.column = columnCount;
			gridBitDataInfo.validWidth = width;
			gridBitDataInfo.validHeight = height;
			gridBitDataInfo.gridWidth = gridWidth;
			gridBitDataInfo.gridHeight = gridHeight;
			gridBitDataInfo.gridBitDataArray = gridArr;
			
			return gridBitDataInfo;
			
		}
		
	}

}