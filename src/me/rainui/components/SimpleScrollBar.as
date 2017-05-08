/*
Feathers
Copyright 2012-2015 Bowler Hat LLC. All Rights Reserved.

This program is free software. You can redistribute and/or modify it in
accordance with the terms of the accompanying license agreement.
*/
package me.rainui.components
{

	import com.greensock.motionPaths.Direction;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.geom.ColorTransform;
	import flash.geom.Point;
	import flash.utils.Timer;
	import me.rainssong.math.MathCore;
	import me.rainssong.utils.Directions;
	import me.rainssong.utils.Draw;



	[Event(name="change",type="starling.events.Event")]

	[Event(name="beginInteraction",type="starling.events.Event")]

	[Event(name="endInteraction",type="starling.events.Event")]

	public class SimpleScrollBar extends Container
	{
		/**
		 * @private
		 */
		private static const HELPER_POINT:Point = new Point();


		/**
		 * Constructor.
		 */
		public function SimpleScrollBar(dataSource:Object=null)
		{
			super(dataSource);
		}

		/**
		 * @private
		 */
		protected var thumbOriginalWidth:Number = NaN;

		/**
		 * @private
		 */
		protected var thumbOriginalHeight:Number = NaN;

		/**
		 * The thumb sub-component.
		 *
		 * <p>For internal use in subclasses.</p>
		 *
		 * @see #thumbFactory
		 * @see #createThumb()
		 */
		protected var thumb:Button;

		/**
		 * @private
		 */
		protected var track:Sprite;

		/**
		 * @private
		 */
		protected var _direction:String = Directions.HORIZONTAL;

		[Inspectable(type="String",enumeration="horizontal,vertical")]
		/**
		 * Determines if the scroll bar's thumb can be dragged horizontally or
		 * vertically. When this value changes, the scroll bar's width and
		 * height values do not change automatically.
		 *
		 * <p>In the following example, the direction is changed to vertical:</p>
		 *
		 * <listing version="3.0">
		 * scrollBar.direction = SimpleScrollBar.Directions.VERTICAL;</listing>
		 *
		 * @default SimpleScrollBar.DIRECTION_HORIZONTAL
		 *
		 * @see #DIRECTION_HORIZONTAL
		 * @see #Directions.VERTICAL
		 */
		public function get direction():String
		{
			return this._direction;
		}

		/**
		 * @private
		 */
		public function set direction(value:String):void
		{
			if(this._direction == value)
			{
				return;
			}
			this._direction = value;
			callLater(redraw);
		}

		/**
		 * Determines if the value should be clamped to the range between the
		 * minimum and maximum. If <code>false</code> and the value is outside of the range,
		 * the thumb will shrink as if the range were increasing.
		 *
		 * <p>In the following example, the clamping behavior is updated:</p>
		 *
		 * <listing version="3.0">
		 * scrollBar.clampToRange = true;</listing>
		 *
		 * @default false
		 */
		public var clampToRange:Boolean = false;

		/**
		 * @private
		 */
		protected var _value:Number = 0;

		/**
		 * @inheritDoc
		 * 内容位置
		 * @default 0
		 *
		 * @see #maximum
		 * @see #minimum
		 * @see #step
		 * @see #page
		 * @see #event:change
		 */
		public function get value():Number
		{
			return this._value;
		}

		/**
		 * @private
		 */
		public function set value(newValue:Number):void
		{
			if(this.clampToRange)
			{
				newValue = MathCore.getRangedNumber(newValue, this._minimum, this._maximum);
			}
			if(this._value == newValue)
			{
				return;
			}
			this._value = newValue;
			callLater(redraw);
			//if(this.liveDragging || !this.isDragging)
			//{
				//this.dispatchEventWith(Event.CHANGE);
			//}
		}

		/**
		 * @private
		 */
		protected var _minimum:Number = 0;

		/**
		 * @inheritDoc
		 *
		 * @default 0
		 *
		 * @see #value
		 * @see #maximum
		 */
		public function get minimum():Number
		{
			return this._minimum;
		}

		/**
		 * @private
		 */
		public function set minimum(value:Number):void
		{
			if(this._minimum == value)
			{
				return;
			}
			this._minimum = value;
			callLater(redraw);
		}

		/**
		 * @private
		 */
		protected var _maximum:Number = 100;

		/**
		 * @inheritDoc
		 *
		 * @default 0
		 *
		 * @see #value
		 * @see #minimum
		 */
		public function get maximum():Number
		{
			return this._maximum;
		}

		/**
		 * @private
		 */
		public function set maximum(value:Number):void
		{
			if(this._maximum == value)
			{
				return;
			}
			this._maximum = value;
			callLater(redraw);
		}

		/**
		 * @private
		 */
		protected var _step:Number = 0;

		/**
		 * @inheritDoc
		 *
		 * @default 0
		 *
		 * @see #value
		 * @see #page
		 */
		public function get step():Number
		{
			return this._step;
		}

		/**
		 * @private
		 */
		public function set step(value:Number):void
		{
			this._step = value;
		}

		/**
		 * @private
		 */
		protected var _page:Number = 50;

		/**
		 * @inheritDoc
		 * 内容长度
		 *
		 * @default 0
		 *
		 * @see #value
		 * @see #step
		 */
		public function get page():Number
		{
			return this._page;
		}

		/**
		 * @private
		 */
		public function set page(value:Number):void
		{
			if(this._page == value)
			{
				return;
			}
			this._page = value;
			callLater(redraw);
		}

		/**
		 * @private
		 */
		protected var currentRepeatAction:Function;

		/**
		 * @private
		 */
		protected var _repeatTimer:Timer;

		/**
		 * @private
		 */
		protected var _repeatDelay:Number = 0.05;

		/**
		 * The time, in seconds, before actions are repeated. The first repeat
		 * happens after a delay that is five times longer than the following
		 * repeats.
		 *
		 * <p>In the following example, the repeat delay is changed to 500 milliseconds:</p>
		 *
		 * <listing version="3.0">
		 * scrollBar.repeatDelay = 0.5;</listing>
		 *
		 * @default 0.05
		 */
		public function get repeatDelay():Number
		{
			return this._repeatDelay;
		}

		/**
		 * @private
		 */
		public function set repeatDelay(value:Number):void
		{
			if(this._repeatDelay == value)
			{
				return;
			}
			this._repeatDelay = value;
			callLater(redraw);
		}

		/**
		 * @private
		 */
		protected var isDragging:Boolean = false;

		/**
		 * Determines if the scroll bar dispatches the <code>Event.CHANGE</code>
		 * event every time the thumb moves, or only once it stops moving.
		 *
		 * <p>In the following example, live dragging is disabled:</p>
		 *
		 * <listing version="3.0">
		 * scrollBar.liveDragging = false;</listing>
		 *
		 * @default true
		 */
		public var liveDragging:Boolean = true;

		/**
		 * @private
		 */
		protected var _thumbFactory:Function;

		/**
		 * A function used to generate the scroll bar's thumb sub-component.
		 * The thumb must be an instance of <code>Button</code>. This factory
		 * can be used to change properties on the thumb when it is first
		 * created. For instance, if you are skinning Feathers components
		 * without a theme, you might use this factory to set skins and other
		 * styles on the thumb.
		 *
		 * <p>The function should have the following signature:</p>
		 * <pre>function():Button</pre>
		 *
		 * <p>In the following example, a custom thumb factory is passed
		 * to the scroll bar:</p>
		 *
		 * <listing version="3.0">
		 * scrollBar.thumbFactory = function():Button
		 * {
		 *     var thumb:Button = new Button();
		 *     thumb.defaultSkin = new Image( upTexture );
		 *     thumb.downSkin = new Image( downTexture );
		 *     return thumb;
		 * };</listing>
		 *
		 * @default null
		 *
		 * @see feathers.controls.Button
		 * @see #thumbProperties
		 */
		public function get thumbFactory():Function
		{
			return this._thumbFactory;
		}

		/**
		 * @private
		 */
		public function set thumbFactory(value:Function):void
		{
			if(this._thumbFactory == value)
			{
				return;
			}
			this._thumbFactory = value;
			callLater(redraw);
		}

		

		/**
		 * @private
		 */
		protected var _touchPointID:int = -1;

		/**
		 * @private
		 */
		protected var _touchStartX:Number = NaN;

		/**
		 * @private
		 */
		protected var _touchStartY:Number = NaN;

		/**
		 * @private
		 */
		protected var _thumbStartX:Number = NaN;

		/**
		 * @private
		 */
		protected var _thumbStartY:Number = NaN;

		/**
		 * @private
		 */
		protected var _touchValue:Number;


		
		override protected function createChildren():void 
		{
			this._width = 10;
			this._height = 10;
			
			
			if(!this.track)
			{
				this.track = Draw.getBoxSp(10, 10, 0xff00ff);
				this.track.alpha = 0;
				this.track.addEventListener(MouseEvent.MOUSE_DOWN, track_touchHandler);
				this.track.addEventListener(MouseEvent.MOUSE_UP, track_touchHandler);
				this.addChild(this.track);
			}
			if(this._value < this._minimum)
			{
				this.value = this._minimum;
			}
			else if(this._value > this._maximum)
			{
				this.value = this._maximum;
			}
			
			this.createThumb();
			//this.refreshThumbStyles();
			
			super.createChildren();
		}

		/**
		 * @private
		 */
		override public function redraw():void
		{


			this.thumb.disabled = !(!this._disabled && this._maximum > this._minimum);

			//sizeInvalid = this.autoSizeIfNeeded() || sizeInvalid;

			this.layout();
			
			super.redraw();
		}
		
		
		

		/**
		 * If the component's dimensions have not been set explicitly, it will
		 * measure its content and determine an ideal size for itself. If the
		 * <code>explicitWidth</code> or <code>explicitHeight</code> member
		 * variables are set, those value will be used without additional
		 * measurement. If one is set, but not the other, the dimension with the
		 * explicit value will not be measured, but the other non-explicit
		 * dimension will still need measurement.
		 *
		 * <p>Calls <code>setSizeInternal()</code> to set up the
		 * <code>actualWidth</code> and <code>displayHeight</code> member
		 * variables used for layout.</p>
		 *
		 * <p>Meant for internal use, and subclasses may override this function
		 * with a custom implementation.</p>
		 */
		//protected function autoSizeIfNeeded():Boolean
		//{
			//if(this.thumbOriginalWidth !== this.thumbOriginalWidth ||
				//this.thumbOriginalHeight !== this.thumbOriginalHeight) //isNaN
			//{
				//this.thumb.validate();
				//this.thumbOriginalWidth = this.thumb.width;
				//this.thumbOriginalHeight = this.thumb.height;
			//}
//
			//var needsWidth:Boolean = this.explicitWidth !== this.explicitWidth; //isNaN
			//var needsHeight:Boolean = this.explicitHeight !== this.explicitHeight; //isNaN
			//if(!needsWidth && !needsHeight)
			//{
				//return false;
			//}
//
			//var range:Number = this._maximum - this._minimum;
			//var adjustedPage:Number = this._page;
			//if(adjustedPage === 0)
			//{
				////fall back to using step!
				//adjustedPage = this._step;
			//}
			//if(adjustedPage > range)
			//{
				//adjustedPage = range;
			//}
			//var newWidth:Number = this.explicitWidth;
			//var newHeight:Number = this.explicitHeight;
			//if(needsWidth)
			//{
				//if(this._direction == Directions.VERTICAL)
				//{
					//newWidth = this.thumbOriginalWidth;
				//}
				//else //horizontal
				//{
					//if(adjustedPage === 0)
					//{
						//newWidth = this.thumbOriginalWidth;
					//}
					//else
					//{
						//newWidth = this.thumbOriginalWidth * range / adjustedPage;
						//if(newWidth < this.thumbOriginalWidth)
						//{
							//newWidth = this.thumbOriginalWidth;
						//}
					//}
				//}
				//newWidth += this._paddingLeft + this._paddingRight;
			//}
			//if(needsHeight)
			//{
				//if(this._direction == Directions.VERTICAL)
				//{
					//if(adjustedPage === 0)
					//{
						//newHeight = this.thumbOriginalHeight;
					//}
					//else
					//{
						//newHeight = this.thumbOriginalHeight * range / adjustedPage;
						//if(newHeight < this.thumbOriginalHeight)
						//{
							//newHeight = this.thumbOriginalHeight;
						//}
					//}
				//}
				//else //horizontal
				//{
					//newHeight = this.thumbOriginalHeight;
				//}
				//newHeight +=  + this._paddingBottom;
			//}
			//return this.setSizeInternal(newWidth, newHeight, false);
		//}

		/**
		 * Creates and adds the <code>thumb</code> sub-component and
		 * removes the old instance, if one exists.
		 *
		 * <p>Meant for internal use, and subclasses may override this function
		 * with a custom implementation.</p>
		 *
		 * @see #thumb
		 * @see #thumbFactory
		 * @see #customThumbStyleName
		 */
		protected function createThumb():void
		{
			if(this.thumb)
			{
				this.thumb.remove();
				this.thumb = null;
			}

			this.thumb = new Button
			this.thumb.normalSkin.transform.colorTransform = new ColorTransform(1,1,1,1,-255,-255,-255);
			this.thumb.alpha = 1;
			this.thumb.width = 10;
			this.thumb.height = 10;
			//this.thumb.addEventListener(TouchEvent.TOUCH, thumb_touchHandler);
			this.addChild(this.thumb);
		}


		/**
		 * @private
		 */
		protected function layout():void
		{
			this.track.width = this._width;
			this.track.height = this._height;

			/**
			 *  总距离
			 */
			var range:Number = this._maximum - this._minimum;
			this.thumb.visible = range > 0;
			if(!this.thumb.visible)
			{
				return;
			}

			//this will auto-size the thumb, if needed
			//this.thumb.validate();

			var contentWidth:Number = this.displayWidth;
			var contentHeight:Number = this.displayHeight;
			/**
			 * 当前位置
			 */
			var adjustedPage:Number = this._page;
			if(this._page == 0)
			{
				adjustedPage = this._step;
			}
			else if(adjustedPage > range)
			{
				adjustedPage = range;
			}
			var valueOffset:Number = 0;
			if(this._value < this._minimum)
			{
				valueOffset = (this._minimum - this._value);
			}
			if(this._value > this._maximum)
			{
				valueOffset = (this._value - this._maximum);
			}
			if(this._direction == Directions.VERTICAL)
			{
				this.thumb.width = this.thumbOriginalWidth;
				var thumbMinHeight:Number = this.thumb.minHeight > 0 ? this.thumb.minHeight : this.thumbOriginalHeight;
				var thumbHeight:Number = contentHeight * adjustedPage / range;
				//滚动条和Thumb高度差
				var heightOffset:Number = contentHeight - thumbHeight;
				if(heightOffset > thumbHeight)
				{
					heightOffset = thumbHeight;
				}
				heightOffset *=  valueOffset / (range * thumbHeight / contentHeight);
				thumbHeight -= heightOffset;
				if(thumbHeight < thumbMinHeight)
				{
					thumbHeight = thumbMinHeight;
				}
				this.thumb.height = thumbHeight;
				this.thumb.x = (this.displayWidth- this.thumb.width) / 2;
				var trackScrollableHeight:Number = contentHeight - this.thumb.height;
				var thumbY:Number = trackScrollableHeight * (this._value - this._minimum) / range;
				if(thumbY > trackScrollableHeight)
				{
					thumbY = trackScrollableHeight;
				}
				else if(thumbY < 0)
				{
					thumbY = 0;
				}
				this.thumb.y =  + thumbY;
			}
			else //horizontal
			{
				var thumbMinWidth:Number = this.thumb.minWidth > 0 ? this.thumb.minWidth : this.thumbOriginalWidth;
				var thumbWidth:Number = contentWidth * adjustedPage / range;
				var widthOffset:Number = contentWidth - thumbWidth;
				if(widthOffset > thumbWidth)
				{
					widthOffset = thumbWidth;
				}
				widthOffset *= valueOffset / (range * thumbWidth / contentWidth);
				thumbWidth -= widthOffset;
				if(thumbWidth < thumbMinWidth)
				{
					thumbWidth = thumbMinWidth;
				}
				this.thumb.width = thumbWidth;
				this.thumb.height = this.thumbOriginalHeight;
				var trackScrollableWidth:Number = contentWidth - this.thumb.width;
				var thumbX:Number = trackScrollableWidth * (this._value - this._minimum) / range;
				if(thumbX > trackScrollableWidth)
				{
					thumbX = trackScrollableWidth;
				}
				else if(thumbX < 0)
				{
					thumbX = 0;
				}
				this.thumb.x = + thumbX;
				this.thumb.y =  + (this.displayHeight  - this.thumb.height) / 2;
			}

			//final validation to avoid juggler next frame issues
			//this.thumb.validate();
		}

		/**
		 * @private
		 */
		protected function locationToValue(location:Point):Number
		{
			var percentage:Number = 0;
			if(this._direction == Directions.VERTICAL)
			{
				var trackScrollableHeight:Number = this.displayHeight - this.thumb.height;
				if(trackScrollableHeight > 0)
				{
					var yOffset:Number = location.y - this._touchStartY ;
					var yPosition:Number = Math.min(Math.max(0, this._thumbStartY + yOffset), trackScrollableHeight);
					percentage = yPosition / trackScrollableHeight;
				}
			}
			else //horizontal
			{
				var trackScrollableWidth:Number = this.displayWidth - this.thumb.width;
				if(trackScrollableWidth > 0)
				{
					var xOffset:Number = location.x - this._touchStartX;
					var xPosition:Number = Math.min(Math.max(0, this._thumbStartX + xOffset), trackScrollableWidth);
					percentage = xPosition / trackScrollableWidth;
				}
			}

			return this._minimum + percentage * (this._maximum - this._minimum);
		}

		/**
		 * @private
		 */
		protected function adjustPage():void
		{
			var range:Number = this._maximum - this._minimum;
			var adjustedPage:Number = this._page;
			if(adjustedPage === 0)
			{
				adjustedPage = this._step;
			}
			if(adjustedPage > range)
			{
				adjustedPage = range;
			}
			if(this._touchValue < this._value)
			{
				var newValue:Number = Math.max(this._touchValue, this._value - adjustedPage);
				if(this._step != 0 && newValue != this._maximum && newValue != this._minimum)
				{
					newValue = MathCore.round(newValue, this._step);
				}
				this.value = newValue;
			}
			else if(this._touchValue > this._value)
			{
				newValue = Math.min(this._touchValue, this._value + adjustedPage);
				if(this._step != 0 && newValue != this._maximum && newValue != this._minimum)
				{
					newValue = MathCore.round(newValue, this._step);
				}
				this.value = newValue;
			}
		}

		/**
		 * @private
		 */
		protected function startRepeatTimer(action:Function):void
		{
			this.currentRepeatAction = action;
			if(this._repeatDelay > 0)
			{
				if(!this._repeatTimer)
				{
					this._repeatTimer = new Timer(this._repeatDelay * 1000);
					this._repeatTimer.addEventListener(TimerEvent.TIMER, repeatTimer_timerHandler);
				}
				else
				{
					this._repeatTimer.reset();
					this._repeatTimer.delay = this._repeatDelay * 1000;
				}
				this._repeatTimer.start();
			}
		}

		
		override public function remove():void 
		{
			this._touchPointID = -1;
			if(this._repeatTimer)
			{
				this._repeatTimer.stop();
			}
			super.remove();
		}

		/**
		 * @private
		 */
		protected function track_touchHandler(event:MouseEvent):void
		{
			//if(!this._isEnabled)
			//{
				//this._touchPointID = -1;
				//return;
			//}
//
			//if(this._touchPointID >= 0)
			//{
				//var touch:Touch = event.getTouch(this.track, TouchPhase.ENDED, this._touchPointID);
				//if(!touch)
				//{
					//return;
				//}
				//this._touchPointID = -1;
				//this._repeatTimer.stop();
			//}
			//else
			//{
				//touch = event.getTouch(this.track, TouchPhase.BEGAN);
				//if(!touch)
				//{
					//return;
				//}
				//this._touchPointID = touch.id;
				//touch.getLocation(this, HELPER_POINT);
				//this._touchStartX = HELPER_POINT.x;
				//this._touchStartY = HELPER_POINT.y;
				//this._thumbStartX = HELPER_POINT.x;
				//this._thumbStartY = HELPER_POINT.y;
				//this._touchValue = this.locationToValue(HELPER_POINT);
				//this.adjustPage();
				//this.startRepeatTimer(this.adjustPage);
			//}
		}

		/**
		 * @private
		 */
		protected function thumb_touchHandler(event:MouseEvent):void
		{

//
//
				//if(touch.phase == MouseEvent.MOUSE_MOVE)
				//{
					//touch.getLocation(this, HELPER_POINT);
					//var newValue:Number = this.locationToValue(HELPER_POINT);
					//if(this._step != 0 && newValue != this._maximum && newValue != this._minimum)
					//{
						//newValue = MathCore.round(newValue, this._step);
					//}
					//this.value = newValue;
				//}
				//else if(touch.phase == TouchPhase.ENDED)
				//{
					//this._touchPointID = -1;
					//this.isDragging = false;
					//if(!this.liveDragging)
					//{
						//this.dispatchEventWith(Event.CHANGE);
					//}
					//this.dispatchEventWith(FeathersEventType.END_INTERACTION);
				//}
			//}
			//else
			//{
				//touch = event.getTouch(this.thumb, TouchPhase.BEGAN);
				//if(!touch)
				//{
					//return;
				//}
				//touch.getLocation(this, HELPER_POINT);
				//this._touchPointID = touch.id;
				//this._thumbStartX = this.thumb.x;
				//this._thumbStartY = this.thumb.y;
				//this._touchStartX = HELPER_POINT.x;
				//this._touchStartY = HELPER_POINT.y;
				//this.isDragging = true;
				//this.dispatchEventWith(FeathersEventType.BEGIN_INTERACTION);
			//}
		}

		/**
		 * @private
		 */
		protected function repeatTimer_timerHandler(event:TimerEvent):void
		{
			if(this._repeatTimer.currentCount < 5)
			{
				return;
			}
			this.currentRepeatAction();
		}
	}
}
