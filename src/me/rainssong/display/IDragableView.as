package  me.rainssong.display
{
	import flash.geom.Rectangle;
	
	/**
	 * ...
	 * @author rainssong
	 */
	public interface IDragableView 
	{
		function startDragging(stageX:Number,stageY:Number):void
		function stopDragging():void
		function onDragging():void
		function offDragging():void
	}
	
}