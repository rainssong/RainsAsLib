package cn.flashk.controls.skin.sourceSkin
{
	import cn.flashk.controls.Button;
	import cn.flashk.controls.support.UIComponent;
	import cn.flashk.controls.support.Scale9GridBitmap;
	
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.FrameLabel;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Matrix;
	import flash.geom.Rectangle;

	public class ButtonSourceSkin extends SourceSkin
	{
		public static var scaleSmoothing:Boolean = false;
		protected static var skin:DisplayObject;
		protected static var bd:BitmapData;
		protected static var bdsAll:Array;
		public var useSkinSize:Boolean = false;
		public var useCatch:Boolean = true;
		protected var skinIns:DisplayObject;
		protected var tar:Button;
		protected var outIndex:uint = 1;
		protected var overIndex:uint = 2;
		protected var pressIndex:uint = 3;
		protected var index:uint=0;
		protected var isOutViewHide:Boolean = false;
		protected var bds:Array;
		
		public function ButtonSourceSkin()
		{
			super();
			bp.scaleSmoothing = scaleSmoothing;
		}
		override public function init(target:UIComponent,styleSet:Object,Skin:Class):void {
			super.init(target,styleSet,Skin);
			var mc:MovieClip;
			tar = target as Button;
			if(useCatch == true){
				if(skin == null){
					skin = new Skin() as DisplayObject;
				}
				initBp(skin);
				mc = skin as MovieClip
			}else{
				skinIns = new Skin() as DisplayObject;
				initBp(skinIns);
				mc = skinIns as MovieClip
			}
			
			if(useCatch == true){
				if(bdsAll == null){
					bdsAll = new Array();
				}
				bds = bdsAll;
				drawMovieClipToArray(skin as MovieClip,bds);
			}else{
				bds = new Array();
				drawMovieClipToArray(skinIns as MovieClip,bds);
			}
			for(var j:int=0;j<mc.currentLabels.length;j++){
				if(FrameLabel(mc.currentLabels[j]).name == "over"){
					overIndex = FrameLabel(mc.currentLabels[j]).frame;
				}
				
				if(FrameLabel(mc.currentLabels[j]).name == "press"){
					pressIndex = FrameLabel(mc.currentLabels[j]).frame;
				}
			}
			if(mc.currentLabels.length == 0){
				overIndex = 2;
				pressIndex = 3;
			}
			bp.sourceBitmapData = bds[1] as BitmapData;
			tar.addChildAt(bp,0);
			tar.addEventListener(MouseEvent.MOUSE_OVER,showOver);
			tar.addEventListener(MouseEvent.MOUSE_OUT,showOut);
			tar.addEventListener(MouseEvent.MOUSE_DOWN,showPress);
			tar.addEventListener(MouseEvent.MOUSE_UP,showUp);
			if(useSkinSize == true){
				bp.useSourceSize();
				reDraw();
			}
		}
		
		public function hideOutState():void {
			isOutViewHide = true;
			bp.alpha = 0;
		}
		public function showOutState():void{
			index = outIndex;
			bp.sourceBitmapData = bds[index] as BitmapData;
			bp.update();
			bp.removeEventListener(Event.ENTER_FRAME,showOutFrame);
		}
		public function showPressState():void{
			index = pressIndex;
			bp.sourceBitmapData = bds[index] as BitmapData;
			bp.update();
		}
		public function showUp(event:MouseEvent):void
		{
			bp.removeEventListener(Event.ENTER_FRAME,showOutFrame);
			bp.removeEventListener(Event.ENTER_FRAME,showOverFrame);
			index = 1;
			bp.sourceBitmapData = bds[index] as BitmapData;
			bp.update();
		}
		
		public function showPress(event:MouseEvent):void
		{
			
			bp.removeEventListener(Event.ENTER_FRAME,showOutFrame);
			bp.removeEventListener(Event.ENTER_FRAME,showOverFrame);
			index = pressIndex;
			bp.sourceBitmapData = bds[index] as BitmapData;
			bp.update();
		}
		
		public function showOut(event:MouseEvent):void
		{
			if(index<overIndex){
				index = overIndex+uint((overIndex-index)/(overIndex-outIndex)*(pressIndex-overIndex));
			}
			if(index>=pressIndex-1){
				index = pressIndex-1;
			}
			bp.removeEventListener(Event.ENTER_FRAME,showOverFrame);
			bp.addEventListener(Event.ENTER_FRAME,showOutFrame);
		}
		
		protected function showOutFrame(event:Event):void
		{
			index++;
			if(index == pressIndex){
				index = 1;
			}
			bp.sourceBitmapData = bds[index] as BitmapData;
			bp.update();
			if(isOutViewHide == true){
				bp.alpha = (overIndex - index + overIndex)/(pressIndex-overIndex);
			}else{
				bp.alpha = 1;
			}
			if(index==pressIndex-1 || index == 1){
				bp.removeEventListener(Event.ENTER_FRAME,showOutFrame);
				if(isOutViewHide == true){
					bp.alpha = 0;
				}
			}
			
		}
		public function showOver(event:MouseEvent):void
		{
			index=1;
			bp.removeEventListener(Event.ENTER_FRAME,showOutFrame);
			bp.addEventListener(Event.ENTER_FRAME,showOverFrame);
		}
		
		protected function showOverFrame(event:Event):void
		{
			index++;
			bp.sourceBitmapData = bds[index] as BitmapData;
			if(index==overIndex){
				bp.removeEventListener(Event.ENTER_FRAME,showOverFrame);
			}
			bp.update();
			if(isOutViewHide == true){
				bp.alpha = (index-outIndex)/(overIndex-outIndex);
			}else{
				bp.alpha = 1;
			}
		}
		override public function reDraw():void {
			if(useSkinSize == true){
				bp.width = (bds[1] as BitmapData).width;
				bp.height = (bds[1] as BitmapData).height;
			}else{
				bp.width = tar.compoWidth+sx*2;
				bp.height = tar.compoHeight+sy*2;
			}
		}
	}
}