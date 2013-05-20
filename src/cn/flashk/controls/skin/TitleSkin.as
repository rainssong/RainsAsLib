package cn.flashk.controls.skin 
{
	import cn.flashk.controls.Button;
	import cn.flashk.controls.Panel;
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

	/**
	 * ...
	 * @author flashk
	 */
	public class TitleSkin extends ActionDrawSkin
	{
		private var tar:Panel;
		private var shape:Shape;
		private var styleSet:Object;
		
		public function TitleSkin() 
		{
			shape = new Shape();
		}
		override public function init(target:UIComponent,styleSet:Object):void {
			this.styleSet = styleSet;
			tar = target as Panel;
			target.addChild(shape);
		}
		public function get skinDisplayObject():DisplayObject {
			return shape;
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
			var width:Number = tar.compoWidth - 0;
			var height:Number = tar.titleHeight;
			mat.createGradientBox(width, height, 90* Math.PI/180);
			shape.graphics.lineStyle(1, SkinThemeColor.border,0);
			shape.graphics.beginGradientFill(GradientType.LINEAR, colors, alphas, ratios, mat);
			var ew:Number = styleSet[ButtonStyle.DEFAULT_SKIN_ELLIPSE_WIDTH];
			var eh:Number = styleSet[ButtonStyle.DEFAULT_SKIN_ELLIPSE_HEIGHT];
			var bw:Number = 0;
			var bh:Number = 0;
			RoundRectAdvancedDraw.drawAdvancedRoundRect(shape.graphics, 0, 1, width, height, ew, eh,ew,eh,ew,eh,bw,bh,bw,bh);
			shape.cacheAsBitmap = true;
			shape.filters = DefaultStyle.filters;
		}
	}
	
}