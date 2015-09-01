package me.rainssong.effects {
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.GradientType;
	import flash.display.Sprite;
	import flash.geom.Matrix;
	
	/**
	* StaticReflection 类为显示对象生成一个静态倒影图像
	* @author PhoenixKerry（http://blog.sina.com.cn/yyy98）
	* @version 0.2
	*/
	public class StaticReflection extends Sprite {
		private var source:DisplayObject;
		private var bitmap:Bitmap;
		
		public function StaticReflection(source:DisplayObject) {
			this.source = source;
			
			var w:Number = source.width;
			var h:Number = source.height;
			
			var colors:Array = [0xFF0000, 0x0000FF];
			var alphas:Array = [0.4, 0];
			var ratios:Array = [0, 0xFF];
			
			var matrix:Matrix = new Matrix();
			matrix.createGradientBox(w, h, Math.PI / 2, 0, 0);
			
			var bmd:BitmapData = new BitmapData(w, h, true, 0x00000000);
			bitmap = new Bitmap(bmd);
			bmd.draw(source);
			addChild(bitmap);
			
			bitmap.scaleY = -1;
			bitmap.y = bitmap.height;
			bitmap.cacheAsBitmap = true;
			
			var mark:Sprite = new Sprite();
			mark.graphics.beginGradientFill(GradientType.LINEAR, colors, alphas, ratios, matrix);
			mark.graphics.drawRect(0, 0, w, h);
			addChild(mark);
			mark.cacheAsBitmap = true;
			
			bitmap.mask = mark;
		}
		
	}
}