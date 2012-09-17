package me.rainssong.display


{
	import com.greensock.TweenMax;
	import com.ObjectPool.ObjectPool;
	import flash.errors.IOError;
	import me.rainssong.events.SlideEvent;

	
	import me.rainssong.events.MyEvent;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.utils.setTimeout;
	import me.rainssong.display.MySprite;
	
	/**
	 * ...
	 * @author rainssong
	 */
	public class SlideShow extends MySprite
	{
		static public const SWIPE_UP:String = "swipeUp";
		static public const SWIPE_COMPLETE:String = "swipeComplete";
		static public const NEXT:String = "next";
		
		private var _slideClassArr:Array;
		private var _targetIndex:int = 0;
		private var _slideContainer:MySprite;
		private var _slideArr:Array;
		private var dpoint:Point = new Point();
		private var mpoint:Point = new Point();
		private var isDrag:Boolean = false;
		private var speedX:Number;
		private var lastX:Number;
		private var speedY:Number;
		private var lastY:Number;
		private var _slideWidth:Number;
		private var _slideHeight:Number;
		
		public function SlideShow(slideWidth:Number = 1024, slideHeight:Number = 768)
		{
			_slideWidth = slideWidth;
			_slideHeight = slideHeight;
			_slideContainer = new MySprite();
			
			addChild(_slideContainer);
			
			addEventListener(SlideEvent.ROLL_TO, rollHandler);
			addEventListener(SlideEvent.ROLL_NEXT, rollHandler);
			addEventListener(SlideEvent.ROLL_PREV, rollHandler);
		}
		
		private function rollHandler(e:SlideEvent):void 
		{
			switch(e.type)
			{
				case SlideEvent.ROLL_TO:
					//var target:int = e.data as int;
					
					rollTo( e.data as int);
					break;
				case SlideEvent.ROLL_NEXT:
					rollNext();
					break;
				case SlideEvent.ROLL_PREV:
					rollPrev();
					break;
			}
		}
		
		private function mouseDownHandler(e:MouseEvent):void
		{
			//这里判断锁
			if (isLocked)
			{
				trace("锁定");
				return;
			}
			
			//
			TweenMax.killTweensOf(_slideContainer);
			dpoint.x = e.stageX;
			dpoint.y = e.stageY;
			mpoint.x = _slideContainer.x;
			mpoint.y = _slideContainer.y;
			lastX = e.stageX;
			lastY = e.stageY;
			speedX = 0;
			speedY = 0;
			
			isDrag = true;
			
			stage.addEventListener(MouseEvent.MOUSE_UP , mouse_Up);
			addEventListener(Event.ENTER_FRAME, enterFrameHandler);
		}
		
		private function mouse_Up(evt:MouseEvent):void
		{
			
			stage.removeEventListener(MouseEvent.MOUSE_UP, mouse_Up);
			removeEventListener(Event.ENTER_FRAME, enterFrameHandler);
			isDrag = false;
			
			if (_slideContainer.x != (speedX / 0.5 + _slideContainer.x) / -1024)
			{
				//dispatchEvent(new Event(SWIPE_LEFT));
				
				rollTo(Math.round((speedX / 0.5 + _slideContainer.x) / -1024));
				//if((speedX / 0.5 + _slideContainer.x)>_slideWidth)
			}
			if (speedY < -30 && Math.abs(speedX)<25)
			{
				//dispatchEvent(new Event(SWIPE_UP));
				if (!isLocked)
					dispatchEvent(new MyEvent(SWIPE_UP));
			}
			speedX = 0;
			speedY = 0;
		}
		
		private function enterFrameHandler(e:Event):void
		{
			speedX *= 0.8;
			speedY *= 0.8;
			//roll();
			//refreash();
			
			if (isDrag)
			{
				speedX += stage.mouseX - lastX;
				speedY += stage.mouseY - lastY;
				
				
				//忽略细微移动
				if (speedX ^ 0 != 0 && _slideContainer.mouseChildren)
				{
					_slideContainer.mouseChildren = _slideContainer.mouseEnabled = false;
				}
				
				lastX = stage.mouseX;
				lastY = stage.mouseY;
				
				var targetX:int = mpoint.x + stage.mouseX - dpoint.x;
				
				if (targetX < -_slideWidth*_targetIndex && !rightRollAble)
				{
					targetX = -_slideWidth * _targetIndex;
					speedX = 0;
					
				}
				if (targetX > -_slideWidth*_targetIndex && !leftRollAble )
				{
					targetX = -_slideWidth * _targetIndex;
					speedX = 0;
				}
				
				_slideContainer.x = targetX;
			}
		}
		
		
		public function rollTo(index:int, time:Number = 0.5):void
		{
			
			TweenMax.killTweensOf(_slideContainer);
			index = index < 0 ? 0 : index;
			index = index >= _slideClassArr.length ? _slideClassArr.length - 1 : index;
			trace("rollTo",index)
			_targetIndex = index;
			dispatchEvent(new SlideEvent(SlideEvent.START_ROLL));
			TweenMax.to(_slideContainer, time, {x: -1024 * _targetIndex, onUpdate: rollUpdateHandler, onComplete: TweenXComplete, onCompleteParams: [index != currentIndex ? true : false]});
		}
		
		public function rollNext():void
		{
			trace("rollNext",_targetIndex + 1)
			rollTo(_targetIndex + 1);
		}
		
		public function rollPrev():void
		{
			trace("rollNext",_targetIndex - 1)
			rollTo(_targetIndex - 1);
		}
		
		private function TweenXComplete(isSwiped:Boolean = false):void
		{
			for (var i:int = 0; i < _slideArr.length; i++)
			{
				if (i == currentIndex && !_slideArr[i].isEnable )
				{
					_slideArr[i].enable();
				}
				if (i != currentIndex && _slideArr[i] && _slideArr[i].isEnable)
				{
					_slideArr[i].disable();
				}
			}
			
			//if (isSwiped)
			//{
				dispatchEvent(new SlideEvent(SlideEvent.ROLL_COMPLETE));
				
			//}
			_slideContainer.mouseChildren = _slideContainer.mouseEnabled = true;
		}
		
		private function rollUpdateHandler():void
		{
			destroySlide(currentIndex - 2);
			destroySlide(currentIndex + 2);
			addSlide(currentIndex);
			addSlide(currentIndex + 1);
			addSlide(currentIndex - 1);
		}
		
		public function load(slideClassArr:Array):void
		{
			_slideClassArr = slideClassArr;
			_slideArr = new Array(_slideClassArr.length);
			//_slideContainer.addChild(new slideArr[0]);
			//addSlide(_targetIndex-1);
			//addSlide(_targetIndex);
			//_slideArr[_targetIndex].enable();
			//addSlide(_targetIndex + 1);
			rollTo(_targetIndex,0);
			addEventListener(MouseEvent.MOUSE_DOWN, mouseDownHandler);
			//_slideArr[_targetIndex].enable();
			
			dispatchEvent(new Event(SlideShow.SWIPE_COMPLETE));
		}
		
		override public function destroy():void 
		{
			for (var i:int = 0; i < _slideArr.length ; i++ )
			{
				destroySlide(i);
			}
			_slideArr = null;
			_slideClassArr = null;
			
			removeEventListener(MouseEvent.MOUSE_DOWN, mouseDownHandler);
			
			dispatchEvent(new Event("destroy"));
			
			removeChild(_slideContainer);
			_slideContainer = null;
			
			super.destroy();
		}
		
		private function addSlide(index:int):void
		{
			if (_slideArr[index]!=null || index < 0 || index >= _slideClassArr.length)
				return;
			_slideArr[index] = new _slideClassArr[index]();
			_slideContainer.addChild(_slideArr[index]);
			
			_slideArr[index].x = 1024 * index;
			_slideArr[index].disable();
			trace("[addSlide]" + index);
		}
		
		private function jumpHandler(e:MyEvent):void
		{
			rollTo(int(e.data));
		}
		
		private function destroySlide(index:int):void
		{
			
			if (_slideArr[index] == null)
				return;
			
			_slideArr[index].destroy();
			_slideArr[index] = null;
			
			trace("[destroySlide]" + index);
		}
		
		
		
		public function get currentIndex():int
		{
			var index:int = Math.round(_slideContainer.x / -1024);
			if (index > _slideClassArr.length-1)
			index = _slideClassArr.length-1 ; 
			if (index < 0)
			index = 0;
			
			return index;
		}
		
		public function get currentSlide():Slide
		{
			return _slideArr[currentIndex];
		}
		
		public function get isLocked():Boolean
		{
			return _slideArr[currentIndex].isLocked;
		}
		
		public function get leftRollAble():Boolean
		{
			
			if (_targetIndex == 0)
			return false;
			
			var rollAble:Boolean = !_slideArr[_targetIndex].isLocked && !_slideArr[_targetIndex - 1].isLocked;

			return  rollAble;
		}
		
		public function get rightRollAble():Boolean
		{
			if (_targetIndex == _slideClassArr.length-1)
			return false;
			
			var rollAble:Boolean = !_slideArr[_targetIndex].isLocked && !_slideArr[_targetIndex + 1].isLocked;

			return  rollAble;
		}
	
	}

}