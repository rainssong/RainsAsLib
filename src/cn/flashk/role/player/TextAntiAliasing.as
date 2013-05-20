package cn.flashk.role.player
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.text.TextField;
	import flash.text.TextFormat;

	public class TextAntiAliasing
	{
		
		private var bp:Bitmap;
		private var bd:BitmapData;
		//质量，此值改为1，则不使用反锯齿
		private var quality:Number = 4;
		private var textDrawSP:Sprite;
		
		public function TextAntiAliasing()
		{
			textDrawSP = new Sprite();
			bp = new Bitmap();
			bp.smoothing = true;
			bp.scaleX = bp.scaleY = 1 / quality;
			textDrawSP.addChild(bp);
		}
		public function getSpriteByText(txt:TextField):Sprite{
			var a_txt:TextField= txt;
			bd = new BitmapData(a_txt.width * quality, a_txt.height * quality, true, 0x00FFFFFF);
			var mat:Matrix = new Matrix();
			mat.scale(quality, quality);
			bd.draw(a_txt, mat);
			bp.bitmapData = bd;

			return textDrawSP;
		}
		public function clear():void{
			bd.dispose();
		}
	}
}