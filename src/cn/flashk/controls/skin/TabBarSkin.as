package cn.flashk.controls.skin 
{
	import cn.flashk.controls.Button;
	import cn.flashk.controls.TabBar;
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
	import flash.geom.ColorTransform;
	import flash.geom.Matrix;

	/**
	 * ...
	 * @author flashk
	 */
	public class TabBarSkin extends ActionDrawSkin
	{
		
		private var tar:TabBar
		private var mot:MotionSkinControl;
		private var shape:Shape
		private var styleSet:Object;
		
		public function TabBarSkin() 
		{
			shape = new Shape();
		}
		override public function init(target:UIComponent,styleSet:Object):void {
			this.styleSet = styleSet;
			tar = target as TabBar;
			target.addChildAt(shape, 0);
			//mot = new MotionSkinControl(tar, shape);
			shape.x = 0.5;
			shape.y = 19.5;
			//reDraw();
		}
		override public function reDraw():void {
			trace("TabBarSkin");
			shape.graphics.clear();
			var colors:Array = [SkinThemeColor.bottom, SkinThemeColor.lowerMiddle, SkinThemeColor.upperMiddle, SkinThemeColor.top];
			var alphas:Array = [0.9, 1.0, 1.0, 1.0];
			
			var ratios:Array;
			//RoundRectAdvancedDraw.drawRoundRectComplex(shape.graphics, 0, 0, width, tar.compoHeight, ew, eh, ew, eh);
			shape.graphics.beginFill(0,0);
			shape.graphics.lineStyle(0,SkinThemeColor.border,1);
			shape.graphics.drawRect(0,2,tar.compoWidth,tar.compoHeight-2);
			if (ThemesSet.GradientMode == 1) {
				ratios = [0, 127, 128, 255];
			}
			if (ThemesSet.GradientMode == 2) {
				ratios = [0, 50, 205, 255];
			}
			var mat:Matrix = new Matrix();
			var width:Number = tar.compoWidth - 0.35;
			var height:Number = 4;
			//mat.rotate(90 * Math.PI / 180);
			mat.createGradientBox(width, height, 90* Math.PI/180);
			shape.graphics.lineStyle(1,0,0);
			//mat.createGradientBox(width, height, 45* Math.PI/180);
			shape.graphics.beginGradientFill(GradientType.LINEAR, colors, alphas, ratios, mat);
			var ew:Number = 2;
			var eh:Number = 2;
			var bw:Number = 2;
			var bh:Number = 2;
			trace(bw);
			//shape.graphics.drawRoundRect(0, 0, width, tar.compoHeight, styleSet[ButtonStyle.DEFAULT_SKIN_ELLIPSE_WIDTH], styleSet[ButtonStyle.DEFAULT_SKIN_ELLIPSE_HEIGHT]);
			//RoundRectAdvancedDraw.drawAdvancedRoundRectNoMax(shape.graphics, 0, 0, width, height, ew, eh, ew, eh, ew, eh, ew,eh,ew,eh);
			RoundRectAdvancedDraw.drawAdvancedRoundRect(shape.graphics, 0, -0.5, width, height, ew, eh,ew,eh,ew,eh,bw,bh,bw,bh);
			shape.transform.colorTransform = new ColorTransform(1,1,1,1,40,40,40,0);
			shape.cacheAsBitmap = true;
		}
	}

}