package me.rainssong.tween
{
	import com.greensock.easing.Cubic;
	import com.greensock.TweenMax;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.StageScaleMode;
	import flash.sampler.NewObjectSample;
	import flash.system.Capabilities;
	import flash.utils.setTimeout;
	import me.rainssong.utils.Directions;
	
	public class AnimationCore
	{
		
		static private var _newView:DisplayObject;
		static private var _oldView:DisplayObject;
		static private var _blackBmp:Bitmap = new Bitmap(new BitmapData(100, 100, false, 0));
		static private var _whiteBmp:Bitmap = new Bitmap(new BitmapData(100, 100, false, 0xffffff));
		
		static public function switchView(oldView:DisplayObject, newView:DisplayObject, effect:String = "move", params:Object = null):DisplayObject
		{
			if (!newView || !oldView)
			{
				return newView;
			}
			var _parent:DisplayObjectContainer = oldView.parent;
			if (_parent == null)
				return _newView;
			_newView = newView;
			_oldView = oldView;
			var duration:Number = 0.5;
			var delay:Number = 0;
			var direction:String = Directions.UP;
			if (!newView.parent)
				_parent.addChildAt(newView, _parent.getChildIndex(oldView));
			
			if (oldView.hasOwnProperty("mouseEnabled"))
			{
				oldView["mouseEnabled"] = false;
				oldView["mouseChildren"] = false;
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
				{
					duration = params["duration"];
					delete  params["duration"];
				}
					
				if (params["direction"])
					direction = params["direction"];
				
			}
			
			var _scaleMode:String = _parent.stage.scaleMode;
			_parent.stage.scaleMode = StageScaleMode.NO_SCALE;
			
			switch (effect)
			{
				//BUG:
				case "none": 
					removeViewComplete(_oldView);
					break;
				case "move": 
					switch (direction)
				{
					case Directions.LEFT: 
						TweenMax.from(newView, duration, {x: _parent.stage.stageWidth, ease: Cubic.easeInOut, delay: delay});
						TweenMax.to(oldView, duration, {x: -_parent.stage.stageWidth, onComplete: removeViewComplete, onCompleteParams: [oldView], ease: Cubic.easeInOut, delay: delay});
						break;
					case Directions.RIGHT: 
						TweenMax.from(newView, duration, {x: -_parent.stage.stageWidth, ease: Cubic.easeInOut, delay: delay});
						TweenMax.to(oldView, duration, {x: _parent.stage.stageWidth, onComplete: removeViewComplete, onCompleteParams: [oldView], ease: Cubic.easeInOut, delay: delay});
						break;
					case Directions.UP: 
						
						TweenMax.from(newView, duration, {y: _parent.stage.stageHeight, ease: Cubic.easeInOut, delay: delay});
						TweenMax.to(oldView, duration, {y: -_parent.stage.stageHeight, onComplete: removeViewComplete, onCompleteParams: [oldView], ease: Cubic.easeInOut, delay: delay});
						break;
					case Directions.DOWN: 
						TweenMax.from(newView, duration, {y: -_parent.stage.stageHeight, ease: Cubic.easeInOut, delay: delay});
						TweenMax.to(oldView, duration, {y: _parent.stage.stageHeight, onComplete: removeViewComplete, onCompleteParams: [oldView], ease: Cubic.easeInOut, delay: delay});
						break;
					default: 
						TweenMax.from(newView, duration, {y: _parent.stage.stageHeight, ease: Cubic.easeInOut, delay: delay});
						TweenMax.to(oldView, duration, {y: -_parent.stage.stageHeight, onComplete: removeViewComplete, onCompleteParams: [oldView], ease: Cubic.easeInOut, delay: delay});
				}
					break;
				case "cover": 
					if (_parent.getChildIndex(_newView) < _parent.getChildIndex(_oldView))
						_parent.swapChildren(_newView, _oldView);
					switch (direction)
				{
					case Directions.LEFT: 
						TweenMax.from(newView, duration, {x: _parent.stage.stageWidth, ease: Cubic.easeInOut, delay: delay, onComplete: removeViewComplete, onCompleteParams: [oldView]});
						break;
					case Directions.RIGHT: 
						TweenMax.from(newView, duration, {x: -_parent.stage.stageWidth, ease: Cubic.easeInOut, delay: delay, onComplete: removeViewComplete, onCompleteParams: [oldView]});
						break;
					case Directions.UP: 
						TweenMax.from(newView, duration, {y: -_parent.stage.stageHeight, ease: Cubic.easeInOut, delay: delay, onComplete: removeViewComplete, onCompleteParams: [oldView]});
						break;
					case Directions.DOWN: 
						TweenMax.from(newView, duration, {y: _parent.stage.stageHeight, ease: Cubic.easeInOut, delay: delay, onComplete: removeViewComplete, onCompleteParams: [oldView]});
						
						break;
					default: 
						TweenMax.from(newView, duration, {y: _parent.stage.stageHeight, ease: Cubic.easeInOut, delay: delay, onComplete: removeViewComplete, onCompleteParams: [oldView]});
					
				}
					break;
				
				case "uncover": 
					if (_parent.getChildIndex(_newView) > _parent.getChildIndex(_oldView))
						_parent.swapChildren(_newView, _oldView);
					switch (direction)
				{
					case Directions.LEFT: 
						TweenMax.to(oldView, duration, {x: -_parent.stage.stageWidth, onComplete: removeViewComplete, onCompleteParams: [oldView], ease: Cubic.easeInOut, delay: delay});
						break;
					case Directions.RIGHT: 
						TweenMax.to(oldView, duration, {x: _parent.stage.stageHeight, onComplete: removeViewComplete, onCompleteParams: [oldView], ease: Cubic.easeInOut, delay: delay});
						break;
					case Directions.UP: 
						TweenMax.to(oldView, duration, {y: -_parent.stage.stageHeight, onComplete: removeViewComplete, onCompleteParams: [oldView], ease: Cubic.easeInOut, delay: delay});
						break;
					case Directions.DOWN: 
						TweenMax.to(oldView, duration, {y: _parent.stage.stageHeight, onComplete: removeViewComplete, onCompleteParams: [oldView], ease: Cubic.easeInOut, delay: delay});
						
						break;
					default: 
						TweenMax.to(oldView, duration, {y: _parent.stage.stageHeight, onComplete: removeViewComplete, onCompleteParams: [oldView], ease: Cubic.easeInOut, delay: delay});
				}
					break;
				
				case "fadeIn": 
					if (_parent.getChildIndex(_newView) < _parent.getChildIndex(_oldView))
						_parent.swapChildren(_newView, _oldView);
					_newView.alpha = 0;
					TweenMax.to(_newView, duration, {alpha: 1, onComplete: removeViewComplete, onCompleteParams: [oldView], ease: Cubic.easeInOut, delay: delay});
					break;
				case "fadeOut": 
					if (_parent.getChildIndex(_newView) > _parent.getChildIndex(_oldView))
						_parent.swapChildren(_newView, _oldView);
					
					TweenMax.to(oldView, duration, {alpha: 0, onComplete: removeViewComplete, onCompleteParams: [oldView], ease: Cubic.easeInOut, delay: delay});
					break;
				case "fadeOutIn": 
					if (_parent.getChildIndex(_newView) > _parent.getChildIndex(_oldView))
						_parent.swapChildren(_newView, _oldView);
					
					TweenMax.to(_oldView, duration, {alpha: 0, ease: Cubic.easeInOut, delay: delay});
					TweenMax.to(_newView, duration, {alpha: 1, onComplete: removeViewComplete, onCompleteParams: [oldView], ease: Cubic.easeInOut, delay: duration + delay});
					break;
				case "fadeBlack":
					
					//_parent.addChild(_blackBmp);
					//_blackBmp.x = _oldView.x;
					//_blackBmp.y = _oldView.y;
					//_blackBmp.width = _oldView.width;
					//_blackBmp.height = _oldView.height;
					//_blackBmp.alpha = 0;
					
					//TweenMax.to(_blackBmp, duration*0.5, {alpha:1, onComplete: removeViewComplete, onCompleteParams: [_oldView], ease: Cubic.easeInOut,delay:delay});
					//TweenMax.to(_blackBmp, duration*0.5, {alpha:0, onComplete: _blackBmp.parent.removeChild, onCompleteParams: [_blackBmp], ease: Cubic.easeInOut,delay:delay+duration*0.5});
					
					if (_parent.getChildIndex(_newView) > _parent.getChildIndex(_oldView))
						_parent.swapChildren(_newView, _oldView);
					
					fadeToBlack(_oldView,duration*0.5, {onComplete: onFadeComplete});
					
					function onFadeComplete():void
					{
						fadeFromBlack(_newView,duration*0.5,params);
						if (_oldView.parent)
							_oldView.parent.removeChild(_oldView);
					}
					
					break;
				default: 
			}
			
			_parent.stage.scaleMode = _scaleMode;
			
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
			
			switch (effect)
			{
				case "move": 
					switch (direction)
				{
					case Directions.LEFT: 
						TweenMax.from(newView, duration, {x: container.stage.stageWidth, ease: Cubic.easeInOut, delay: delay});
						break;
					case Directions.RIGHT: 
						TweenMax.from(newView, duration, {x: -container.stage.stageWidth, ease: Cubic.easeInOut, delay: delay});
						break;
					case Directions.UP: 
						TweenMax.from(newView, duration, {y: container.stage.stageHeight, ease: Cubic.easeInOut, delay: delay});
						break;
					case Directions.DOWN: 
						TweenMax.from(newView, duration, {y: -container.stage.stageHeight, ease: Cubic.easeInOut, delay: delay});
						break;
					default: 
						TweenMax.from(newView, duration, {y: container.stage.stageHeight, ease: Cubic.easeInOut, delay: delay});
				}
					break;
				case "fadeFromBlack": 
					container.addChild(_blackBmp);
					_blackBmp.x = newView.x;
					_blackBmp.y = newView.y;
					_blackBmp.width = newView.width;
					_blackBmp.height = newView.height;
					_blackBmp.alpha = 1;
					TweenMax.to(_blackBmp, duration, {alpha: 0, onComplete: removeBlack, ease: Cubic.easeInOut, delay: delay});
					
					function removeBlack():void
					{	
					if (_blackBmp.parent)
						_blackBmp.parent.removeChild(_blackBmp);
					}
					break;
				default: 
			}
		
		}
		
		static public function removeView(view:DisplayObject, effect:String = "move", params:Object = null):void
		{
			var duration:Number = 0.5;
			var direction:String = Directions.DOWN;
			var delay:Number = 0;
			var _parent:DisplayObjectContainer = view.parent;
			if (_parent == null)
				return;
			
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
			switch (effect)
			{
				case "fadeToBlack": 
					_parent.addChild(_blackBmp);
					_blackBmp.x = view.x;
					_blackBmp.y = view.y;
					_blackBmp.width = view.width;
					_blackBmp.height = view.height;
					_blackBmp.alpha = 0;
					TweenMax.to(_blackBmp, duration, {alpha: 1, onComplete: removeViewComplete, onCompleteParams: [view], ease: Cubic.easeInOut, delay: delay});
					//TweenMax.to(_blackBmp, duration*0.5, {alpha:0, onComplete: _blackBmp.parent.removeChild, onCompleteParams: [_blackBmp], ease: Cubic.easeInOut,delay:delay+duration*0.5});
					break;
				case "fadeToBlackOut": 
					_parent.addChild(_blackBmp);
					_blackBmp.x = view.x;
					_blackBmp.y = view.y;
					_blackBmp.width = view.width;
					_blackBmp.height = view.height;
					_blackBmp.alpha = 0;
					TweenMax.to(_blackBmp, duration * 0.5, {alpha: 1, onComplete: removeViewComplete, onCompleteParams: [view], ease: Cubic.easeInOut, delay: delay});
					TweenMax.to(_blackBmp, duration * 0.5, {alpha: 0, onComplete: removeBlack, ease: Cubic.easeInOut, delay: delay + duration * 0.5});
					
					function removeBlack():void
				{
					if (_blackBmp.parent)
						_blackBmp.parent.removeChild(_blackBmp);
				}
					break;
				case "move": 
					switch (direction)
				{
					case Directions.LEFT: 
						TweenMax.to(view, duration, {x: -view.stage.stageWidth, onComplete: removeViewComplete, onCompleteParams: [view], ease: Cubic.easeInOut, delay: delay});
						break;
					case Directions.RIGHT: 
						TweenMax.to(view, duration, {x: view.stage.stageWidth, onComplete: removeViewComplete, onCompleteParams: [view], ease: Cubic.easeInOut, delay: delay});
						break;
					case Directions.UP: 
						TweenMax.to(view, duration, {y: -view.stage.stageHeight, onComplete: removeViewComplete, onCompleteParams: [view], ease: Cubic.easeInOut, delay: delay});
						break;
					case Directions.DOWN: 
						TweenMax.to(view, duration, {y: view.stage.stageHeight, onComplete: removeViewComplete, onCompleteParams: [view], ease: Cubic.easeInOut, delay: delay});
						break;
					default: 
						TweenMax.to(view, duration, {y: view.stage.stageHeight, onComplete: removeViewComplete, onCompleteParams: [view], ease: Cubic.easeInOut, delay: delay});
				}
					break;
				case "none":
					
					removeViewComplete(view);
					break;
				
				default: 
			}
		
		}
		
		static private function removeViewComplete(scene:DisplayObject):void
		{
			if (scene.parent)
				scene.parent.removeChild(scene);
			
			//if (_changeMouseEnabled == true)
			//{
			//_changeMouseEnabled == false
			//_newView["mouseEnabled"] = true;
			//}
			//if (_changeMouseChildren == true)
			//{
			//_changeMouseChildren = false;
			//_newView["mouseChildren"] = true;
			//}
			
			_oldView = null;
			_newView = null;
		
		}
		
		static public function chessboardAnim(view:DisplayObjectContainer):void
		{
		
		}
		
		static public function fadeToBlack(view:DisplayObject,duration:Number=0.4, vars:Object = null):void
		{
			var _parent:DisplayObjectContainer = view.parent;
			
			_parent.addChild(_blackBmp);
			_blackBmp.x = view.x;
			_blackBmp.y = view.y;
			_blackBmp.width = view.width;
			_blackBmp.height = view.height;
			_blackBmp.alpha = 0;
			
			if (vars == null)
				vars = {};
			
			
			vars.alpha = 1;
			
			TweenMax.to(_blackBmp, duration, vars);
		}
		
		static public function blackToTrans(view:DisplayObject,duration:Number=0.4, vars:Object = null):void
		{
			var _parent:DisplayObjectContainer = view.parent;
			
			_parent.addChild(_blackBmp);
			_blackBmp.x = view.x;
			_blackBmp.y = view.y;
			_blackBmp.width = view.width;
			_blackBmp.height = view.height;
			_blackBmp.alpha = 1;
			
			if (vars == null)
				vars = {};
			
			vars.alpha = 0;
			
			TweenMax.to(_blackBmp, duration, vars);
		}
		
		static public function fadeFromBlack(view:DisplayObject,duration:Number=0.4, vars:Object = null):void
		{
			var _parent:DisplayObjectContainer = view.parent;
			
			//if (_blackBmp.parent)_blackBmp.parent.removeChild(_blackBmp) 
			_parent.addChild(_blackBmp);
			_blackBmp.x = view.x;
			_blackBmp.y = view.y;
			_blackBmp.width = view.width;
			_blackBmp.height = view.height;
			_blackBmp.alpha = 1;
			
			if (vars == null)
				vars = {};
			
			vars.alpha = 0;
			
			TweenMax.to(_blackBmp, duration, vars);
			
			//setTimeout(function() { if (_blackBmp.parent)_blackBmp.parent.removeChild(_blackBmp) }, duration * 1000);
		}
		
		static public function fadeIn(view:DisplayObject,duration:Number=0.4, vars:Object = null):void
		{
			
			
			view.alpha = 0;
			
			if (vars == null)
				vars = {};
			
			vars.alpha = 1;
			
			TweenMax.to(view, duration, vars);
		}
		
		static public function fadeOut(view:DisplayObject,duration:Number=0.4, vars:Object = null):void
		{
			
			if (vars == null)
				vars = {};
			
			vars.alpha = 0;
			
			TweenMax.to(view, duration, vars);
		}
	
	}

}
