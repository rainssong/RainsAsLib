package me.rainssong.controls
{
	
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.ColorTransform;
	import flash.display.MovieClip;
	import me.rainssong.display.MySprite;
	
	/**
	 * ...
	 * @author rainssong
	 */
	public class LowLightBtn extends MySprite
	{
		private const colorTrans:ColorTransform = new ColorTransform();
		public function LowLightBtn() 
		{
			super();
		}
		
		override protected function onAdd(evt:Event=null):void 
		{
			super.onAdd(evt);
			this.addEventListener(MouseEvent.MOUSE_DOWN, downHandler);
		}
		
		private function downHandler(e:MouseEvent):void 
		{
			gotoDownFrame();
			stage.addEventListener(MouseEvent.MOUSE_UP, upHandler);
			//stage.addEventListener(MouseEvent.MOUSE_OUT, upHandler);
		}
		
		public function gotoDownFrame():void
		{
			var temp:ColorTransform = new ColorTransform(0.7, 0.7, 0.7, 1, 0, 0, 0, 0);
			this.transform.colorTransform = temp;
		}
		
		private function upHandler(e:MouseEvent):void 
		{
			this.transform.colorTransform = colorTrans;
		}
		
		
		
		//private function removeAt():void 
//		{
//			stage.removeEventListener(MouseEvent.MOUSE_UP, upHandler);
//			stage.removeEventListener(MouseEvent.MOUSE_OUT, upHandler);
//			
//			super.removeAt();
//		}
		
		
	}

}