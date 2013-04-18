package  me.rainssong.display
{
	import me.rainssong.events.SlideEvent;
	
	/**
	 * ...
	 * @author rainssong
	 */
	public interface ISlide
	{
		function lock(e:SlideEvent=null):void
		function unlock(e:SlideEvent=null):void
		function get isLeftRollInEnabled():Boolean
		function get isRightRollInEnabled():Boolean
		function get isLeftRollOutEnabled():Boolean
		function get isRightRollOutEnabled():Boolean
	}
	
}