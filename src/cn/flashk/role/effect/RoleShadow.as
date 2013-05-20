package cn.flashk.role.effect
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.GradientType;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.filters.BlurFilter;
	import flash.geom.Matrix;

	public class RoleShadow extends Bitmap
	{
		public static var defautWidth:Number = 100;
		public static var defaultPercent:Number = 0.0;
		private var cx:Number;
		private var cy:Number;
		private var w:Number;
		private var sy:Number;
		private var per:Number;
		private var blur:Number = 0;
		private var qu:int = 1;
		private var col:uint = 0x000000;
		private var bd:BitmapData;
		private var alphaNum:Number = 0.95;
		
		public function RoleShadow()
		{
			per = defaultPercent;
			resetSize(100);
			//color = 0x0099FF;
		}
		public function set color(value:uint):void{
			col = value;
			redraw();
		}
		public function initXY(centerX:Number,centerY:Number):void{
			cx = centerX;
			cy = centerY;
			this.x = cx - this.width/2;
			this.y = cy - this.height/2;
		}
		public function resetSize(newWidth:Number,newScaleY:Number = 0.5):void{
			w = newWidth;
			sy = newScaleY;
			redraw();
		}
		public function setEffect(percent:Number,blur:Number=0,quality:int=1):void{
			per = percent;
			this.blur = blur;
			qu = quality;
			redraw();
		}
		private function redraw():void{
			var sh:Shape = new Shape();
			var sh2:Shape = new Shape();
			var sp:Sprite = new Sprite();
			var mat:Matrix = new Matrix();
			mat.createGradientBox(w,w,0,-w/2,-w/2);
			sh.graphics.beginGradientFill(GradientType.RADIAL,[col,col],[alphaNum,0],[int(per*255),255],mat,"pad","rgb",0);
			sh.graphics.drawCircle(0,0,w/2);
			sh2.graphics.beginGradientFill(GradientType.RADIAL,[col,col],[alphaNum,0],[int(per*255),255],mat,"pad","rgb",0);
			sh2.graphics.drawCircle(0,0,w/2);
			sh.cacheAsBitmap = true;
			sh2.cacheAsBitmap = true;
			sp.addChild(sh);
			sp.addChild(sh2);
			sh.mask = sh2;
			if(blur != 0){
				sh.filters = [ new BlurFilter(blur,blur,qu) ];
			}
			if(bd != null) bd.dispose();
			bd = new BitmapData(w,w*sy,true,0x00FFFFFF);
			var mat2:Matrix = new Matrix(1,0,0,1,w/2,w*sy);
			mat2.scale(1,sy);
			bd.draw(sp,mat2);
			this.bitmapData = bd;
			//this.addChild(sp);
		}
	}
}