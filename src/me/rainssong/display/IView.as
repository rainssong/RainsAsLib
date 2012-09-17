

package me.rainssong.display 
{
	import flash.display.DisplayObjectContainer;
	/**
	 * ...
	 * @author Rainssong
	 */
	public interface IView 
	{
		function register():void
		
		function show():void
		function enable():void
		function disable():void
		function hide():void
		
		function destroy():void
	}
	
}