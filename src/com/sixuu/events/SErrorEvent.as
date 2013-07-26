package com.sixuu.events {
	import flash.events.Event;
	
	public class SErrorEvent extends Event{
		static public const ERROR:String="error"
		public var errorType:String="error"
		public var file
		public function SErrorEvent(type:String) {
			super(type)
		}

	}
	
}
