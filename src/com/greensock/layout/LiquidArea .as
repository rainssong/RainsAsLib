/**
 * VERSION: 2.25
 * DATE: 2010-07-27
 * AS3
 * UPDATES AND DOCUMENTATION AT: http://www.greensock.com/liquidstage/
 **/
package com.greensock.layout {
	import com.greensock.TweenLite;
	import com.greensock.layout.core.LiquidData;
	
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.events.Event;
	import flash.geom.Point;
	import flash.geom.Rectangle;
/**
 * <code>LiquidArea</code> is an <code>AutoFitArea</code> that integrates with <code>LiquidStage</code>,
 * automatically adjusting its size whenever the stage is resized. Like AutoFitArea, it allows you to define a 
 * rectangular area and then <code>attach()</code> DisplayObjects so that they automatically fill 
 * the area, scaling/stretching in any of the following modes: <code>STRETCH, PROPORTIONAL_INSIDE, 
 * PROPORTIONAL_OUTSIDE, NONE, WIDTH_ONLY,</code> or <code>HEIGHT_ONLY</code>. Horizontally align
 * the attached DisplayObjects left, center, or right. Vertically align them top, center, or bottom.
 * Since LiquidArea inherits from the <code>Shape</code> class, so you can alter its <code>width, 
 * height, scaleX, scaleY, x,</code>, or <code>y</code> properties and then all of the attached 
 * objects will automatically be adjusted accordingly. Attach as many DisplayObjects as you want. 
 * To make visualization easy, you can choose a <code>previewColor</code>
 * and set the <code>preview</code> property to <code>true</code> in order to see the area on the stage
 * (or simply use it like a regular Shape by adding it to the display list with <code>addChild()</code>, but the 
 * <code>preview</code> property makes it simpler because it automatically ensures that it is behind 
 * all of its attached DisplayObjects in the stacking order).<br /><br />
 * 
 * You can set minimum and maximum width/height constraints on a LiquidArea so that stage
 * resizes don't expand or contract it beyond certain values.<br /><br />
 * 
 * With LiquidArea, it's simple to create things like a background that proportionally 
 * fills the stage or a bar that always stretches horizontally to fill the stage but stays stuck 
 * to the bottom, etc.<br /><br />
 * 
 * @example Example AS3 code:<listing version="3.0">
import com.greensock.layout.~~;

//create a LiquidStage instance for the current stage which was built at an original size of 550x400
//don't allow the stage to collapse smaller than 550x400 either.
var ls:LiquidStage = new LiquidStage(this.stage, 550, 400, 550, 400);

//create a 300x100 rectangular area at x:50, y:70 that stretches when the stage resizes (as though its top left and bottom right corners are pinned to their corresponding PinPoints on the stage)
var area:LiquidArea = new LiquidArea(this, 50, 70, 300, 100);

//attach a "myImage" Sprite to the area and set its ScaleMode to PROPORTIONAL_INSIDE and horizontally and vertically align it in the center of the area
area.attach(myImage, ScaleMode.PROPORTIONAL_INSIDE, AlignMode.CENTER, AlignMode.CENTER);

//if you'd like to preview the area visually (by default previewColor is red), set preview to true
area.preview = true;
 
//attach a CHANGE event listener to the LiquidArea instance
ls.addEventListener(Event.CHANGE, onAreaUpdate);
function onAreaUpdate(event:Event):void {
	trace("updated LiquidArea");
}
</listing>
 * 
 * LiquidArea is a <a href="http://www.greensock.com/club/">Club GreenSock</a> membership benefit. 
 * You must have a valid membership to use this class without violating the terms of use. Visit 
 * <a href="http://www.greensock.com/club/">http://www.greensock.com/club/</a> to sign up or get more details.<br /><br />
 * 
 * <b>Copyright 2010, GreenSock. All rights reserved.</b> This work is subject to the license that came with your Club GreenSock membership and is <b>ONLY</b> to be used by corporate or "Shockingly Green" Club GreenSock members. To learn more about Club GreenSock, visit <a href="http://blog.greensock.com/club/">http://blog.greensock.com/club/</a>.
 * 
 * @author Jack Doyle, jack@greensock.com
 */	
	public class LiquidArea extends AutoFitArea {
		/** @private **/
		public static const version:Number = 2.25;
		
		/** @private **/
		protected var _liquidStage:LiquidStage;
		/** @private **/
		protected var _topLeftPin:PinPoint;
		/** @private **/
		protected var _bottomRightPin:PinPoint;
		/** @private **/
		protected var _tlData:LiquidData;
		/** @private **/
		protected var _brData:LiquidData;
		/** @private **/
		protected var _tlPrev:Point;
		/** @private **/
		protected var _brPrev:Point;
		/** @private **/
		protected var _tween:TweenLite;
		/** @private we allow this to be temporarily swapped out using dynamicTween() **/
		protected var _originalTween:TweenLite; 
		/** @private used to enforce min/max width/height in a way that allows the window to be dragged bigger and then smaller again without it making the LiquidArea smaller until the window size gets back to the point where it exceeded the max width/height.  **/
		protected var _wOffset:Number;
		/** @private **/
		protected var _hOffset:Number;
		/** @private **/
		protected var _data:LiquidData;
		
		/** Minimum width that a LiquidStage resize is allowed to make the LiquidArea (only affects stage resizes, not when you manually set the width property) **/
		public var minWidth:Number;
		/** Minimum height that a LiquidStage resize is allowed to make the LiquidArea (only affects stage resizes, not when you manually set the height property) **/
		public var minHeight:Number;
		/** Maximum width that a LiquidStage resize is allowed to make the LiquidArea (only affects stage resizes, not when you manually set the width property) **/
		public var maxWidth:Number;
		/** Maximum height that a LiquidStage resize is allowed to make the LiquidArea (only affects stage resizes, not when you manually set the height property) **/
		public var maxHeight:Number;
		
		/**
		 * Constructor
		 * 
		 * @param parent The parent DisplayObjectContainer in which the LiquidArea should be created. All objects that get attached must share the same parent.
		 * @param x x coordinate of the LiquidArea's upper left corner
		 * @param y y coordinate of the LiquidArea's upper left corner
		 * @param width width of the LiquidArea
		 * @param height height of the LiquidArea
		 * @param previewColor color of the LiquidArea (which won't be seen unless you set preview to true or manually add it to the display list with addChild())
		 * @param minWidth Minimum width that a LiquidStage resize is allowed to make the LiquidArea (only affects stage resizes, not when you manually set the width property)
		 * @param minHeight Minimum height that a LiquidStage resize is allowed to make the LiquidArea (only affects stage resizes, not when you manually set the height property)
		 * @param maxWidth Maximum width that a LiquidStage resize is allowed to make the LiquidArea (only affects stage resizes, not when you manually set the width property)
		 * @param maxHeight Maximum height that a LiquidStage resize is allowed to make the LiquidArea (only affects stage resizes, not when you manually set the height property)
		 * @param autoPinCorners By default, the LiquidArea's upper left corner is pinned to the LiquidStage's <code>TOP_LEFT</code> PinPoint, and its lower right corner is pinned to the LiquidStage's <code>BOTTOM_RIGHT</code> PinPoint, but to skip the pinning, set autoPinCorners to false.
		 * @param liquidStage Optionally declare the LiquidStage instance to which this LiquidArea should be associated. If none is defined, the class will try to determine the LiquidStage instance based on the parent's <code>stage</code> property (<code>LiquidStage.getByStage()</code>). The only time it is useful to specifically declare the LiquidStage instance is when you plan to subload a swf that uses LiquidStage into another swf that also has a LiquidStage instance (thus they share the same stage).
		 */
		public function LiquidArea(parent:DisplayObjectContainer, x:Number, y:Number, width:Number, height:Number, previewColor:uint=0xFF0000, minWidth:Number=0, minHeight:Number=0, maxWidth:Number=99999999, maxHeight:Number=99999999, autoPinCorners:Boolean=true, liquidStage:LiquidStage=null) {
			super(parent, x, y, width, height, previewColor);
			_wOffset = _hOffset = 0;
			this.minWidth = minWidth;
			this.minHeight = minHeight;
			this.maxWidth = maxWidth;
			this.maxHeight = maxHeight;
			_liquidStage = liquidStage;
			
			if (autoPinCorners) {
				if (_parent.stage) {
					this.autoPinCorners(null);
				} else {
					_parent.addEventListener(Event.ADDED_TO_STAGE, this.autoPinCorners);
				}
			}
		}
		
		/**
		 * Creates an LiquidArea with its initial dimensions fit precisely around a target DisplayObject. 
		 * It also attaches the target DisplayObject immediately.
		 * 
		 * @param target The target DisplayObject whose position and dimensions the LiquidArea should match initially.
		 * @param scaleMode Determines how the target should be scaled to fit the LiquidArea. ScaleMode choices are: <code>STRETCH, PROPORTIONAL_INSIDE, PROPORTIONAL_OUTSIDE, NONE, WIDTH_ONLY,</code> or <code>HEIGHT_ONLY</code>.
		 * @param hAlign Horizontal alignment of the target inside the LiquidArea. AlignMode choices are: <code>LEFT</code>, <code>CENTER</code>, and <code>RIGHT</code>.
		 * @param vAlign Vertical alignment of the target inside the LiquidArea. AlignMode choices are: <code>TOP</code>, <code>CENTER</code>, and <code>BOTTOM</code>.
		 * @param crop If true, a mask will be created so that the target will be cropped wherever it exceeds the bounds of the AutoFitArea.
		 * @param previewColor color of the LiquidArea (which won't be seen unless you set preview to true or manually add it to the display list with addChild())
		 * @param minWidth Minimum width that a LiquidStage resize is allowed to make the LiquidArea (only affects stage resizes, not when you manually set the width property)
		 * @param minHeight Minimum height that a LiquidStage resize is allowed to make the LiquidArea (only affects stage resizes, not when you manually set the height property)
		 * @param maxWidth Maximum width that a LiquidStage resize is allowed to make the LiquidArea (only affects stage resizes, not when you manually set the width property)
		 * @param maxHeight Maximum height that a LiquidStage resize is allowed to make the LiquidArea (only affects stage resizes, not when you manually set the height property)
		 * @param autoPinCorners By default, the LiquidArea's upper left corner is pinned to the LiquidStage's <code>TOP_LEFT</code> PinPoint, and its lower right corner is pinned to the LiquidStage's <code>BOTTOM_RIGHT</code> PinPoint, but to skip the pinning, set autoPinCorners to false.
		 * @param calculateVisible If true, only the visible portions of the target will be taken into account when determining its position and scale which can be useful for objects that have masks applied (otherwise, Flash reports their width/height and getBounds() values including the masked portions). Setting <code>calculateVisible</code> to <code>true</code> degrades performance, so only use it when absolutely necessary.
		 * @param liquidStage Optionally declare the LiquidStage instance to which this LiquidArea should be associated. If none is defined, the class will try to determine the LiquidStage instance based on the parent's <code>stage</code> property (<code>LiquidStage.getByStage()</code>). The only time it is useful to specifically declare the LiquidStage instance is when you plan to subload a swf that uses LiquidStage into another swf that also has a LiquidStage instance (thus they share the same stage).
		 * @param reconcile If true, LiquidStage will be reverted to <code>retroMode</code> (briefly forcing the stage to the base width/height) before creating the LiquidArea. This effectively acts as though the target was attached BEFORE the stage was scaled. If you create the LiquidArea after the stage has been scaled and you don't want it to reconcile with the initial base stage size initially, set <code>reconcile</code> to <code>false</code>.
		 * @return An LiquidArea instance
		 */
		public static function createAround(target:DisplayObject, scaleMode:String="proportionalInside", hAlign:String="center", vAlign:String="center", crop:Boolean=false, previewColor:uint=0xFF0000, minWidth:Number=0, minHeight:Number=0, maxWidth:Number=99999999, maxHeight:Number=99999999, autoPinCorners:Boolean=true, calculateVisible:Boolean=false, liquidStage:LiquidStage=null, reconcile:Boolean=true):LiquidArea {
			var ls:LiquidStage = (liquidStage != null) ? liquidStage : LiquidStage.getByStage(target.stage);
			var tempRetro:Boolean = Boolean(reconcile && !ls.isBaseSize && !ls.retroMode);
			if (tempRetro) {
				ls.retroMode = true;
			}
			var bounds:Rectangle = (calculateVisible) ? getVisibleBounds(target, target.parent) : target.getBounds(target.parent);
			var la:LiquidArea = new LiquidArea(target.parent, bounds.x, bounds.y, bounds.width, bounds.height, previewColor, minWidth, minHeight, maxWidth, maxHeight, autoPinCorners, liquidStage);
			la.attach(target, scaleMode, hAlign, vAlign, crop, 0, 999999999, 0, 999999999, calculateVisible);
			if (tempRetro) {
				ls.retroMode = false;
			}
			return la;
		}
		
		/** @private **/
		protected function autoPinCorners(event:Event=null):void {
			if (event) {
				_parent.removeEventListener(Event.ADDED_TO_STAGE, this.autoPinCorners);
			}
			if (_liquidStage == null) {
				_liquidStage = LiquidStage.getByStage(_parent.stage);
			}
			if (_liquidStage && _topLeftPin == null) {
				pinCorners(_liquidStage.TOP_LEFT, _liquidStage.BOTTOM_RIGHT, true, 0, null);
			}
		}
		
		/**
		 * By default, a LiquidArea pins itself to the <code>TOP_LEFT</code> and <code>BOTTOM_RIGHT</code> PinPoints of the LiquidStage, but
		 * this method allows you to pin the corners to different PinPoints if you prefer. 
		 * 
		 * @param topLeft The PinPoint to which the top left corner of the LiquidArea should be pinned.
		 * @param bottomRight The PinPoint to which the bottom right corner of the LiquidArea should be pinned.
		 * @param reconcile If true, the LiquidArea's position and dimensions will immediately be adjusted as though it was attached BEFORE the stage was scaled. If you create the LiquidArea after the stage has been scaled and you don't want it to reconcile with the PinPoint initially, set <code>reconcile</code> to <code>false</code>.
		 * @param tweenDuration To make the LiquidArea tween to its new position and dimensions instead of immediately moving/resizing, set the tween duration (in seconds) to a non-zero value. A <code>TweenLite</code> instance will be used for the tween.
		 * @param tweenVars To control other aspects of the tween (like ease, onComplete, delay, etc.), use an object just like the one you'd pass into a <code>TweenLite</code> instance as the 3rd parameter (like <code>{ease:Elastic.easeOut, delay:0.2}</code>)
		 */
		public function pinCorners(topLeft:PinPoint, bottomRight:PinPoint, reconcile:Boolean=true, tweenDuration:Number=0, tweenVars:Object=null):void {
			if (_liquidStage == null) {
				_liquidStage = LiquidStage.getByStage(_parent.stage);
			}
			var tempRetro:Boolean = Boolean(reconcile && !_liquidStage.isBaseSize && !_liquidStage.retroMode);
			if (tempRetro) {
				_liquidStage.retroMode = true;
			}
			if (_topLeftPin != null) {
				_data.destroy(false);
				if (_tweenMode) {
					_tween.kill();
				}
			}
			if (tweenDuration > 0) {
				_tween = _originalTween = dynamicTween(tweenDuration, tweenVars || {});
				_tween.setEnabled(false, false);
			}
			_topLeftPin = topLeft;
			_bottomRightPin = bottomRight;
			_liquidStage = _topLeftPin.data.liquidStage;
			
			_tlData = _topLeftPin.data;
			_brData = _bottomRightPin.data;
			capturePinData();
			
			_data = new LiquidData(_topLeftPin, this, 3, _liquidStage, false, 0, null);
			LiquidData.addCacheData(_liquidStage, _data);
			
			if (tempRetro) {
				_liquidStage.retroMode = false;
			}
		}
		
		/** @inheritDoc **/
		override public function destroy():void {
			if (_topLeftPin) {
				_data.destroy(false);
				_topLeftPin = _bottomRightPin = null;
			}
			_liquidStage = null;
			super.destroy();
		}
		
		/** @private Used by LiquidStage to capture the current positions of the top left and bottom right PinPoints before doing an update so that the relative change can be determined. **/
		public function capturePinData():void {
			_tlPrev = _parent.globalToLocal(_tlData.global);
			_brPrev = _parent.globalToLocal(_brData.global);
		}
		
		/** @private Used by LiquidStage to resize the LiquidArea after the top left and bottom right PinPoints have been updated. **/
		public function updatePins():void {
			
			var p:Point = _parent.globalToLocal(_tlData.global);
			var xDif:Number = int(p.x) - int(_tlPrev.x);
			var yDif:Number = int(p.y) - int(_tlPrev.y);
			
			p = _parent.globalToLocal(_brData.global);
			var widthDif:Number = int(p.x) - int(_brPrev.x) - xDif - _wOffset;
			var heightDif:Number = int(p.y) - int(_brPrev.y) - yDif - _hOffset;			
			var w:Number = _tweenMode ? _tween.vars.width + widthDif : this.width + widthDif;
			if (w < this.minWidth) {
				_wOffset = this.minWidth - w;
			} else if (w > this.maxWidth) {
				_wOffset = this.maxWidth - w;
			} else {
				_wOffset = 0;
			}
			w += _wOffset;
			
			var h:Number = _tweenMode ? _tween.vars.height + heightDif : this.height + heightDif;
			if (h < this.minHeight) {
				_hOffset = this.minHeight - h;
			} else if (h > this.maxHeight) {
				_hOffset = this.maxHeight - h;
			} else {
				_hOffset = 0;
			}
			h += _hOffset;
			
			if (xDif == 0 && yDif == 0 && widthDif == 0 && heightDif == 0) {
				//do nothing
				
			} else if (_tween) {
				if (_tweenMode) {
					_tween.vars.x += xDif;
					_tween.vars.y += yDif;
				} else {
					_tween.vars.x = this.x + xDif;
					_tween.vars.y = this.y + yDif;
				}
				_tween.vars.width = w;
				_tween.vars.height = h;
				
				if (_tween == _originalTween) {
					_tween.invalidate();
					_tween.restart(true, true);
				} else {
					var oldTime:Number = _tween.currentTime;
					_tween.restart(false, true);
					_tween.invalidate();
					_tween.currentTime = oldTime;
				}
				_tweenMode = true;
				
			} else {
				var oldTweenMode:Boolean = _tweenMode;
				_tweenMode = true;
				this.x += xDif;
				this.y += yDif;
				this.width = w;
				this.height = h;
				_tweenMode = oldTweenMode;
				
				update();
			}
			
		}
		
		/** @private **/
		protected function onTweenStart(vars:Object, tween:TweenLite):void {
			_tweenMode = true;
			_tween = tween;
			if (vars.onStart) {
				vars.onStart.apply(null, vars.onStartParams);
			}
		}
		
		/** @private **/
		protected function onTweenUpdate(vars:Object, tween:TweenLite):void {
			update();
			if (vars.onUpdate) {
				vars.onUpdate.apply(null, vars.onUpdateParams);
			}
		}
		
		/** @private **/
		protected function onTweenComplete(vars:Object, tween:TweenLite):void {
			_tweenMode = false;
			_tween = _originalTween;
			if (vars.onComplete) {
				vars.onComplete.apply(null, vars.onCompleteParams);
			}
		}
		
		/**
		 * If you want to tween a LiquidArea's transform properties (like <code>x, y, width, height, 
		 * scaleX,</code> or <code>scaleY</code>), you may want the destination values to be 
		 * dynamically affected by LiquidStage resizes and that's exactly what <code>dynamicTween()</code>
		 * allows. For example, maybe you start tweening to a width of 100 but in the middle of the 
		 * tween, the user widens the stage by 50 pixels - with a tween generated by 
		 * <code>dynamicTween()</code>, the width will end up being 150 instead of 100. Only one
		 * dynamic tween can be in effect at any given time. 
		 * 
		 * @param duration The duration of the tween in seconds (unless useFrames:true is passed in through the vars object in which case the duration is described in terms of frames)
		 * @param vars The tween vars object that defines the destination values, ease, etc. For example <code>{width:100, height:200, ease:Elastic.easeOut}</code>
		 * @return A TweenLite instance
		 */
		public function dynamicTween(duration:Number, vars:Object):TweenLite {
			var tv:Object = {};
			for (var p:String in vars) {
				tv[p] = vars[p];
			}
			if (!("x" in tv)) {
				tv.x = this.x;
			}
			if (!("y" in tv)) {
				tv.y = this.y;
			}
			if (!("width" in tv)) {
				tv.width = this.width;
			}
			if (!("height" in tv)) {
				tv.height = this.height;
			}
			tv.overwrite = false;
			tv.onStart = onTweenStart;
			tv.onUpdate = onTweenUpdate;
			tv.onComplete = onTweenComplete;
			tv.onStartParams = tv.onUpdateParams = tv.onCompleteParams = [vars];
			var tl:TweenLite = new TweenLite(this, duration, tv);
			tv.onStartParams[1] = tl;
			return tl;
		}
		
	}
}