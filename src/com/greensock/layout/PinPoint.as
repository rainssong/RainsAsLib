/**
 * VERSION: 2.1
 * DATE: 2010-04-08
 * AS3
 * UPDATES AND DOCUMENTATION AT: http://www.greensock.com/liquidstage/
 **/
package com.greensock.layout {
	import com.greensock.layout.core.LiquidData;
	
	import flash.display.DisplayObject;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.geom.Point;
/**
 * PinPoint works with LiquidStage to create reference points on the stage and/or inside 
 * DisplayObjects so that the movement of these PinPoints trickles down and affects
 * the position of attached DisplayObjects. See LiquidStage documentation for more information. <br /><br />
 * 
 * <b>Copyright 2010, GreenSock. All rights reserved.</b> This work is subject to the terms in <a href="http://www.greensock.com/terms_of_use.html">http://www.greensock.com/terms_of_use.html</a> or for corporate Club GreenSock members, the software agreement that was issued with the corporate membership.
 * 
 * @author Jack Doyle, jack@greensock.com
 */	 
	public class PinPoint extends Point implements IEventDispatcher {
		/** @private **/
		public static const version:Number = 2.1;
		/** @private **/
		protected var _dispatcher:EventDispatcher;
		/** @private **/
		protected var _data:LiquidData;
		
		/**
		 * Constructor
		 * 
		 * @param x x coordinate
		 * @param y y coordinate
		 * @param target target DisplayObject who is like the "parent" of this PinPoint (its coordinate system is used for the x and y values). You can pass in the stage that is associated with a LiquidStage if you want the PinPoint to use the stage as its parent.
		 * @param liquidStage Optionally declare the LiquidStage instance to which this PinPoint should be associated. If none is defined, the class will try to determine the LiquidStage instance based on the target's <code>stage</code> property (<code>LiquidStage.getByStage()</code>). The only time it is useful to specifically declare the LiquidStage instance is when you plan to subload a swf that uses LiquidStage into another swf that also has a LiquidStage instance (thus they share the same stage).
		 */
		public function PinPoint(x:Number, y:Number, target:DisplayObject, liquidStage:LiquidStage=null) {
			super(x, y);
			var t:DisplayObject = (target is Stage) ? LiquidStage.getByStage(target as Stage).stageBox : target;
			init(t, liquidStage);
		}
		
		/** @private **/
		protected function init(target:DisplayObject, liquidStage:LiquidStage):void {
			_data = new LiquidData(this, target, 0, liquidStage || LiquidStage.getByStage(target.stage), false, 0, null);
			LiquidData.addCacheData(_data.liquidStage, _data);
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
		 * @param strict In strict mode, the target will be forced to remain <b>EXACTLY</b> the same distance from the pin as it was when it was attached. If strict is false, LiquidStage will honor any manual changes you make to the target's position, making it more flexible. Note that LiquidStage only performs updates to the target's position when the stage resizes and/or when <code>update()</code> is called.
		 * @param reconcile If <code>true</code>, the target's position will immediately be moved as far as the PinPoint has moved from its original position, effectively acting as though the target was attached BEFORE the stage was scaled. If you attach an object after the stage has been scaled and you don't want it to reconcile with the PinPoint initially, set <code>reconcile</code> to <code>false</code>.
		 * @param tweenDuration To make the target tween to its new position instead of immediately moving there, set the tween duration (in seconds) to a non-zero value. A <code>TweenLite</code> instance will be used for the tween.
		 * @param tweenVars To control other aspects of the tween (like ease, onComplete, delay, etc.), use an object just like the one you'd pass into a <code>TweenLite</code> instance as the 3rd parameter (like <code>{ease:Elastic.easeOut, delay:0.2}</code>)
		 */
		public function attach(target:DisplayObject, strict:Boolean=false, reconcile:Boolean=true, tweenDuration:Number=0, tweenVars:Object=null):void {
			_data.liquidStage.attach(target, this, strict, reconcile, tweenDuration, tweenVars);
		}
		/**
		 * Releases a DisplayObject from being controlled by LiquidStage after having been attached. 
		 * 
		 * @param target The DisplayObject to release
		 * @return if the target was found and released, this value will be true. Otherwise, it will be false.
		 */
		public function release(target:DisplayObject):Boolean {
			return _data.liquidStage.release(target);
		}
		
		/**
		 * Determines a PinPoint's coordinates according to any DisplayObject's coordinate space. 
		 * For example, to figure out where the CENTER PinPoint is inside the "myImage" DisplayObject,
		 * you'd do:<br /><br /><code>
		 * 
		 * var point:Point = myPinPoint.toLocal(myImage);</code>
		 * 
		 * @param target DisplayObject whose coordinate space the PinPoint's position should be translated into.
		 * @return Point translated into the target's coordinate space.
		 */
		public function toLocal(target:DisplayObject):Point {
			return target.globalToLocal(_data.target.localToGlobal(this));
		}
		
		/** Forces an update of LiquidStage (useful if you manually changed this PinPoint's coordinates) **/
		public function update():void {
			_data.liquidStage.update(null);
		}
		
		/** @inheritDoc **/
		override public function clone():Point {
			return new PinPoint(this.x, this.y, _data.target, _data.liquidStage);
		}
		
		/** Destroys the PinPoint, making it eligible for garbage collection. **/
		public function destroy():void {
			_data.destroy(false);
			_data = null;
		}
		
		
//---- EVENT DISPATCHING -------------------------------------------------------------------------------
		
		/**
		 * Use this to add an <code>Event.CHANGE</code> listener to find out when the PinPoint moves.
		 *  
		 * @param type Event type (<code>Event.CHANGE</code>)
		 * @param listener Listener function
		 * @param useCapture useCapture
		 * @param priority Priority level
		 * @param useWeakReference Use weak references
		 */
		public function addEventListener(type:String, listener:Function, useCapture:Boolean=false, priority:int = 0, useWeakReference:Boolean=false):void {
			if (_dispatcher == null) {
				_dispatcher = new EventDispatcher(this);
			}
			_data.hasListener = true;
			_dispatcher.addEventListener(type, listener, useCapture, priority, useWeakReference);
		}
		
		/** @inheritDoc **/
		public function removeEventListener(type:String, listener:Function, useCapture:Boolean=false):void {
			if (_dispatcher) {
				_dispatcher.removeEventListener(type, listener, useCapture);
			}
		}
		/** @inheritDoc **/
		public function hasEventListener(type:String):Boolean {
			return (_dispatcher == null) ? false : _dispatcher.hasEventListener(type);
		}
		/** @inheritDoc **/
		public function willTrigger(type:String):Boolean {
			return (_dispatcher == null) ? false : _dispatcher.willTrigger(type);
		}
		/** @inheritDoc **/
		public function dispatchEvent(event:Event):Boolean {
			return (_dispatcher == null) ? false : _dispatcher.dispatchEvent(event);
		}
		
//---- GETTERS / SETTERS --------------------------------------------------------------------------------
		
		/** @private **/
		public function get target():DisplayObject {
			return _data.target;
		}
		
		/** @private **/
		public function set target(value:DisplayObject):void {
			_data.target = value;
			if (value.stage != _data.liquidStage.stage) {
				_data.liquidStage = LiquidStage.getByStage(value.stage);
			}
			_data.refreshPoints();
		}
		
		/** @private **/
		public function get data():LiquidData {
			return _data;
		}
		
	}
}