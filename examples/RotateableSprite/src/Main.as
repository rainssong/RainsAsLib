package 
{
	import flash.display.GradientType;
	import flash.display.Sprite;
	import flash.events.Event;
	import me.rainssong.display.MouseRotatableSprite;
	import me.rainssong.display.SpeedRotatableSprite;
	import me.rainssong.display.TargetRotatableSprite;

	
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
			
			var temp:TargetRotatableSprite = new TargetRotatableSprite(4);
			temp.x = 200;
			temp.y = 200;
			temp.graphics.beginGradientFill(GradientType.LINEAR, [0xFF0000, 0x00FF00], [1, 1], [0, 255]);
			temp.graphics.drawCircle(0, 0, 100);
			
			var temp2:SpeedRotatableSprite = new SpeedRotatableSprite();
			temp2.x = 500;
			temp2.y = 200;
			temp2.graphics.beginGradientFill(GradientType.LINEAR, [0xFF0000, 0x00FF00], [1, 1], [0, 255]);
			temp2.graphics.drawCircle(0, 0, 100);
			
			addChild(temp2);
			
		}
		
	}
	
}