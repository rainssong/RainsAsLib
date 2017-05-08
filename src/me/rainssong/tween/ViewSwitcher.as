package me.rainssong.tween
{
	import com.greensock.easing.Cubic;
	import com.greensock.easing.Ease;
	import com.greensock.TweenMax;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.sampler.NewObjectSample;
	import flash.utils.setTimeout;
	import me.rainssong.utils.Directions;
	
	public class ViewSwitcher
	{
		private var _newView:DisplayObject;
		private var _oldView:DisplayObject;
		public var autoDestory:Boolean = true;
		
		public function switchView(oldView:DisplayObject, newView:DisplayObject, effect:String = "move", params:Object = null ):DisplayObject
		{
			if (!newView || !oldView)
			{
				return newView;
			}
			
			if (_newView == newView)
				return newView;
				
			if (_oldView == oldView)
				return newView;
			
			var _parent:DisplayObjectContainer = oldView.parent;
			if (_parent == null)
				return newView;
			
			var duration:Number = 0.5;
			var delay:Number = 0;
			var direction:String = Directions.UP;
			var ease:Ease=Cubic.easeInOut;
			var onComplete:Function=null;
			var onCompleteParams:Array=null;
			
			if (!newView.parent)
				_parent.addChildAt(newView, _parent.getChildIndex(oldView));
			
			_oldView = oldView;
			_newView = newView;
			
			if (params)
			{
				if (params.hasOwnProperty("delay"))
					delay = params["delay"];
				if (params.hasOwnProperty("duration"))
					duration = params["duration"];
				if (params.hasOwnProperty("direction"))
					direction = params["direction"];
				if (params.hasOwnProperty("onComplete"))
					onComplete = params["onComplete"];
				if (params.hasOwnProperty("onCompleteParams"))
					onCompleteParams = params["onCompleteParams"];
			}
			else
				params = { };
				
			var vars1:Object={delay:delay,duration:duration,ease:ease}
			var vars2:Object={delay:delay,duration:duration,ease:ease}
			
			switch (effect)
			{
				//BUG:未移除旧视图
				case "none": 
						//addView(_parent, newView, effect, vars1);
						//removeView(oldView, effect, vars2);
					break;
				case "move": 
					
					vars1.direction = direction;
					vars2.direction = direction;
					vars2.onComplete = onComplete;
					vars2.onCompleteParams = onCompleteParams;
					
					addView(_parent, newView, effect, vars1);
					removeView(oldView, effect, vars2);
					
					
					
					break;
				case "cover": 
					
					//vars1.direction = direction;
					//vars1.onComplete = onComplete;
					//vars1.onCompleteParams = onCompleteParams;
					addView(_parent, newView, "move", params);
					
					if (_parent.getChildIndex(newView) < _parent.getChildIndex(oldView))
						_parent.swapChildren(newView, oldView);
					
					
					//setTimeout(removeOldView, (duration + delay) * 1000);
					
					
					break;
				
				case "uncover": 
					
					//addView(_parent, newView, "none");
					
					if (_parent.getChildIndex(newView) > _parent.getChildIndex(oldView))
						_parent.swapChildren(newView, oldView);
					
					removeView(oldView, "move", params);
					
					
					break;
				
				case "fadeIn": 
					if (_parent.getChildIndex(newView) < _parent.getChildIndex(oldView))
						_parent.swapChildren(newView, oldView);
					
					vars1.onComplete = onComplete;
					vars1.onCompleteParams = onCompleteParams;
					addView(_parent, newView, effect, vars1);
					
					
					break;
				case "fadeOut": 
					if (_parent.getChildIndex(newView) > _parent.getChildIndex(oldView))
						_parent.swapChildren(newView, oldView);
						
					
					vars2.onComplete = onComplete;
					vars2.onCompleteParams = onCompleteParams;
					removeView(oldView, effect, vars2);
					
					break;
				case "fadeOutIn": 
					//if (_parent.getChildIndex(_newView) > _parent.getChildIndex(_oldView))
						//_parent.swapChildren(_newView, _oldView);
					//
					//TweenMax.to(_oldView, duration, {alpha: 0, ease: Cubic.easeInOut, delay: delay});
					//TweenMax.to(_newView, duration, {alpha: 1, onComplete: removeViewComplete, onCompleteParams: [oldView], ease: Cubic.easeInOut, delay: duration + delay});
					break;
				case "fadeBlack":
					
					
					if (_parent.getChildIndex(newView) > _parent.getChildIndex(oldView))
						_parent.swapChildren(newView, oldView);
					
					vars1.delay = duration * 0.5 + delay;
					vars2.duration = duration * 0.5;
					vars1.onComplete = onComplete;
					vars1.onCompleteParams = onCompleteParams;
					
					//BUG:bitmap没有消失
					addView(_parent, newView, "fadeFromBlack", vars1);
					removeView(oldView, "fadeToBlack", vars2);
					
					//_parent.removeChild(oldView);
					//_parent.addChild(newView);
					
					break;
				default: 
			}
			
			setTimeout(animFinish,(duration+delay)*1000);
			
			return newView;
		}
		
		public function addView(container:DisplayObjectContainer, newView:DisplayObject, effect:String = "move", params:Object = null):void
		{
			
			var duration:Number = 0.5;
			var delay:Number = 0;
			var direction:String = Directions.UP;
			var ease:Ease=Cubic.easeInOut;
			var onComplete:Function=null;
			var onCompleteParams:Array=null;
			
			if(newView.parent!=container)
				container.addChild(newView);
			
			if (params)
			{
				if (params.hasOwnProperty("delay"))
					delay = params["delay"];
				if (params.hasOwnProperty("duration"))
					duration = params["duration"];
				if (params.hasOwnProperty("direction"))
					direction = params["direction"];
				if (params.hasOwnProperty("onComplete"))
					onComplete = params["onComplete"];
				if (params.hasOwnProperty("onCompleteParams"))
					onCompleteParams = params["onCompleteParams"];
			}
			else
				params = { };
				
			var vars:Object = { delay:delay, ease:ease, onComplete:onComplete, onCompleteParams:onCompleteParams };
			
			
			
			switch (effect)
			{
				case "none":
						
				break;
				case "move": 
					switch (direction)
					{
						case Directions.LEFT: 
							vars.x = container.stage.stageWidth;
							break;
						case Directions.RIGHT: 
							vars.x = -container.stage.stageWidth;
							break;
						case Directions.UP: 
							vars.y = container.stage.stageHeight;
							break;
						case Directions.DOWN: 
							vars.y = -container.stage.stageHeight;
							break;
						default: 
							vars.y = container.stage.stageHeight;
					}
						
					TweenMax.from(newView, duration, vars);
					break;
				case "fadeFromBlack": 
					AnimationCore.fadeFromBlack(newView, duration, vars);
					break;
				case "fadeIn": 
					AnimationCore.fadeIn(newView, duration, vars);
					break;
				default: 
			}
			
			_newView = newView;
		
		}
		
		public function removeView(view:DisplayObject, effect:String = "move", params:Object = null):void
		{
			
			var direction:String = Directions.UP;
			var delay:Number = 0;
			var duration:Number = 0.5;
			var onComplete:Function = null;
			var onCompleteParams:Array = null;
			var ease:Ease = Cubic.easeInOut;
			
			_oldView = view;
			
			
			if (params)
			{
				if (params.hasOwnProperty("delay"))
					delay = params["delay"];
				if (params.hasOwnProperty("direction"))
					direction = params["direction"];
				if (params.hasOwnProperty("duration"))
					duration = params["duration"];
				if (params.hasOwnProperty("onComplete"))
					onComplete = params["onComplete"];
				if (params.hasOwnProperty("onCompleteParams"))
					onCompleteParams = params["onCompleteParams"];
			}
			else
				params = { };
				
			var vars:Object = { delay:delay, ease:ease, onComplete:onComplete, onCompleteParams:onCompleteParams };
			
			switch (effect)
			{
				case "fadeToBlack": 
					
					AnimationCore.fadeToBlack(view, duration,vars);
					setTimeout(removeOldView,(duration+delay)*1000);
					break;
				case "fadeToBlackOut": 
					
					AnimationCore.fadeToBlack(view, duration * 0.5,  { delay:delay, ease:ease});
					AnimationCore.blackToTrans(view, duration * 0.5,  { delay:delay, ease:ease});
					AnimationCore.fadeOut(view,duration * 0.5, vars);
					
					setTimeout(removeOldView,(duration+delay)*1000);
					break;
				case "fadeOut": 
					AnimationCore.fadeOut(view,duration,vars);
					
					setTimeout(removeOldView,(duration+delay)*1000);
					break;
				case "move": 
					switch (direction)
					{
						case Directions.LEFT: 
							vars.x = -view.stage.stageWidth;
							break;
						case Directions.RIGHT: 
							vars.x = view.stage.stageWidth;
							break;
						case Directions.UP: 
							vars.y = -view.stage.stageHeight;
							break;
						case Directions.DOWN: 
							vars.y = view.stage.stageHeight;
							break;
						default: 
							vars.y = -view.stage.stageHeight;
					}
						
					TweenMax.to(view, duration, vars);
					
					setTimeout(removeOldView,(duration+delay)*1000);
					break;
				default: 
			}
		}
		
		private function removeOldView():void
		{
			if(_oldView)
				if (_oldView.parent)
					_oldView.parent.removeChild(_oldView);
		}
		
		private function animFinish():void
		{
			if (autoDestory)
				destroy();
			
			removeOldView();
		}
		
		public function destroy():void
		{
			TweenMax.killTweensOf(_oldView);
			TweenMax.killTweensOf(_newView);
			
			_oldView = null;
			_newView = null;
		}
		
		public static function addView(container:DisplayObjectContainer, newView:DisplayObject, effect:String = "move", params:Object = null):ViewSwitcher
		{
			var vs:ViewSwitcher = new ViewSwitcher();
			vs.addView(container,newView,effect,params);
			return vs;
		}
		
		public static function removeView(view:DisplayObject, effect:String = "move", params:Object = null):ViewSwitcher
		{
			var vs:ViewSwitcher = new ViewSwitcher();
			vs.removeView(view,effect,params);
			return vs;
		}
		
		public static function switchView(oldView:DisplayObject, newView:DisplayObject, effect:String = "move", params:Object = null ):ViewSwitcher
		{
			var vs:ViewSwitcher = new ViewSwitcher();
			vs.switchView(oldView, newView, effect, params);
			
			return vs;
		}
	}
}