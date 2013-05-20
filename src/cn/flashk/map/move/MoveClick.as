package cn.flashk.map.move
{
	import flash.display.Shape;
	import flash.display.SimpleButton;
	import flash.events.MouseEvent;

	public class MoveClick extends SimpleButton
	{
		private var area:Shape;
		
		public function MoveClick()
		{
			area = new Shape();
			area.graphics.beginFill(0,1);
			area.graphics.drawRect(0,0,5000,3000);
			this.hitTestState = area;
			this.addEventListener(MouseEvent.MOUSE_UP,checkMoveTo);
			trace("i run");
		}
		private function checkMoveTo(event:MouseEvent):void{
			AutoRoad.maxCount = 0;
			AutoRoad.getInstance().moveTo(this.mouseX,this.mouseY);		
		}
	}
}