package cn.flashk.controls.skin.sourceSkin
{
	import cn.flashk.controls.CheckBox;
	import cn.flashk.controls.support.ListItemRender;
	import cn.flashk.controls.support.UIComponent;
	import cn.flashk.controls.support.Scale9GridBitmap;
	
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Matrix;
	
	public class ListItemSourceSkin extends SourceSkin
	{
		private static var bd:BitmapData;
		private static var skin:DisplayObject;
		private static var bds:Array;
		private var _space:Number=0;
		
		protected var tar:DisplayObjectContainer;
		
		public function ListItemSourceSkin()
		{
			super();
		}
		public function init2(target:DisplayObjectContainer,styleSet:Object,Skin:Class):void {
			if(skin == null){
				skin = new Skin() as DisplayObject;
			}
			initBp(skin);
			tar = target as DisplayObjectContainer;
			
			if(bds == null){
				bds = new Array();
				drawMovieClipToArray(skin as MovieClip,bds);
			}
			bp.sourceBitmapData = bds[1] as BitmapData;
		}
		public function set space(value:Number):void{
			_space = value;
			bp.x = _space;
		}
		public function showState(state:int):void{
			if(state>0 ){
				bp.sourceBitmapData = bds[state] as BitmapData;
				bp.update();
				tar.addChildAt(bp,0);
			}else{
				if(bp.parent == tar){
					tar.removeChild(bp);
				}
			}
		}
		override public function reDraw():void {
			
		}
		public function setSize(newWidth:Number, newHeight:Number):void{
			bp.width = newWidth-_space*2;
		}
	}
}