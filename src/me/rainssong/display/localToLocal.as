package me.rainssong.display
{
	import flash.display.DisplayObject;
	import flash.geom.Point;

	/**
	 * Translate <code>DisplayObject</code> container position in a new container.
	 */
	public function localToLocal(point:Point,from:DisplayObject, to:DisplayObject):Point
	{
		
		point = from.localToGlobal(point);
		point = to.globalToLocal(point);
		return point;
	}
}