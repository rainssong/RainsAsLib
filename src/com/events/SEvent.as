package com.sixuu.events {
	import flash.events.Event;
	
	public dynamic class SEvent extends Event{
		static public const COMPLETE:String="complete"
		static public const FILE_DOWN_COMPLETE:String="fileDownComplete"
		public var file
		public function SEvent(type:String) {
			super(type)
		}

	}
	
}
