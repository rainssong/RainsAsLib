package cn.flashk.controls.skin 
{
	import cn.flashk.controls.TextInput;
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
	import flash.geom.Matrix;

	/**
	 * ...
	 * @author flashk
	 */
	public class TextInputSkin extends ActionDrawSkin
	{
		
		private var tar:TextInput;
		private var mot:MotionSkinControl;
		private var shape:Shape;
		private var styleSet:Object;
		
		public function TextInputSkin() 
		{
			shape = new Shape();
		}
		override public function init(target:UIComponent,styleSet:Object):void {
			this.styleSet = styleSet;
			tar = target as TextInput;
			tar.addChildAt(shape, 0);
			mot = new MotionSkinControl(tar, shape);
			//shape.x = 0.5;
			//shape.y = 0.5;
			//reDraw();
		}
		public function get skinDisplayObject():DisplayObject {
			return shape;
		}
		override public function reDraw():void {
			
			shape.graphics.clear();
			var colors:Array = [SkinThemeColor.bottom,SkinThemeColor.textBackgroudColor];
			var alphas:Array = [1.0, 1.0];
			
			var ratios:Array;
			ratios = [0, 255];

			var mat:Matrix = new Matrix();
			var width:Number = tar.compoWidth - 0;
			var height:Number = tar.compoHeight -0;
			mat.createGradientBox(width, height, 90* Math.PI/180);
			//mat.createGradientBox(width, height, 45* Math.PI/180);
			shape.graphics.lineStyle(1, SkinThemeColor.border,1.0,false,LineScaleMode.NORMAL,CapsStyle.ROUND,JointStyle.ROUND,3);
			shape.graphics.beginGradientFill(GradientType.LINEAR, colors, alphas, ratios, mat);
			var ew:Number = styleSet[ButtonStyle.DEFAULT_SKIN_ELLIPSE_WIDTH];
			var eh:Number = styleSet[ButtonStyle.DEFAULT_SKIN_ELLIPSE_HEIGHT];
			//shape.graphics.drawRoundRect(0, 0, width, tar.compoHeight, styleSet[ButtonStyle.DEFAULT_SKIN_ELLIPSE_WIDTH], styleSet[ButtonStyle.DEFAULT_SKIN_ELLIPSE_HEIGHT]);
			RoundRectAdvancedDraw.drawAdvancedRoundRect(shape.graphics, 0+DefaultStyle.graphicsDrawOffset, 0+DefaultStyle.graphicsDrawOffset, width, height, ew, eh, ew, eh, ew, eh, ew,eh,ew,eh);
			//RoundRectAdvancedDraw.drawRoundRectComplex(shape.graphics, 0, 0, width, tar.compoHeight, ew, eh, ew, eh);
			shape.cacheAsBitmap = true;
		}
	}

}