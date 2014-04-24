package me.rainssong.tween
{
	import com.greensock.easing.Cubic;
	import com.greensock.TweenMax;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.sampler.NewObjectSample;
	import me.rainssong.utils.Directions;
	
	public class TweenCore
	{
		static public function switchView(oldView:DisplayObject, newView:DisplayObject, effect:String = "move", duration:Number = 0.5, vars:Object = null):DisplayObject
		{
			if (!newView || !oldView)
			{
				return newView;
			}
			var _parent:DisplayObjectContainer = oldView.parent;
			
			if (!newView.parent)
			{
				_parent.addChildAt(newView, _parent.getChildIndex(oldView));
				
			}
			if (!vars)
				vars = {};
			if (vars.x)
				newView.x = vars.x
			if (vars.y)
				newView.y = vars.y;
			//oldView.x = 0;
			//oldView.y = 0;
			
			switch (effect)
			{
				case "move": 
					switch (vars["direction"])
				{
					case Directions.LEFT: 
						TweenMax.from(newView, duration, {x: _parent.stage.stageWidth, ease: Cubic.easeInOut});
						TweenMax.to(oldView, duration, {x: -_parent.stage.stageWidth, onComplete: removeView, onCompleteParams: [oldView], ease: Cubic.easeInOut});
						break;
					case Directions.RIGHT: 
						TweenMax.from(newView, duration, {x: -_parent.stage.stageWidth, ease: Cubic.easeInOut});
						TweenMax.to(oldView, duration, {x: _parent.stage.stageWidth, onComplete: removeView, onCompleteParams: [oldView], ease: Cubic.easeInOut});
						break;
					case Directions.UP: 
						TweenMax.from(newView, duration, {y: _parent.stage.stageHeight, ease: Cubic.easeInOut});
						TweenMax.to(oldView, duration, {y: -_parent.stage.stageHeight, onComplete: removeView, onCompleteParams: [oldView], ease: Cubic.easeInOut});
						break;
					case Directions.DOWN: 
						TweenMax.from(newView, duration, {y: -_parent.stage.stageHeight, ease: Cubic.easeInOut});
						TweenMax.to(oldView, duration, {y: _parent.stage.stageHeight, onComplete: removeView, onCompleteParams: [oldView], ease: Cubic.easeInOut});
						break;
					default: 
						TweenMax.from(newView, duration, {y: _parent.stage.stageHeight, ease: Cubic.easeInOut});
						TweenMax.to(oldView, duration, {y: -_parent.stage.stageHeight, onComplete: removeView, onCompleteParams: [oldView], ease: Cubic.easeInOut});
				}
					break;
				default: 
			}
			return newView;
		}
		
		static private function removeView(scene:DisplayObject):void
		{
			if (scene.parent)
				scene.parent.removeChild(scene);
		}
	}
}
