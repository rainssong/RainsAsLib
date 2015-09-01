/**
 * Copyright (c) 2008 Bartek Drozdz (http://www.everydayflash.com)
 * 
 * Permission is hereby granted, free of charge, to any person
 * obtaining a copy of this software and associated documentation
 * files (the "Software"), to deal in the Software without
 * restriction, including without limitation the rights to use,
 * copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the
 * Software is furnished to do so, subject to the following
 * conditions:
 * 
 * The above copyright notice and this permission notice shall be
 * included in all copies or substantial portions of the Software.
 * 
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
 * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
 * OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
 * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
 * HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
 * WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
 * FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
 * OTHER DEALINGS IN THE SOFTWARE.
 */

 package  me.rainssong.display{
	
	import flash.display.DisplayObject;
	import flash.geom.Point;

	/**
	 * This class can be used as a replacement for the DisplayObject.rotation property.
	 * 
	 * It rotates a DisplayObject, but it does not limit itself to rotate around the it's 
	 * registration point, instead it can rotate the object around any point. The point is
	 * defined in the objects parent coodrinate system.
	 * 
	 * @author Bartek Drozdz (http://www.everydayflash.com)
	 * @version 1.0
	 */
	public class Rotator {
		
		private var _target:DisplayObject;
		
		/**
		 * A value that is based on the initial rotation of the display object itself, and
		 * the angle between the registration point of the display object and of the rotator
		 */
		private var offset:Number;
		
		/**
		 * Registration point - the point around which the rotation takse place
		 */
		private var _regPoint:Point;
		
		/**
		 * Distance between the registration point of the display object and the registration 
		 * point of the rotator
		 */
		private var dist:Number;

		/**
		 * Registers a DisplayObject that will be rotated and an registration Point around which it will be rotated.
		 * 
		 * @param	target DisplayObject to rotate
		 * @param	registrationPoint Point containing the coodrinates around which the object should be rotated 
		 *          (in the targets parent coordinate space) If omitted, the displays object x and y coordinates are used
		 */
		public function Rotator(target:DisplayObject=null, registrationPoint:Point=null) {
			_target = target;
			regPoint=registrationPoint;
		}
		
		public function get regPoint():Point 
		{
			return _regPoint;
		}
		/**
		 * Once set in the constructor, the rotation registration point can be modified an any moment
		 * 
		 * @param	registrationPoint, if null defaults to targets x and y coordinates
		 */
		public function set regPoint(registrationPoint:Point):void {
			
			_regPoint = registrationPoint;
			if (_target == null) return;
			var dx:Number = _regPoint.x - target.x;
			var dy:Number = _regPoint.y - target.y;
			dist = Math.sqrt( dx * dx + dy * dy );
			
			var a:Number = Math.atan2(dy, dx) * 180 / Math.PI;
			offset = 180 - a + target.rotation;
		}
		
		/**
		 * Sets the rotation to the angle passed as parameter.
		 * 
		 * Since it uses a getter/setter Rotator can easily be used with Tween or Tweener classes.
		 */
		public function set rotation(angle:Number):void {
			var tp:Point = new Point(target.x, target.y);

			var ra:Number = (angle - offset) * Math.PI / 180;
			
			target.x = _regPoint.x + Math.cos(ra) * dist;
			target.y = _regPoint.y + Math.sin(ra) * dist;
			
			target.rotation =  angle;
		}
		
		/**
		 * Returns current rotation of the target in degrees
		 */
		public function get rotation():Number {
			return target.rotation;
		}
		
		/**
		 * Rotates the target by the angle passed as parameter. 
		 * Works the same as Rotator.rotation += angle;
		 * 
		 * @param angle angle by which to rotate the target DisplayObject
		 */
		public function rotateBy(angle:Number):void {
			var tp:Point = new Point(target.x, target.y);

			var ra:Number = (target.rotation + angle - offset) * Math.PI / 180;
			
			target.x = _regPoint.x + Math.cos(ra) * dist;
			target.y = _regPoint.y + Math.sin(ra) * dist;
			
			target.rotation =  target.rotation + angle;
		}
		
		public function set target(value:DisplayObject):void
		{
			_target = value;
		}
		
		public function get target():DisplayObject
		{
			return _target;
		}
		
		
		
	}
}











