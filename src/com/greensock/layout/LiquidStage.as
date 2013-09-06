/**
 * VERSION: 2.05
 * DATE: 2010-04-10
 * AS3
 * UPDATES AND DOCUMENTATION AT: http://www.greensock.com/liquidstage/
 **/
package com.greensock.layout {
	import com.greensock.TweenLite;
	import com.greensock.layout.core.LiquidData;
	
	import flash.display.*;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.geom.Point;
	import flash.utils.Dictionary;
/**
 * LiquidStage allows you to "pin" DisplayObjects to reference points on the stage (or inside other DisplayObjects) 
 * so that when the stage is resized, they are repositioned and maintain their relative distance from
 * the PinPoint. For example, you could make a logo Sprite stay in the bottom right corner when the stage is resized.
 * 
 * You can also scale or stretch DisplayObjects using the LiquidArea class which allows you to define a rectangular
 * area that expands and contracts as the stage resizes, and you attach DisplayObjects so that they
 * fill the area, scaling in any of the following modes: <code>STRETCH, PROPORTIONAL_INSIDE, PROPORTIONAL_OUTSIDE, WIDTH_ONLY,</code>
 * or <code>HEIGHT_ONLY</code>. For example, you could have a bar snap to the bottom of the screen and 
 * stretch horizontally to fill the width of the stage. Or add a background image that proportionally scales 
 * to fill the entire stage.<br /><br />
 *	
 * There are a few things that make LiquidStage particularly useful:
 *	<ul>
 *		<li> Your DisplayObjects do not need to be at the root level - LiquidStage will compensate for nesting even if the DisplayObject's
 *		  anscestors are offset and/or scaled. </li>
 *		<li> By default, repositioning only factors in the amount of change in the PinPoint's position, meaning 
 * 			you are free to move the DisplayObject manually and LiquidStage will honor its new position instead of 
 * 			forcing it to always remain a certain distance from the PinPoint (although a "strict" mode is available too).</li>
 *		<li> Not only can you pin things to the <code>TOP_LEFT, TOP_CENTER, TOP_RIGHT, RIGHT_CENTER, BOTTOM_RIGHT, 
 * 			BOTTOM_CENTER, BOTTOM_LEFT, LEFT_CENTER,</code> and <code>CENTER</code>, but you can create your own 
 * 			custom PinPoints in any DisplayObject.</li>
 *		<li> LiquidStage leverages the TweenLite engine to allow for animated transitions. Simply define the duration 
 * 			of the tween and optionally pass in a tween vars object to control other aspects of the tween like its
 * 			ease, delay, add an onComplete, onUpdate, etc.</li>
 *		<li> LiquidStage does NOT force you to align the stage to the upper left corner - it will honor whatever StageAlign you choose.</li>
 *		<li> Optionally define a minimum/maximum width and height to prevent objects from repositioning when the stage 
 * 			gets too small or too big.</li>
 *		<li> LiquidStage only does its work when the stage resizes, and it is built for maximum performance.</li>
 *	</ul> 
 *	
 *	
 * @example Example AS3 code:<listing version="3.0">
import com.greensock.layout.~~;

//create a LiquidStage instance for the current stage which was built at an original size of 550x400
//don't allow the stage to collapse smaller than 550x400 either.
var ls:LiquidStage = new LiquidStage(this.stage, 550, 400, 550, 400);
 
//attach a "logo" Sprite to the BOTTOM_RIGHT PinPoint
ls.attach(logo, ls.BOTTOM_RIGHT);

//create a 300x100 rectangular area at x:50, y:70 that stretches when the stage resizes (as though its top left and bottom right corners are pinned to their corresponding PinPoints on the stage)
var area:LiquidArea = new LiquidArea(this, 50, 70, 300, 100);

//attach a "myImage" Sprite to the area and set its ScaleMode to PROPORTIONAL_INSIDE and horizontally and vertically align it in the center of the area
area.attach(myImage, ScaleMode.PROPORTIONAL_INSIDE, AlignMode.CENTER, AlignMode.CENTER);

//if you'd like to preview the area visually (by default previewColor is red), set preview to true
area.preview = true;
 
//attach a RESIZE event listener to the LiquidStage instance (you could do this with the LiquidArea as well)
ls.addEventListener(Event.RESIZE, onLiquidStageUpdate);
function onLiquidStageUpdate(event:Event):void {
	trace("updated LiquidStage");
}

</listing>
 *		
 * <b>NOTES / LIMITATIONS:</b>
 * <ul>
 *		<li> You need to set up your objects on the stage initially with the desired relative distance between
 * 			them and their PinPoint; LiquidStage doesn't reposition them initially. For example, if you want
 * 			logo_mc to be exactly 20 pixels away from the BOTTOM_RIGHT corner of the stage on both axis (x and y),
 * 			you must put it there before attach()-ing it.</li>
 *		<li> If a DisplayObject is not in the display list (has no parent), LiquidStage will ignore it until it 
 * 			is back in the display list.</li>
 * 		<li> If you plan to set the <code>align</code> property of your stage, do so before creating its LiquidStage
 * 			instance.</li>
 * 		<li> LiquidStage is a <a href="http://www.greensock.com/club/">Club GreenSock</a> membership benefit. 
 * 			You must have a valid membership to use this class without violating the terms of use. Visit 
 * 			<a href="http://www.greensock.com/club/">http://www.greensock.com/club/</a> to sign up or get more details.</li>
 * </ul>
 * 
 * <b>Copyright 2010, GreenSock. All rights reserved.</b> This work is subject to the license that came with your Club GreenSock membership and is <b>ONLY</b> to be used by corporate or "Shockingly Green" Club GreenSock members. To learn more about Club GreenSock, visit <a href="http://blog.greensock.com/club/">http://blog.greensock.com/club/</a>.
 * 
 * @author Jack Doyle, jack@greensock.com
 */	 
	public class LiquidStage extends EventDispatcher {
		/** @private **/
		public static const VERSION:Number = 2.05;
		/** Refers to the first LiquidStage instance created (or you can set it to any other instance) - it serves as an easy way to reference a LiquidStage through a static variable. **/
		public static var defaultStage:LiquidStage;
		
		/** @private **/
		private static var _instances:Dictionary = new Dictionary(true);
		
		/** @private Sprite that stretches to cover the stage **/
		private var _stageBox:Sprite = new Sprite();
		/** @private Populated with LiquidData objects (one for each PinPoint and pinned DisplayObjects) **/
		private var _items:Array;
		/** @private 0 = left, 1 = center, 2 = right **/
		private var _xStageAlign:uint;
		/** @private 0 = top, 1 = center, 2 = bottom**/
		private var _yStageAlign:uint;
		/** @private to improve performance, we don't dispatch events unless addEventListener() has been called. **/
		private var _hasListener:Boolean; 
		/** @private reference to the stage to which LiquidStage was applied **/
		private var _stage:Stage;
		/** @private **/
		private var _baseWidth:uint;
		/** @private **/
		private var _baseHeight:uint;
		/** @private **/
		private var _retroMode:Boolean;
		
		/** top left corner of the stage **/
		public var TOP_LEFT:PinPoint;
		/** top center of the stage **/
		public var TOP_CENTER:PinPoint;
		/** top right corner of the stage **/
		public var TOP_RIGHT:PinPoint;
		/** bottom left corner of the stage **/
		public var BOTTOM_LEFT:PinPoint;
		/** bottom center of the stage **/
		public var BOTTOM_CENTER:PinPoint;
		/** bottom right corner of the stage **/
		public var BOTTOM_RIGHT:PinPoint;
		/** left center of the stage **/
		public var LEFT_CENTER:PinPoint;
		/** right center of the stage **/
		public var RIGHT_CENTER:PinPoint;
		/** center of the stage **/
		public var CENTER:PinPoint;
		
		/** minimum width of the LiquidStage area **/
		public var minWidth:uint;
		/** minimum height of the LiquidStage area **/
		public var minHeight:uint;
		/** maximum width of the LiquidStage area **/
		public var maxWidth:uint;
		/** maximum height of the LiquidStage area **/
		public var maxHeight:uint;
		/** @private to improve speed, LiquidArea instances ignore CHANGE events dispatched by PinPoints when the LiquidStage is resizing. This way, they can react when the user manually tweens/changes the PinPoints and also maximize performance on stage resizes because they just listen for LiquidStage RESIZE events (otherwise they'd update twice every resize, once for each PinPoint) **/
		public var resizing:Boolean;
		
		/**
		 * Constructor
		 * 
		 * @param stage The Stage to which LiquidStage is applied
		 * @param baseWidth The width of the SWF as it was built in the IDE originally (NOT the width that it is stretched to in the browser or standalone player). 
		 * @param baseHeight The height of the SWF as it was built in the IDE originally (NOT the height that it is stretched to in the browser or standalone player). 
		 * @param minWidth Minimum width (if you never want the width of LiquidStage to go below a certain amount, use minWidth).
		 * @param minHeight Minimum height (if you never want the height of LiquidStage to go below a certain amount, use minHeight).
		 * @param maxWidth Maximum width (if you never want the width of LiquidStage to exceed a certain amount, use maxWidth).
		 * @param maxHeight Maximum height (if you never want the height of LiquidStage to exceed a certain amount, use maxHeight).
		 */
		public function LiquidStage(stage:Stage, baseWidth:uint, baseHeight:uint, minWidth:uint=0, minHeight:uint=0, maxWidth:uint=99999999, maxHeight:uint=99999999):void {
			
			if (TweenLite.version < 11.1) {
				throw new Error("LiquidStage warning: please update your TweenLite class to at least version 11.1 at http://www.TweenLite.com.");
			} else if (stage == null) {
				throw new Error("LiquidStage error: you must define a valid stage instance in the constructor. If the stage is null, please addEventListener(Event.ADDED_TO_STAGE) one of your DisplayObjects and wait to create the LiquidStage instance until AFTER the stage property is not null.");
			}
			
			_stage = stage;
			if (_stage in _instances) {
				_instances[_stage] = this;
			}
			if (LiquidStage.defaultStage == null) {
				LiquidStage.defaultStage = this;
			}
			
			this.minWidth = minWidth;
			this.minHeight = minHeight;
			this.maxWidth = maxWidth;
			this.maxHeight = maxHeight;
			
			_stageBox.graphics.beginFill(0x0000FF, 0.5);
			_stageBox.graphics.drawRect(0, 0, baseWidth, baseHeight);
			_stageBox.graphics.endFill();
			_stageBox.name = "__stageBox_mc";
			_stageBox.visible = false;
			
			_items = [];
			_baseWidth = baseWidth;
			_baseHeight = baseHeight;
			
			TOP_LEFT = 		new PinPoint(0, 0, _stageBox, this);
			TOP_CENTER = 	new PinPoint(baseWidth * 0.5, 0, _stageBox, this);
			TOP_RIGHT = 	new PinPoint(baseWidth, 0, _stageBox, this);
			RIGHT_CENTER = 	new PinPoint(baseWidth, baseHeight * 0.5, _stageBox, this);
			BOTTOM_RIGHT = 	new PinPoint(baseWidth, baseHeight, _stageBox, this);
			BOTTOM_CENTER = new PinPoint(baseWidth * 0.5, baseHeight, _stageBox, this);
			BOTTOM_LEFT = 	new PinPoint(0, baseHeight, _stageBox, this);
			LEFT_CENTER = 	new PinPoint(0, baseHeight * 0.5, _stageBox, this);
			CENTER = 		new PinPoint(baseWidth * 0.5, baseHeight * 0.5, _stageBox, this);
			
			_stage.addEventListener(Event.RESIZE, update);
			_stage.scaleMode = StageScaleMode.NO_SCALE;
			
			switch (_stage.align) {
				case StageAlign.TOP_LEFT:
					_xStageAlign = 0;
					_yStageAlign = 0;
					break;
				case "":
					_xStageAlign = 1;
					_yStageAlign = 1;
					break;
				case StageAlign.TOP:
					_xStageAlign = 1;
					_yStageAlign = 0;
					break;
				case StageAlign.BOTTOM:
					_xStageAlign = 1;
					_yStageAlign = 2;
					break;
				case StageAlign.BOTTOM_LEFT:
					_xStageAlign = 0;
					_yStageAlign = 2;
					break;
				case StageAlign.BOTTOM_RIGHT:
					_xStageAlign = 2;
					_yStageAlign = 2;
					break;
				case StageAlign.LEFT:
					_xStageAlign = 0;
					_yStageAlign = 1;
					break;
				case StageAlign.RIGHT:
					_xStageAlign = 2;
					_yStageAlign = 1;
					break;
				case StageAlign.TOP_RIGHT:
					_xStageAlign = 2;
					_yStageAlign = 0;
					break;
			}
			
			_stage.addEventListener(Event.ENTER_FRAME, onFirstRender);
		}
		
		/** @private **/
		protected function onFirstRender(event:Event):void {
			_stage.removeEventListener(Event.ENTER_FRAME, onFirstRender);
			update(event);
		}
		
		/**
		 * Retrieves the LiquidStage instance associated with a particular stage. For example:<br /><br /><code>
		 * 
		 * //create the LiquidStage instance<br />
		 * var ls:LiquidStage = new LiquidStage(this.stage, 550, 400); <br /><br />
		 * 
		 * //then later, if you need to find the LiquidStage instance for this stage to attach() objects, you could do this:<br />
		 * var ls:LiquidStage = LiquidStage.getByStage(this.stage);<br />
		 * ls.attach(mc1, ls.TOP_RIGHT);<br />
		 * ls.attach(mc2, ls.BOTTOM_CENTER);<br /></code>
		 * 
		 * @param stage The stage whose LiquidStage instance to return
		 * @return LiquidStage instance associated with the stage
		 */
		public static function getByStage(stage:Stage):LiquidStage {
			return _instances[stage] || defaultStage;
		}
		
		/**
		 * Attaches a DisplayObject to a particular PinPoint (like <code>TOP_RIGHT</code>) so that any movement of the 
		 * PinPoint will also affect the relative position of the DisplayObject. Attaching the DisplayObject
		 * does NOT force it to share the same coordinates as the PinPoint - it simply causes the PinPoint's 
		 * movement to proportionally affect the position of the DisplayObject. The relationship is one-way
		 * so moving the DisplayObject will not move the PinPoint. Unless the <code>strict</code> parameter
		 * is <code>true</code>, changes are relative so you are free to move the DisplayObject as you wish and when the 
		 * PinPoint's position changes, its proportional movement will honor the DisplayObject's new position
		 * instead of forcing it back to the same distance from the PinPoint. But again, you can set
		 * the <code>strict</code> parameter to <code>true</code> if you want to force the object to always 
		 * maintain a certain distance from the PinPoint<br /><br />
		 * 
		 * For example, if your object is 100 pixels away from the PinPoint and the PinPoint moves 15 pixels,
		 * the DisplayObject will move 15 pixels as well (or however many pixels it takes to maintain its relative
		 * distance to the PinPoint which may be more or less than 15 pixels if it is nested inside a scaled parent).
		 * Strict mode, however, will force the DisplayObject to maintain its exact distance away from the PinPoint
		 * (no manual position changes will be honored when LiquidStage updates).
		 * 
		 * @param target The DisplayObject to attach
		 * @param pin The PinPoint to which the target should be attached (like <code>TOP_RIGHT</code> or <code>CENTER</code> or a custom PinPoint)
		 * @param strict In strict mode, the target will be forced to remain <b>EXACTLY</b> the same distance from the pin as it was when it was attached. If strict is false, LiquidStage will honor any manual changes you make to the target's position, making it more flexible. Note that LiquidStage only performs updates to the target's position when the stage resizes and/or when <code>update()</code> is called.
		 * @param reconcile If true, the target's position will immediately be moved as far as the PinPoint has moved from its original position, effectively acting as though the target was attached BEFORE the stage was scaled. If you attach an object after the stage has been scaled and you don't want it to reconcile with the PinPoint initially, set <code>reconcile</code> to <code>false</code>.
		 * @param tweenDuration To make the target tween to its new position instead of immediately moving there, set the tween duration (in seconds) to a non-zero value. A <code>TweenLite</code> instance will be used for the tween.
		 * @param tweenVars To control other aspects of the tween (like ease, onComplete, delay, etc.), use an object just like the one you'd pass into a <code>TweenLite</code> instance as the 3rd parameter (like <code>{ease:Elastic.easeOut, delay:0.2}</code>)
		 */
		public function attach(target:DisplayObject, pin:PinPoint, strict:Boolean=false, reconcile:Boolean=true, tweenDuration:Number=0, tweenVars:Object=null):void {
			var ls:LiquidStage = LiquidStage.getByStage(target.stage) || this;
			if (ls != this) {
				ls.release(target);
			}
			this.release(target); //in case it's already being watched or was pinned with another PinPoint.
			var data:LiquidData = pin.data;
			var tempRetro:Boolean = Boolean(reconcile && !this.isBaseSize);
			if (tempRetro) {
				this.retroMode = true;
			}
			LiquidData.addCacheData(this, new LiquidData(pin, target, 2, this, strict, tweenDuration, tweenVars));
			if (tempRetro) {
				this.retroMode = false;
			}
		}
		
		/**
		 * Releases a DisplayObject from being controlled by LiquidStage after having been attached. 
		 * 
		 * @param target The DisplayObject to release
		 * @return if the target was found and released, this value will be true. Otherwise, it will be false.
		 */
		public function release(target:DisplayObject):Boolean {
			var i:int = _items.length;
			var item:LiquidData;
			while (--i > -1) {
				item = _items[i];
				if (item.target == target && item.type == 2) {
					_items.splice(i, 1);
					item.destroy(true);
					return true;
				}
			}
			return false;
		}
		
		/** Forces an update of all PinPoints and DisplayObject positions. **/
		public function update(event:Event=null):void {
			var w:Number = _retroMode ? _baseWidth : _stage.stageWidth; 
			var h:Number = _retroMode ? _baseHeight : _stage.stageHeight;
			
			//REMOVE
			if (this.minHeight == 599) {
				trace(w+", "+h);
			}
			
			if (w < this.minWidth) {
				w = this.minWidth;
			} else if (w > this.maxWidth) {
				w = this.maxWidth;
			}
			if (h < this.minHeight) {
				h = this.minHeight;
			} else if (h > this.maxHeight) {
				h = this.maxHeight;
			}
			if (_xStageAlign == 1) {
				_stageBox.x = (TOP_RIGHT.x - w) / 2;
			} else if (_xStageAlign == 2) {
				_stageBox.x = TOP_RIGHT.x - w;
			}
			if (_yStageAlign == 1) {
				_stageBox.y = (BOTTOM_LEFT.y - h) / 2;
			} else if (_yStageAlign == 2) {
				_stageBox.y = BOTTOM_LEFT.y - h;
			}
			
			if (event != null) {
				this.resizing = true;
			}
			
			_stageBox.width = w;
			_stageBox.height = h;
			
			updateItems();
		
			this.resizing = false;
			if (_hasListener) {
				dispatchEvent(new Event(Event.RESIZE));
			}
				
		}
		
		/** @private **/
		private function updateItems():void {
			_stage.addChild(_stageBox);
			var event:Event = new Event(Event.CHANGE);
			var item:LiquidData, p:Point, p2:Point, xDif:Number, yDif:Number;
			var revert:Array = [];
			var cnt:uint = 0;
			
			var i:int = _items.length;
			
			//for objects that aren't strictly pinned, we need to set the reference values first before we move anything so that we can determine the amount of relative distance the resize caused.
			while (--i > -1) {
				item = _items[i];
				if (item.type == 3) {
					(item.target as Object).capturePinData(); //didn't strict data type this so that file size could be minimized (otherwise LiquidArea and AutoFitArea would be forced to be included)
				} else if (item.type == 2 && !item.strict && item.target.parent) {
					p = item.target.parent.globalToLocal(item.global);
					item.reference.x = int(p.x);
					item.reference.y = int(p.y);
				}
			}
			
			i = _items.length;
			while (--i > -1) {
				item = _items[i];
				
				if (item.type == 3) {
					(item.target as Object).updatePins(); //didn't strict data type this so that file size could be minimized (otherwise LiquidArea and AutoFitArea would be forced to be included)
				
				//item is a PinPoint or DynamicPinPoint
				} else if (item.type < 2) {
					if (item.type == 1) {
						p = item.getter();
						item.pin.x = p.x;
						item.pin.y = p.y;
					}
					p = item.target.localToGlobal(item.pin);
					item.reference.x = item.global.x;
					item.reference.y = item.global.y;
					item.global.x = int(p.x);
					item.global.y = int(p.y);
					
					if (item.hasListener && (item.global.x != item.reference.x || item.global.y != item.reference.y)) {
						item.pin.dispatchEvent(event);
					}
				
				//item is a DisplayObject that has been pinned
				} else if (item.target.parent) {
					
					if (item.strict) {
						p = item.target.parent.globalToLocal(new Point(item.global.x + item.reference.x, item.global.y + item.reference.y));
						xDif = p.x - item.target.x;
						yDif = p.y - item.target.y;
					} else {
						p = item.target.parent.globalToLocal(item.global);
						p2 = item.reference;
						xDif = int(p.x) - int(p2.x);
						yDif = int(p.y) - int(p2.y);
					}
					
					if (item.tween) {
						if (item.tween.cachedTime < item.tween.cachedDuration && !item.tween.gc) {
							if (item.strict) {
								xDif = p.x - item.tween.vars.x;
								yDif = p.y - item.tween.vars.y;
							}
							item.tween.vars.x += xDif;
							item.tween.vars.y += yDif;
						} else {
							item.tween.vars.x = item.target.x + xDif;
							item.tween.vars.y = item.target.y + yDif;
						}
						
						//to ensure that nested objects are offset correctly, we must render the end position temporarily, then later in this method we return tweening objects to their current position
						item.xRevert = item.target.x;
						item.yRevert = item.target.y;
						revert[cnt++] = item;
						
						item.target.x = item.tween.vars.x;
						item.target.y = item.tween.vars.y; 
						
					} else {
						item.target.x += xDif;
						item.target.y += yDif;
					}
					
				}
			}
			
			//now revert tweening objects to their previous position and restart the tween.
			i = revert.length;
			while (--i > -1) {
				item = revert[i];
				item.tween.restart(true, true);
				item.target.x = item.xRevert;
				item.target.y = item.yRevert;
				item.tween.invalidate();
			}
			
			_stage.removeChild(_stageBox);
		}
		
		
		/** @private 
		 * The order in which updates are made is extremely important because of nesting; refreshLevels() 
		 * looks at each attached DisplayObject's and PinPoint's level in the display list hierarchy and
		 * organizes things accordingly.
		 **/
		public function refreshLevels():void { //nesting levels are extremely important in terms of the order in which we update LiquidItems and PinPoints...
			var i:int = _items.length;
			while (--i > -1) {
				LiquidData(_items[i]).refreshLevel();
			}
			_items.sortOn("level", Array.NUMERIC | Array.DESCENDING); //to ensure that nested objects are updated AFTER their parents.
		}
		
		/**
		 * Use this to add an <code>Event.RESIZE</code> event listener which can be
		 * particularly handy if you need to run other functions AFTER LiquidStage does all its repositioning.
		 *  
		 * @param type Event type (<code>Event.RESIZE</code>)
		 * @param listener Listener function
		 * @param useCapture useCapture
		 * @param priority Priority level
		 * @param useWeakReference Use weak references
		 */
		override public function addEventListener(type:String, listener:Function, useCapture:Boolean=false, priority:int=0, useWeakReference:Boolean=false):void {
			_hasListener = true; //just so we can avoid dispatching events when there are no listeners (which will likely happen most of the time)
			super.addEventListener(type, listener, useCapture, priority, useWeakReference);
		}
		
		/** The stage associated with the LiquidStage instance **/
		public function get stage():Stage {
			return _stage;
		}
		
		/** @private **/
		public function get stageBox():Sprite {
			return _stageBox;
		}
		
		/** @private Used primarily by LiquidData **/
		public function get cacheData():Array {
			return _items;
		}
		
		/** When <code>retroMode</code> is <code>true</code>, LiquidStage will revert to (and stay at) the base stage size as it was defined in the constructor (<code>baseWidth</code> and <code>baseHeight</code>) which can be useful when you want to pin objects according to coordinates on the original (unscaled) stage. **/
		public function get retroMode():Boolean {
			return _retroMode;
		}
		public function set retroMode(value:Boolean):void {
			if (value != _retroMode) {
				_retroMode = value;
				update(null);
			}
		}
		
		/** Only <code>true</code> when the LiquidStage instance is at the base size as it was defined in the constructor (<code>baseWidth</code> and <code>baseHeight</code>). This essentially indicates whether or not the stage is currently scaled. **/
		public function get isBaseSize():Boolean {
			return Boolean(_stageBox.width == _baseWidth && _stageBox.height == _baseHeight);
		}
		
	}
}
