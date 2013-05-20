package cn.flashk.controls.skin
{
	import cn.flashk.controls.Image;
	import cn.flashk.controls.managers.DefaultStyle;
	import cn.flashk.controls.managers.ThemesSet;
	import cn.flashk.controls.modeStyles.ButtonStyle;
	import cn.flashk.controls.support.RoundRectAdvancedDraw;
	import cn.flashk.controls.support.UIComponent;
	
	import flash.display.CapsStyle;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.GradientType;
	import flash.display.JointStyle;
	import flash.display.LineScaleMode;
	import flash.display.Shape;
	import flash.events.MouseEvent;
	import flash.geom.Matrix;

	public class ImageSkin extends ActionDrawSkin
	{
		private var tar:Image;
		private var shape:Shape;
		private var mot:MotionSkinControl;
		private var styleSet:Object;
		
		public function ImageSkin()
		{shape = new Shape();
		}
		override public function init(target:UIComponent,styleSet:Object):void {
			this.styleSet = styleSet;
			tar = target as Image;
			target.addChildAt(shape, 0);
			mot = new MotionSkinControl(tar, shape);
			mot.resetAlpha = false;
		}
		public function get skinDisplayObject():DisplayObject {
			return shape;
		}
		override public function reDraw():void {
			
			shape.graphics.clear();
			var colors:Array = [0xfefefe, 0xe4e4e4, 0xdedede, 0xFFFFFF];
			var alphas:Array = [1.0, 1.0, 1.0, 1.0];
			
			var ratios:Array;
			ratios = [0, 127, 128, 255];
		
			var mat:Matrix = new Matrix();
			var width:Number = tar.compoWidth - 0;
			var height:Number = tar.compoHeight -0;
			mat.createGradientBox(width, height, 90* Math.PI/180);
			shape.graphics.lineStyle(1, SkinThemeColor.border,0.5,DefaultStyle.pixelHinting,LineScaleMode.NORMAL,CapsStyle.ROUND,JointStyle.ROUND,3);
			shape.graphics.beginGradientFill(GradientType.LINEAR, colors, alphas, ratios, mat);
			var ew:Number = DefaultStyle.ellipse;
			var eh:Number = DefaultStyle.ellipse;
			var bw:Number = DefaultStyle.ellipse;
			var bh:Number = DefaultStyle.ellipse;
			RoundRectAdvancedDraw.drawAdvancedRoundRect(shape.graphics, 0+DefaultStyle.graphicsDrawOffset, 0+DefaultStyle.graphicsDrawOffset, width, height, ew, eh,ew,eh,ew,eh,bw,bh,bw,bh);
			shape.cacheAsBitmap = true;
			//shape.filters = DefaultStyle.filters;
		}
	}
}