package  me.rainssong.rainSlideShow
{
	import me.rainssong.events.SlideEvent;
	
	/**
	 * ...
	 * @author rainssong
	 */
	public interface IRainSlide
	{
		function lock(e:SlideEvent=null):void
		function unlock(e:SlideEvent=null):void
		function get isLeftRollInEnabled():Boolean
		function get isRightRollInEnabled():Boolean
		function get isLeftRollOutEnabled():Boolean
		function get isRightRollOutEnabled():Boolean
	}
	
}