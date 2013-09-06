/**
 * VERSION: 3.0
 * DATE: 2010-03-17
 * AS3
 * UPDATES AND DOCUMENTATION AT: http://www.GreenSock.com
 **/
package com.greensock.plugins {
	import com.greensock.*;
	import com.greensock.core.*;
/**
 * If you'd like to tween something to a destination value that may change at any time,
 * DynamicPropsPlugin allows you to simply associate a function with a property so that
 * every time the tween is rendered, it calls that function to get the new destination value 
 * for the associated property. For example, if you want a MovieClip to tween to wherever the
 * mouse happens to be, you could do:<br /><br /><code>
 * 	
 * 	TweenLite.to(mc, 3, {dynamicProps:{x:getMouseX, y:getMouseY}}); <br />
 * 	function getMouseX():Number {<br />
 * 		return this.mouseX;<br />
 * 	}<br />
 * 	function getMouseY():Number {<br />
 * 		return this.mouseY;<br />
 * 	}<br /><br /></code>
 * 	
 * Of course you can get as complex as you want inside your custom function, as long as
 * it returns the destination value, TweenLite/Max will take care of adjusting things 
 * on the fly.<br /><br />
 * 
 * You can optionally pass any number of parameters to functions using the "params" 
 * special property like so:<br /><br /><code>
 * 
 * TweenLite.to(mc, 3, {dynamicProps:{x:myFunction, y:myFunction, params:{x:[mc2, "x"], y:[mc2, "y"]}}}); <br />
 * 	function myFunction(object:MovieClip, propName:String):Number {<br />
 * 		return object[propName];<br />
 * 	}<br /><br /></code>
 * 
 * DynamicPropsPlugin is a <a href="http://www.greensock.com/club/">Club GreenSock</a> membership benefit. 
 * You must have a valid membership to use this class without violating the terms of use. 
 * Visit <a href="http://www.greensock.com/club/">http://www.greensock.com/club/</a> to sign up or get 
 * more details. <br /><br />
 * 
 * <b>USAGE:</b><br /><br />
 * <code>
 * 		import com.greensock.TweenLite; <br />
 * 		import com.greensock.plugins.~~; <br />
 * 		TweenPlugin.activate([DynamicPropsPlugin]); //activation is permanent in the SWF, so this line only needs to be run once.<br /><br />
 * 
 * 		TweenLite.to(my_mc, 3, {dynamicProps:{x:getMouseX, y:getMouseY}}); <br /><br />
 * 			
 * 		function getMouseX():Number {<br />
 * 			return this.mouseX;<br />
 * 		}<br />
 * 		function getMouseY():Number {<br />
 * 			return this.mouseY;<br />
 * 		} <br /><br />
 * </code>
 * 
 * <b>Copyright 2010, GreenSock. All rights reserved.</b> This work is subject to the terms in <a href="http://www.greensock.com/terms_of_use.html">http://www.greensock.com/terms_of_use.html</a> or for corporate Club GreenSock members, the software agreement that was issued with the corporate membership.
 * 
 * @author Jack Doyle, jack@greensock.com
 */
	public class DynamicPropsPlugin extends TweenPlugin {
		/** @private **/
		public static const API:Number = 1.0; //If the API/Framework for plugins changes in the future, this number helps determine compatibility
		
		/** @private **/
		protected var _tween:TweenLite;
		/** @private **/
		protected var _target:Object;
		/** @private **/
		protected var _props:Array;
		/** @private **/
		protected var _prevFactor:Number;
		/** @private **/
		protected var _prevTime:Number;
		
		/** @private **/
		public function DynamicPropsPlugin() {
			super();
			this.propName = "dynamicProps"; //name of the special property that the plugin should intercept/manage
			this.overwriteProps = []; //will be populated in init()
			_props = [];
		}
		
		/** @private **/
		override public function onInitTween(target:Object, value:*, tween:TweenLite):Boolean {
			_target = tween.target;
			_tween = tween;
			var params:Object = value.params || {};
			_prevFactor = 0;
			_prevTime = 0;
			for (var p:String in value) {
				if (p != "params") {
					_props[_props.length] = new DynamicProperty(_target[p], p, value[p] as Function, params[p]);
					this.overwriteProps[this.overwriteProps.length] = p;
				}
			}
			return true;
		}
		
		/** @private **/
		override public function killProps(lookup:Object):void {
			var i:int = _props.length;
			while (i--) {
				if (_props[i].name in lookup) {
					_props.splice(i, 1);
				}
			}
			super.killProps(lookup);
		}	
		
		/** @private **/
		override public function set changeFactor(n:Number):void {
			if (n != _prevFactor) {
				var i:int = _props.length, prop:DynamicProperty, end:Number, ratio:Number;
				
				//going forwards towards the end
				if (_tween.cachedTime > _prevTime) {
					ratio = (n == 1 || _prevFactor == 1) ? 0 : 1 - ((n - _prevFactor) / (1 - _prevFactor));
					while (i--) {
						prop = _props[i];
						end = (prop.params) ? prop.getter.apply(null, prop.params) : prop.getter();
						_target[prop.name] = end - ((end - _target[prop.name]) * ratio);
					}
					
				//going backwards towards the start
				} else {
					ratio = (n == 0 || _prevFactor == 0) ? 0 : 1 - ((n - _prevFactor) / -_prevFactor);
					while (i--) {
						prop = _props[i];
						_target[prop.name] = prop.start + ((_target[prop.name] - prop.start) * ratio);
					}
				}
				
				_prevFactor = n;
			}
			_prevTime = _tween.cachedTime;
		}
		
	}
}

internal class DynamicProperty {
	public var start:Number;
	public var name:String;
	public var getter:Function;
	public var params:Array;
	
	public function DynamicProperty(start:Number, name:String, getter:Function, params:Array) {
		this.start = start;
		this.name = name;
		this.getter = getter;
		this.params = params;
	}
}