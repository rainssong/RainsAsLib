/**
 * @date 2016-06-14
 * @author Rainssong
 * @blog http://blog.sina.com.cn/rainssong
 * @homepage http://rainsgameworld.sinaapp.com
 * @weibo http://www.weibo.com/rainssong
 */
package me.rainui.components
{
	
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.geom.Point;
	import flash.ui.Keyboard;
	import flash.utils.Timer;
	import me.rainssong.math.MathCore;
	import me.rainssong.utils.Directions;
	
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	
	[Event(name = "change", type = "starling.events.Event")]
	
	[Event(name = "beginInteraction", type = "starling.events.Event")]
	
	[Event(name = "endInteraction", type = "starling.events.Event")]
	
	public class Slider extends Container
	{
		/**
		 * @private
		 */
		//private static const e:Point = new Point();
		
		/**
		 * @private
		 */
		protected static const INVALIDATION_FLAG_THUMB_FACTORY:String = "thumbFactory";
		
		/**
		 * @private
		 */
		protected static const INVALIDATION_FLAG_MINIMUM_TRACK_FACTORY:String = "minimumTrackFactory";
		
		/**
		 * @private
		 */
		protected static const INVALIDATION_FLAG_MAXIMUM_TRACK_FACTORY:String = "maximumTrackFactory";
		
		/**
		 * The slider has only one track, that fills the full length of the
		 * slider. In this layout mode, the "minimum" track is displayed and
		 * fills the entire length of the slider. The maximum track will not
		 * exist.
		 *
		 * @see #trackLayoutMode
		 */
		public static const TRACK_LAYOUT_MODE_SINGLE:String = "single";
		
		/**
		 * The slider has two tracks, stretching to fill each side of the slider
		 * with the thumb in the middle. The tracks will be resized as the thumb
		 * moves. This layout mode is designed for sliders where the two sides
		 * of the track may be colored differently to show the value
		 * "filling up" as the slider is dragged.
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
		 * The slider's track dimensions fill the full width and height of the
		 * slider.
		 *
		 * @see #trackScaleMode
		 */
		public static const TRACK_SCALE_MODE_EXACT_FIT:String = "exactFit";
		
		/**
		 * If the slider's direction is horizontal, the width of the track will
		 * fill the full width of the slider, and if the slider's direction is
		 * vertical, the height of the track will fill the full height of the
		 * slider. The other edge will not be scaled.
		 *
		 * @see #trackScaleMode
		 */
		public static const TRACK_SCALE_MODE_DIRECTIONAL:String = "directional";
		
		/**
		 * When the track is touched, the slider's thumb jumps directly to the
		 * touch position, and the slider's <code>value</code> property is
		 * updated to match as if the thumb were dragged to that position.
		 *
		 * @see #trackInteractionMode
		 */
		public static const TRACK_INTERACTION_MODE_TO_VALUE:String = "toValue";
		
		/**
		 * When the track is touched, the <code>value</code> is increased or
		 * decreased (depending on the location of the touch) by the value of
		 * the <code>page</code> property.
		 *
		 * @see #trackInteractionMode
		 */
		public static const TRACK_INTERACTION_MODE_BY_PAGE:String = "byPage";
		
		/**
		 * The default value added to the <code>styleNameList</code> of the
		 * minimum track.
		 *
		 * @see feathers.core.FeathersControl#styleNameList
		 */
		public static const DEFAULT_CHILD_STYLE_NAME_MINIMUM_TRACK:String = "feathers-slider-minimum-track";
		
		/**
		 * The default value added to the <code>styleNameList</code> of the
		 * maximum track.
		 *
		 * @see feathers.core.FeathersControl#styleNameList
		 */
		public static const DEFAULT_CHILD_STYLE_NAME_MAXIMUM_TRACK:String = "feathers-slider-maximum-track";
		
		/**
		 * The default value added to the <code>styleNameList</code> of the thumb.
		 *
		 * @see feathers.core.FeathersControl#styleNameList
		 */
		public static const DEFAULT_CHILD_STYLE_NAME_THUMB:String = "feathers-slider-thumb";
		
		/**
		 * The default <code>IStyleProvider</code> for all <code>Slider</code>
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
		 * Constructor.
		 */
		public function Slider(dataSource:Object = null)
		{
			super(dataSource);
		}
		
		override protected function createChildren():void
		{
			createTrack()
			createThumb();
			
			super.createChildren();
		}
		
		/**
		 * The value added to the <code>styleNameList</code> of the minimum
		 * track. This variable is <code>protected</code> so that sub-classes
		 * can customize the minimum track style name in their constructors
		 * instead of using the default style name defined by
		 * <code>DEFAULT_CHILD_STYLE_NAME_MINIMUM_TRACK</code>.
		 *
		 * <p>To customize the minimum track style name without subclassing, see
		 * <code>customMinimumTrackStyleName</code>.</p>
		 *
		 * @see #customMinimumTrackStyleName
		 * @see feathers.core.FeathersControl#styleNameList
		 */
		protected var minimumTrackStyleName:String = DEFAULT_CHILD_STYLE_NAME_MINIMUM_TRACK;
		
		/**
		 * The value added to the <code>styleNameList</code> of the maximum
		 * track. This variable is <code>protected</code> so that sub-classes
		 * can customize the maximum track style name in their constructors
		 * instead of using the default style name defined by
		 * <code>DEFAULT_CHILD_STYLE_NAME_MAXIMUM_TRACK</code>.
		 *
		 * <p>To customize the maximum track style name without subclassing, see
		 * <code>customMaximumTrackStyleName</code>.</p>
		 *
		 * @see #customMaximumTrackStyleName
		 * @see feathers.core.FeathersControl#styleNameList
		 */
		protected var maximumTrackStyleName:String = DEFAULT_CHILD_STYLE_NAME_MAXIMUM_TRACK;
		
		/**
		 * The value added to the <code>styleNameList</code> of the thumb. This
		 * variable is <code>protected</code> so that sub-classes can customize
		 * the thumb style name in their constructors instead of using the
		 * default style name defined by <code>DEFAULT_CHILD_STYLE_NAME_THUMB</code>.
		 *
		 * <p>To customize the thumb style name without subclassing, see
		 * <code>customThumbStyleName</code>.</p>
		 *
		 * @see #customThumbStyleName
		 * @see feathers.core.FeathersControl#styleNameList
		 */
		protected var thumbStyleName:String = DEFAULT_CHILD_STYLE_NAME_THUMB;
		
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
		 * The minimum track sub-component.
		 *
		 * <p>For internal use in subclasses.</p>
		 *
		 * @see #minimumTrackFactory
		 * @see #createMinimumTrack()
		 */
		protected var track:Image;
		

		
		/**
		 * @private
		 */
		
		/**
		 * @private
		 */
		protected var _direction:String = Directions.HORIZONTAL;
		
		[Inspectable(type = "String", enumeration = "horizontal,vertical")]
		/**
		 * Determines if the slider's thumb can be dragged horizontally or
		 * vertically. When this value changes, the slider's width and height
		 * values do not change automatically.
		 *
		 * <p>In the following example, the direction is changed to vertical:</p>
		 *
		 * <listing version="3.0">
		 * slider.direction = Directions.VERTICAL;</listing>
		 *
		 * @default Directions.HORIZONTAL
		 *
		 * @see #Directions.HORIZONTAL
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
			if (this._direction == value)
			{
				return;
			}
			this._direction = value;
			callLater(redraw);
		}
		
		/**
		 * @private
		 */
		protected var _value:Number = 0;
		
		/**
		 * The value of the slider, between the minimum and maximum.
		 *
		 * <p>In the following example, the value is changed to 12:</p>
		 *
		 * <listing version="3.0">
		 * slider.minimum = 0;
		 * slider.maximum = 100;
		 * slider.step = 1;
		 * slider.page = 10
		 * slider.value = 12;</listing>
		 *
		 * @default 0
		 *
		 * @see #minimum
		 * @see #maximum
		 * @see #step
		 * @see #page
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
			//if(this._step != 0 && newValue != this._maximum && newValue != this._minimum)
			//{
			//newValue = MathCore.getRangedNumber(value,this._minimum, this._maximum);
			//}
			newValue = MathCore.getRangedNumber(newValue, this._minimum, this._maximum);
			if (this._value == newValue)
			{
				return;
			}
			this._value = newValue;
			callLater(redraw);
			if (this.liveDragging || !this.isDragging)
			{
				this.sendEvent(Event.CHANGE);
			}
		}
		
		/**
		 * @private
		 */
		protected var _minimum:Number = 0;
		
		/**
		 * The slider's value will not go lower than the minimum.
		 *
		 * <p>In the following example, the minimum is set to 0:</p>
		 *
		 * <listing version="3.0">
		 * slider.minimum = 0;
		 * slider.maximum = 100;
		 * slider.step = 1;
		 * slider.page = 10
		 * slider.value = 12;</listing>
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
			if (this._minimum == value)
			{
				return;
			}
			this._minimum = value;
			callLater(redraw);
		}
		
		/**
		 * @private
		 */
		protected var _maximum:Number = 0;
		
		/**
		 * The slider's value will not go higher than the maximum. The maximum
		 * is zero (<code>0</code>), by default, and it should almost always be
		 * changed to something more appropriate.
		 *
		 * <p>In the following example, the maximum is set to 100:</p>
		 *
		 * <listing version="3.0">
		 * slider.minimum = 0;
		 * slider.maximum = 100;
		 * slider.step = 1;
		 * slider.page = 10
		 * slider.value = 12;</listing>
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
			if (this._maximum == value)
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
		 * As the slider's thumb is dragged, the value is snapped to a multiple
		 * of the step. Paging using the slider's track will use the <code>step</code>
		 * value if the <code>page</code> value is <code>NaN</code>. If the
		 * <code>step</code> is zero (<code>0</code>), paging with the track will not be possible.
		 *
		 * <p>In the following example, the step is changed to 1:</p>
		 *
		 * <listing version="3.0">
		 * slider.minimum = 0;
		 * slider.maximum = 100;
		 * slider.step = 1;
		 * slider.page = 10;
		 * slider.value = 10;</listing>
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
			if (this._step == value)
			{
				return;
			}
			this._step = value;
		}
		
		/**
		 * @private
		 */
		protected var _page:Number = NaN;
		
		/**
		 * If the <code>trackInteractionMode</code> property is set to
		 * <code>Slider.TRACK_INTERACTION_MODE_BY_PAGE</code>, and the slider's
		 * track is touched, and the thumb is shown, the slider value will be
		 * incremented or decremented by the page value.
		 *
		 * <p>If this value is <code>NaN</code>, the <code>step</code> value
		 * will be used instead. If the <code>step</code> value is zero, paging
		 * with the track is not possible.</p>
		 *
		 * <p>In the following example, the page is changed to 10:</p>
		 *
		 * <listing version="3.0">
		 * slider.minimum = 0;
		 * slider.maximum = 100;
		 * slider.step = 1;
		 * slider.page = 10
		 * slider.value = 12;</listing>
		 *
		 * @default NaN
		 *
		 * @see #value
		 * @see #page
		 * @see #trackInteractionMode
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
			if (this._page == value)
			{
				return;
			}
			this._page = value;
		}
		
		/**
		 * @private
		 */
		protected var isDragging:Boolean = false;
		
		/**
		 * Determines if the slider dispatches the <code>Event.CHANGE</code>
		 * event every time the thumb moves, or only once it stops moving.
		 *
		 * <p>In the following example, live dragging is disabled:</p>
		 *
		 * <listing version="3.0">
		 * slider.liveDragging = false;</listing>
		 *
		 * @default true
		 */
		public var liveDragging:Boolean = true;
		public var minimumTrack:Button;
		
		/**
		 * @private
		 */
		protected var _showThumb:Boolean = true;
		
		/**
		 * Determines if the thumb should be displayed.
		 *
		 * <p>In the following example, the thumb is hidden:</p>
		 *
		 * <listing version="3.0">
		 * slider.showThumb = false;</listing>
		 *
		 * @default true
		 */
		public function get showThumb():Boolean
		{
			return this._showThumb;
		}
		
		/**
		 * @private
		 */
		public function set showThumb(value:Boolean):void
		{
			if (this._showThumb == value)
			{
				return;
			}
			this._showThumb = value;
			callLater(redraw);
		}
		
		/**
		 * @private
		 */
		protected var _thumbOffset:Number = 0;
		
		/**
		 *
		 * Offsets the position of the thumb by a certain number of pixels in a
		 * direction perpendicular to the track. This does not affect the
		 * measurement of the slider. The slider will measure itself as if the
		 * thumb were not offset from its original position.
		 *
		 * <p>In the following example, the thumb is offset by 20 pixels:</p>
		 *
		 * <listing version="3.0">
		 * slider.thumbOffset = 20;</listing>
		 *
		 * @default 0
		 */
		public function get thumbOffset():Number
		{
			return this._thumbOffset;
		}
		
		/**
		 * @private
		 */
		public function set thumbOffset(value:Number):void
		{
			if (this._thumbOffset == value)
			{
				return;
			}
			this._thumbOffset = value;
			callLater(redraw);
		}
		
		/**
		 * @private
		 */
		protected var _minimumPadding:Number = 0;
		
		/**
		 * The space, in pixels, between the minimum position of the thumb and
		 * the minimum edge of the track. May be negative to extend the range of
		 * the thumb.
		 *
		 * <p>In the following example, minimum padding is set to 20 pixels:</p>
		 *
		 * <listing version="3.0">
		 * slider.minimumPadding = 20;</listing>
		 *
		 * @default 0
		 */
		public function get minimumPadding():Number
		{
			return this._minimumPadding;
		}
		
		/**
		 * @private
		 */
		public function set minimumPadding(value:Number):void
		{
			if (this._minimumPadding == value)
			{
				return;
			}
			this._minimumPadding = value;
			callLater(redraw);
		}
		
		/**
		 * @private
		 */
		protected var _maximumPadding:Number = 0;
		
		/**
		 * The space, in pixels, between the maximum position of the thumb and
		 * the maximum edge of the track. May be negative to extend the range
		 * of the thumb.
		 *
		 * <p>In the following example, maximum padding is set to 20 pixels:</p>
		 *
		 * <listing version="3.0">
		 * slider.maximumPadding = 20;</listing>
		 *
		 * @default 0
		 */
		public function get maximumPadding():Number
		{
			return this._maximumPadding;
		}
		
		/**
		 * @private
		 */
		public function set maximumPadding(value:Number):void
		{
			if (this._maximumPadding == value)
			{
				return;
			}
			this._maximumPadding = value;
			callLater(redraw);
		}
		
		/**
		 * @private
		 */
		protected var _trackLayoutMode:String = TRACK_LAYOUT_MODE_SINGLE;
		
		[Inspectable(type = "String", enumeration = "single,minMax")]
		/**
		 * Determines how the minimum and maximum track skins are positioned and
		 * sized.
		 *
		 * <p>In the following example, the slider is given two tracks:</p>
		 *
		 * <listing version="3.0">
		 * slider.trackLayoutMode = Slider.TRACK_LAYOUT_MODE_MIN_MAX;</listing>
		 *
		 * @default Slider.TRACK_LAYOUT_MODE_SINGLE
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
			if (this._trackLayoutMode == value)
			{
				return;
			}
			this._trackLayoutMode = value;
			callLater(redraw);
		}
		
		/**
		 * @private
		 */
		protected var _trackScaleMode:String = TRACK_SCALE_MODE_DIRECTIONAL;
		
		[Inspectable(type = "String", enumeration = "exactFit,directional")]
		/**
		 * Determines how the minimum and maximum track skins are positioned and
		 * sized.
		 *
		 * <p>In the following example, the slider's track layout is customized:</p>
		 *
		 * <listing version="3.0">
		 * slider.trackScaleMode = Slider.TRACK_SCALE_MODE_EXACT_FIT;</listing>
		 *
		 * @default Slider.TRACK_SCALE_MODE_DIRECTIONAL
		 *
		 * @see #TRACK_SCALE_MODE_DIRECTIONAL
		 * @see #TRACK_SCALE_MODE_EXACT_FIT
		 * @see #trackLayoutMode
		 */
		public function get trackScaleMode():String
		{
			return this._trackScaleMode;
		}
		
		/**
		 * @private
		 */
		public function set trackScaleMode(value:String):void
		{
			if (this._trackScaleMode == value)
			{
				return;
			}
			this._trackScaleMode = value;
			callLater(redraw);
		}
		
		/**
		 * @private
		 */
		protected var _trackInteractionMode:String = TRACK_INTERACTION_MODE_TO_VALUE;
		
		[Inspectable(type = "String", enumeration = "toValue,byPage")]
		/**
		 * Determines how the slider's value changes when the track is touched.
		 *
		 * <p>If <code>showThumb</code> is set to <code>false</code>, the slider
		 * will always behave as if <code>trackInteractionMode</code> has been
		 * set to <code>Slider.TRACK_INTERACTION_MODE_TO_VALUE</code>. In other
		 * words, the value of <code>trackInteractionMode</code> may be ignored
		 * if the thumb is hidden.</p>
		 *
		 * <p>In the following example, the slider's track interaction is changed:</p>
		 *
		 * <listing version="3.0">
		 * slider.trackScaleMode = Slider.TRACK_INTERACTION_MODE_BY_PAGE;</listing>
		 *
		 * @default Slider.TRACK_INTERACTION_MODE_TO_VALUE
		 *
		 * @see #TRACK_INTERACTION_MODE_TO_VALUE
		 * @see #TRACK_INTERACTION_MODE_BY_PAGE
		 * @see #page
		 */
		public function get trackInteractionMode():String
		{
			return this._trackInteractionMode;
		}
		
		/**
		 * @private
		 */
		public function set trackInteractionMode(value:String):void
		{
			this._trackInteractionMode = value;
		}
		
		/**
		 * @private
		 */
		protected var _minimumTrackFactory:Function;
		
		/**
		 * A function used to generate the slider's minimum track sub-component.
		 * The minimum track must be an instance of <code>Button</code>. This
		 * factory can be used to change properties on the minimum track when it
		 * is first created. For instance, if you are skinning Feathers
		 * components without a theme, you might use this factory to set skins
		 * and other styles on the minimum track.
		 *
		 * <p>The function should have the following signature:</p>
		 * <pre>function():Button</pre>
		 *
		 * <p>In the following example, a custom minimum track factory is passed
		 * to the slider:</p>
		 *
		 * <listing version="3.0">
		 * slider.minimumTrackFactory = function():Button
		 * {
		 *     var track:Button = new Button();
		 *     track.defaultSkin = new Image( upTexture );
		 *     track.downSkin = new Image( downTexture );
		 *     return track;
		 * };</listing>
		 *
		 * @default null
		 *
		 * @see feathers.controls.Button
		 * @see #minimumTrackProperties
		 */
		public function get minimumTrackFactory():Function
		{
			return this._minimumTrackFactory;
		}
		
		/**
		 * @private
		 */
		public function set minimumTrackFactory(value:Function):void
		{
			if (this._minimumTrackFactory == value)
			{
				return;
			}
			this._minimumTrackFactory = value;
			callLater(redraw);
		}
		
		/**
		 * @private
		 */
		protected var _customMinimumTrackStyleName:String;
		
		/**
		 * A style name to add to the slider's minimum track sub-component.
		 * Typically used by a theme to provide different styles to different
		 * sliders.
		 *
		 * <p>In the following example, a custom minimum track style name is
		 * passed to the slider:</p>
		 *
		 * <listing version="3.0">
		 * slider.customMinimumTrackStyleName = "my-custom-minimum-track";</listing>
		 *
		 * <p>In your theme, you can target this sub-component style name to
		 * provide different styles than the default:</p>
		 *
		 * <listing version="3.0">
		 * getStyleProviderForClass( Button ).setFunctionForStyleName( "my-custom-minimum-track", setCustomMinimumTrackStyles );</listing>
		 *
		 * @default null
		 *
		 * @see #DEFAULT_CHILD_STYLE_NAME_MINIMUM_TRACK
		 * @see feathers.core.FeathersControl#styleNameList
		 * @see #minimumTrackFactory
		 * @see #minimumTrackProperties
		 */
		public function get customMinimumTrackStyleName():String
		{
			return this._customMinimumTrackStyleName;
		}
		
		/**
		 * @private
		 */
		public function set customMinimumTrackStyleName(value:String):void
		{
			if (this._customMinimumTrackStyleName == value)
			{
				return;
			}
			this._customMinimumTrackStyleName = value;
			callLater(redraw);
		}
		
		/**
		 * @private
		 */
		protected var _maximumTrackFactory:Function;
		
		/**
		 * A function used to generate the slider's maximum track sub-component.
		 * The maximum track must be an instance of <code>Button</code>.
		 * This factory can be used to change properties on the maximum track
		 * when it is first created. For instance, if you are skinning Feathers
		 * components without a theme, you might use this factory to set skins
		 * and other styles on the maximum track.
		 *
		 * <p>The function should have the following signature:</p>
		 * <pre>function():Button</pre>
		 *
		 * <p>In the following example, a custom maximum track factory is passed
		 * to the slider:</p>
		 *
		 * <listing version="3.0">
		 * slider.maximumTrackFactory = function():Button
		 * {
		 *     var track:Button = new Button();
		 *     track.defaultSkin = new Image( upTexture );
		 *     track.downSkin = new Image( downTexture );
		 *     return track;
		 * };</listing>
		 *
		 * @default null
		 *
		 * @see feathers.controls.Button
		 * @see #maximumTrackProperties
		 */
		public function get maximumTrackFactory():Function
		{
			return this._maximumTrackFactory;
		}
		
		/**
		 * @private
		 */
		public function set maximumTrackFactory(value:Function):void
		{
			if (this._maximumTrackFactory == value)
			{
				return;
			}
			this._maximumTrackFactory = value;
			callLater(redraw);
		}
		
		/**
		 * @private
		 */
		protected var _customMaximumTrackStyleName:String;
		
		/**
		 * A style name to add to the slider's maximum track sub-component.
		 * Typically used by a theme to provide different skins to different
		 * sliders.
		 *
		 * <p>In the following example, a custom maximum track style name is
		 * passed to the slider:</p>
		 *
		 * <listing version="3.0">
		 * slider.customMaximumTrackStyleName = "my-custom-maximum-track";</listing>
		 *
		 * <p>In your theme, you can target this sub-component style name to
		 * provide different styles than the default:</p>
		 *
		 * <listing version="3.0">
		 * getStyleProviderForClass( Button ).setFunctionForStyleName( "my-custom-maximum-track", setCustomMaximumTrackStyles );</listing>
		 *
		 * @default null
		 *
		 * @see #DEFAULT_CHILD_STYLE_NAME_MAXIMUM_TRACK
		 * @see feathers.core.FeathersControl#styleNameList
		 * @see #maximumTrackFactory
		 * @see #maximumTrackProperties
		 */
		public function get customMaximumTrackStyleName():String
		{
			return this._customMaximumTrackStyleName;
		}
		
		/**
		 * @private
		 */
		public function set customMaximumTrackStyleName(value:String):void
		{
			if (this._customMaximumTrackStyleName == value)
			{
				return;
			}
			this._customMaximumTrackStyleName = value;
			callLater(redraw);
		}
		
		/**
		 * @private
		 */
		protected var _thumbFactory:Function;
		
		/**
		 * A function used to generate the slider's thumb sub-component.
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
		 * to the slider:</p>
		 *
		 * <listing version="3.0">
		 * slider.thumbFactory = function():Button
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
			if (this._thumbFactory == value)
			{
				return;
			}
			this._thumbFactory = value;
			callLater(redraw);
		}
		
		/**
		 * @private
		 */
		protected var _customThumbStyleName:String;
		
		/**
		 * A style name to add to the slider's thumb sub-component. Typically
		 * used by a theme to provide different styles to different sliders.
		 *
		 * <p>In the following example, a custom thumb style name is passed
		 * to the slider:</p>
		 *
		 * <listing version="3.0">
		 * slider.customThumbStyleName = "my-custom-thumb";</listing>
		 *
		 * <p>In your theme, you can target this sub-component style name to
		 * provide different styles than the default:</p>
		 *
		 * <listing version="3.0">
		 * getStyleProviderForClass( Button ).setFunctionForStyleName( "my-custom-thumb", setCustomThumbStyles );</listing>
		 *
		 * @default null
		 *
		 * @see #DEFAULT_CHILD_STYLE_NAME_THUMB
		 * @see feathers.core.FeathersControl#styleNameList
		 * @see #thumbFactory
		 * @see #thumbProperties
		 */
		public function get customThumbStyleName():String
		{
			return this._customThumbStyleName;
		}
		
		/**
		 * @private
		 */
		public function set customThumbStyleName(value:String):void
		{
			if (this._customThumbStyleName == value)
			{
				return;
			}
			this._customThumbStyleName = value;
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
			if (this._value < this._minimum)
			{
				this.value = this._minimum;
			}
			else if (this._value > this._maximum)
			{
				this.value = this._maximum;
			}
			super.initialize();
		}
		
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
			if (this.thumb==null)
			{
				this.thumb = new Button();
				//this.thumb.keepDownStateOnRollOut = true;
				this.thumb.addEventListener(MouseEvent.CLICK, thumb_touchHandler);
			}
			
			
			
			this.addChild(this.thumb);
		}
		
		protected function createTrack():void
		{
			if(this.minimumTrack)
			{
				this.minimumTrack.remove();
				this.minimumTrack = null;
			}

			//var factory:Function = this._minimumTrackFactory != null ? this._minimumTrackFactory : defaultMinimumTrackFactory;
			this.minimumTrack =new Button();
			//this.minimumTrack.keepDownStateOnRollOut = true;
			this.minimumTrack.addEventListener(MouseEvent.CLICK, track_touchHandler);
			
			this.addChildAt(this.minimumTrack, 0);
		}
		
		/**
		 * @private
		 */
		override public function resize():void
		{
			
			this.layoutThumb();
			
			super.resize();
		}
		
		/**
		 * @private
		 */
		protected function layoutThumb():void
		{
			//this will auto-size the thumb, if needed
			this.thumb.redraw();
			thumb.setSize(Math.min(this.width,this.height),Math.min(this.width,this.height));
			minimumTrack.setSize(this._width, this._height);
			
			if (this._minimum === this._maximum)
			{
				var percentage:Number = 1;
			}
			else
			{
				percentage = (this._value - this._minimum) / (this._maximum - this._minimum);
				if (percentage < 0)
				{
					percentage = 0;
				}
				else if (percentage > 1)
				{
					percentage = 1;
				}
			}
			if (this._direction == Directions.VERTICAL)
			{
				var trackScrollableHeight:Number = this.displayHeight - this.thumb.height - this._minimumPadding - this._maximumPadding;
				this.thumb.x = Math.round((this.displayWidth - this.thumb.width) / 2) + this._thumbOffset;
				//maximum is at the top, so we need to start the y position of
				//the thumb from the maximum padding
				this.thumb.y = Math.round(this._maximumPadding + trackScrollableHeight * (1 - percentage));
			}
			else //horizontal
			{
				var trackScrollableWidth:Number = this.displayWidth - this.thumb.width - this._minimumPadding - this._maximumPadding;
				//minimum is at the left, so we need to start the x position of
				//the thumb from the minimum padding
				this.thumb.x = Math.round(this._minimumPadding + (trackScrollableWidth * percentage));
				this.thumb.y = Math.round((this.displayHeight - this.thumb.height) / 2) + this._thumbOffset;
			}
		}
		
		/**
		 * @private
		 */
		protected function locationToValue(location:Point):Number
		{
			var percentage:Number;
			if (this._direction == Directions.VERTICAL)
			{
				var trackScrollableHeight:Number = this.displayHeight - this.thumb.height - this._minimumPadding - this._maximumPadding;
				var yOffset:Number = location.y - this._touchStartY - this._maximumPadding;
				var yPosition:Number = Math.min(Math.max(0, this._thumbStartY + yOffset), trackScrollableHeight);
				percentage = 1 - (yPosition / trackScrollableHeight);
			}
			else //horizontal
			{
				var trackScrollableWidth:Number = this.displayWidth - this.thumb.width - this._minimumPadding - this._maximumPadding;
				var xOffset:Number = location.x - this._touchStartX - this._minimumPadding;
				var xPosition:Number = Math.min(Math.max(0, this._thumbStartX + xOffset), trackScrollableWidth);
				percentage = xPosition / trackScrollableWidth;
			}
			
			return this._minimum + percentage * (this._maximum - this._minimum);
		}
		
		/**
		 * @private
		 */
		protected function adjustPage():void
		{
			var page:Number = this._page;
			if (page !== page) //isNaN
			{
				page = this._step;
			}
			if (this._touchValue < this._value)
			{
				this.value = Math.max(this._touchValue, this._value - page);
			}
			else if (this._touchValue > this._value)
			{
				this.value = Math.min(this._touchValue, this._value + page);
			}
		}
		
		/**
		 * @private
		 */
		override protected function onRemoved(e:Event):void
		{
			
			if (e.target == this)
			{
				this._touchPointID = -1;
				var wasDragging:Boolean = this.isDragging;
				this.isDragging = false;
				if (wasDragging && !this.liveDragging)
				{
					this.sendEvent(Event.CHANGE);
				}
			}
		
		}
		
		/**
		 * @private
		 */
		//override protected function focusInHandler(event:Event):void
		//{
		//super.focusInHandler(event);
		//this.stage.addEventListener(KeyboardEvent.KEY_DOWN, stage_keyDownHandler);
		//}
		
		/**
		 * @private
		 */
		//override protected function focusOutHandler(event:Event):void
		//{
		//super.focusOutHandler(event);
		//this.stage.removeEventListener(KeyboardEvent.KEY_DOWN, stage_keyDownHandler);
		//}
		
		/**
		 * @private
		 */
		protected function track_touchHandler(e:MouseEvent):void
		{
			if (this._disabled)
			{
				this._touchPointID = -1;
				return;
			}
			
			var track:DisplayObject = DisplayObject(e.currentTarget);
			switch (e.type)
			{
				case MouseEvent.MOUSE_DOWN:
					
					if (this._direction == Directions.VERTICAL)
					{
						this._thumbStartX = e.localX;
						this._thumbStartY = Math.min(this.displayHeight - this.thumb.height, Math.max(0, e.localY - this.thumb.height / 2));
					}
					else //horizontal
					{
						this._thumbStartX = Math.min(this.displayWidth - this.thumb.width, Math.max(0, e.localX - this.thumb.width / 2));
						this._thumbStartY = e.localY;
					}
					this._touchStartX = e.localX;
					this._touchStartY = e.localY;
					this._touchValue = this.locationToValue(new Point(e.localX,e.localY));
					this.isDragging = true;
					//this.sendEvent(FeathersEventType.BEGIN_INTERACTION);
					if (this._showThumb && this._trackInteractionMode == TRACK_INTERACTION_MODE_BY_PAGE)
					{
						this.adjustPage();
					}
					else
					{
						this.value = this._touchValue;
					}
					break;
				case MouseEvent.MOUSE_MOVE: 
					this.value = this.locationToValue(new Point(e.localX,e.localY));
					break;
				case MouseEvent.MOUSE_UP: 
					this._touchPointID = -1;
					this.isDragging = false;
					if (!this.liveDragging)
					{
						this.sendEvent(Event.CHANGE);
					}
					break;
				default: 
			}
		
		}
		
		/**
		 * @private
		 */
		protected function thumb_touchHandler(e:MouseEvent):void
		{
			switch (e.type)
			{
				case MouseEvent.MOUSE_DOWN:
					
					this._thumbStartX = e.localX;
					this._thumbStartY = e.localY;
					this._touchStartX = e.stageX;
					this._touchStartY = e.stageY;
					this.isDragging = true;
					break;
				case MouseEvent.MOUSE_MOVE:
					
					this.value =  this.locationToValue(new Point(e.localX,e.localY));
					break;
				case MouseEvent.MOUSE_UP: 
					this._touchPointID = -1;
					this.isDragging = false;
					if (!this.liveDragging)
					{
						this.sendEvent(Event.CHANGE);
					}
					break;
			}
		
		}
		
		/**
		 * @private
		 */
		protected function stage_keyDownHandler(event:KeyboardEvent):void
		{
			if (event.keyCode == Keyboard.HOME)
			{
				this.value = this._minimum;
				return;
			}
			if (event.keyCode == Keyboard.END)
			{
				this.value = this._maximum;
				return;
			}
			var page:Number = this._page;
			if (page !== page) //isNaN
			{
				page = this._step;
			}
			if (this._direction == Directions.VERTICAL)
			{
				if (event.keyCode == Keyboard.UP)
				{
					if (event.shiftKey)
					{
						this.value += page;
					}
					else
					{
						this.value += this._step;
					}
				}
				else if (event.keyCode == Keyboard.DOWN)
				{
					if (event.shiftKey)
					{
						this.value -= page;
					}
					else
					{
						this.value -= this._step;
					}
				}
			}
			else
			{
				if (event.keyCode == Keyboard.LEFT)
				{
					if (event.shiftKey)
					{
						this.value -= page;
					}
					else
					{
						this.value -= this._step;
					}
				}
				else if (event.keyCode == Keyboard.RIGHT)
				{
					if (event.shiftKey)
					{
						this.value += page;
					}
					else
					{
						this.value += this._step;
					}
				}
			}
		}
		
		
	}
}