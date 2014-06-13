package me.rainssong.tween
{
	import com.greensock.easing.Cubic;
	import com.greensock.TweenMax;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.sampler.NewObjectSample;
	import me.rainssong.utils.Directions;
	
	public class AnimationCore
	{
		static private var _changeMouseEnabled:Boolean = false;
		static private var _changeMouseChildren:Boolean = false;
		static private var _newView:DisplayObject;
		static private var _oldView:DisplayObject;
		
		static public function switchView(oldView:DisplayObject, newView:DisplayObject, effect:String = "move", params:Object = null):DisplayObject
		{
			if (!newView || !oldView)
			{
				return newView;
			}
			var _parent:DisplayObjectContainer = oldView.parent;
			_newView = newView;
			_oldView = oldView;
			var duration:Number = 0.5;
			var delay:Number = 0;
			var direction:String = Directions.UP;
			if (!newView.parent)
				_parent.addChildAt(newView, _parent.getChildIndex(oldView));
			
			if (oldView["mouseEnabled"] == true)
			{
				_changeMouseEnabled = true;
				oldView["mouseEnabled"] = false;
			}
			else
			{
				_changeMouseEnabled = false;
			}
			if (oldView["mouseChildren"] == true)
			{
				_changeMouseChildren = true;
				oldView["mouseChildren"] = false;
			}
			else
			{
				_changeMouseChildren = false;
			}
			
			if (params)
			{
				if (params.x)
					newView.x = params.x;
				if (params.y)
					newView.y = params.y;
				if (params.hasOwnProperty("delay"))
					delay = params["delay"];
				if (params["duration"])
					duration = params["duration"];
					if (params["direction"])
					direction = params["direction"];
				
			}
			
			switch (effect)
			{
				case "move": 
					switch (direction)
				{
					case Directions.LEFT: 
						TweenMax.from(newView, duration, {x: _parent.stage.stageWidth, ease: Cubic.easeInOut,delay:delay});
						TweenMax.to(oldView, duration, {x: -_parent.stage.stageWidth, onComplete: removeViewComplete, onCompleteParams: [oldView], ease: Cubic.easeInOut,delay:delay});
						break;
					case Directions.RIGHT: 
						TweenMax.from(newView, duration, {x: -_parent.stage.stageWidth, ease: Cubic.easeInOut,delay:delay});
						TweenMax.to(oldView, duration, {x: _parent.stage.stageWidth, onComplete: removeViewComplete, onCompleteParams: [oldView], ease: Cubic.easeInOut,delay:delay});
						break;
					case Directions.UP: 
						TweenMax.from(newView, duration, {y: _parent.stage.stageHeight, ease: Cubic.easeInOut,delay:delay});
						TweenMax.to(oldView, duration, {y: -_parent.stage.stageHeight, onComplete: removeViewComplete, onCompleteParams: [oldView], ease: Cubic.easeInOut,delay:delay});
						break;
					case Directions.DOWN: 
						TweenMax.from(newView, duration, {y: -_parent.stage.stageHeight, ease: Cubic.easeInOut,delay:delay});
						TweenMax.to(oldView, duration, {y: _parent.stage.stageHeight, onComplete: removeViewComplete, onCompleteParams: [oldView], ease: Cubic.easeInOut,delay:delay});
						break;
					default: 
						TweenMax.from(newView, duration, {y: _parent.stage.stageHeight, ease: Cubic.easeInOut,delay:delay});
						TweenMax.to(oldView, duration, {y: -_parent.stage.stageHeight, onComplete: removeViewComplete, onCompleteParams: [oldView], ease: Cubic.easeInOut,delay:delay});
				}
					break;
				case "cover": 
					if (_parent.getChildIndex(_newView) < _parent.getChildIndex(_oldView))
						_parent.swapChildren(_newView, _oldView);
					switch (direction)
					{
					case Directions.LEFT: 
						TweenMax.from(newView, duration, {x: _parent.stage.stageWidth, ease: Cubic.easeInOut,delay:delay, onComplete: removeViewComplete, onCompleteParams: [oldView]});
						break;
					case Directions.RIGHT: 
						TweenMax.from(newView, duration, {x: -_parent.stage.stageWidth, ease: Cubic.easeInOut,delay:delay, onComplete: removeViewComplete, onCompleteParams: [oldView]});
						break;
					case Directions.UP: 
						TweenMax.from(newView, duration, {y: _parent.stage.stageHeight, ease: Cubic.easeInOut,delay:delay, onComplete: removeViewComplete, onCompleteParams: [oldView]});
						break;
					case Directions.DOWN: 
						TweenMax.from(newView, duration, {y: -_parent.stage.stageHeight, ease: Cubic.easeInOut,delay:delay, onComplete: removeViewComplete, onCompleteParams: [oldView]});

						break;
					default: 
						TweenMax.from(newView, duration, {y: _parent.stage.stageHeight, ease: Cubic.easeInOut,delay:delay, onComplete: removeViewComplete, onCompleteParams: [oldView]});
				
					}
					break;
					
				case "uncover": 
					if (_parent.getChildIndex(_newView) > _parent.getChildIndex(_oldView))
						_parent.swapChildren(_newView, _oldView);
					switch (direction)
					{
					case Directions.LEFT: 
						TweenMax.to(oldView, duration, {x: -_parent.stage.stageWidth, onComplete: removeViewComplete, onCompleteParams: [oldView], ease: Cubic.easeInOut,delay:delay});
						break;
					case Directions.RIGHT: 
						TweenMax.to(oldView, duration, {y: -_parent.stage.stageHeight, onComplete: removeViewComplete, onCompleteParams: [oldView], ease: Cubic.easeInOut,delay:delay});
						break;
					case Directions.UP: 
						TweenMax.to(oldView, duration, {y: _parent.stage.stageHeight, onComplete: removeViewComplete, onCompleteParams: [oldView], ease: Cubic.easeInOut,delay:delay});
						break;
					case Directions.DOWN: 
						TweenMax.to(oldView, duration, {y: _parent.stage.stageHeight, onComplete: removeViewComplete, onCompleteParams: [oldView], ease: Cubic.easeInOut,delay:delay});

						break;
					default: 
						TweenMax.to(oldView, duration, {y: _parent.stage.stageHeight, onComplete: removeViewComplete, onCompleteParams: [oldView], ease: Cubic.easeInOut,delay:delay});
				
					}
					break;
				default: 
			}
			
			return newView;
		}
		
		static public function addView(container:DisplayObjectContainer, newView:DisplayObject, effect:String = "move", params:Object = null):void
		{
			var duration:Number = 0.5;
			var direction:String = Directions.UP;
			var delay:Number = 0;
			container.addChild(newView);
			
			if (params)
			{
				if (params.x)
					newView.x = params.x;
				if (params.y)
					newView.y = params.y;
				if (params.hasOwnProperty("delay"))
					delay = params["delay"];
				if (params["duration"])
					duration = params["duration"];
				if (params["direction"])
					direction = params["direction"];
			}
			
			switch (direction)
			{
				case Directions.LEFT: 
					TweenMax.from(newView, duration, {x: container.stage.stageWidth, ease: Cubic.easeInOut,delay:delay});
					break;
				case Directions.RIGHT: 
					TweenMax.from(newView, duration, {x: -container.stage.stageWidth, ease: Cubic.easeInOut,delay:delay});
					break;
				case Directions.UP: 
					TweenMax.from(newView, duration, {y: container.stage.stageHeight, ease: Cubic.easeInOut,delay:delay});
					break;
				case Directions.DOWN: 
					TweenMax.from(newView, duration, {y: -container.stage.stageHeight, ease: Cubic.easeInOut,delay:delay});
					break;
				default: 
					TweenMax.from(newView, duration, {y: container.stage.stageHeight, ease: Cubic.easeInOut,delay:delay});
			
			}
		}
		
		static public function removeView(view:DisplayObject, params:Object = null):void
		{
			var duration:Number = 0.5;
			var direction:String = Directions.DOWN;
			var delay:Number = 0;
			if (params)
			{
				if (params.x)
					view.x = params.x;
				if (params.y)
					view.y = params.y;
				if (params.hasOwnProperty("delay"))
					delay = params["delay"];
				if (params["duration"])
					duration = params["duration"];
				if (params["direction"])
					direction = params["direction"];
			}
			
			switch (direction)
			{
				case Directions.LEFT: 
					TweenMax.to(view, duration, {x: -view.stage.stageWidth, onComplete: removeViewComplete, onCompleteParams: [view], ease: Cubic.easeInOut,delay:delay});
					break;
				case Directions.RIGHT: 
					TweenMax.to(view, duration, {x: view.stage.stageWidth, onComplete: removeViewComplete, onCompleteParams: [view], ease: Cubic.easeInOut,delay:delay});
					break;
				case Directions.UP: 
					TweenMax.to(view, duration, {y: -view.stage.stageHeight, onComplete: removeViewComplete, onCompleteParams: [view], ease: Cubic.easeInOut,delay:delay});
					break;
				case Directions.DOWN: 
					TweenMax.to(view, duration, {y: view.stage.stageHeight, onComplete: removeViewComplete, onCompleteParams: [view], ease: Cubic.easeInOut,delay:delay});
					break;
				default: 
					TweenMax.to(view, duration, {y: view.stage.stageHeight, onComplete: removeViewComplete, onCompleteParams: [view], ease: Cubic.easeInOut,delay:delay});
			}
		}
		
		static private function removeViewComplete(scene:DisplayObject):void
		{
			if (scene.parent)
				scene.parent.removeChild(scene);
			
			if (_changeMouseEnabled == true)
			{
				_changeMouseEnabled == false
					//_newView["mouseEnabled"] = true;
			}
			if (_changeMouseChildren == true)
			{
				_changeMouseChildren = false;
					//_newView["mouseChildren"] = true;
			}
			
			_oldView = null;
			_newView = null;
		
		}
		
		public function chessboardAnim(view:DisplayObjectContainer):void
		{
		
		}
	
	}

}
