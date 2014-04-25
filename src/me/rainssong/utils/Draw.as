package me.rainssong.utils
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.GradientType;
	import flash.display.Graphics;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.geom.Matrix;
	
	public class Draw
	{
		static public function sector(graphics:Graphics, startAngle:Number = 0,endAngle:Number = 90 , color:Number = 0xff0000,r:Number = 100,x:Number = 0, y:Number = 0, alpha:Number=1):void
		{
			
			graphics.beginFill(color,alpha);
		
			graphics.moveTo(x, y);
			endAngle = (Math.abs(endAngle) > 360) ? 360 : endAngle;
			
			for (var i:int = startAngle; i <= endAngle; i++)
			{
				graphics.lineTo(x + r * Math.cos(i / 180 * Math.PI),y + r * Math.sin(i / 180 * Math.PI));
				
			}
			if (endAngle != 360)
			{
				graphics.lineTo(x, y);
			}
			graphics.endFill(); 
		}
		
		static public function ellipse(graphics:Graphics,x:Number, y:Number, width:Number, height:Number,color:int=0xFF0000):void
		{
			graphics.beginFill(color);
			graphics.drawEllipse(x, y, width, height);
			graphics.endFill(); 
		}
		
		static public function getBoxSp(width:Number, height:Number, rgb:uint,alpha:Number=1):Sprite
		{
			var sp:Sprite = new Sprite();
			sp.graphics.beginFill(rgb,alpha);
			sp.graphics.drawRect(0, 0, width, height);
			sp.graphics.endFill(); 
			return sp;
		}
		
		static public function rect(graphics:Graphics,x:Number=0,y:Number=0,width:Number=100, height:Number=100, rgb:uint=0xFF00000,alpha:Number=1):void
		{
			graphics.beginFill(rgb,alpha);
			graphics.drawRect(x, y, width, height);
			graphics.endFill();
		}
		
		public static function gridLines(graphics:Graphics, cols:uint = 10,rows:uint = 8,  cellWidth:Number = 10, cellHeight:Number = 10, startX:Number = 0, startY:Number = 0):Boolean
		{
			if(graphics != null)
			{
				var width:Number = cols * cellWidth;
				var height:Number = rows * cellHeight;
				
				for(var row:uint = 0; row <= rows; row++)
				{
					graphics.moveTo(startX, startY + row * cellHeight);
					graphics.lineTo(startX + width, startY + row * cellHeight);
				}
				
				for(var col:uint = 0; col <= cols; col++) 
				{
					graphics.moveTo(startX + col * cellWidth, startY);
					graphics.lineTo(startX + col * cellWidth, startY + height);
				}
				
				return true;
			}
			else
			{
				return false;
			}
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