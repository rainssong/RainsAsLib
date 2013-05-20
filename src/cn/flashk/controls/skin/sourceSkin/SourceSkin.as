package cn.flashk.controls.skin.sourceSkin
{
	import cn.flashk.controls.support.UIComponent;
	import cn.flashk.controls.support.Scale9GridBitmap;
	
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.geom.Matrix;
	import flash.geom.Rectangle;

	public class SourceSkin
	{
		protected var styleSet:Object;
		protected var bp:Scale9GridBitmap;
		protected var sx:Number;
		protected var sy:Number;
		
		public function SourceSkin()
		{
			bp = new Scale9GridBitmap();
		}
		public function get sc9Bitmap():Scale9GridBitmap{
			return bp;
		}
		public function init(target:UIComponent,styleSet:Object,Skin:Class):void {
			this.styleSet = styleSet;
		}
		protected function initBp(skin:DisplayObject):void{
			var rect:Rectangle = skin.getRect(skin);
			sx = -rect.x;
			sy = -rect.y;
			bp.leftLineSpace = skin.scale9Grid.x+sx;
			bp.topLineSpace = skin.scale9Grid.y +sy;
			bp.rightLineSpace = skin.width-skin.scale9Grid.x-skin.scale9Grid.width-sx;
			bp.bottomLineSpace = skin.height-skin.scale9Grid.y-skin.scale9Grid.height-sy;
			bp.x = -sx;
			bp.y = -sy;
		}
		protected function initBp2(sc9BP:Scale9GridBitmap,skin:DisplayObject):void{
			var rect:Rectangle = skin.getRect(skin);
			sc9BP.leftLineSpace = skin.scale9Grid.x;
			sc9BP.topLineSpace = skin.scale9Grid.y;
			sc9BP.rightLineSpace = skin.width-skin.scale9Grid.x-skin.scale9Grid.width;
			sc9BP.bottomLineSpace = skin.height-skin.scale9Grid.y-skin.scale9Grid.height;
		}
		public function reDraw():void {
			
		}
		public function drawMovieClipToArray(mc:MovieClip,bds:Array):void{
			var bd:BitmapData;
			var w:Number=-1;
			var h:Number=-1
				
			bds.push(null);
			for(var i:int=1;i<=mc.totalFrames;i++){
				mc.gotoAndStop(i);
				if(w<0) w=mc.width;
				if(h<0) h=mc.height;
				bd =new BitmapData(w,h,true,0);
				bd.draw(mc,new Matrix(1,0,0,1,sx,sy));
				bds.push(bd);
			}
		}
		public function updateSkin():void {
			reDraw();
		}
	}
}