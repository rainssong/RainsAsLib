package
{
	import flash.display.Sprite;
	import flash.utils.getTimer;
	import flash.utils.setTimeout;
	import me.rainssong.utils.functionTiming;
	
	/**
	 *  我一定是足够蛋痛才会来写这个
	 * @author Rainssong
	 */
	public class Main extends Sprite
	{
		
		public function Main():void
		{
			var swt1:Sprite = new Sprite()
			
			addChild(swt1);
			
			swt1.graphics.lineStyle(2, 0x000000);
			
			swt1.graphics.moveTo(swt1.x, swt1.y);
			
		
			
			var conX1:Number = 1
			var conY1:Number = 2
			
			swt1.graphics.curveTo(conX1, conY1, 10, 12);
		}
	
	}

}