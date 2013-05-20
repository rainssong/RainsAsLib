package cn.flashk.controls.skin.sourceSkin
{
	import cn.flashk.controls.List;
	import cn.flashk.controls.Panel;
	import cn.flashk.controls.support.UIComponent;
	import cn.flashk.controls.support.Scale9GridBitmap;
	
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.geom.Matrix;
	import flash.geom.Rectangle;
	
	public class ListSourceSkin extends SourceSkin
	{
		
		private static var bd:BitmapData;
		private static var skin:DisplayObject;
		
		private var tar:UIComponent;
		
		public function ListSourceSkin()
		{
			super();
		}
		override public function init(target:UIComponent,styleSet:Object,Skin:Class):void {
			super.init(target,styleSet,Skin);
			if(skin == null){
				skin = new Skin() as DisplayObject;
			}
			initBp(skin);
			tar = target as UIComponent;
			if(bd == null){
				bd=new BitmapData(skin.width,skin.height,true,0);
				bd.draw(skin,new Matrix(1,0,0,1,sx,sy));
			}
			bp.sourceBitmapData = bd;
			tar.addChildAt(bp,0);
		}
		override public function reDraw():void {
			bp.width = tar.compoWidth+sx*2;
			bp.height = tar.compoHeight+sy*2;
		}
	}
}