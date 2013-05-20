package cn.flashk.controls.skin
{
	import cn.flashk.controls.Button;
	import cn.flashk.controls.List;
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
	
	public class ListSkin extends ActionDrawSkin
	{
		private var tar:UIComponent;
		private var mot:MotionSkinControl;
		private var shape:Shape;
		private var styleSet:Object;
		
		public function ListSkin()
		{
			shape = new Shape();
		}
		override public function init(target:UIComponent,styleSet:Object):void {
			this.styleSet = styleSet;
			tar = target as UIComponent;
			target.addChildAt(shape, 0);
			//mot = new MotionSkinControl(tar, shape);
		}
		override public function reDraw():void {
			
			shape.graphics.clear();
			var width:Number = tar.compoWidth - 0;
			var height:Number = tar.compoHeight -0;
			shape.graphics.lineStyle(1,SkinThemeColor.border,styleSet["borderAlpha"],true,LineScaleMode.NORMAL,CapsStyle.ROUND,JointStyle.ROUND,3);
			shape.graphics.beginFill(ColorConversion.transformWebColor(styleSet["backgroundColor"]),styleSet["backgroundAlpha"]);
			var ew:Number = styleSet["ellipse"];
			var eh:Number = styleSet["ellipse"];
			var bw:Number = styleSet["ellipse"];
			var bh:Number = styleSet["ellipse"];
			RoundRectAdvancedDraw.drawAdvancedRoundRect(shape.graphics, 0, 0, width, height, ew, eh,ew,eh,ew,eh,bw,bh,bw,bh);
			shape.cacheAsBitmap = true;
			shape.filters = DefaultStyle.filters;
		}
	}
}