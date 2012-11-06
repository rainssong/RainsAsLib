

package me.rainssong.display 
{
	/**
	 * ...
	 * @author Rainssong
	 */
	import flash.events.Event;
	
	public interface IView 
	{
		function show():void
		function enable():void
		function disable():void
		function hide():void
		function destroy():void
	}
	
}