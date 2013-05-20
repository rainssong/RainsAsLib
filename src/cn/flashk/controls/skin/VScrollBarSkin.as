package cn.flashk.controls.skin 
{
	import cn.flashk.controls.VScrollBar;
	import cn.flashk.controls.managers.DefaultStyle;
	import cn.flashk.controls.modeStyles.ButtonStyle;
	import cn.flashk.controls.support.RoundRectAdvancedDraw;
	import cn.flashk.controls.support.UIComponent;
	import cn.flashk.conversion.ColorConversion;
	
	import flash.display.CapsStyle;
	import flash.display.GradientType;
	import flash.display.JointStyle;
	import flash.display.LineScaleMode;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.geom.Matrix;
	/**
	 * ...
	 * @author flashk
	 */
	public class VScrollBarSkin extends ActionDrawSkin
	{
		public var arrowUp:Sprite;
		public var arrowDown:Sprite;
		public var bar:Sprite;
		public var scroller:Sprite;
		
		private var tar:VScrollBar;
		private var mot:MotionSkinControl;
		private var styleSet:Object;
		
		
		public function VScrollBarSkin() 
		{
			arrowUp = new Sprite();
			arrowDown = new Sprite();
			bar = new Sprite();
			bar.alpha = 0.5;
			scroller = new Sprite();
		}
		
		override public function init(target:UIComponent,styleSet:Object):void {
			this.styleSet = styleSet;
			tar = target as VScrollBar;
			target.addChildAt(scroller, 0);
			target.addChildAt(arrowUp, 0);
			target.addChildAt(arrowDown, 0);
			target.addChildAt(bar, 0);
			mot = new MotionSkinControl(arrowUp, arrowUp);
			new MotionSkinControl(arrowDown, arrowDown);
			var smo:MotionSkinControl = new MotionSkinControl(scroller, scroller);
			smo.filtersDown = [];
		}
		override public function reDraw():void {
			
			arrowUp.graphics.clear();
			var colors:Array = [SkinThemeColor.top, SkinThemeColor.upperMiddle, SkinThemeColor.lowerMiddle, SkinThemeColor.bottom];
			var alphas:Array = [1.0, 1.0, 1.0, 1.0];
			var mat:Matrix;
			var width:Number;
			var height:Number;
			var ratios:Array;
			var ew:Number = DefaultStyle.scrollBarRound;
			var eh:Number = DefaultStyle.scrollBarRound;
			ratios = [0, 127, 128, 255];
			mat = new Matrix();
			width= tar.compoWidth - 3;
			height= width;
			mat.createGradientBox(width, height, 90 * Math.PI / 180);
			arrowUp.graphics.beginFill(0, 0);
			arrowUp.graphics.drawRect(0, 0, width+2, height + 2);
			arrowUp.graphics.lineStyle(1, SkinThemeColor.border,0.7,DefaultStyle.pixelHinting,LineScaleMode.NORMAL,CapsStyle.ROUND,JointStyle.ROUND,3);
			arrowUp.graphics.beginGradientFill(GradientType.LINEAR, colors, alphas, ratios, mat);
			RoundRectAdvancedDraw.drawAdvancedRoundRect(arrowUp.graphics, 1+DefaultStyle.graphicsDrawOffset, 1+DefaultStyle.graphicsDrawOffset, width+1, height, ew, eh, ew, eh, ew, eh, ew, eh, ew, eh);
			arrowUp.graphics.beginFill(ColorConversion.transformWebColor(DefaultStyle.buttonOutTextColor), 1);
			arrowUp.graphics.lineStyle(0.1, SkinThemeColor.border,0);
			arrowUp.graphics.moveTo(int(width / 2)+2.5, 4+2);
			arrowUp.graphics.lineTo(int(width / 2)+6.5, 8+2);
			arrowUp.graphics.lineTo(int(width / 2)-1.5, 8+2);
			arrowUp.graphics.endFill();
			
			
			//this.graphics.moveTo(50.5,50);
			//this.graphics.lineTo(54,54);
			//this.graphics.lineTo(50-3.5,54);
			
			//this.graphics.moveTo(50,49.4);
			//this.graphics.lineTo(53.5,53);
			//this.graphics.lineTo(50-3.5,53);
			//
			arrowDown.graphics.clear();
			ratios = [0, 127, 128, 255];
			mat = new Matrix();
			width= tar.compoWidth - 3;
			height= width;
			arrowDown.scaleY = -1;
			arrowDown.y = int(tar.compoHeight - tar.compoWidth+height+2);
			mat.createGradientBox(width, height, 90 * Math.PI / 180);
			arrowDown.graphics.beginFill(0, 0);
			arrowDown.graphics.drawRect(0, 0, width+2, height + 2);
			arrowDown.graphics.lineStyle(1, SkinThemeColor.border,0.7,DefaultStyle.pixelHinting,LineScaleMode.NORMAL,CapsStyle.ROUND,JointStyle.ROUND,3);
			arrowDown.graphics.beginGradientFill(GradientType.LINEAR, colors, alphas, ratios, mat);
			RoundRectAdvancedDraw.drawAdvancedRoundRect(arrowDown.graphics, 1+DefaultStyle.graphicsDrawOffset, -1+DefaultStyle.graphicsDrawOffset, width+1, height+1, ew, eh, ew, eh, ew, eh, ew, eh, ew, eh);
			arrowDown.graphics.beginFill(ColorConversion.transformWebColor(DefaultStyle.buttonOutTextColor), 1);
			arrowDown.graphics.lineStyle(0.1, SkinThemeColor.border,0);
			arrowDown.graphics.moveTo(int(width / 2)+2.5, 4+1);
			arrowDown.graphics.lineTo(int(width / 2)+6.5, 8+1);
			arrowDown.graphics.lineTo(int(width / 2)-1.5, 8+1);
			arrowDown.graphics.endFill();
			//
			
			
			//
			bar.graphics.clear();
			colors = [ SkinThemeColor.bottom,SkinThemeColor.scrollBarBackground];
			ratios = [0, 255];
			alphas = [1.0, 1.0];
			mat = new Matrix();
			width= tar.compoWidth;
			height= tar.compoHeight;
			mat.createGradientBox(width, height, 0 * Math.PI / 180);
			bar.graphics.lineStyle(1, SkinThemeColor.border,0.15,DefaultStyle.pixelHinting,LineScaleMode.NORMAL,CapsStyle.ROUND,JointStyle.ROUND,3);
			bar.graphics.beginGradientFill(GradientType.LINEAR, colors, alphas, ratios, mat);
			//bar.graphics.drawRect(0, 0, width-1, height-1);
			RoundRectAdvancedDraw.drawAdvancedRoundRect(bar.graphics, 0.5, 0.5, width-1, height-1, ew, eh, ew, eh, ew, eh, ew, eh, ew, eh);

			bar.cacheAsBitmap = true;
			
			updateScrollder();
			
		}
		public function updateScrollder():void {
			if(scroller.y == 0 && arrowUp.visible == true){
				scroller.y = tar.compoWidth;
			}
			
			scroller.graphics.clear();
			var colors:Array = [SkinThemeColor.top, SkinThemeColor.upperMiddle, SkinThemeColor.lowerMiddle, SkinThemeColor.bottom];
			var alphas:Array = [1.0, 1.0, 1.0, 1.0];
			var mat:Matrix;
			var width:Number;
			var height:Number;
			var ratios:Array;
			var ew:Number = DefaultStyle.scrollBarRound;
			var eh:Number = DefaultStyle.scrollBarRound;
			ratios = [0, 127, 128, 255];
			mat = new Matrix();
			width = tar.compoWidth - 3;
			var lessNum:Number;
			if (arrowUp.visible  == true) {
				lessNum =  tar.compoWidth;
			}else {
				lessNum = 0;
			}
			height = (tar.compoHeight - lessNum * 2) / (1+tar.maxScrollPosition / tar.clipSize);
			if (height < 30) {
				height = 30;
			}
			if(isNaN(tar.maxScrollPosition) || tar.maxScrollPosition <0){
				scroller.visible = false;
				return;
			}else{
				scroller.visible = true;
			}
			mat.createGradientBox(width, height, 90 * Math.PI / 180);
			scroller.graphics.beginFill(0, 0);
			scroller.graphics.drawRect(0, 0, width+2, height + 2);
			scroller.graphics.lineStyle(1, SkinThemeColor.border,0.6,DefaultStyle.pixelHinting,LineScaleMode.NORMAL,CapsStyle.ROUND,JointStyle.ROUND,3);
			scroller.graphics.beginGradientFill(GradientType.LINEAR, colors, alphas, ratios, mat);
			RoundRectAdvancedDraw.drawAdvancedRoundRect(scroller.graphics, 1+DefaultStyle.graphicsDrawOffset, 0+DefaultStyle.graphicsDrawOffset, width+1, height+2, ew, eh, ew, eh, ew, eh, ew, eh, ew, eh);
			scroller.graphics.beginFill(SkinThemeColor.border, 0.85);
			scroller.graphics.lineStyle(0, SkinThemeColor.border,0);
			scroller.graphics.drawRect(3 + 2, int(height / 2) - 2, width - 7, 2);
			scroller.graphics.drawRect(3 + 2, int(height / 2) - 2+3, width - 7, 2);
			scroller.graphics.drawRect(3 + 2, int(height / 2) - 2+6, width - 7, 2);
			scroller.graphics.beginFill(0xFFFFFF, 0.2);
			scroller.graphics.drawRect(3 + 2, int(height / 2) - 0, width - 7, 1);
			scroller.graphics.drawRect(3 + 2, int(height / 2) +3, width - 7, 1);
			scroller.graphics.drawRect(3 + 2, int(height / 2) +6, width - 7, 1);
			scroller.filters = DefaultStyle.filters;
			//scroller.graphics.drawRect(3 + 1, int(height / 2) +3, width - 6, 1);
			
		}
	}

}