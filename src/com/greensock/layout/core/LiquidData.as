/**
 * VERSION: 2.04
 * DATE: 2010-04-08
 * AS3
 * UPDATES AND DOCUMENTATION AT: http://www.greensock.com/liquidstage/
 **/
package com.greensock.layout.core {
	import com.greensock.TweenLite;
	import com.greensock.layout.LiquidStage;
	import com.greensock.layout.PinPoint;
	
	import flash.display.DisplayObject;
	import flash.display.Stage;
	import flash.geom.Point;
/**
 * LiquidData holds core information about PinPoints and DisplayObjects that have been
 * attached to a LiquidStage, but this class is only intended to be used by LiquidStage
 * internally - there is no reason to use it directly. 
 * 
 * <b>Copyright 2010, GreenSock. All rights reserved.</b> This work is subject to the terms in <a href="http://www.greensock.com/terms_of_use.html">http://www.greensock.com/terms_of_use.html</a> or for corporate Club GreenSock members, the software agreement that was issued with the corporate membership.
 * 
 * @author Jack Doyle, jack@greensock.com
 */	 
	public class LiquidData {
		/** @private **/
		public var level:int;
		/** @private 0 = PinPoint, 1 = DynamicPinPoint, 2 = DisplayObject, 3 = LiquidArea **/
		public var type:uint;
		/** @private **/
		public var pin:PinPoint;
		
		/** @private **/
		public var global:Point;		
		/** @private **/
		public var xRevert:Number;
		/** @private **/
		public var yRevert:Number;
		/** @private **/
		public var reference:Point;
		/** @private **/
		public var strict:Boolean;
		/** @private **/
		public var hasListener:Boolean;
		/** @private **/
		public var getter:Function;
		/** @private **/
		public var tween:TweenLite;
		
		/** @private **/
		public var target:DisplayObject;
		/** @private **/
		public var liquidStage:LiquidStage;
		
		/** @private **/
		public function LiquidData(pin:PinPoint, target:DisplayObject, type:uint, liquidStage:LiquidStage, strict:Boolean, tweenDuration:Number, tweenVars:Object) {
			this.pin = pin;
			this.target = target;
			this.strict = strict;
			if (tweenDuration > 0) {
				tweenVars = tweenVars || {};
				tweenVars.x = this.target.x;
				tweenVars.y = this.target.y;
				tweenVars.overwrite = false;
				this.tween = new TweenLite(this.target, tweenDuration, tweenVars);
				this.tween.setEnabled(false, false);
			}
			this.liquidStage = liquidStage; //LiquidStage.getByStage(this.target.stage);
			this.type = type;
			
			//PinPoint
			if (type < 2) {
				this.global = this.target.localToGlobal(this.pin);
				this.reference = this.global.clone();
				this.xRevert = this.global.x;
				this.yRevert = this.global.y;
				
			//LiquidArea
			} else if (type == 3) {
				
			//DisplayObject
			} else {
				this.global = this.pin.data.global;
				if (strict) {
					this.reference = this.target.parent.localToGlobal(new Point(this.target.x, this.target.y));
					this.reference.x -= this.global.x;
					this.reference.y -= this.global.y;
				} else {
					this.reference = this.target.parent.globalToLocal(this.global);
				}
			}
			refreshLevel();
		}
		
		/** @private **/
		public function refreshLevel():void {
			if (this.target == this.liquidStage.stageBox) {
				this.level = -1;
				return;
			}
			var stage:Stage = this.target.stage;
			var tempPreview:Boolean = Boolean(this.type == 3 && stage == null);
			if (tempPreview) {
				//If the LiquidArea isn't in the display list, we must add it temporarily in order to accurately discern the level
				(this.target as Object).preview = true;
				stage = this.target.stage;
			}
			if (stage) {
				this.level = (this.type < 2) ? 1 : 0; //forces pins to be 1 level higher than the DisplayObjects which is necessary to have them refresh in the correct order.
				var p:DisplayObject = this.target;
				while (p != stage) {
					this.level += 2;
					p = p.parent;
				}
			}
			if (this.type >= 2 && this.level < this.pin.data.level) { //if an object is pinned with a pin that's at a deeper nested level, we must let the pin update first, so adjust the level here. 
				this.level = this.pin.data.level + 1;
			}
			if (tempPreview) {
				(this.target as Object).preview = false;
			}
		}
		
		/** @private **/
		public function refreshPoints():void {
			var p:Point = this.target.localToGlobal(this.pin);
			this.global.x = this.reference.x = p.x;
			this.global.y = this.reference.y = p.y;
			if (strict && this.target.parent) {
				this.reference = this.target.parent.localToGlobal(new Point(this.target.x, this.target.y));
				this.reference.x -= this.global.x;
				this.reference.y -= this.global.y;
			}
			refreshLevel();
		}
		
		/** @private **/
		public function destroy(skipRelease:Boolean=false):void {
			if (!skipRelease) {
				removeCacheData(this.liquidStage, this);
			}
			if (this.type < 2) {
				var items:Array = this.liquidStage.cacheData.slice();
				var item:LiquidData;
				var i:int = items.length;
				while (--i > -1) {
					item = items[i];
					if (item.pin == this.pin) {
						item.destroy(false);
					}
				}
			}
			this.pin = null;
			this.target = null;
			this.global = this.reference = null;
			if (tween) {
				this.tween.kill();
				this.tween = null;
			}
		}
		
//---- STATIC METHODS -------------------------------------------------------------------------------
		
		/** @private **/
		public static function searchCache(liquidStage:LiquidStage, target:DisplayObject):LiquidData {
			var items:Array = liquidStage.cacheData;
			var i:int = items.length;
			var item:LiquidData;
			while (--i > -1) {
				item = items[i];
				if (item.target == target && item.type == 2) {
					return items[i];
				}
			}
			return null;
		}
		
		/** @private **/
		public static function addCacheData(liquidStage:LiquidStage, item:LiquidData):void {
			liquidStage.cacheData.push(item);
			liquidStage.refreshLevels();
		}
		
		/** @private **/
		public static function removeCacheData(liquidStage:LiquidStage, item:LiquidData):Boolean {
			var items:Array = liquidStage.cacheData;
			var i:int = items.length;
			while (--i > -1) {
				if (items[i] == item) {
					items.splice(i, 1);
					item.destroy(true);
					return true;
				}
			}
			return false;
		}
		
		/*
		public static function updateTweens(tweens:Array, xDif:Number, yDif:Number, widthDif:Number, heightDif:Number, minWidth:Number, minHeight:Number, maxWidth:Number, maxHeight:Number):void {
			var i:int = tweens.length;
			var t:TweenLite, lookup:Object, pt:PropTween, endVal:Number, inv:Number, vars:Object;
			while (--i > -1) {
				t = tweens[i];
				vars = t.vars;
				lookup = t.propTweenLookup;
				inv = 1 / (1 - t.ratio);
				if (xDif != 0 && "x" in vars) {
					endVal = t.vars.x = t.vars.x + xDif;
					if ((pt = lookup.x)) {
						pt.change = (endVal - (pt.start + t.ratio * pt.change)) * inv;
						pt.start = endVal - pt.change;
					}
				}
				if (yDif != 0 && "y" in vars) {
					endVal = t.vars.y = t.vars.y + yDif;
					if ((pt = lookup.y)) {
						pt.change = (endVal - (pt.start + t.ratio * pt.change)) * inv;
						pt.start = endVal - pt.change;
					}
				}
				if (widthDif != 0 && "width" in vars) {
					endVal = t.vars.width + widthDif;
					trace(endVal);
					if (endVal < minWidth) {
						endVal = minWidth;
					} else if (endVal > maxWidth) {
						endVal = maxWidth;
					}
					t.vars.width = endVal;
					if ((pt = lookup.width)) {
						pt.change = (endVal - (pt.start + t.ratio * pt.change)) * inv;
						pt.start = endVal - pt.change;
					}
				}
				if (heightDif != 0 && "height" in vars) {
					endVal = t.vars.height + heightDif;
					if (endVal < minHeight) {
						endVal = minHeight;
					} else if (endVal > maxHeight) {
						endVal = maxHeight;
					}
					t.vars.height = endVal;
					if ((pt = lookup.height)) {
						pt.change = (endVal - (pt.start + t.ratio * pt.change)) * inv;
						pt.start = endVal - pt.change;
					}
				}
			}
		}
		*/

	}
}