package cn.flashk.eventManager 
{
	import flash.events.EventDispatcher;
	/**
	 * ...
	 * @author flashk
	 */
	public class EventCenter 
	{
		public static const eventRadio:EventRadio = new EventRadio();
		
		public function EventCenter() 
		{
			
		}
		public static function init():void{
			EventCenter.eventRadio;
		}
		
	}

}