package me.rainssong.robotlegs.controller
{
	
	
	import com.greensock.easing.Cubic;
	import com.greensock.TweenMax;
	import me.rainssong.events.SwitchSceneEvent;
	
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import me.rainssong.utils.Directions;
	import me.rainssong.utils.superTrace;
	
	import org.robotlegs.mvcs.Command;
	import org.robotlegs.mvcs.Mediator;
	
	/**
	 * ...
	 * @author Rainssong
	 */
	public class SwitchSceneCommand extends Command
	{
		[Inject]
		public var switchSceneEvent:SwitchSceneEvent;
		
		private var _parent:DisplayObjectContainer;
		
		public function SwitchSceneCommand()
		{
			super();
		}
		
		override public function execute():void
		{
			
			if (!switchSceneEvent.targetScene || !switchSceneEvent.sourceScene)
			{
				return;
			}
			_parent = switchSceneEvent.sourceScene.parent;
			
			if (!switchSceneEvent.targetScene.parent)
				_parent.addChild(switchSceneEvent.targetScene);
			
			switchSceneEvent.targetScene.x = 0;
			switchSceneEvent.targetScene.y = 0;
			switchSceneEvent.sourceScene.x = 0;
			switchSceneEvent.sourceScene.y = 0;
			
			switch (switchSceneEvent.direction)
			
			{
				case Directions.LEFT: 
					TweenMax.from(switchSceneEvent.targetScene, 0.5, {x: _parent.stage.stageWidth, ease: Cubic.easeInOut});
					TweenMax.to(switchSceneEvent.sourceScene, 0.5, {x: -_parent.stage.stageWidth, onComplete: destroyScene, onCompleteParams: [switchSceneEvent.sourceScene], ease: Cubic.easeInOut});
					break;
				case Directions.RIGHT: 
					TweenMax.from(switchSceneEvent.targetScene, 0.5, {x: -_parent.stage.stageWidth, ease: Cubic.easeInOut});
					TweenMax.to(switchSceneEvent.sourceScene, 0.5, {x: _parent.stage.stageWidth, onComplete: destroyScene, onCompleteParams: [switchSceneEvent.sourceScene], ease: Cubic.easeInOut});
					break;
				case Directions.UP: 
					TweenMax.from(switchSceneEvent.targetScene, 0.5, {y: _parent.stage.stageHeight, ease: Cubic.easeInOut});
					TweenMax.to(switchSceneEvent.sourceScene, 0.5, {y: -_parent.stage.stageHeight, onComplete: destroyScene, onCompleteParams: [switchSceneEvent.sourceScene], ease: Cubic.easeInOut});
					break;
				case Directions.DOWN: 
					TweenMax.from(switchSceneEvent.targetScene, 0.5, {y: _parent.stage.stageHeight, ease: Cubic.easeInOut});
					TweenMax.to(switchSceneEvent.sourceScene, 0.5, {y: -_parent.stage.stageHeight, onComplete: destroyScene, onCompleteParams: [switchSceneEvent.sourceScene], ease: Cubic.easeInOut});
					
					break;
			}
		
		}
		
		private function destroyScene(scene:DisplayObject):void
		{
			if (scene.parent)
				scene.parent.removeChild(scene);
		}
	
	}

}