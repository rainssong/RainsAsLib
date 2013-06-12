package org.superkaka.kakalib.events 
{
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	/**
	 * 像素级交互的鼠标事件
	 * @author ｋａｋａ
	 */
	public class PixelMouseEvent extends MouseEvent 
	{
		
		static public const ROLL_OVER:String = "PixelMouseEvent_rollOver";
		
		static public const ROLL_OUT:String = "PixelMouseEvent_rollOut";
		
		static public const MOUSE_DOWN:String = "PixelMouseEvent_mouseDown";
		static public const MOUSE_UP:String = "PixelMouseEvent_mouseUp";
		static public const MOUSE_MOVE:String = "PixelMouseEvent_mouseMove";
		static public const CLICK:String = "PixelMouseEvent_click";
		
		static public const DOUBLE_CLICK:String = "PixelMouseEvent_doubleClick";
		
		public function PixelMouseEvent(type:String, localX:Number = NaN, localY:Number = NaN, bubbles:Boolean = true, cancelable:Boolean = false):void
		{ 
			
			super(type, bubbles, cancelable, localX, localY);
			
		}
		
		public override function clone():Event 
		{ 
			return new PixelMouseEvent(type, localX, localY, bubbles, cancelable);
		} 
		
		public override function toString():String 
		{ 
			return formatToString("PixelMouseEvent", "type", "localX", "localY", "bubbles", "cancelable", "eventPhase");
		}
		
	}
	
}