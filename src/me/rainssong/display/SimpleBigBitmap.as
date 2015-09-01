package me.rainssong.display 
{

	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.IBitmapDrawable;
	import flash.display.Sprite;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	/**
	 * 简单的无尺寸限制的位图。不支持缩放。
	 * 由多张位图拼接而成。
	 */
	public class SimpleBigBitmap extends Sprite
	{
		public static const CELL_SIZE:int = 2880;
		
		/**
		 * 构造函数
		 * 
		 * @param	cellWidth 单张位图宽度
		 * @param	cellHeight 单张位图高度
		 * @param	width 总宽度
		 * @param	height 总高度
		 * @param	transparent 是否透明
		 * @param	fillColor 填充色
		 */
		public function SimpleBigBitmap(cellWidth:int = 2000, cellHeight:int = 2000, 
			width:int = 4000, height:int = 4000, 
			transparent:Boolean = false, fillColor:uint = 0x00000000, mergeAlpha:Boolean = true) 
		{
			if (cellWidth <= 0 || cellHeight <= 0 || width <= 0 || height <= 0)
			{
				throw new IllegalParameterException();
			}
			
			_rows = Math.ceil(height / cellHeight);
			_cols = Math.ceil(width / cellWidth);
			_cellWidth = cellWidth;
			_cellHeight = cellHeight;
			_width = width;
			_height = height;
			_transparant = transparent;
			_fillColor = fillColor;
			initializeCanvas();
			interactive = false;
			_matrix = new Matrix();
			_destPoint = new Point();
			_mergeAlpha = mergeAlpha;

		}
		
		//---------------------------------------------------------------------------------------------------------------
		// 位图操作
		//---------------------------------------------------------------------------------------------------------------
		
		private var _matrix:Matrix = null;
		
		private var _destPoint:Point = null;
		
		private var _mergeAlpha:Boolean = false;
		
		public function fill(color:uint):void
		{
			var bmpd:BitmapData;
			for each(var bmp:Bitmap in _canvas)
			{
				bmpd = bmp.bitmapData;
				bmpd.fillRect(bmpd.rect, color);
			}
		}
		
		/**
		 * 向砖块画布上画一个对象。指定的对象必须是左上角对齐注册点
		 * 
		 * @param	target	指定的对象
		 * @param	width	对象的宽，NaN表示默认的使用的target的width属性
		 * @param	height	对象的高，NaN表示默认的使用的target的height属性
		 * @param	x	画在画布上的x坐标
		 * @param	y	画在画布上的y坐标
		 * 
		 * @return	返回成功画到画布上的对象
		 */
		public function draw(target:IBitmapDrawable, x:Number = 0, y:Number = 0, width:Number = NaN, height:Number = NaN):IBitmapDrawable
		{
			if(target != null)
			{
				if (isNaN(width))
				{
					width = Object(target).width;
				}
				if (isNaN(height))
				{
					height = Object(target).height;
				}
				
				var matrix:Matrix = new Matrix();
				if(target is DisplayObject)
				{
					var targetObj:DisplayObject = DisplayObject(target);
					matrix.a = targetObj.transform.matrix.a;
					matrix.d = targetObj.transform.matrix.d;
				}
				
				var rowFrom:int = Math.max(y / _cellHeight, 0);
				var rowTo:int = Math.min(Math.ceil((y + height) / _cellHeight), _rows);
				var colFrom:int = Math.max(x / _cellWidth, 0);
				var colTo:int = Math.min(Math.ceil((x + width) / _cellWidth), _cols);
				var bmp:Bitmap;
				for (var row:int = rowFrom; row < rowTo; row++)
				{
					for (var col:int = colFrom; col < colTo; col++)
					{
						bmp = _canvas[row * _cols + col];
						_matrix.tx = x - bmp.x;
						_matrix.ty = y - bmp.y;
						_matrix.a = matrix.a;
						_matrix.d = matrix.d;
						bmp.bitmapData.draw(target, _matrix);
					}
				}
				
				return target;
			}
			else
			{
				return null;
			}
		}
		
		
		/**
		 * 向砖块画布上画一个位图
		 * 
		 * @param	target	指定的位图
		 * @param	x	画在画布上的x坐标
		 * @param	y	画在画布上的y坐标
		 * 
		 * @return	返回成功画到画布上的位图
		 */
		public function copyPixels(bmpd:BitmapData, bmpdRect:Rectangle = null, x:Number = 0, y:Number = 0):BitmapData
		{
			if (bmpd != null)
			{
				var rowFrom:int = Math.max(y / _cellHeight, 0);
				var rowTo:int = Math.min(Math.ceil((y + bmpd.height) / _cellHeight), _rows);
				var colFrom:int = Math.max(x / _cellWidth, 0);
				var colTo:int = Math.min(Math.ceil((x + bmpd.width) / _cellWidth), _cols);
				var bmp:Bitmap;
				for (var row:int = rowFrom; row < rowTo; row++)
				{
					for (var col:int = colFrom; col < colTo; col++)
					{
						bmp = _canvas[row * _cols + col];
						_destPoint.x = x - bmp.x;
						_destPoint.y = y - bmp.y;
						bmp.bitmapData.copyPixels(bmpd, bmpdRect == null ? bmpd.rect : bmpdRect, _destPoint, null, null, _mergeAlpha);
					}
				}
				
				return bmpd;
			}
			else
			{
				return null;
			}
		}
		
		//---------------------------------------------------------------------------------------------------------------
		// 交互
		//---------------------------------------------------------------------------------------------------------------
		
		private var _interactive:Boolean = false;
		
		public function set interactive(bool:Boolean):void
		{
			_interactive = bool;
			super.mouseEnabled = bool;
			super.mouseChildren = bool;
		}
		
		public function get interactive():Boolean
		{
			return _interactive;
		}
		
		override public function set mouseEnabled(bool:Boolean):void
		{
			throw new UnsupportedException();
		}
		
		override public function set mouseChildren(bool:Boolean):void
		{
			throw new UnsupportedException();
		}
		
		//---------------------------------------------------------------------------------------------------------------
		// 宽高尺寸
		//---------------------------------------------------------------------------------------------------------------
		
		private var _rows:uint = 0;
		
		private var _cols:uint = 0;
		
		private var _cellWidth:int = 0
		
		private var _cellHeight:int = 0;
		
		private var _width:int = 0;
		
		private var _height:int = 0;
		
		//---------------------------------------------------------------------------------------------------------------
		// 画布
		//---------------------------------------------------------------------------------------------------------------
		
		private var _canvas:Vector.<Bitmap> = null;
		
		private var _transparant:Boolean = false;
		
		private var _fillColor:uint = 0x000000;
		
		private function initializeCanvas():void
		{
			var numCanvas:int = _rows * _cols
			var row:int;
			var col:int;
			var lastRowIndex:int = _rows - 1;
			var lastColIndex:int = _cols - 1;
			var bmpdWidth:int;
			var bmpdHeight:int;
			var bmp:Bitmap;
			_canvas = new Vector.<Bitmap>(numCanvas);
			for (var i:int = 0; i < numCanvas; i++) 
			{
				row = i / _cols;
				col = i % _cols;
				bmpdWidth = col == lastColIndex ? _width - col * _cellWidth : _cellWidth;
				bmpdHeight = row == lastRowIndex ? _height - row * _cellHeight : _cellHeight;
				bmp = new Bitmap(new BitmapData(bmpdWidth, bmpdHeight, _transparant, _fillColor));
				_canvas[i] = bmp;
				bmp.x = col * _cellWidth;
				bmp.y = row * _cellHeight;
				addChild(bmp);
			}
		}
		
		//---------------------------------------------------------------------------------------------------------------
		// 实现 IDestroy 接口
		//---------------------------------------------------------------------------------------------------------------
		
		public function destroy():void
		{
			DestroyUtil.removeChildren(this);
			DestroyUtil.destroyVector(_canvas);
			_canvas = null;
			_matrix = null;
			_destPoint = null;
		}
	}

}