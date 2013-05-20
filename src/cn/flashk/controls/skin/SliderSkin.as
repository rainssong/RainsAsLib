package cn.flashk.controls.skin
{
	import cn.flashk.controls.Slider;
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
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.Matrix;

	public class SliderSkin extends ActionDrawSkin
	{
		public var sliderNum:uint;
		private var shape:Sprite;
		private var styleSet:Object;
		private var tar:Slider;
		private var mot:MotionSkinControl;
		private var mot2:MotionSkinControl;
		private var sliders:Array = [];
		private var space:Shape;
		
		public function SliderSkin()
		{	
			shape = new Sprite();
			space = new Shape();
		}
		override public function init(target:UIComponent,styleSet:Object):void {
			var sli:Sprite;
			this.styleSet = styleSet;
			styleSet["sliderUnableColor"] = "#FFFFFF";
			tar = target as Slider;
			if(sliders[0] == null){
				target.addChildAt(shape, 0);
				sli = new Sprite();
				sli.y = 2;
				sliders[0] = sli;
				mot = new MotionSkinControl(sli, sli);
				target.addChildAt(sli, 1);
			}
			if(tar.thumbCount == 2){
				sli = new Sprite();
				sli.y = 2;
				sli.x = tar.compoWidth;
				sliders[1] = sli;
				mot2 = new MotionSkinControl(sli, sli);
				target.addChildAt(sli, 2);
				target.addChildAt(space,1);
			}
		}
		public function getSliderByIndex(index:uint):Sprite{
			return Sprite(sliders[index]);
		}
		public function get bar():Sprite{
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
			var height:Number = tar.compoHeight -1;
			shape.graphics.beginFill(0,0);
			shape.graphics.drawRect(-5,-4,width+9,height+8);
			mat.createGradientBox(width, height, 90* Math.PI/180);
			shape.graphics.lineStyle(1, SkinThemeColor.border,1.0,false,LineScaleMode.NORMAL,CapsStyle.ROUND,JointStyle.ROUND,3);
			shape.graphics.beginGradientFill(GradientType.LINEAR, colors, alphas, ratios, mat);
			var ew:Number = 30;
			var eh:Number = 30;
			var bw:Number = 30;
			var bh:Number = 30;
			RoundRectAdvancedDraw.drawAdvancedRoundRect(shape.graphics, 0-5+DefaultStyle.graphicsDrawOffset, 0+DefaultStyle.graphicsDrawOffset, width+9, height, ew, eh,ew,eh,ew,eh,bw,bh,bw,bh);
			shape.cacheAsBitmap = true;
			
			drawSliver(Sprite(sliders[0]));
			
			if(tar.thumbCount == 2){
				drawSliver(Sprite(sliders[1]));
			}
		}
		public function drawSliver(sp:Sprite):void{
			sp.graphics.clear();
			sp.rotation = 45;
			var colors:Array = [SkinThemeColor.top, SkinThemeColor.upperMiddle, SkinThemeColor.lowerMiddle, SkinThemeColor.bottom];
			var alphas:Array = [1.0, 1.0, 1.0, 1.0];
			var ratios:Array;
			ratios = [0, 127, 128, 255];
			var mat:Matrix = new Matrix();
			var width:Number = 5.1;
			var height:Number = height;
			sp.graphics.beginFill(0,0);
			sp.graphics.drawCircle(0,0,width+3);
			sp.graphics.endFill();
			//mat.createGradientBox(width, height, 90* Math.PI/180);
			sp.graphics.lineStyle(1, SkinThemeColor.border,0.5,false,LineScaleMode.NORMAL,CapsStyle.ROUND,JointStyle.ROUND,3);
			sp.graphics.beginGradientFill(GradientType.LINEAR, colors, alphas, ratios, mat);
			sp.graphics.drawCircle(0,0,width);
		}
		public function updateSliderSpace():void{
			space.graphics.clear();
			space.graphics.beginFill(ColorConversion.transformWebColor(styleSet["sliderUnableColor"]),0.5);
			var xs:Array = tar.values;
			space.graphics.drawRect(-5,0,Sprite(sliders[0]).x+5,tar.compoHeight);
			space.graphics.drawRect(Sprite(sliders[1]).x,0,tar.compoWidth-Sprite(sliders[1]).x+5,tar.compoHeight);
		}
	}
}