package org.airbaby.events
{
	import flash.events.Event;

	public class MailEvent extends Event
	{
		static public const COMPLETE:String = "complete";
		public var phpScriptURL:String;
		public var result
		public var senderName:String;
		public var subject:String
		public var targetMail
		public function MailEvent(type:String)
		{
			super(COMPLETE);
		}
		override public function clone():Event
		{
			var e:MailEvent = new MailEvent(type);
			e.phpScriptURL = phpScriptURL;
			e.result = result;
			e.senderName = senderName;
			e.subject=subject
			e.targetMail=targetMail
			return e;
		}

	}

}