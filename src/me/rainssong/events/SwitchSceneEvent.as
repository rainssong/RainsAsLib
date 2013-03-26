package  me.rainssong.events 
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.events.Event;
	import me.rainssong.utils.Directions;
	
	/**
	 * ...
	 * @author Rainssong
	 */
	public class SwitchSceneEvent extends Event 
	{
		
		static public const SWITCH_SCENE:String = "switchScene";
		public var targetScene:DisplayObject;
		public var sourceScene:DisplayObject;
		public var direction:String;
		
		public function SwitchSceneEvent(type:String,sourceScene:DisplayObject,targetScene:DisplayObject,direction:String="left", bubbles:Boolean=false, cancelable:Boolean=false) 
		{
			super(type, bubbles, cancelable);
			this.direction = direction;
			this.targetScene = targetScene;
			this.sourceScene = sourceScene;
			
		}
		
	}

}