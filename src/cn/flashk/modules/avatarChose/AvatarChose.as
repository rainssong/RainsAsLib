package cn.flashk.modules.avatarChose
{
	import cn.flashk.eventManager.EventCenter;
	import cn.flashk.events.CoreEvent;
	
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;

	public class AvatarChose extends Sprite
	{
		public var start_btn:SimpleButton;
		
		public function AvatarChose()
		{
			start_btn.addEventListener(MouseEvent.CLICK,startCore);
		}
		public function startCore(event:MouseEvent=null):void{
			EventCenter.eventRadio.addEventListener(CoreEvent.FIRST_RUN_CLEAR,clearMe);
			Load.getInstance().loadCore();
		}
		
		protected function clearMe(event:Event):void
		{
			EventCenter.eventRadio.removeEventListener(CoreEvent.FIRST_RUN_CLEAR,clearMe);
		}
	}
}