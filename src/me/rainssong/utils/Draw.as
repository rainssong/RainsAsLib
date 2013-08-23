package me.rainssong.utils
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.GradientType;
	import flash.display.Sprite;
	import flash.geom.Matrix;
	
	public class Draw
	{
		static public function circle(x:Number, y:Number, width:Number, height:Number, rgbs:Array, alphas:Array=null ,ratios:Array=null):Sprite
		{
			if (!alphas) alphas = [1];
			if (!ratios) ratios = [0,255];
			
			var sp:Sprite = new Sprite();
			var mtx:Matrix = new Matrix();
			mtx.createGradientBox(width * 2, height * 2, 0, x - width, y - height);
			sp.graphics.beginGradientFill(GradientType.RADIAL, rgbs, alphas, ratios, mtx);
			sp.graphics.drawEllipse(x - width, y - height, width * 2, height * 2);
			return sp;
		}
		
		static public function box(x:Number, y:Number, width:Number, height:Number, rgb:uint):Sprite
		{
			var sp:Sprite = new Sprite();
			sp.graphics.beginFill(rgb);
			sp.graphics.drawRect(x, y, width, height);
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