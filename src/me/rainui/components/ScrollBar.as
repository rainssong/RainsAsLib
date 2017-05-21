/*
Feathers
Copyright 2012-2015 Bowler Hat LLC. All Rights Reserved.

This program is free software. You can redistribute and/or modify it in
accordance with the terms of the accompanying license agreement.
*/
package me.rainui.components
{
	import feathers.utils.math.clamp;
	import feathers.utils.math.roundToNearest;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import me.rainssong.math.MathCore;
	import me.rainssong.utils.Directions;
	import me.rainssong.utils.Draw;
	import me.rainui.RainUI;

	import flash.events.TimerEvent;
	import flash.geom.Point;
	import flash.utils.Timer;

	import starling.display.DisplayObject;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;


	[Event(name="change",type="flash.events.Event")]


	//[Event(name="beginInteraction",type="flash.events.Event")]

	//[Event(name="endInteraction",type="starling.events.Event")]

	public class ScrollBar extends Component
	{
		/**
		 * @private
		 */
		private static const HELPER_POINT:Point = new Point();

		public static const TRACK_LAYOUT_MODE_SINGLE:String = "single";

		/**
		 * The scroll bar has two tracks, stretching to fill each side of the
		 * scroll bar with the thumb in the middle. The tracks will be resized
		 * as the thumb moves. This layout mode is designed for scroll bars
		 * where the two sides of the track may be colored differently to show
		 * the value "filling up" as the thumb is dragged or to highlight the
		 * track when it is triggered to scroll by a page instead of a step.
		 *
		 * <p>Since the width and height of the tracks will change, consider
		 * using a special display object such as a <code>Scale9Image</code>,
		 * <code>Scale3Image</code> or a <code>TiledImage</code> that is
		 * designed to be resized dynamically.</p>
		 *
		 * @see #trackLayoutMode
		 * @see feathers.display.Scale9Image
		 * @see feathers.display.Scale3Image
		 * @see feathers.display.TiledImage
		 */
		public static const TRACK_LAYOUT_MODE_MIN_MAX:String = "minMax";

		/**
		 * The default value added to the <code>styleNameList</code> of the minimum
		 * track.
		 *
		 * @see feathers.core.FeathersControl#styleNameList
		 */
		public static const DEFAULT_CHILD_STYLE_NAME_MINIMUM_TRACK:String = "feathers-scroll-bar-minimum-track";

		/**
		 * The default value added to the <code>styleNameList</code> of the maximum
		 * track.
		 *
		 * @see feathers.core.FeathersControl#styleNameList
		 */
		public static const DEFAULT_CHILD_STYLE_NAME_MAXIMUM_TRACK:String = "feathers-scroll-bar-maximum-track";

		/**
		 * The default value added to the <code>styleNameList</code> of the thumb.
		 *
		 * @see feathers.core.FeathersControl#styleNameList
		 */
		public static const DEFAULT_CHILD_STYLE_NAME_THUMB:String = "feathers-scroll-bar-thumb";

		/**
		 * The default value added to the <code>styleNameList</code> of the decrement
		 * button.
		 *
		 * @see feathers.core.FeathersControl#styleNameList
		 */
		public static const DEFAULT_CHILD_STYLE_NAME_DECREMENT_BUTTON:String = "feathers-scroll-bar-decrement-button";

		/**
		 * The default value added to the <code>styleNameList</code> of the increment
		 * button.
		 *
		 * @see feathers.core.FeathersControl#styleNameList
		 */
		public static const DEFAULT_CHILD_STYLE_NAME_INCREMENT_BUTTON:String = "feathers-scroll-bar-increment-button";

		/**
		 * The default <code>IStyleProvider</code> for all <code>ScrollBar</code>
		 * components.
		 *
		 * @default null
		 * @see feathers.core.FeathersControl#styleProvider
		 */
		//public static var globalStyleProvider:IStyleProvider;

		/**
		 * @private
		 */
		protected static function defaultThumbFactory():Button
		{
			return new Button();
		}

		/**
		 * @private
		 */
		protected static function defaultMinimumTrackFactory():Button
		{
			return new Button();
		}

		/**
		 * @private
		 */
		protected static function defaultMaximumTrackFactory():Button
		{
			return new Button();
		}

		/**
		 * @private
		 */
		protected static function defaultDecrementButtonFactory():Button
		{
			return new Button();
		}

		/**
		 * @private
		 */
		protected static function defaultIncrementButtonFactory():Button
		{
			return new Button();
		}

		/**
		 * Constructor.
		 */
		public function ScrollBar(dataSource:Object)
		{
			super(dataSource);
		}

		/**
		 * The scroll bar's decrement button sub-component.
		 *
		 * <p>For internal use in subclasses.</p>
		 *
		 * @see #decrementButtonFactory
		 * @see #createDecrementButton()
		 */
		protected var decrementButton:Button;

		/**
		 * The scroll bar's increment button sub-component.
		 *
		 * <p>For internal use in subclasses.</p>
		 *
		 * @see #incrementButtonFactory
		 * @see #createIncrementButton()
		 */
		protected var incrementButton:Button;

		/**
		 * The scroll bar's thumb sub-component.
		 *
		 * <p>For internal use in subclasses.</p>
		 *
		 * @see #thumbFactory
		 * @see #createThumb()
		 */
		protected var thumb:Button;
		protected var track:Sprite;

		/**
		 * The scroll bar's minimum track sub-component.
		 *
		 * <p>For internal use in subclasses.</p>
		 *
		 * @see #minimumTrackFactory
		 * @see #createMinimumTrack()
		 */
		protected var minimumTrack:Button;

		/**
		 * The scroll bar's maximum track sub-component.
		 *
		 * <p>For internal use in subclasses.</p>
		 *
		 * @see #maximumTrackFactory
		 * @see #createMaximumTrack()
		 */
		protected var maximumTrack:Button;

		/**
		 * @private
		 */
		//protected function get defaultStyleFactory():Function
		//{
			//return ScrollBar.defaultStyleFactory;
		//}

		/**
		 * @private
		 */
		protected var _direction:String = Directions.HORIZONTAL;

		[Inspectable(type="String",enumeration="horizontal,vertical")]
		public function get direction():String
		{
			return this._direction;
		}

		/**
		 * @private
		 */
		public function set direction(value:String):void
		{
			if(this._direction != value)
			{
				this._direction = value;
				callLater(redraw);
			}
		}

		/**
		 * @private
		 */
		protected var _value:Number = 0;

		/**
		 * @inheritDoc
		 *
		 * @default 0
		 *
		 * @see #minimum
		 * @see #maximum
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
			newValue = MathCore.getRangedNumber(newValue, this._minimum, this._maximum);
			if(this._value == newValue)
			{
				return;
			}
			this._value = newValue;
			callLater(redraw);
			if(this.liveDragging || !this.isDragging)
			{
				this.sendEvent(Event.CHANGE);
			}
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
		protected var _maximum:Number = 10;

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
		protected var _page:Number = 0;

		/**
		 * @inheritDoc
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
			callLater(redraw)
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
		public var thumbOriginalHeight:Number=40;
		public var thumbOriginalWidth:Number=40;

		/**
		 * @private
		 */
		protected var _trackLayoutMode:String = TRACK_LAYOUT_MODE_SINGLE;

		[Inspectable(type="String",enumeration="single,minMax")]
		/**
		 * Determines how the minimum and maximum track skins are positioned and
		 * sized.
		 *
		 * <p>In the following example, the scroll bar is given two tracks:</p>
		 *
		 * <listing version="3.0">
		 * scrollBar.trackLayoutMode = ScrollBar.TRACK_LAYOUT_MODE_MIN_MAX;</listing>
		 *
		 * @default ScrollBar.TRACK_LAYOUT_MODE_SINGLE
		 *
		 * @see #TRACK_LAYOUT_MODE_SINGLE
		 * @see #TRACK_LAYOUT_MODE_MIN_MAX
		 */
		public function get trackLayoutMode():String
		{
			return this._trackLayoutMode;
		}

		/**
		 * @private
		 */
		public function set trackLayoutMode(value:String):void
		{
			if(this._trackLayoutMode == value)
			{
				return;
			}
			this._trackLayoutMode = value;
			callLater(redraw)
		}


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

		/**
		 * @private
		 */
		override protected function initialize():void
		{
			if(this._value < this._minimum)
			{
				this.value = this._minimum;
			}
			else if(this._value > this._maximum)
			{
				this.value = this._maximum;
			}
		}

		/**
		 * @private
		 */
		override protected function createChildren():void
		{
			
			this.createThumb();
			
			
			this.createMinimumTrack();
			this.createMaximumTrack();
				
			this.createDecrementButton();
			this.createIncrementButton();

			
			if(!this.track)
			{
				this.track = Draw.getBoxSp(10, 10, 0xff00ff);
				this.track.alpha = 0;
				//this.track.addEventListener(MouseEvent.MOUSE_DOWN, track_touchHandler);
				//this.track.addEventListener(MouseEvent.MOUSE_UP, track_touchHandler);
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

			//this.layout();
			
			super.createChildren();
		}
		
		override public function redraw():void 
		{
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
		 * <code>displayWidth</code> and <code>displayHeight</code> member
		 * variables used for layout.</p>
		 *
		 * <p>Meant for internal use, and subclasses may override this function
		 * with a custom implementation.</p>
		 */
		//protected function autoSizeIfNeeded():Boolean
		//{
			//if(this.minimumTrackOriginalWidth !== this.minimumTrackOriginalWidth || //isNaN
				//this.minimumTrackOriginalHeight !== this.minimumTrackOriginalHeight) //isNaN
			//{
				//this.minimumTrack.validate();
				//this.minimumTrackOriginalWidth = this.minimumTrack.width;
				//this.minimumTrackOriginalHeight = this.minimumTrack.height;
			//}
			//if(this.maximumTrack)
			//{
				//if(this.maximumTrackOriginalWidth !== this.maximumTrackOriginalWidth || //isNaN
					//this.maximumTrackOriginalHeight !== this.maximumTrackOriginalHeight) //isNaN
				//{
					//this.maximumTrack.validate();
					//this.maximumTrackOriginalWidth = this.maximumTrack.width;
					//this.maximumTrackOriginalHeight = this.maximumTrack.height;
				//}
			//}
			//if(this.thumbOriginalWidth !== this.thumbOriginalWidth || //isNaN
				//this.thumbOriginalHeight !== this.thumbOriginalHeight) //isNaN
			//{
				//this.thumb.validate();
				//this.thumbOriginalWidth = this.thumb.width;
				//this.thumbOriginalHeight = this.thumb.height;
			//}
			//this.decrementButton.validate();
			//this.incrementButton.validate();
//
			//var needsWidth:Boolean = this.explicitWidth !== this.explicitWidth; //isNaN
			//var needsHeight:Boolean = this.explicitHeight !== this.explicitHeight; //isNaN
			//if(!needsWidth && !needsHeight)
			//{
				//return false;
			//}
//
			//var newWidth:Number = this.explicitWidth;
			//var newHeight:Number = this.explicitHeight;
			//if(needsWidth)
			//{
				//if(this._direction == Directions.VERTICAL)
				//{
					//if(this.maximumTrack)
					//{
						//newWidth = Math.max(this.minimumTrackOriginalWidth, this.maximumTrackOriginalWidth);
					//}
					//else
					//{
						//newWidth = this.minimumTrackOriginalWidth;
					//}
				//}
				//else //horizontal
				//{
					//if(this.maximumTrack)
					//{
						//newWidth = Math.min(this.minimumTrackOriginalWidth, this.maximumTrackOriginalWidth) + this.thumb.width / 2;
					//}
					//else
					//{
						//newWidth = this.minimumTrackOriginalWidth;
					//}
					//newWidth += this.incrementButton.width + this.decrementButton.width;
				//}
			//}
			//if(needsHeight)
			//{
				//if(this._direction == Directions.VERTICAL)
				//{
					//if(this.maximumTrack)
					//{
						//newHeight = Math.min(this.minimumTrackOriginalHeight, this.maximumTrackOriginalHeight) + this.thumb.height / 2;
					//}
					//else
					//{
						//newHeight = this.minimumTrackOriginalHeight;
					//}
					//newHeight += this.incrementButton.height + this.decrementButton.height;
				//}
				//else //horizontal
				//{
					//if(this.maximumTrack)
					//{
						//newHeight = Math.max(this.minimumTrackOriginalHeight, this.maximumTrackOriginalHeight);
					//}
					//else
					//{
						//newHeight = this.minimumTrackOriginalHeight;
					//}
				//}
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
				this.thumb.removeFromParent(true);
				this.thumb = null;
			}


			this.thumb = new Button
			
			this.thumb.isFocusEnabled = false;
			//this.thumb.addEventListener(MouseEvent.CLICK,onClick);
			this.addChild(this.thumb);
		}

		/**
		 * Creates and adds the <code>minimumTrack</code> sub-component and
		 * removes the old instance, if one exists.
		 *
		 * <p>Meant for internal use, and subclasses may override this function
		 * with a custom implementation.</p>
		 *
		 * @see #minimumTrack
		 * @see #minimumTrackFactory
		 * @see #customMinimumTrackStyleName
		 */
		protected function createMinimumTrack():void
		{
			if(this.minimumTrack)
			{
				this.minimumTrack.remove();
				this.minimumTrack = null;
			}

			//var factory:Function = this._minimumTrackFactory != null ? this._minimumTrackFactory : defaultMinimumTrackFactory;
			//var minimumTrackStyleName:String = this._customMinimumTrackStyleName != null ? this._customMinimumTrackStyleName : this.minimumTrackStyleName;
			this.minimumTrack =new Button()
			//this.minimumTrack.styleNameList.add(minimumTrackStyleName);
			//this.minimumTrack.keepDownStateOnRollOut = true;
			this.minimumTrack.tabEnabled = false;
			//this.minimumTrack.addEventListener(TouchEvent.TOUCH, track_touchHandler);
			this.addChildAt(this.minimumTrack, 0);
		}

		/**
		 * Creates and adds the <code>maximumTrack</code> sub-component and
		 * removes the old instance, if one exists. If the maximum track is not
		 * needed, it will not be created.
		 *
		 * <p>Meant for internal use, and subclasses may override this function
		 * with a custom implementation.</p>
		 *
		 * @see #maximumTrack
		 * @see #maximumTrackFactory
		 * @see #customMaximumTrackStyleName
		 */
		protected function createMaximumTrack():void
		{
			if(this.maximumTrack)
			{
				this.maximumTrack.removeFromParent(true);
				this.maximumTrack = null;
			}
			//var factory:Function = this._maximumTrackFactory != null ? this._maximumTrackFactory : defaultMaximumTrackFactory;
			//var maximumTrackStyleName:String = this._customMaximumTrackStyleName != null ? this._customMaximumTrackStyleName : this.maximumTrackStyleName;
			//this.maximumTrack = Button(factory());
			this.maximumTrack = new Button
			//this.maximumTrack.styleNameList.add(maximumTrackStyleName);
			this.maximumTrack.keepDownStateOnRollOut = true;
			this.maximumTrack.tabEnabled = false;
			//this.maximumTrack.addEventListener(TouchEvent.TOUCH, track_touchHandler);
			this.addChildAt(this.maximumTrack, 1);
			
		}

		/**
		 * Creates and adds the <code>decrementButton</code> sub-component and
		 * removes the old instance, if one exists.
		 *
		 * <p>Meant for internal use, and subclasses may override this function
		 * with a custom implementation.</p>
		 *
		 * @see #decrementButton
		 * @see #decrementButtonFactory
		 * @see #customDecremenButtonStyleName
		 */
		protected function createDecrementButton():void
		{
			if(this.decrementButton)
			{
				this.decrementButton.removeFromParent(true);
				this.decrementButton = null;
			}

			
			this.decrementButton = new Button
			//this.decrementButton.addEventListener(TouchEvent.TOUCH, decrementButton_touchHandler);
			this.addChild(this.decrementButton);
		}

		/**
		 * Creates and adds the <code>incrementButton</code> sub-component and
		 * removes the old instance, if one exists.
		 *
		 * <p>Meant for internal use, and subclasses may override this function
		 * with a custom implementation.</p>
		 *
		 * @see #incrementButton
		 * @see #incrementButtonFactory
		 * @see #customIncrementButtonStyleName
		 */
		protected function createIncrementButton():void
		{
			if(this.incrementButton)
			{
				this.incrementButton.removeFromParent(true);
				this.incrementButton = null;
			}

			
			this.incrementButton = new Button
			//this.incrementButton.addEventListener(TouchEvent.TOUCH, incrementButton_touchHandler);
			this.addChild(this.incrementButton);
		}

		/**
		 * @private
		 */
		//protected function refreshThumbStyles():void
		//{
			//for(var propertyName:String in this._thumbProperties)
			//{
				//var propertyValue:Object = this._thumbProperties[propertyName];
				//this.thumb[propertyName] = propertyValue;
			//}
		//}


		/**
		 * @private
		 */
		protected function layout():void
		{
			//this.layoutStepButtons();
			//this.layoutThumb();
			
			this.track.width = this.displayWidth;
			this.track.height = this.displayHeight;

			var range:Number = this._maximum - this._minimum;
			
			this.thumb.visible = range > 0;
			if(!this.thumb.visible)
			{
				return;
			}

			//this will auto-size the thumb, if needed
			//this.thumb.validate();

			var contentWidth:Number = this.displayWidth ;
			var contentHeight:Number = this.displayHeight ;
			
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
				this.thumb.x = + (this.displayWidth  - this.thumb.width) / 2;
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
				this.thumb.y = thumbY;
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
				this.thumb.x =+ thumbX;
				this.thumb.y =  (this.displayHeight  - this.thumb.height) / 2;
			}

			//final validation to avoid juggler next frame issues
			//this.thumb.validate();
		}

		/**
		 * @private
		 */
		protected function layoutStepButtons():void
		{
			if(this._direction == Directions.VERTICAL)
			{
				this.decrementButton.x = (this.width - this.decrementButton.width) / 2;
				this.decrementButton.y = 0;
				this.incrementButton.x = (this.width - this.incrementButton.width) / 2;
				this.incrementButton.y = this.height - this.incrementButton.height;
			}
			else
			{
				this.decrementButton.x = 0;
				this.decrementButton.y = (this.height - this.decrementButton.height) / 2;
				this.incrementButton.x = this.width - this.incrementButton.width;
				this.incrementButton.y = (this.height - this.incrementButton.height) / 2;
			}
			var showButtons:Boolean = this._maximum != this._minimum;
			this.decrementButton.visible = showButtons;
			this.incrementButton.visible = showButtons;
		}

		/**
		 * @private
		 */
		protected function layoutThumb():void
		{
			var range:Number = this._maximum - this._minimum;
			this.thumb.visible = range > 0 && range < Number.POSITIVE_INFINITY && !this._disabled;
			if(!this.thumb.visible)
			{
				return;
			}

			//this will auto-size the thumb, if needed
			callLater(this.thumb.resize);

			var contentWidth:Number = this.width;
			var contentHeight:Number = this.height;
			var adjustedPage:Number = this._page;
			if(this._page == 0)
			{
				adjustedPage = this._step;
			}
			if(adjustedPage > range)
			{
				adjustedPage = range;
			}
			if(this._direction == Directions.VERTICAL)
			{
				contentHeight -= (this.decrementButton.height + this.incrementButton.height);
				var thumbMinHeight:Number = this.thumb.minHeight > 0 ? this.thumb.minHeight : this.thumbOriginalHeight;
				this.thumb.width = this.thumbOriginalWidth;
				this.thumb.height = Math.max(thumbMinHeight, contentHeight * adjustedPage / range);
				var trackScrollableHeight:Number = contentHeight - this.thumb.height;
				this.thumb.x =  + (this.width - this.thumb.width) / 2;
				this.thumb.y = this.decrementButton.height +  Math.max(0, Math.min(trackScrollableHeight, trackScrollableHeight * (this._value - this._minimum) / range));
			}
			else //horizontal
			{
				contentWidth -= (this.decrementButton.width + this.decrementButton.width);
				var thumbMinWidth:Number = this.thumb.minWidth > 0 ? this.thumb.minWidth : this.thumbOriginalWidth;
				this.thumb.width = Math.max(thumbMinWidth, contentWidth * adjustedPage / range);
				this.thumb.height = this.thumbOriginalHeight;
				var trackScrollableWidth:Number = contentWidth - this.thumb.width;
				this.thumb.x = this.decrementButton.width + Math.max(0, Math.min(trackScrollableWidth, trackScrollableWidth * (this._value - this._minimum) / range));
				this.thumb.y =  (this.height- this.thumb.height) / 2;
			}
		}

		/**
		 * @private
		 */
		protected function layoutTrackWithMinMax():void
		{
			var range:Number = this._maximum - this._minimum;
			this.minimumTrack.touchable = range > 0 && range < Number.POSITIVE_INFINITY;
			if(this.maximumTrack)
			{
				this.maximumTrack.touchable = range > 0 && range < Number.POSITIVE_INFINITY;
			}

			var showButtons:Boolean = this._maximum != this._minimum;
			if(this._direction == Directions.VERTICAL)
			{
				this.minimumTrack.x = 0;
				if(showButtons)
				{
					this.minimumTrack.y = this.decrementButton.height;
				}
				else
				{
					this.minimumTrack.y = 0;
				}
				this.minimumTrack.width = this.displayWidth;
				this.minimumTrack.height = (this.thumb.y + this.thumb.height / 2) - this.minimumTrack.y;

				this.maximumTrack.x = 0;
				this.maximumTrack.y = this.minimumTrack.y + this.minimumTrack.height;
				this.maximumTrack.width = this.displayWidth;
				if(showButtons)
				{
					this.maximumTrack.height = this.height- this.incrementButton.height - this.maximumTrack.y;
				}
				else
				{
					this.maximumTrack.height = this.height- this.maximumTrack.y;
				}
			}
			else //horizontal
			{
				if(showButtons)
				{
					this.minimumTrack.x = this.decrementButton.width;
				}
				else
				{
					this.minimumTrack.x = 0;
				}
				this.minimumTrack.y = 0;
				this.minimumTrack.width = (this.thumb.x + this.thumb.width / 2) - this.minimumTrack.x;
				this.minimumTrack.height = this.displayHeight;

				this.maximumTrack.x = this.minimumTrack.x + this.minimumTrack.width;
				this.maximumTrack.y = 0;
				if(showButtons)
				{
					this.maximumTrack.width = this.displayWidth - this.incrementButton.width - this.maximumTrack.x;
				}
				else
				{
					this.maximumTrack.width = this.displayWidth - this.maximumTrack.x;
				}
				this.maximumTrack.height = this.displayHeight;
			}

			//final validation to avoid juggler next frame issues
			this.minimumTrack.validate();
			this.maximumTrack.validate();
		}

		/**
		 * @private
		 */
		protected function layoutTrackWithSingle():void
		{
			var range:Number = this._maximum - this._minimum;
			this.minimumTrack.touchable = range > 0 && range < Number.POSITIVE_INFINITY;

			var showButtons:Boolean = this._maximum != this._minimum;
			if(this._direction == Directions.VERTICAL)
			{
				this.minimumTrack.x = 0;
				if(showButtons)
				{
					this.minimumTrack.y = this.decrementButton.height;
				}
				else
				{
					this.minimumTrack.y = 0;
				}
				this.minimumTrack.width = this.displayWidth;
				if(showButtons)
				{
					this.minimumTrack.height = this.height- this.minimumTrack.y - this.incrementButton.height;
				}
				else
				{
					this.minimumTrack.height = this.height- this.minimumTrack.y;
				}
			}
			else //horizontal
			{
				if(showButtons)
				{
					this.minimumTrack.x = this.decrementButton.width;
				}
				else
				{
					this.minimumTrack.x = 0;
				}
				this.minimumTrack.y = 0;
				if(showButtons)
				{
					this.minimumTrack.width = this.displayWidth - this.minimumTrack.x - this.incrementButton.width;
				}
				else
				{
					this.minimumTrack.width = this.displayWidth - this.minimumTrack.x;
				}
				this.minimumTrack.height = this.displayHeight;
			}

			//final validation to avoid juggler next frame issues
			this.minimumTrack.validate();
		}

		/**
		 * @private
		 */
		protected function locationToValue(location:Point):Number
		{
			var percentage:Number = 0;
			if(this._direction == Directions.VERTICAL)
			{
				var trackScrollableHeight:Number = this.height- this.thumb.height - this.decrementButton.height - this.incrementButton.height ;
				if(trackScrollableHeight > 0)
				{
					var yOffset:Number = location.y - this._touchStartY ;
					var yPosition:Number = Math.min(Math.max(0, this._thumbStartY + yOffset - this.decrementButton.height), trackScrollableHeight);
					percentage = yPosition / trackScrollableHeight;
				}
			}
			else //horizontal
			{
				var trackScrollableWidth:Number = this.displayWidth - this.thumb.width - this.decrementButton.width - this.incrementButton.width ;
				if(trackScrollableWidth > 0)
				{
					var xOffset:Number = location.x - this._touchStartX;
					var xPosition:Number = Math.min(Math.max(0, this._thumbStartX + xOffset - this.decrementButton.width), trackScrollableWidth);
					percentage = xPosition / trackScrollableWidth;
				}
			}

			return this._minimum + percentage * (this._maximum - this._minimum);
		}

		/**
		 * @private
		 */
		protected function decrement():void
		{
			this.value -= this._step;
		}

		/**
		 * @private
		 */
		protected function increment():void
		{
			this.value += this._step;
		}

		/**
		 * @private
		 */
		protected function adjustPage():void
		{
			var range:Number = this._maximum - this._minimum;
			var adjustedPage:Number = this._page;
			if(this._page == 0)
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


		/**
		 * @private
		 */
		protected function removedFromStageHandler(event:Event):void
		{
			this._touchPointID = -1;
			if(this._repeatTimer)
			{
				this._repeatTimer.stop();
			}
		}

		/**
		 * @private
		 */
		//protected function track_touchHandler(event:TouchEvent):void
		//{
			//if(!this._isEnabled)
			//{
				//this._touchPointID = -1;
				//return;
			//}
//
			//var track:DisplayObject = DisplayObject(event.currentTarget);
			//if(this._touchPointID >= 0)
			//{
				//var touch:Touch = event.getTouch(track, TouchPhase.ENDED, this._touchPointID);
				//if(!touch)
				//{
					//return;
				//}
				//this._touchPointID = -1;
				//this._repeatTimer.stop();
				//this.dispatchEventWith(FeathersEventType.END_INTERACTION);
			//}
			//else
			//{
				//touch = event.getTouch(track, TouchPhase.BEGAN);
				//if(!touch)
				//{
					//return;
				//}
				//this._touchPointID = touch.id;
				//this.dispatchEventWith(FeathersEventType.BEGIN_INTERACTION);
				//touch.getLocation(this, HELPER_POINT);
				//this._touchStartX = HELPER_POINT.x;
				//this._touchStartY = HELPER_POINT.y;
				//this._thumbStartX = HELPER_POINT.x;
				//this._thumbStartY = HELPER_POINT.y;
				//this._touchValue = this.locationToValue(HELPER_POINT);
				//this.adjustPage();
				//this.startRepeatTimer(this.adjustPage);
			//}
		//}

		/**
		 * @private
		 */
		//protected function thumb_touchHandler(event:MouseEvent):void
		//{
			//if(this._disabled)
			//{
				//this._touchPointID = -1;
				//return;
			//}
//
			//if(this._touchPointID >= 0)
			//{
				//var touch:Touch = event.getTouch(this.thumb, null, this._touchPointID);
				//if(!touch)
				//{
					//return;
				//}
				//if(touch.phase == TouchPhase.MOVED)
				//{
					//touch.getLocation(this, HELPER_POINT);
					//var newValue:Number = this.locationToValue(HELPER_POINT);
					//if(this._step != 0 && newValue != this._maximum && newValue != this._minimum)
					//{
						//newValue = Math.round(newValue, this._step);
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
				//}
			//}
			//else
			//{
				//
				//this.isDragging = true;
			//}
		//}

		/**
		 * @private
		 */
		//protected function decrementButton_touchHandler(event:TouchEvent):void
		//{
			//if(!this._isEnabled)
			//{
				//this._touchPointID = -1;
				//return;
			//}
//
			//if(this._touchPointID >= 0)
			//{
				//var touch:Touch = event.getTouch(this.decrementButton, TouchPhase.ENDED, this._touchPointID);
				//if(!touch)
				//{
					//return;
				//}
				//this._touchPointID = -1;
				//this._repeatTimer.stop();
				//this.dispatchEventWith(FeathersEventType.END_INTERACTION);
			//}
			//else //if we get here, we don't have a saved touch ID yet
			//{
				//touch = event.getTouch(this.decrementButton, TouchPhase.BEGAN);
				//if(!touch)
				//{
					//return;
				//}
				//this._touchPointID = touch.id;
				//this.dispatchEventWith(FeathersEventType.BEGIN_INTERACTION);
				//this.decrement();
				//this.startRepeatTimer(this.decrement);
			//}
		//}

		/**
		 * @private
		 */
		//protected function incrementButton_touchHandler(event:TouchEvent):void
		//{
			//if(!this._isEnabled)
			//{
				//this._touchPointID = -1;
				//return;
			//}
//
			//if(this._touchPointID >= 0)
			//{
				//var touch:Touch = event.getTouch(this.incrementButton, TouchPhase.ENDED, this._touchPointID);
				//if(!touch)
				//{
					//return;
				//}
				//this._touchPointID = -1;
				//this._repeatTimer.stop();
				//this.dispatchEventWith(FeathersEventType.END_INTERACTION);
			//}
			//else //if we get here, we don't have a saved touch ID yet
			//{
				//touch = event.getTouch(this.incrementButton, TouchPhase.BEGAN);
				//if(!touch)
				//{
					//return;
				//}
				//this._touchPointID = touch.id;
				//this.dispatchEventWith(FeathersEventType.BEGIN_INTERACTION);
				//this.increment();
				//this.startRepeatTimer(this.increment);
			//}
		//}

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
