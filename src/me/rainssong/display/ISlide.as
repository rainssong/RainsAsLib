package  me.rainssong.display
{
	
	/**
	 * ...
	 * @author rainssong
	 */
	public interface ISlide
	{
		function lock():void
		function unlock():void
		function get isLeftRollInEnabled():Boolean
		function get isRightRollInEnabled():Boolean
		function get isLeftRollOutEnabled():Boolean
		function get isRightRollOutEnabled():Boolean
	}
	
}