/**
 * VERSION: 0.5
 * DATE: 2010-03-17
 * ACTIONSCRIPT VERSION: 3.0 
 * UPDATES AND DOCUMENTATION AT: http://www.greensock.com
 **/
package com.greensock.plugins {
	import com.greensock.TweenLite;
	import com.greensock.layout.LiquidStage;
	import com.greensock.layout.PinPoint;
	import com.greensock.layout.core.LiquidData;
	
	import flash.display.DisplayObject;
	import flash.geom.Point;
/**
 * If you're using <a href="http://www.greensock.com/liquidstage/">LiquidStage</a> and you'd like to tween 
 * a DisplayObject to coordinates that are relative to a particular <code>PinPoint</code> (like the <code>CENTER</code>)
 * whose position may change at any time, <code>LiquidPositionPlugin</code> makes it easy by dynamically updating the 
 * destination values accordingly. For example, let's say you have an "mc" Sprite that should tween to the center of
 * the screen, you could do:<br /><br />
 * 
 * <code>
 * 		import com.greensock.TweenLite; <br />
 * 		import com.greensock.layout.~~; <br />
 * 		import com.greensock.plugins.~~; <br />
 * 		TweenPlugin.activate([LiquidPositionPlugin]); //activation is permanent in the SWF, so this line only needs to be run once.<br /><br />
 * 
 * 		var ls:LiquidStage = new LiquidStage(this.stage, 550, 400, 550, 400); <br /><br />
 * 
 * 		TweenLite.to(mc, 2, {liquidPosition:{pin:ls.CENTER}}); <br /><br />
 * </code>
 * 
 * Or to tween to exactly x:100, y:200 but have that position move with the <code>TOP_RIGHT</code> PinPoint 
 * whenever it repositions (so they retain their relative distance from each other), the tween would look like this:<br /><br />
 * 
 * <code>
 * 		TweenLite.to(mc, 2, {liquidPosition:{x:100, y:200, pin:ls.TOP_RIGHT}}); <br /><br />
 * </code>
 * 
 * To prevent the <code>LiquidPositionPlugin</code> from controlling the object's y property, 
 * simply pass <code>ignoreY:true</code> in the vars object. The same goes for the x position: 
 * <code>ignoreX:true</code>.<br /><br />
 * 
 * By default, <code>LiquidPositionPlugin</code> will reconcile the position which means it will 
 * act as though the coordinates were defined before the stage was resized (so they'd be according 
 * to the original size at which the swf was built in the IDE). If you don't want it to reconcile,
 * simply pass <code>reconcile:false</code> through the vars object. <br /><br />
 * 
 * LiquidPositionPlugin is a Club GreenSock membership benefit and requires <a href="http://www.greensock.com/liquidstage/">LiquidStage</a>. 
 * You must have a valid membership to use this class without violating the terms of use. Visit 
 * <a href="http://www.greensock.com/club/">http://www.greensock.com/club/</a> 
 * to sign up or get more details.<br /><br />
 * 
 * <b>Copyright 2010, GreenSock. All rights reserved.</b> This work is subject to the terms in <a href="http://www.greensock.com/terms_of_use.html">http://www.greensock.com/terms_of_use.html</a> or for corporate Club GreenSock members, the software agreement that was issued with the corporate membership.
 * 
 * @author Jack Doyle, jack@greensock.com
 */
	public class LiquidPositionPlugin extends TweenPlugin {
		/** @private **/
		public static const API:Number = 1.0; //If the API/Framework for plugins changes in the future, this number helps determine compatibility
		
		/** @private **/
		protected var _tween:TweenLite;
		/** @private **/
		protected var _target:DisplayObject;
		/** @private **/
		protected var _prevFactor:Number;
		/** @private **/
		protected var _prevTime:Number;
		/** @private **/
		protected var _xStart:Number;
		/** @private **/
		protected var _yStart:Number;
		/** @private **/
		protected var _xOffset:Number;
		/** @private **/
		protected var _yOffset:Number;
		/** @private **/
		protected var _data:LiquidData;
		/** @private **/
		protected var _ignoreX:Boolean;
		/** @private **/
		protected var _ignoreY:Boolean;
		
		
		/** Constructor **/
		public function LiquidPositionPlugin() {
			super();
			this.propName = "liquidPosition"; //name of the special property that the plugin should intercept/manage
			this.overwriteProps = [];
		}
		
		/** @private **/
		override public function onInitTween(target:Object, value:*, tween:TweenLite):Boolean {
			if (!(target is DisplayObject)) {
				throw Error("Tween Error: liquidPosition requires that the target be a DisplayObject.");
				return false;
			} else if (!("pin" in value) || !(value.pin is PinPoint)) {
				throw Error("Tween Error: liquidPosition requires a valid 'pin' property which must be a PinPoint.");
				return false;
			}
			_target = DisplayObject(target);
			_tween = tween;
			_prevFactor = _tween.ratio;
			_prevTime = _tween.cachedTime;
			_ignoreX = Boolean(value.ignoreX == true);
			_ignoreY = Boolean(value.ignoreY == true);
			_data = PinPoint(value.pin).data;
			_xStart = _target.x;
			_yStart = _target.y;
			
			var ls:LiquidStage = _data.liquidStage;
			var reconcile:Boolean = Boolean(value.reconcile != false);
			if (reconcile) {
				ls.retroMode = true;
			}
			var local:Point = _target.parent.globalToLocal(_data.global);
			
			_xOffset = ("x" in value) ? value.x - local.x : 0;
			if (!_ignoreX) {
				this.overwriteProps[this.overwriteProps.length] = "x";
			} 
			_yOffset = ("y" in value) ? value.y - local.y : 0;
			if (!_ignoreY) {
				this.overwriteProps[this.overwriteProps.length] = "y";
			}
			
			if (reconcile) {
				ls.retroMode = false;
			}
			return true;
		}
		
		/** @private **/
		override public function killProps(lookup:Object):void {
			if ("x" in lookup) {
				_ignoreX = true;
			}
			if ("y" in lookup) {
				_ignoreY = true;
			}
			super.killProps(lookup);
		}
		
		/** @private **/
		override public function set changeFactor(n:Number):void {
			if (n != _prevFactor) {
				var ratio:Number;
				var local:Point = _target.parent.globalToLocal(_data.global);
				local.x += _xOffset;
				local.y += _yOffset;
				
				//going forwards towards the end
				if (_tween.cachedTime > _prevTime) {
					ratio = (n == 1 || _prevFactor == 1) ? 0 : 1 - ((n - _prevFactor) / (1 - _prevFactor));
					
					if (!_ignoreX) {
						_target.x = local.x - ((local.x - _target.x) * ratio);
					}
					if (!_ignoreY) {
						_target.y = local.y - ((local.y - _target.y) * ratio);
					}
					
				//going backwards towards the start
				} else {
					ratio = (n == 0 || _prevFactor == 0) ? 0 : 1 - ((n - _prevFactor) / -_prevFactor);
					
					if (!_ignoreX) {
						_target.x = _xStart + ((_target.x - _xStart) * ratio);
					}
					if (!_ignoreY) {
						_target.y = _yStart + ((_target.y - _yStart) * ratio);
					}
				}
				
				_prevFactor = n;
			}
			_prevTime = _tween.cachedTime;
		}
		
	}
}