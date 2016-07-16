package me.rainssong.rainSlideShow

{
	import com.greensock.TweenMax;
	import flash.display.Shape;
	import flash.errors.IOError;
	import flash.geom.Rectangle;
	import me.rainssong.display.MouseDragableSprite;
	import me.rainssong.events.DataEvent;
	import me.rainssong.events.SlideEvent;
	import me.rainssong.utils.superTrace;
	
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
	public class RainSlideShow extends MouseDragableSprite
	{
		static public const SWIPE_UP:String = "swipeUp";
		static public const SWIPE_COMPLETE:String = "swipeComplete";
		static public const NEXT:String = "next";
		
		private var _slideContentArr:Array;
		private var _targetIndex:int = 0;
		private var _slideContainer:MySprite;
		private var _slideArr:Array;
		private var mpoint:Point = new Point();
		private var isDrag:Boolean = false;
		
		private var _slideWidth:Number;
		private var _slideHeight:Number;
		
		private var _mask:Shape
		
		//不允许删除当前页
		public function RainSlideShow(slideWidth:Number = 1024, slideHeight:Number = 768)
		{
			_slideWidth = slideWidth;
			_slideHeight = slideHeight;
			super();
		
		}
		
		override protected function onRegister():void
		{
			super.onRegister();
			
			_slideContainer = new MySprite();
			_slideArr = new Array();
			addChild(_slideContainer);
			
			_slideContainer.addEventListener(SlideEvent.ROLL_NEXT, rollNext);
			_slideContainer.addEventListener(SlideEvent.ROLL_PREV, rollPrev);
			_slideContainer.addEventListener(SlideEvent.ROLL_TO, onRollTo);
			_slideContainer.addEventListener(SlideEvent.PUSH_SLIDE, onPushSlide);
		}
		
		private function onRollTo(e:SlideEvent):void
		{
			rollTo(e.data);
		}
		
		private function onPushSlide(e:SlideEvent):void
		{
			_slideContentArr = _slideContentArr.concat(e.data as Array);
			rollTo(currentIndex);
		}
		
		override public function startDragging(stageX:Number, stageY:Number):void
		{
			
			//这里判断锁
			if (isLocked)
			{
				trace("锁定");
				
				return;
			}
			super.startDragging(stageX, stageY);
			mpoint.x = _slideContainer.x;
			mpoint.y = _slideContainer.y;
		}
		
		override public function stopDragging():void
		{
			
			super.stopDragging();
			
			//if (_slideContainer.x - mpoint.x != 0)
				if (_speedX * 10 + (stage.mouseX - _startX) < -_slideWidth / 2)
					rollNext();
				else if (_speedX * 10 + (stage.mouseX - _startX) > _slideWidth / 2)
					rollPrev();
				else
					rollTo(_targetIndex);
			
			if (_speedY < -30 && Math.abs(_speedX) < 25)
			{
				
				dispatchEvent(new DataEvent(SWIPE_UP));
			}
			_speedX = 0;
			_speedY = 0;
		}
		
		override public function onDragging():void
		{
			super.onDragging();
			
			//拖动超过
			if (_slideContainer.x - mpoint.x > 5 && _slideContainer.mouseChildren)
			{
				_slideContainer.mouseChildren = _slideContainer.mouseEnabled = false;
			}
			//else
			//{
			//
			//}
			
			var targetX:int = mpoint.x + stage.mouseX - _startX;
			
			if (targetX < -_slideWidth * _targetIndex && !rightRollAble)
			{
				targetX = -_slideWidth * _targetIndex;
					//_speedX = 0;
			}
			if (targetX > -_slideWidth * _targetIndex && !leftRollAble)
			{
				targetX = -_slideWidth * _targetIndex;
					//_speedX = 0;
			}
			
			_slideContainer.x = targetX;
		
		}
		
		public function rollTo(index:int, time:Number = 0.5):void
		{
			//if (currentIndex == _targetIndex) return;
			//TweenMax.killTweensOf(_slideContainer);
			
			if (index < 0)
			{
				index = 0;
				if (!isLocked)
					dispatchEvent(new SlideEvent(SlideEvent.ALREADY_FIRST_PAGE, null, true));
			}
			if (index >= _slideContentArr.length)
			{
				index = _slideContentArr.length - 1;
				if (!isLocked)
					dispatchEvent(new SlideEvent(SlideEvent.ALREADY_LAST_PAGE, null, true));
			}
			
			//index = index >= _slideContentArr.length ? _slideContentArr.length - 1 : index;
			trace("rollTo", index)
			_targetIndex = index;
			dispatchEvent(new SlideEvent(SlideEvent.START_ROLL));
			TweenMax.to(_slideContainer, time, {x: -_slideWidth * _targetIndex, onUpdate: rollUpdateHandler, onComplete: TweenXComplete, onCompleteParams: [index != currentIndex ? true : false]});
		}
		
		public function rollNext(e:SlideEvent = null):void
		{
			rollTo(_targetIndex + 1);
		}
		
		public function rollPrev(e:SlideEvent = null):void
		{
			
			rollTo(_targetIndex - 1);
		}
		
		protected function TweenXComplete(isSwiped:Boolean = false):void
		{
			for (var i:int = 0; i < _slideContentArr.length; i++)
			{
				if (i == currentIndex && !_slideArr[i].isEnable)
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
			//destroySlide(currentIndex + 2);
			//destroySlide(currentIndex - 2);
			//addSlide(currentIndex);
			//addSlide(currentIndex + 1);
			//addSlide(currentIndex - 1);
			
			for (var i:int = 0; i < _slideContentArr.length; i++)
			{
				if (i == currentIndex || i == currentIndex + 1 || i == currentIndex - 1)
					addSlide(i);
				else
					destroySlide(i);
			}
			dispatchEvent(new SlideEvent(SlideEvent.ROLLING));
		
		}
		
		public function refreash():void
		{
			for (var i:int = 0; i < _slideContentArr.length; i++)
			{
				destroySlide(i);
			}
			
			if (_slideContentArr.length == 0)
			return;
			//destroySlide(currentIndex + 1);
			//destroySlide(currentIndex - 1);
			//destroySlide(currentIndex);
			addSlide(currentIndex);
			slideArr[currentIndex].enable();
			addSlide(currentIndex + 1);
			addSlide(currentIndex - 1);
		}
		
		private function updateSlide(index:int):void
		{
			//if (index < 0 || index >= _slideContentArr.length)
			//return;
			
			if (!_slideArr[index])
			{
				_slideArr[index] = new RainSlide();
				_slideContainer.addChild(_slideArr[index]);
				_slideArr[index].x = _slideWidth * index;
			}
			
			var point:Point = _slideArr[index].parent.localToGlobal(new Point(_slideArr[index].x, _slideArr[index].y));
			if ((point.x <= -_slideWidth * 2 || point.x >= _slideWidth * 2))
			{
				if (_slideArr[index].hasContent)
					_slideArr[index].unload();
			}
			else
			{
				if (!_slideArr[index].hasContent && _slideContentArr[index])
				{
					_slideArr[index].reload(_slideContentArr[index]);
					powerTrace("读取资源:" + _slideContentArr[index])
					
				}
			}
		}
		
		private function moveSlide(index:int):void
		{
			if (_slideArr[index] == null)
				return;
			
			var point:Point = _slideArr[index].parent.localToGlobal(new Point(_slideArr[index].x, _slideArr[index].y));
			if (point.x < -_slideWidth)
			{
				_slideArr[index].x = _slideWidth * (currentIndex + 2);
				_slideArr[currentIndex + 2] = _slideArr[index];
				_slideArr[index].unload();
				_slideArr[index] = null;
			}
			if (point.x > _slideWidth)
			{
				_slideArr[index].x = _slideWidth * (currentIndex - 2);
				_slideArr[currentIndex - 2] = _slideArr[index];
				_slideArr[index].unload()
				_slideArr[index] = null;
			}
			//
		
			//if (index == 1)
			//{
			//superTrace("moveSlide2",_slideArr[index].x);
			//}
		}
		
		//public function load(slideContentArr:Array):void
		//{
		//_slideContentArr = slideClassArr;
		//_slideArr = new Array(_slideContentArr.length);
		//
		//rollTo(_targetIndex,0);
		//
		//_slideArr[_targetIndex].enable();
		//
		//dispatchEvent(new Event(SlideShow.SWIPE_COMPLETE));
		//}
		
		override public function destroy():void
		{
			for (var i:int = 0; i < _slideArr.length; i++)
			{
				destroySlide(i);
			}
			_slideArr = null;
			TweenMax.killTweensOf(_slideContainer);
			_slideContentArr = null;
			removeChild(_slideContainer);
			_slideContainer = null;
			
			super.destroy();
		}
		
		protected function addSlide(index:int):void
		{
			if (_slideArr[index] != null || index < 0 || index >= _slideContentArr.length)
				return;
			//var point:Point = _slideArr[index].localToGlobal(new Point(_slideArr[index].x, _slideArr[index].y));
			
			if (_slideContentArr[index] is Class && (new _slideContentArr[index]()) is RainSlide)
				_slideArr[index] = new _slideContentArr[index]();
			else
				_slideArr[index] = new RainSlide(_slideContentArr[index],_slideWidth,_slideHeight);
			
			_slideContainer.addChild(_slideArr[index]);
			//
			
			_slideArr[index].x = _slideWidth * index;
			_slideArr[index].disable();
			
			//_slideArr[index].addEventListener(MouseEvent.CLICK,onSlideClick)
			
			//var _mask:Shape = new Shape();
			//_mask.graphics.beginFill(0xFFFFFF,0);
			//_mask.graphics.drawRect(0, 0, _slideWidth, _slideHeight);
			//_slideArr[index].addChild(_mask);
			//_slideArr[index].mask = _mask;
			_slideArr[index].scrollRect = new Rectangle(0, 0, _slideWidth, _slideHeight);
		
		}
		
		protected function destroySlide(index:int):void
		{
			if (_slideArr[index] == null)
				return;
			
			_slideContainer.removeChild(_slideArr[index]);
			_slideArr[index].destroy();
			_slideArr[index] = null;
		}
		
		public function get numOfSlide():int
		{
			return slideContentArr.length;
		}
		
		public function get currentIndex():int
		{
			var index:int = -Math.round(_slideContainer.x / _slideWidth);
			if (index > slideContentArr.length - 1)
				index = slideContentArr.length - 1;
			if (index < 0)
				index = 0;
			
			return index;
		}
		
		public function get currentSlide():RainSlide
		{
			return _slideArr[currentIndex];
		}
		
		public function get isLocked():Boolean
		{
			return _slideArr[currentIndex].isLocked;
		}
		
		public function get leftRollAble():Boolean
		{
			
			if (_targetIndex == 0 || !_slideArr[_targetIndex] || !_slideArr[_targetIndex - 1])
				return false;
			
			var rollAble:Boolean = !_slideArr[_targetIndex].isLocked && _slideArr[_targetIndex].isLeftRollOutEnabled && _slideArr[_targetIndex - 1].isRightRollInEnabled;
			
			return rollAble;
		}
		
		public function get rightRollAble():Boolean
		{
			if (_targetIndex == _slideContentArr.length - 1 || !_slideArr.length || !_slideArr[_targetIndex] || !_slideArr[_targetIndex + 1])
				return false;
			
			var rollAble:Boolean = !_slideArr[_targetIndex].isLocked && _slideArr[_targetIndex].isRightRollOutEnabled && _slideArr[_targetIndex + 1].isLeftRollInEnabled;
			
			return rollAble;
		}
		
		public function get slideContentArr():Array
		{
			_slideContentArr ||= [];
			return _slideContentArr;
		}
		
		public function set slideContentArr(value:Array):void
		{
			
			_slideContentArr = value;
			refreash();
			
			if (_targetIndex > _slideContentArr.length - 1)
				_targetIndex = _slideContentArr.length - 1;
			
			rollTo(_targetIndex, 0.5);
			powerTrace("更新ContentArr");
		}
		
		public function get slideArr():Array
		{
			return _slideArr;
		}
		
		public function get targetIndex():int 
		{
			return _targetIndex;
		}
	
	}

}