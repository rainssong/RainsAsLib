

package me.rainssong.display 
{
	/**
	 * ...
	 * @author Rainssong
	 */
	public interface IView 
	{
		function onRegister():void
		function onAdd():void
		function show():void
		function enable():void
		function disable():void
		function hide():void
		function onRemove():void
		function destroy():void
	}
	
}