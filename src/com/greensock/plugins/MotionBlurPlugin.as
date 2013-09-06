/**
 * VERSION: 2.04
 * DATE: 2010-04-19
 * ACTIONSCRIPT VERSION: 3.0 
 * UPDATES AND DOCUMENTATION AT: http://www.TweenMax.com
 **/
package com.greensock.plugins {
	import com.greensock.*;
	import com.greensock.core.*;
	
	import flash.display.*;
	import flash.filters.BlurFilter;
	import flash.geom.*;
	import flash.utils.getDefinitionByName;
/**
 * MotionBlurPlugin provides an easy way to apply a directional blur to a DisplayObject based on its velocity
 * and angle of movement in 2D (x/y). This creates a much more realistic effect than a standard BlurFilter for
 * several reasons:
 * <ol>
 * 		<li>A regular BlurFilter is limited to blurring horizontally and/or vertically whereas the motionBlur 
 * 		   gets applied at the angle at which the object is moving.</li>
 * 
 * 		<li>A BlurFilter tween has static start/end values whereas a motionBlur tween dynamically adjusts the
 * 			values on-the-fly during the tween based on the velocity of the object. So if you use a <code>Strong.easeInOut</code>
 * 			for example, the strength of the blur will start out low, then increase as the object moves faster, and 
 * 			reduce again towards the end of the tween.</li>
 * </ol>
 * 
 * motionBlur even works on bezier/bezierThrough tweens!<br /><br />
 * 
 * To accomplish the effect, MotionBlurPlugin creates a Bitmap that it places over the original object, changing 
 * alpha of the original to [almost] zero during the course of the tween. The original DisplayObject still follows the 
 * course of the tween, so MouseEvents are properly dispatched. You shouldn't notice any loss of interactivity. 
 * The DisplayObject can also have animated contents - MotionBlurPlugin automatically updates on every frame. 
 * Be aware, however, that as with most filter effects, MotionBlurPlugin is somewhat CPU-intensive, so it is not 
 * recommended that you tween large quantities of objects simultaneously. You can activate <code>fastMode</code>
 * to significantly speed up rendering if the object's contents and size/color doesn't need to change during the
 * course of the tween. <br /><br />
 * 
 * motionBlur recognizes the following properties:
 * <ul>
 * 		<li><b>strength : int</b> - Determines the strength of the blur. The default is 1. For a more powerful
 * 							blur, increase the number. Or reduce it to make the effect more subtle.</li>
 * 
 * 		<li><b>fastMode : Boolean</b> - Setting fastMode to <code>true</code> will significantly improve rendering
 * 						performance but it is only appropriate for situations when the target object's contents, 
 * 						size, color, filters, etc. do not need to change during the course of the tween. It works
 * 						by essentially taking a BitmapData snapshot of the target object at the beginning of the
 * 						tween and then reuses that throughout the tween, blurring it appropriately. The default
 * 						value for <code>fastMode</code> is <code>false</code>.</li>
 * 
 * 		<li><b>quality : int</b> - The lower the quality, the less CPU-intensive the effect will be. Options 
 * 							are 1, 2, or 3. The default is 2.</li>
 * 
 * 		<li><b>padding : int</b> - padding controls the amount of space around the edges of the target object that is included
 * 						in the BitmapData capture (the default is 10 pixels). If the target object has filters applied to 
 * 						it like a GlowFilter or DropShadowFilter that extend beyond the bounds of the object itself,
 * 						you might need to increase the padding to accommodate the filters. </li>
 * </ul>
 * 
 * You can optionally set motionBlur to the Boolean value of <code>true</code> in order to use the defaults. (see below for examples)<br /><br />
 * 
 * Also note that due to a bug in Flash, if you apply motionBlur to an object that was masked in the Flash IDE it won't work
 * properly - you must apply the mask via ActionScript instead (and set both the mask's and the masked object's cacheAsBitmap
 * property to true). And another bug in Flash prevents motionBlur from working on objects that have 3D properties applied, 
 * like <code>z, rotationY, rotationX,</code> or <code>rotationZ</code>.<br /><br />
 * 
 * <b>USAGE:</b><br /><br />
 * <code>
 * 		import com.greensock.~~; <br />
 * 		import com.greensock.plugins.~~; <br />
 * 		TweenPlugin.activate([MotionBlurPlugin]); //only do this once in your SWF to activate the plugin <br /><br />
 * 
 * 		TweenMax.to(mc, 2, {x:400, y:300, motionBlur:{strength:1.5, fastMode:true, padding:15}}); <br /><br />
 * 
 * 		//or to use the default values, you can simply pass in the Boolean "true" instead: <br />
 * 		TweenMax.to(mc, 2, {x:400, y:300, motionBlur:true}); <br /><br />
 * </code>
 * 
 * MotionBlurPlugin is a <a href="http://www.greensock.com/club/">Club GreenSock</a> membership benefit. 
 * You must have a valid membership to use this class without violating the terms of use. Visit 
 * <a href="http://www.greensock.com/club/">http://www.greensock.com/club/</a> to sign up or get more details.<br /><br />
 * 
 * <b>Copyright 2010, GreenSock. All rights reserved.</b> This work is subject to the terms in <a href="http://www.greensock.com/terms_of_use.html">http://www.greensock.com/terms_of_use.html</a> or for corporate Club GreenSock members, the software agreement that was issued with the corporate membership.
 * 
 * @author Jack Doyle, jack@greensock.com
 */
	public class MotionBlurPlugin extends TweenPlugin {
		/** @private **/
		public static const API:Number = 1.0; //If the API/Framework for plugins changes in the future, this number helps determine compatibility
		
		/** @private **/
		private static const _DEG2RAD:Number = Math.PI / 180; //precomputation for speed
		/** @private **/
		private static const _RAD2DEG:Number = 180 / Math.PI; //precomputation for speed;
		/** @private **/
		private static const _point:Point = new Point(0, 0);
		/** @private **/
		private static const _ct:ColorTransform = new ColorTransform();
		/** @private **/
		private static const _blankArray:Array = [];
		/** @private **/
		private static var _classInitted:Boolean;
		/** @private **/
		private static var _isFlex:Boolean;
		
		/** @private **/
		protected var _target:DisplayObject;
		/** @private **/
		protected var _time:Number;
		/** @private **/
		protected var _xCurrent:Number;
		/** @private **/
		protected var _yCurrent:Number;
		/** @private **/
		protected var _bd:BitmapData;
		/** @private **/
		protected var _bitmap:Bitmap;
		/** @private **/
		protected var _strength:Number = 0.05;
		/** @private **/
		protected var _tween:TweenLite;
		/** @private **/
		protected var _blur:BlurFilter = new BlurFilter(0, 0, 2);
		/** @private **/
		protected var _matrix:Matrix = new Matrix();
		/** @private **/
		protected var _sprite:Sprite;
		/** @private **/
		protected var _rect:Rectangle;
		/** @private **/
		protected var _angle:Number;
		/** @private **/
		protected var _alpha:Number;
		/** @private **/
		protected var _xRef:Number; //we keep recording this value every time the _target moves at least 2 pixels in either direction in order to accurately determine the angle (small measurements don't produce accurate results).
		/** @private **/
		protected var _yRef:Number;
		/** @private **/
		protected var _mask:DisplayObject;
		/** @private **/
		protected var _padding:int;
		/** @private **/
		protected var _bdCache:BitmapData;
		/** @private **/
		protected var _rectCache:Rectangle;
		/** @private **/
		protected var _cos:Number;
		/** @private **/
		protected var _sin:Number;
		/** @private **/
		protected var _smoothing:Boolean;
		/** @private **/
		protected var _xOffset:Number;
		/** @private **/
		protected var _yOffset:Number;
		/** @private **/
		protected var _cached:Boolean;
		/** @private **/
		protected var _fastMode:Boolean;
		
		/** @private **/
		public function MotionBlurPlugin() {
			super();
			this.propName = "motionBlur"; //name of the special property that the plugin should intercept/manage
			this.overwriteProps = ["motionBlur"]; 
			this.onComplete = disable;
			this.onDisable = onTweenDisable;
			this.priority = -2; //so that the x/y/alpha tweens occur BEFORE the motion blur is applied (we need to determine the angle at which it moved first)
			this.activeDisable = true;
		}
		
		/** @private **/
		override public function onInitTween(target:Object, value:*, tween:TweenLite):Boolean {
			if (!(target is DisplayObject)) {
				throw new Error("motionBlur tweens only work for DisplayObjects.");
				return false;
			} else if (value == false) {
				_strength = 0;
			} else if (typeof(value) == "object") {
				_strength = (value.strength || 1) * 0.05;
				_blur.quality = int(value.quality) || 2;
				_fastMode = Boolean(value.fastMode == true);
			}
			if (!_classInitted) {
				try {
					_isFlex = Boolean(getDefinitionByName("mx.managers.SystemManager")); // SystemManager is the first display class created within a Flex application
				} catch (e:Error) {
					_isFlex = false;
				}
				_classInitted = true;
			}
			
			_target = target as DisplayObject;
			_tween = tween;
			_time = 0;
			_padding = ("padding" in value) ? int(value.padding) : 10;
			_smoothing = Boolean(_blur.quality > 1);
			
			_xCurrent = _xRef = _target.x;
			_yCurrent = _yRef = _target.y;
			_alpha = _target.alpha;
			
			if ("x" in _tween.propTweenLookup && "y" in _tween.propTweenLookup && !_tween.propTweenLookup.x.isPlugin && !_tween.propTweenLookup.y.isPlugin) { //if the tweens are plugins, like bezier or bezierThrough for example, we cannot assume the angle between the current _x/_y and the destination ones is what it should start at!
				_angle = Math.PI - Math.atan2(_tween.propTweenLookup.y.change, _tween.propTweenLookup.x.change);
			} else if (_tween.vars.x != null || _tween.vars.y != null) {
				var x:Number = _tween.vars.x || _target.x;
				var y:Number = _tween.vars.y || _target.y;
				_angle = Math.PI - Math.atan2((y - _target.y), (x - _target.x));
			} else {
				_angle = 0;
			}
			_cos = Math.cos(_angle);
			_sin = Math.sin(_angle);
			
			_bd = new BitmapData(_target.width + _padding * 2, _target.height + _padding * 2, true, 0x00FFFFFF);
			_bdCache = _bd.clone();
			_bitmap = new Bitmap(_bd);
			_bitmap.smoothing = _smoothing;
			_sprite = _isFlex ? new (getDefinitionByName("mx.core.UIComponent"))() : new Sprite();
			_sprite.mouseEnabled = _sprite.mouseChildren = false;			
			_sprite.addChild(_bitmap);
			_rectCache = new Rectangle(0, 0, _bd.width, _bd.height);
			_rect = _rectCache.clone();
			if (_target.mask) {
				_mask = _target.mask;
			}
			
			return true;
		}
		
		/** @private **/
		private function disable():void {
			if (_strength != 0) {
				_target.alpha = _alpha;
			}
			if (_sprite.parent) {
				_sprite.parent.removeChild(_sprite);
			}
			if (_mask) {
				_target.mask = _mask;
			}
		}
		
		/** @private **/
		private function onTweenDisable():void {
			if (_tween.cachedTime != _tween.cachedDuration && _tween.cachedTime != 0) { //if the tween is on a TimelineLite/Max that eventually completes, another tween might have affected the target's alpha in which case we don't want to mess with it - only disable() if it's mid-tween. Also remember that from() tweens will complete at a value of 0, not 1.
				disable();
			}
		}
		
		/** @private **/
		override public function set changeFactor(n:Number):void {
			var time:Number = (_tween.cachedTime - _time);
			if (time < 0) {
				time = -time; //faster than Math.abs(_tween.cachedTime - _time)
			}
			
			if (time < 0.0000001) {
				return; //number is too small - floating point errors will cause it to render incorrectly
			}
			
			var dx:Number = _target.x - _xCurrent;
			var dy:Number = _target.y - _yCurrent;
			var rx:Number = _target.x - _xRef;
			var ry:Number = _target.y - _yRef;
			_changeFactor = n;
			
			if (rx > 2 || ry > 2 || rx < -2 || ry < -2) { //setting a tolerance of 2 pixels helps eliminate floating point error funkiness.
				_angle = Math.PI - Math.atan2(ry, rx);
				_cos = Math.cos(_angle);
				_sin = Math.sin(_angle);
				_xRef = _target.x;
				_yRef = _target.y;
			}
					
			_blur.blurX = Math.sqrt(dx * dx + dy * dy) * _strength / time;
			
			_xCurrent = _target.x;
			_yCurrent = _target.y;
			_time = _tween.cachedTime;
			
			if (n == 0 || _target.parent == null) { 
				disable();
				return;
			}
			
			if (_sprite.parent != _target.parent && _target.parent) {
				_target.parent.addChildAt(_sprite, _target.parent.getChildIndex(_target));
				if (_mask) {
					_sprite.mask = _mask;
				}
			}
			
			if (!_fastMode || !_cached) {
				var parentFilters:Array = _target.parent.filters;
				if (parentFilters.length != 0) {
					_target.parent.filters = _blankArray; //if the parent has filters, it will choke when we move the child object (_target) to x/y of 20,000/20,000.
				}
				
				_target.x = _target.y = 20000; //get it away from everything else;
				var prevVisible:Boolean = _target.visible;
				_target.visible = true;
				var bounds:Rectangle = _target.getBounds(_target.parent);
				if (bounds.width + _blur.blurX * 2 > 2870) { //in case it's too big and would exceed the 2880 maximum in Flash
					_blur.blurX = (bounds.width >= 2870) ? 0 : (2870 - bounds.width) * 0.5;
				}
				
				_xOffset = 20000 - bounds.x + _padding;
				_yOffset = 20000 - bounds.y + _padding;
				bounds.width += _padding * 2;
				bounds.height += _padding * 2;
				
				if (bounds.height > _bdCache.height || bounds.width > _bdCache.width) {
					_bdCache = new BitmapData(bounds.width, bounds.height, true, 0x00FFFFFF);
					_rectCache = new Rectangle(0, 0, _bdCache.width, _bdCache.height);
				}
				
				_matrix.tx = _padding - bounds.x;
				_matrix.ty = _padding - bounds.y;
				_matrix.a = _matrix.d = 1;
				_matrix.b = _matrix.c = 0;
				
				bounds.x = bounds.y = 0;
				if (_target.alpha == 0.00390625) {
					_target.alpha = _alpha;
				} else { //means the tween is affecting alpha, so respect it.
					_alpha = _target.alpha;
				}
				
				_bdCache.fillRect(_rectCache, 0x00FFFFFF);
				_bdCache.draw(_target.parent, _matrix, _ct, "normal", bounds, _smoothing);
				
				_target.visible = prevVisible;
				_target.x = _xCurrent;
				_target.y = _yCurrent;
				
				if (parentFilters.length != 0) {
					_target.parent.filters = parentFilters;
				}
				
				_cached = true;
			} else if (_target.alpha != 0.00390625) {
				//means the tween is affecting alpha, so respect it.
				_alpha = _target.alpha;
			}
			_target.alpha = 0.00390625; //use 0.00390625 instead of 0 so that we can identify if it was changed outside of this plugin next time through. We were running into trouble with tweens of alpha to 0 not being able to make the final value because of the conditional logic in this plugin.
			
			_matrix.tx = _matrix.ty = 0;
			_matrix.a = _cos;
			_matrix.b = _sin;
			_matrix.c = -_sin;
			_matrix.d = _cos;
			
			var width:Number, height:Number, val:Number;
			if ((width = _matrix.a * _bdCache.width) < 0) {
				_matrix.tx = -width;
				width = -width;
			} 
			if ((val = _matrix.c * _bdCache.height) < 0) {
				_matrix.tx -= val;
				width -= val;
			} else {
				width += val;
			}
			if ((height = _matrix.d * _bdCache.height) < 0) {
				_matrix.ty = -height;
				height = -height;
			} 
			if ((val = _matrix.b * _bdCache.width) < 0) {
				_matrix.ty -= val;
				height -= val;
			} else {
				height += val;
			}
			
			width += _blur.blurX * 2;
			_matrix.tx += _blur.blurX;
			if (width > _bd.width || height > _bd.height) {
				_bd = _bitmap.bitmapData = new BitmapData(width, height, true, 0x00FFFFFF);
				_rect = new Rectangle(0, 0, _bd.width, _bd.height);
				_bitmap.smoothing = _smoothing;
			}
			
			_bd.fillRect(_rect, 0x00FFFFFF);
			_bd.draw(_bdCache, _matrix, _ct, "normal", _rect, _smoothing);
			_bd.applyFilter(_bd, _rect, _point, _blur);
			
			_bitmap.x = 0 - (_matrix.a * _xOffset + _matrix.c * _yOffset + _matrix.tx);
			_bitmap.y = 0 - (_matrix.d * _yOffset + _matrix.b * _xOffset + _matrix.ty);
			
			_matrix.b = -_sin;
			_matrix.c = _sin;
			_matrix.tx = _xCurrent;
			_matrix.ty = _yCurrent;
			
			_sprite.transform.matrix = _matrix;
			
		}
		
	}
}