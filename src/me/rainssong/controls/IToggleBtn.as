package  me.rainssong.controls
{
	
	/**
	 * ...
	 * @author Rainssong
	 */
	public interface IToggleBtn 
	{
		function get name():String;
		function set name(value:String):void
		function select():void
		function unselect():void
		function get selected():Boolean
		function set selected(value:Boolean):void
		function get label():String
		function set label(content:String):void
	}
	
}