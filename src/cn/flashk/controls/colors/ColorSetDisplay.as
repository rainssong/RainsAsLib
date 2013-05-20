package cn.flashk.controls.colors
{
	import flash.display.Shape;

	public class ColorSetDisplay extends Shape
	{
		protected var colorsStr:String ="";
		protected var colors:Array;
		
		public function ColorSetDisplay()
		{
			//initColorsView();
		}
		public function initColorsView():void{
			colors = colorsStr.split(",");
			this.graphics.clear();
			for(var i:int=0;i<colors.length;i++){
				colors[i] = parseInt(colors[i],16);
				var Y:int = i%16;
				var X:int= int(i/16);
				this.graphics.beginFill(colors[i],1);
				this.graphics.drawRect(X*10+1,Y*10+1,9,9);
			}
			
		}
	}
}