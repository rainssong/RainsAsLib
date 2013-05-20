package cn.flashk.image
{
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import cn.flashk.controls.support.Scale9GridBitmap;

	public class DisplayObjectDrawScale9GridBitmap extends Scale9GridBitmap
	{
		private var drawBD:BitmapData;
		
		public function DisplayObjectDrawScale9GridBitmap()
		{
		}
		public function draw(displayObject:DisplayObject,transparent:Boolean = true,needReDraw:Boolean = false,disWidth:Number=0,disHeight:Number=0):void{
			if(drawBD != null && needReDraw == true){
				drawBD.dispose();
			}
			if(disWidth == 0){
				disWidth = Math.ceil(displayObject.width/displayObject.scaleX);
			}
			if(disHeight == 0){
				disHeight = Math.ceil(displayObject.height/displayObject.scaleY);
			}
			if(needReDraw == true || drawBD == null){
				drawBD = new BitmapData(disWidth,disHeight,transparent,0);
				drawBD.draw(displayObject);
			}
			this.sourceBitmapData = drawBD;
			_width  = disWidth*displayObject.scaleX;
			_height = disHeight*displayObject.scaleY;
			trace("run me",displayObject.width,_width);
			update();
		}
	}
}