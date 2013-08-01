package me.rainssong.tween
{
	import com.greensock.easing.Cubic;
	import com.greensock.TweenMax;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import me.rainssong.utils.Directions;
	
	public class TweenCore
	{
		static public function switchView(oldView:DisplayObject, newView:DisplayObject, effect:String="move",duration:Number=0.5, ... arg):void
		{
			if (!newView || !oldView)
			{
				return;
			}
			var _parent :DisplayObjectContainer= oldView.parent;
			
			if (!newView.parent)
				_parent.addChild(newView);
			
			newView.x = 0;
			newView.y = 0;
			oldView.x = 0;
			oldView.y = 0;
			
			switch (effect)
			{
				case "move": 
					switch (arg[0])
					{
					case Directions.LEFT: 
						TweenMax.from(newView, 0.5, {x: _parent.stage.stageWidth, ease: Cubic.easeInOut});
						TweenMax.to(oldView, 0.5, {x: -_parent.stage.stageWidth, onComplete: removeView, onCompleteParams: [oldView], ease: Cubic.easeInOut});
						break;
					case Directions.RIGHT: 
						TweenMax.from(newView, 0.5, {x: -_parent.stage.stageWidth, ease: Cubic.easeInOut});
						TweenMax.to(oldView, 0.5, {x: _parent.stage.stageWidth, onComplete: removeView, onCompleteParams: [oldView], ease: Cubic.easeInOut});
						break;
					case Directions.UP: 
						TweenMax.from(newView, 0.5, {y: _parent.stage.stageHeight, ease: Cubic.easeInOut});
						TweenMax.to(oldView, 0.5, {y: -_parent.stage.stageHeight, onComplete: removeView, onCompleteParams: [oldView], ease: Cubic.easeInOut});
						break;
					case Directions.DOWN: 
						TweenMax.from(newView, 0.5, {y: -_parent.stage.stageHeight, ease: Cubic.easeInOut});
						TweenMax.to(oldView, 0.5, {y: _parent.stage.stageHeight, onComplete: removeView, onCompleteParams: [oldView], ease: Cubic.easeInOut});
						break;
					default: 
						TweenMax.from(newView, 0.5, {y: _parent.stage.stageHeight, ease: Cubic.easeInOut});
						TweenMax.to(oldView, 0.5, {y: -_parent.stage.stageHeight, onComplete: removeView, onCompleteParams: [oldView], ease: Cubic.easeInOut});
					}
					break;
				default: 
			}
		
		}
		
		static private function removeView(scene:DisplayObject):void 
		{
			if (scene.parent)
				scene.parent.removeChild(scene);
		}
	}
}
