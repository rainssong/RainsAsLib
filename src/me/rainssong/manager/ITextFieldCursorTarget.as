package com.codeTooth.actionscript.interaction.cursor 
{
	/**
	 * 文本光标对象
	 */
	public interface ITextFieldCursorTarget 
	{
		/**
		 * 是否参与CursorManager的控制
		 */
		function get underCursorManagerControl():Boolean;
		
		/**
		 * 对象选中
		 */
		function set selected(bool:Boolean):void;
	}
	
}