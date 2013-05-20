package cn.flashk.controls.skin.sourceSkin
{
	import cn.flashk.controls.CheckBox;
	import cn.flashk.controls.support.UIComponent;
	import cn.flashk.controls.support.Scale9GridBitmap;
	
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Matrix;

	public class CheckBoxSourceSkin extends SourceSkin
	{
		private static var bd:BitmapData;
		private static var skin:DisplayObject;
		private static var bds:Array;
		
		protected var tar:CheckBox;
		
		public function CheckBoxSourceSkin()
		{
			super();
		}
		override public function init(target:UIComponent,styleSet:Object,Skin:Class):void {
			super.init(target,styleSet,Skin);
			if(skin == null){
				skin = new Skin() as DisplayObject;
			}
			initBp(skin);
			tar = target as CheckBox;
			
			if(bds == null){
				bds = new Array();
				drawMovieClipToArray(skin as MovieClip,bds);
			}
			bp.sourceBitmapData = bds[1] as BitmapData;
			tar.addChildAt(bp,0);
			tar.addEventListener(MouseEvent.MOUSE_OVER,showOver);
			tar.addEventListener(MouseEvent.MOUSE_OUT,showOut);
			tar.addEventListener(MouseEvent.MOUSE_DOWN,showDown);
			tar.addEventListener(Event.CHANGE,checkShowState);
		}
		public function updateToggleView(isSelect:Boolean):void {
			
		}
		protected function checkShowState(event:Event):void
		{
			showOut();
		}
		protected function showDown(event:MouseEvent):void
		{
			if(tar.selected == false){
				bp.sourceBitmapData = bds[3] as BitmapData;
			}else{
				bp.sourceBitmapData = bds[6] as BitmapData;
			}
		}
		protected function showOut(event:MouseEvent=null):void
		{
			if(tar.selected == false){
				bp.sourceBitmapData = bds[1] as BitmapData;
			}else{
				bp.sourceBitmapData = bds[4] as BitmapData;
			}
		}
		
		protected function showOver(event:MouseEvent):void
		{
			if(tar.selected == false){
				bp.sourceBitmapData = bds[2] as BitmapData;
			}else{
				bp.sourceBitmapData = bds[5] as BitmapData;
			}
		}
		override public function reDraw():void {
			bp.y = (tar.compoHeight-bp.height)/2;
		}
	}
}