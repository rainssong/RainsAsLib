package cn.flashk.controls.skin
{
	import cn.flashk.controls.Button;
	import cn.flashk.controls.ToolTip;
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
	
	public class ToolTipSkin extends ActionDrawSkin
	{
		
		private var tar:ToolTip;
		private var shape:Shape;
		private var styleSet:Object;
		
		public function ToolTipSkin() 
		{
			shape = new Shape();
		}
		override public function init(target:UIComponent,styleSet:Object):void {
			this.styleSet = styleSet;
			tar = target as ToolTip;
			target.addChildAt(shape, 0);
		}
		public function get skinDisplayObject():DisplayObject {
			return shape;
		}
		override public function reDraw():void {
			shape.graphics.clear();
			var colors:Array = [styleSet["backgroundTopColor"], styleSet["backgroundBottomColor"]];
			var alphas:Array = [styleSet["backgroundTopAlpha"], styleSet["backgroundBottomAlpha"]];
			
			var ratios:Array;
			
			ratios = [0,  255];
			
			
			var mat:Matrix = new Matrix();
			var width:Number = tar.compoWidth - 0;
			var height:Number = tar.compoHeight -0;
			mat.createGradientBox(width, height, 90* Math.PI/180);
			shape.graphics.lineStyle(1, styleSet["borderColor"],styleSet["borderAlpha"],DefaultStyle.pixelHinting,LineScaleMode.NORMAL,CapsStyle.ROUND,JointStyle.ROUND,3);
			shape.graphics.beginGradientFill(GradientType.LINEAR, colors, alphas, ratios, mat);
			var ew:Number = styleSet["ellipse"];
			var eh:Number = styleSet["ellipse"];
			var bw:Number = styleSet["ellipse"];
			var bh:Number = styleSet["ellipse"];
			RoundRectAdvancedDraw.drawAdvancedRoundRect(shape.graphics, 0+DefaultStyle.graphicsDrawOffset, 0.5+DefaultStyle.graphicsDrawOffset, width, height, ew, eh,ew,eh,ew,eh,bw,bh,bw,bh);
		}
	}
}