package cn.flashk.controls.events 
{
	import flash.events.Event;
	/**
	 * ...
	 * @author flashk
	 */
	public class ClickAbleAlphaBitmapEvent extends Event
	{
		public static const ALPHA_CLICK:String = "alphaClick";
		public static const NO_ALPHA_CLICK:String = "noAlphaClick";
		public static const NO_ALPHA_OVER:String = "noAlphaOver";
		public static const NO_ALPHA_OUT:String = "noAlphaOut";
		
		public function ClickAbleAlphaBitmapEvent(type:String):void
		{
			super(type);
		}
		
	}

}