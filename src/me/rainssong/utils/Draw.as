package me.rainssong.utils
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.GradientType;
	import flash.display.Graphics;
	import flash.display.IBitmapDrawable;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.geom.Matrix;
	
	public class Draw
	{
		static public function sector(graphics:Graphics, startAngle:Number = 0, endAngle:Number = 90, color:Number = 0xff0000, r:Number = 100, x:Number = 0, y:Number = 0, alpha:Number = 1):void
		{
			
			graphics.beginFill(color, alpha);
			
			graphics.moveTo(x, y);
			endAngle = (Math.abs(endAngle) > 360) ? 360 : endAngle;
			
			for (var i:int = startAngle; i <= endAngle; i++)
			{
				graphics.lineTo(x + r * Math.cos(i / 180 * Math.PI), y + r * Math.sin(i / 180 * Math.PI));
				
			}
			if (endAngle != 360)
			{
				graphics.lineTo(x, y);
			}
			graphics.endFill();
		}
		
		static public function getSprite(drawFun:Function = null, args:Array = null):Sprite
		{
			var sp:Sprite = new Sprite();
			args ||= [];
			
			if (drawFun != null)
			{
				var _args:Array = args.slice();
				_args.unshift(sp.graphics);
				drawFun.apply(_args,_args);
			}
			return sp;
		}
		
		static public function getShape(drawFun:Function = null, args:Array = null):Shape
		{
			var sp:Shape = new Shape();
			
			if (drawFun != null)
			{
				var _args:Array = args.slice();
				_args.unshift(sp.graphics);
				drawFun.apply(null,_args);
			}
			return sp;
		}
		
		static public function ellipse(graphics:Graphics, x:Number, y:Number, width:Number, height:Number, color:int = 0xFF0000):void
		{
			graphics.beginFill(color);
			graphics.drawEllipse(x, y, width, height);
			graphics.endFill();
		}
		
		static public function cirlce(graphics:Graphics, x:Number, y:Number, radius:Number, color:int = 0xFF0000):void
		{
			graphics.beginFill(color);
			graphics.drawCircle(x, y, radius);
			graphics.endFill();
		}
		
		static public function getBoxSp(width:Number = 100, height:Number = 100, rgb:uint = 0xFF0000, alpha:Number = 1):Sprite
		{
			var sp:Sprite = new Sprite();
			sp.graphics.beginFill(rgb, alpha);
			sp.graphics.drawRect(0, 0, width, height);
			sp.graphics.endFill();
			return sp;
		}
		
		static public function drawGraphics(graphics:Graphics, fun:Function,  rgb:uint = 0xFF0000,...args):Graphics
		{
			graphics.beginFill(rgb);
			
			fun.apply(null, args);
			graphics.endFill();
			return graphics;
		}
		
		//static public function roundRect(target:*, x:Number = 0, y:Number = 0, width:Number = 100, height:Number = 100,ellipseWidth:Number=0, ellipseHeight:Number=null, rgb:uint = 0xFF0000, alpha:Number = 1):void
		//{
			//
			//if (target == null)
				//return;
			//var graphics:Graphics
			//var shape:Shape = new Shape();
			//if (target.hasOwnProperty("graphics"))
			//{
				//graphics = target.graphics;
			//}
			//else if (target is Graphics)
			//{
				//graphics = target as Graphics;
			//}
			//else
			//{
				//graphics = shape.graphics;
			//}
			//
			//var graphics:Graphics = new Graphics();
			//graphics.beginFill(rgb, alpha);
			//graphics.drawRoundRect(x, y, width, height,ellipseWidth, ellipseHeight);
			//graphics.endFill();
			//
			//if (target is BitmapData)
				//BitmapData(target).draw(shape);
			//else if (target is Bitmap)
				//Bitmap(target).bitmapData.draw(shape);
		//
		//}
		//
		
		static public function rect(target:*, x:Number = 0, y:Number = 0, width:Number = 100, height:Number = 100, rgb:uint = 0xFF0000, alpha:Number = 1):void
		{
			
			if (target == null)
				return;
			var graphics:Graphics
			var shape:Shape = new Shape();
			if (target.hasOwnProperty("graphics"))
			{
				graphics = target.graphics;
			}
			else if (target is Graphics)
			{
				graphics = target as Graphics;
			}
			else
			{
				graphics = shape.graphics;
			}
			
			//var graphics:Graphics = new Graphics();
			graphics.beginFill(rgb, alpha);
			graphics.drawRect(x, y, width, height);
			graphics.endFill();
			
			if (target is BitmapData)
				BitmapData(target).draw(shape);
			else if (target is Bitmap)
				Bitmap(target).bitmapData.draw(shape);
		
		}
		
		public static function gridLines(graphics:Graphics, cols:uint = 10, rows:uint = 8, cellWidth:Number = 10, cellHeight:Number = 10, startX:Number = 0, startY:Number = 0):Boolean
		{
			if (graphics != null)
			{
				var width:Number = cols * cellWidth;
				var height:Number = rows * cellHeight;
				
				for (var row:uint = 0; row <= rows; row++)
				{
					graphics.moveTo(startX, startY + row * cellHeight);
					graphics.lineTo(startX + width, startY + row * cellHeight);
				}
				
				for (var col:uint = 0; col <= cols; col++)
				{
					graphics.moveTo(startX + col * cellWidth, startY);
					graphics.lineTo(startX + col * cellWidth, startY + height);
				}
				
				return true;
			}
			else
				return false;
		}
		
		static public function spriteBmp(bmd:BitmapData, scale:Number = 1, x:Number = 0, y:Number = 0):Sprite
		{
			var sp:Sprite = new Sprite();
			sp.addChild(bitmap.apply(null, arguments));
			return sp;
		}
		
		static public function bitmap(bmd:BitmapData, scale:Number = 1, x:Number = 0, y:Number = 0):Bitmap
		{
			var bmp:Bitmap = new Bitmap(bmd);
			bmp.scaleX = bmp.scaleY = scale;
			bmp.x = x * scale;
			bmp.y = y * scale;
			return bmp;
		}
	}
}