package cn.flashk.net
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.text.TextField;

	public class Loading extends MovieClip
	{
		public var percent_txt:TextField;
		
		public function Loading()
		{
			stop();
			this.addEventListener(Event.ENTER_FRAME,updatePercent);
		}
		
		protected function updatePercent(event:Event):void
		{
			var per:Number = this.loaderInfo.bytesLoaded/this.loaderInfo.bytesTotal;
			var perInt:int = int(per*100);
			percent_txt.text = perInt +"%";
			this.gotoAndStop(perInt);
			if(per==1){
				this.removeEventListener(Event.ENTER_FRAME,updatePercent);
				this.gotoAndStop(1,"Main");
			}
		}
	}
}