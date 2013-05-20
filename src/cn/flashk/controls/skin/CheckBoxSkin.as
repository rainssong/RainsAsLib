package cn.flashk.controls.skin 
{
	import cn.flashk.controls.Button;
	import cn.flashk.controls.CheckBox;
	import cn.flashk.controls.managers.DefaultStyle;
	import cn.flashk.controls.managers.ThemesSet;
	import cn.flashk.controls.modeStyles.ButtonStyle;
	import cn.flashk.controls.support.RoundRectAdvancedDraw;
	import cn.flashk.controls.support.UIComponent;
	import cn.flashk.conversion.ColorConversion;
	
	import flash.display.CapsStyle;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.GradientType;
	import flash.display.JointStyle;
	import flash.display.LineScaleMode;
	import flash.display.Shape;
	import flash.events.MouseEvent;
	import flash.geom.Matrix;
	/**
	 * ...
	 * @author flashk
	 */
	public class CheckBoxSkin extends ToggleDrawSkin
	{
		
		private var tar:CheckBox;
		private var mot:MotionSkinControl;
		private var shape:Shape;
		private var styleSet:Object;
		
		public function CheckBoxSkin() 
		{
			shape = new Shape();
		}
		override public function init(target:UIComponent,styleSet:Object):void {
			this.styleSet = styleSet;
			tar = target as CheckBox;
			DisplayObjectContainer(target).addChildAt(shape, 0);
			mot = new MotionSkinControl(tar, shape);
			//shape.x = 0.5;
			//shape.y = 1.5;
			reDraw();
		}
		override public function updateToggleView(isSelect:Boolean):void {
			super.updateToggleView(isSelect);
		}
		
		override public function reDraw():void {
			
			shape.graphics.clear();
			var colors:Array = [SkinThemeColor.top, SkinThemeColor.upperMiddle, SkinThemeColor.lowerMiddle, SkinThemeColor.bottom];
			var alphas:Array = [1.0, 1.0, 1.0, 1.0];
			
			var ratios:Array;
			if (ThemesSet.GradientMode == 1) {
				ratios = [0, 127, 128, 255];
			}
			if (ThemesSet.GradientMode == 2) {
				ratios = [0, 50, 205, 255];
			}
			var mat:Matrix = new Matrix();
			var width:Number = 14;
			var height:Number = 14;
			mat.createGradientBox(width, height, 90* Math.PI/180);
			//mat.createGradientBox(width, height, 45* Math.PI/180);
			shape.graphics.lineStyle(1, SkinThemeColor.border,1.0,DefaultStyle.pixelHinting,LineScaleMode.NORMAL,CapsStyle.ROUND,JointStyle.ROUND,3);
			shape.graphics.beginGradientFill(GradientType.LINEAR, colors, alphas, ratios, mat);
			var ew:Number = styleSet[ButtonStyle.DEFAULT_SKIN_ELLIPSE_WIDTH];
			var eh:Number = styleSet[ButtonStyle.DEFAULT_SKIN_ELLIPSE_HEIGHT];
			//shape.graphics.drawRoundRect(0, 0, width, tar.compoHeight, styleSet[ButtonStyle.DEFAULT_SKIN_ELLIPSE_WIDTH], styleSet[ButtonStyle.DEFAULT_SKIN_ELLIPSE_HEIGHT]);
			RoundRectAdvancedDraw.drawAdvancedRoundRect(shape.graphics, 1+DefaultStyle.graphicsDrawOffset, 3+DefaultStyle.graphicsDrawOffset, width, height, ew, eh, ew, eh, ew, eh, ew,eh,ew,eh);
			//RoundRectAdvancedDraw.drawRoundRectComplex(shape.graphics, 0, 0, width, tar.compoHeight, ew, eh, ew, eh);
			//trace("CheckBox", tar.selected);
			if (tar.selected == true) {
				shape.graphics.lineStyle(1.5, ColorConversion.transformWebColor(DefaultStyle.checkBoxLineColor), 1);
				shape.graphics.moveTo(3+1, 9+1);
				shape.graphics.lineTo(7+1, 13+1);
				shape.graphics.lineTo(13+1, 4+1);
				shape.graphics.lineTo(7+1, 13+1);
				shape.graphics.moveTo(2+1, 8+1);
			}
			shape.filters = DefaultStyle.filters;
			shape.cacheAsBitmap = true;
		}
	}

}