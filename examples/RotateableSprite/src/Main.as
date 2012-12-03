package 
{
	import flash.display.GradientType;
	import flash.display.Sprite;
	import flash.events.Event;
	import me.rainssong.display.RotatableSprite;
	
	/**
	 * ...
	 * @author rainssong
	 */
	public class Main extends Sprite 
	{
		
		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			
			var temp:RotatableSprite = new RotatableSprite();
			temp.x = 200;
			temp.y = 200;
			temp.graphics.beginGradientFill(GradientType.LINEAR, [0xFF0000, 0x00FF00], [1, 1], [0, 255]);
			temp.graphics.drawCircle(0, 0, 100);
			
			addChild(temp);
			
		}
		
	}
	
}