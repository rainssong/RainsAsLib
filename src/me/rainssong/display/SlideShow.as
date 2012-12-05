package me.rainssong.display


{
	import com.greensock.TweenMax;
	import com.ObjectPool.ObjectPool;
	import flash.errors.IOError;
	import me.rainssong.events.SlideEvent;
	import me.rainssong.utils.superTrace;
	

	
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
	public class SlideShow extends MouseDragableSprite
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
		
		public function SlideShow(slideWidth:Number = 1024, slideHeight:Number = 768)
		{
			_slideWidth = slideWidth;
			_slideHeight = slideHeight;
			_slideContainer = new MySprite();
			_slideArr = new Array();
			addChild(_slideContainer);
		}
		
		override public function startDragging(stageX:Number,stageY:Number):void
		{
			super.startDragging(stageX, stageY);
			//这里判断锁
			if (isLocked)
			{
				trace("锁定");
				return;
			}
			
			mpoint.x = _slideContainer.x;
			mpoint.y = _slideContainer.y;
		}

		
		
		
		override public function stopDragging():void
		{
			super.stopDragging();
			
			if (_speedX < -50)
			rollNext();
			if (_speedX > 50)
			rollPrev();
			//if (_slideContainer.x != (speedX / 0.5 + _slideContainer.x) / -_slideWidth)
			//{
				//dispatchEvent(new Event(SWIPE_LEFT));
				//var result:int = Math.round((speedX / 0.5 + _slideContainer.x) / -_slideWidth);
				//if (result > _targetIndex)
				//{
					//rollNext();
				//}
				//else if (result < _targetIndex)
				//{
					//rollPrev();
				//}
				//else
				//{
					//rollTo(_targetIndex)
				//}
				//
			//}
			if (_speedY < -30 && Math.abs(_speedX)<25)
			{
				if (!isLocked)
					dispatchEvent(new MyEvent(SWIPE_UP));
			}
			_speedX = 0;
			_speedY = 0;
		}
		
		override public function onDragging():void 
		{
			super.onDragging();
				
				//忽略细微移动
				//if (_speedX ^ 0 != 0 && _slideContainer.mouseChildren)
				//{
					//_slideContainer.mouseChildren = _slideContainer.mouseEnabled = false;
				//}
				//
				//var targetX:int = mpoint.x + stage.mouseX - _startX;
				//
				//if (targetX < -_slideWidth*_targetIndex && !rightRollAble)
				//{
					//targetX = -_slideWidth * _targetIndex;
					//_speedX = 0;
					//
				//}
				//if (targetX > -_slideWidth*_targetIndex && !leftRollAble )
				//{
					//targetX = -_slideWidth * _targetIndex;
					//_speedX = 0;
				//}
				//
				//_slideContainer.x = targetX;
			
		}
		
		public function rollTo(index:int, time:Number = 0.5):void
		{
			//if (currentIndex == _targetIndex) return;
			//TweenMax.killTweensOf(_slideContainer);
			index = index < 0 ? 0 : index;
			index = index >= _slideContentArr.length ? _slideContentArr.length - 1 : index;
			trace("rollTo",index)
			_targetIndex = index;
			dispatchEvent(new SlideEvent(SlideEvent.START_ROLL));
			TweenMax.to(_slideContainer, time, {x: -_slideWidth * _targetIndex, onUpdate: rollUpdateHandler, onComplete: TweenXComplete, onCompleteParams: [index != currentIndex ? true : false]});
		}
		
		public function rollNext():void
		{
			rollTo(_targetIndex + 1);
		}
		
		public function rollPrev():void
		{
			
			rollTo(_targetIndex - 1);
		}
		
		private function TweenXComplete(isSwiped:Boolean = false):void
		{
			for (var i:int = 0; i < _slideContentArr.length; i++)
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
			for (var i:int = 0; i < _slideArr.length ; i++ )
			{
				destroySlide(i);
			}
			_slideArr = null;
			_slideContentArr = null;
			removeChild(_slideContainer);
			_slideContainer = null;
			
			super.destroy();
		}
		
		private function addSlide(index:int):void
		{
			if (_slideArr[index]!=null || index < 0 || index >= _slideContentArr.length)
				return;
			_slideArr[index] = new Slide(_slideContentArr[index]);
			_slideContainer.addChild(_slideArr[index]);
			//
			_slideArr[index].x = _slideWidth * index;
			_slideArr[index].disable();
			superTrace(index);
		}
		
		private function destroySlide(index:int):void
		{
			if (_slideArr[index] == null)
				return;
			
			_slideArr[index].destroy();
			_slideArr[index] = null;
			
			superTrace(index);
		}
		
		public function get currentIndex():int
		{
			var index:int = -Math.round(_slideContainer.x / _slideWidth);
			if (index > _slideContentArr.length-1)
			index = _slideContentArr.length-1 ; 
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
			
			var rollAble:Boolean = !_slideArr[_targetIndex].isLocked && _slideArr[_targetIndex].isLeftRollOutEnabled && _slideArr[_targetIndex-1].isRightRollInEnabled ;

			return  rollAble;
		}
		
		public function get rightRollAble():Boolean
		{
			if (_targetIndex == _slideContentArr.length-1)
			return false;
			
			var rollAble:Boolean = !_slideArr[_targetIndex].isLocked && _slideArr[_targetIndex].isRightRollOutEnabled && _slideArr[_targetIndex+1].isLeftRollInEnabled ;

			return  rollAble;
		}
		
		public function get slideContentArr():Array 
		{
			return _slideContentArr;
		}
		
		public function set slideContentArr(value:Array):void 
		{
			_slideContentArr = value;
			rollTo(_targetIndex, 0);
			superTrace("");
		}
	
	}

}