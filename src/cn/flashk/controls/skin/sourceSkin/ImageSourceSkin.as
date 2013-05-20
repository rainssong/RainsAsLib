package cn.flashk.controls.skin.sourceSkin
{
	import cn.flashk.controls.Image;
	import cn.flashk.controls.support.UIComponent;
	import cn.flashk.controls.support.Scale9GridBitmap;
	
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.geom.Matrix;
	import flash.geom.Rectangle;
	
	public class ImageSourceSkin extends SourceSkin
	{
		private static var bd:BitmapData;
		private static var skin:DisplayObject;
		private static var bds:Array;
		
		private var tar:Image;
		
		public function ImageSourceSkin()
		{
			super();
		}
		override public function init(target:UIComponent,styleSet:Object,Skin:Class):void {
			super.init(target,styleSet,Skin);
			if(skin == null){
				skin = new Skin() as DisplayObject;
			}
			initBp(skin);
			tar = target as Image;
			
			if(bds == null){
				bds = new Array();
				drawMovieClipToArray(skin as MovieClip,bds);
			}
			tar.addChildAt(bp,0);
			tar.addEventListener(MouseEvent.MOUSE_OVER,showOver);
			tar.addEventListener(MouseEvent.MOUSE_OUT,showOut);
			tar.addEventListener(MouseEvent.MOUSE_DOWN,showDown);
			tar.addEventListener(MouseEvent.MOUSE_UP,showOver);
			bp.sourceBitmapData = bds[1] as BitmapData;
		}
		
		protected function showOver(event:MouseEvent):void
		{
			
			bp.sourceBitmapData = bds[2] as BitmapData;
			bp.update();
		}
		protected function showOut(event:MouseEvent):void
		{
			
			bp.sourceBitmapData = bds[1] as BitmapData;
			bp.update();
		}
		protected function showDown(event:MouseEvent):void
		{
			
			bp.sourceBitmapData = bds[3] as BitmapData;
			bp.update();
		}
		override public function reDraw():void {
			bp.width = tar.compoWidth+sx*2;
			bp.height = tar.compoHeight+sy*2;
		}
	}
}