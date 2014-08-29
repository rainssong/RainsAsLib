package 
{
	import flash.display.Sprite;
	import flash.events.Event;
	
	/**
	 *  我一定是足够蛋痛才会来写这个
	 * @author Rainssong
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
			
		}
		
	}
	
}