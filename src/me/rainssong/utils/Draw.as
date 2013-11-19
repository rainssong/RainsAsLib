package me.rainssong.utils
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.GradientType;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.geom.Matrix;
	
	public class Draw
	{
		static public function ellipse(target:Shape,x:Number, y:Number, width:Number, height:Number,color:int=0xFF0000):void
		{
			target.graphics.beginFill(color);
			target.graphics.drawEllipse(x, y, width, height);
		}
		
		static public function box(width:Number, height:Number, rgb:uint,alpha:Number=1):Sprite
		{
			var sp:Sprite = new Sprite();
			sp.graphics.beginFill(rgb,alpha);
			sp.graphics.drawRect(0,0, width, height);
			return sp;
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