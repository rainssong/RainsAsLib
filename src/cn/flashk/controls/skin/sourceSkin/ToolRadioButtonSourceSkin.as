package cn.flashk.controls.skin.sourceSkin
{
	import cn.flashk.controls.support.UIComponent;
	
	import flash.events.Event;
	import flash.events.MouseEvent;

	public class ToolRadioButtonSourceSkin extends ToggleButtonSourceSkin
	{
		public function ToolRadioButtonSourceSkin()
		{
			isOutViewHide = true;
			bp.scaleSmoothing = true;
		}
		override public function updateToggleView(isSelect:Boolean):void {
			super.updateToggleView(isSelect);
			if(_isSelect == false){
				bp.alpha = 0;
			}else{
				bp.alpha = 1;
			}
			
		}
		override public function init(target:UIComponent,styleSet:Object,Skin:Class):void {
			super.init(target,styleSet,Skin);
			tar.addEventListener(MouseEvent.MOUSE_OVER,alphaOver);
		}
		
		protected function alphaOver(event:MouseEvent):void
		{
			//tar.addEventListener(Event.ENTER_FRAME,alphaShow);
		}
		
		protected function alphaShow(event:Event):void
		{
			// TODO Auto-generated method stub
			
		}
	}
}