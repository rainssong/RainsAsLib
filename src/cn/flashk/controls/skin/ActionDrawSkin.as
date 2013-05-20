package cn.flashk.controls.skin 
{
	import cn.flashk.controls.support.UIComponent;
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	/**
	 * ...
	 * @author flashk
	 */
	public class ActionDrawSkin
	{
		protected var isHideOutSide:Boolean;
		
		public function ActionDrawSkin() 
		{
			
		}
		public function init(target:UIComponent,styleSet:Object):void {
			
		}
		public function reDraw():void {
			
		}
		public function hideOutState():void {
			isHideOutSide = true;
		}
		public function updateSkin():void {
			reDraw();
		}
	}

}