package cn.flashk.controls.skin.sourceSkin
{
	import cn.flashk.controls.ComboBox;
	import cn.flashk.controls.managers.SkinLoader;
	import cn.flashk.controls.managers.SourceSkinLinkDefine;
	import cn.flashk.controls.support.UIComponent;
	import cn.flashk.controls.support.Scale9GridBitmap;
	
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.MouseEvent;

	public class ComboBoxSourceSkin extends SourceSkin
	{
		private static var skin:DisplayObject;
		private static var bd:BitmapData;
		private static var bds:Array;
		private var tar:ComboBox;
		private var sp:Sprite;
		private var arr:DisplayObject;
		
		public function ComboBoxSourceSkin()
		{
			super();
			sp = new Sprite();
			sp.addChild(bp);
		}
		override public function init(target:UIComponent,styleSet:Object,Skin:Class):void {
			super.init(target,styleSet,Skin);
			if(skin == null){
				skin = new Skin() as DisplayObject;
			}
			initBp(skin);
			tar = target as ComboBox;
			var mc:MovieClip = skin as MovieClip;
			
			if(bds == null){
				bds = new Array();
				drawMovieClipToArray(skin as MovieClip,bds);
			}
			bp.sourceBitmapData = bds[1] as BitmapData;
			tar.addChildAt(sp,0);
			tar.addEventListener(MouseEvent.MOUSE_OVER,showOver);
			tar.addEventListener(MouseEvent.MOUSE_OUT,showOut);
			tar.addEventListener(MouseEvent.MOUSE_DOWN,showPress);
			tar.addEventListener(MouseEvent.MOUSE_UP,showUp);
			var ClassRef:Class = SkinLoader.getClassFromSkinFile(SourceSkinLinkDefine.COMBO_BOX_ARROW);
			arr =new ClassRef() as DisplayObject;
			sp.addChild(arr);
		}
		public function get skinDisplayObject():DisplayObject {
			return sp;
		}
		
		protected function showUp(event:MouseEvent):void
		{
			bp.sourceBitmapData = bds[1] as BitmapData;
			bp.update();
		}
		
		protected function showPress(event:MouseEvent):void
		{
			bp.sourceBitmapData = bds[3] as BitmapData;
			bp.update();
		}
		
		protected function showOut(event:MouseEvent):void
		{
			bp.sourceBitmapData = bds[1] as BitmapData;
			bp.update();
		}
		
		
		protected function showOver(event:MouseEvent):void
		{
			bp.sourceBitmapData = bds[2] as BitmapData;
			bp.update();
		}
		override public function reDraw():void {
			bp.width = tar.compoWidth+sx*2;
			bp.height = tar.compoHeight+sy*2;
			arr.x = bp.width-arr.width;
			arr.y = int((bp.height-arr.height)/2);
		}
	}
}