package cn.flashk.controls.skin 
{
	import cn.flashk.controls.CheckBox;
	import cn.flashk.controls.managers.DefaultStyle;
	import cn.flashk.controls.RadioButton;
	import cn.flashk.controls.support.UIComponent;
	import cn.flashk.conversion.ColorConversion;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Shape;
	import cn.flashk.controls.Button;
	import cn.flashk.controls.managers.ThemesSet;
	import cn.flashk.controls.modeStyles.ButtonStyle;
	import cn.flashk.controls.support.RoundRectAdvancedDraw;
	import flash.display.CapsStyle;
	import flash.display.GradientType;
	import flash.display.JointStyle;
	import flash.display.LineScaleMode;
	import flash.events.MouseEvent;
	import flash.geom.Matrix;
	/**
	 * ...
	 * @author flashk
	 */
	public class RadioButtonSkin extends ToggleDrawSkin
	{
		
		private var tar:RadioButton;
		private var mot:MotionSkinControl;
		private var shape:Shape;
		private var styleSet:Object;
		
		public function RadioButtonSkin() 
		{
			
			shape = new Shape();
		}
		override public function init(target:UIComponent,styleSet:Object):void {
			this.styleSet = styleSet;
			tar = target as RadioButton;
			DisplayObjectContainer(target).addChildAt(shape, 0);
			mot = new MotionSkinControl(tar, shape);
			shape.x = 0.5;
			shape.y = 2;
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
			var width:Number = 15;
			var height:Number = 15;
			mat.createGradientBox(width, height, 90* Math.PI/180);
			//mat.createGradientBox(width, height, 45* Math.PI/180);
			shape.graphics.lineStyle(1, SkinThemeColor.border,1.0,true,LineScaleMode.NORMAL,CapsStyle.ROUND,JointStyle.ROUND,3);
			shape.graphics.beginGradientFill(GradientType.LINEAR, colors, alphas, ratios, mat);
			var ew:Number = styleSet[ButtonStyle.DEFAULT_SKIN_ELLIPSE_WIDTH];
			var eh:Number = styleSet[ButtonStyle.DEFAULT_SKIN_ELLIPSE_HEIGHT];
			//shape.graphics.drawRoundRect(0, 0, width, tar.compoHeight, styleSet[ButtonStyle.DEFAULT_SKIN_ELLIPSE_WIDTH], styleSet[ButtonStyle.DEFAULT_SKIN_ELLIPSE_HEIGHT]);
			shape.graphics.drawCircle(8, 7, 7);
			//RoundRectAdvancedDraw.drawRoundRectComplex(shape.graphics, 0, 0, width, tar.compoHeight, ew, eh, ew, eh);
			//trace("CheckBox", tar.selected);
			if (tar.selected == true) {
				shape.graphics.beginFill(ColorConversion.transformWebColor(DefaultStyle.checkBoxLineColor), 1);
				shape.graphics.lineStyle(1, SkinThemeColor.border,0);
				shape.graphics.drawCircle(8, 7, 3);
			}
			shape.filters = DefaultStyle.filters;
			shape.cacheAsBitmap = true;
		}
		
	}

}