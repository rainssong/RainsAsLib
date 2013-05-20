package cn.flashk.layout
{
	import flash.display.DisplayObject;

	public class Align
	{
		public function Align()
		{
		}
		public static function alignToCenter(display:DisplayObject,boxWidth:Number,boxHeight:Number,isIntXY:Boolean=true):void{
			display.x = (boxWidth-display.width)/2;
			display.y = (boxHeight-display.height)/2;
			if(isIntXY == true){
				display.x = int(display.x);
				display.y = int(display.y);
			}
		}
	}
}