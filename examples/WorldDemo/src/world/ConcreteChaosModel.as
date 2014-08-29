package  world
{
	import world.ChaosModel;
	
	/**
	 * ...
	 * @author Rainssong
	 */
	public class ConcreteChaosModel extends ChaosModel 
	{
		public var existTime:Number = 0;
		
		public function ConcreteChaosModel() 
		{
			super();
		}
		
		public function init():void
		{
			existTime = 0;
		}
	
		public function destroy():void
		{
			existTime = 0;
		}
	}

}