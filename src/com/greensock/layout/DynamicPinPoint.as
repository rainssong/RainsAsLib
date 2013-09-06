/**
 * VERSION: 2.1
 * DATE: 2010-04-08
 * AS3
 * UPDATES AND DOCUMENTATION AT: http://blog.greensock.com/liquidstage/
 **/
package com.greensock.layout {
	import com.greensock.layout.core.LiquidData;
	
	import flash.display.DisplayObject;
	import flash.geom.Point;
/**
 * Sometimes it's useful to have a PinPoint base its coordinates on some custom criteria, like the 
 * edge of another DisplayObject or the center of an object whose width/height changes frequently, so
 * DynamicPinPoint allows you to associate a function (one you define) that returns a Point instance
 * that will determine the DynamicPinPoint's x/y values. For example, to make the DynamicPinPoint
 * position itself at the center bottom of the "video_mc" object and then attach a "mc" object, 
 * you could do this: <br /><br /><code>
 * 
 * var pin:DynamicPinPoint = new DynamicPinPoint(video_mc, getBottomCenter); <br />
 * pin.attach(mc);<br />
 * function getBottomCenter():Point {<br />
 * 		var bounds:Rectangle = video_mc.getBounds(video_mc);<br />
 * 		return new Point(bounds.x + bounds.width / 2, bounds.y + bounds.height);<br />
 * }<br /><br />
 * 
 * //if you want to initially position the "mc" object directly on the DynamicPinPoint, you could add this:<br />
 * var p:Point = pin.toLocal(mc.parent);<br />
 * mc.x = p.x;<br />
 * mc.y = p.y;<br />
 * 
 * <br /><br /></code>
 * 
 * <b>Copyright 2010, GreenSock. All rights reserved.</b> This work is subject to the terms in <a href="http://www.greensock.com/terms_of_use.html">http://www.greensock.com/terms_of_use.html</a> or for corporate Club GreenSock members, the software agreement that was issued with the corporate membership.
 * 
 * @author Jack Doyle, jack@greensock.com
 */	 
	public class DynamicPinPoint extends PinPoint {
		/** @private **/
		public static const version:Number = 2.1;
		/** @private **/
		private var _getter:Function;
		
		/**
		 * Constructor
		 * 
		 * @param target target DisplayObject who is like the "parent" of this PinPoint (its coordinate system is used for the x and y values).
		 * @param getter the function to be called which will return a Point object defining the new coordinates (based on the target's coordinate space)
		 * @param liquidStage Optionally declare the LiquidStage instance to which this PinPoint should be associated. If none is defined, the class will try to determine the LiquidStage instance based on the target's <code>stage</code> property (<code>LiquidStage.getByStage()</code>). The only time it is useful to specifically declare the LiquidStage instance is when you plan to subload a swf that uses LiquidStage into another swf that also has a LiquidStage instance (thus they share the same stage).
		 */
		public function DynamicPinPoint(target:DisplayObject, getter:Function, liquidStage:LiquidStage=null) {
			super(getter().x, getter().y, target, liquidStage);
			_getter = _data.getter = getter;
			if (!(_getter() is Point)) {
				throw new Error("The getter function passed to the DynamicPinPoint constructor did not return a Point instance.");
			}
		}
		
		/** @private **/
		override protected function init(target:DisplayObject, liquidStage:LiquidStage):void {
			_data = new LiquidData(this, target, 1, liquidStage || LiquidStage.getByStage(target.stage), false, 0, null);
			LiquidData.addCacheData(_data.liquidStage, _data);
		}
		
		/** @inheritDoc **/
		override public function clone():Point {
			var p:DynamicPinPoint = new DynamicPinPoint(_data.target, _getter, _data.liquidStage);
			p.x = this.x;
			p.y = this.y;
			return p;
		}
		
		
//---- GETTERS / SETTERS --------------------------------------------------------------------------------
		
		/** the function to be called which will return a Point object defining the new coordinates (based on the target's coordinate space) **/
		public function get getter():Function {
			return _getter;
		}
		public function set getter(value:Function):void {
			_getter = _data.getter = value;
			var p:Point = _getter();
			this.x = p.x;
			this.y = p.y;
		}
		
	}
}