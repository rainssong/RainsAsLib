package com.sixuu.events
{
	import flash.events.Event;
	import flash.events.ProgressEvent;

	public class SProgressEvent extends Event
	{
		static public const PROGRESS:String = "progress";
		static public const FILE_DOWN_PROGRESS:String="fileDownProgress"
		public var bytesLoaded
		public var bytesTotal
		public var file
		public function SProgressEvent(type:String)
		{
			super(type);

		}
		

	}

}