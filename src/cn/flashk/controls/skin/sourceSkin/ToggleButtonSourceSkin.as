package cn.flashk.controls.skin.sourceSkin
{
	import flash.display.BitmapData;
	import flash.events.Event;
	import flash.events.MouseEvent;

	public class ToggleButtonSourceSkin extends ButtonSourceSkin
	{
		protected var _isSelect:Boolean = false;
		
		public function ToggleButtonSourceSkin()
		{
		}
		 public function updateToggleView(isSelect:Boolean):void {
			 _isSelect = isSelect;
			 if(_isSelect == true){
				 index = outIndex;
				 bp.sourceBitmapData = bds[pressIndex] as BitmapData;
				 bp.update();
			 }
		}
		override public function showOut(event:MouseEvent):void
		 {
			if(_isSelect == true){
				bp.removeEventListener(Event.ENTER_FRAME,showOverFrame);
				updateToggleView(true);
				return ;
			}
			super.showOut(event);
		 }
	}
}