package  {
	
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextFieldAutoSize;
	
	
	
	public class MyCheckBox extends MovieClip {
	
		
		public function MyCheckBox(selected:Boolean=false) {
			// constructor code
			stop();
			if(this["labelText"])
			{
				this["labelText"].autoSize = TextFieldAutoSize.LEFT;
			}
			
			this.addEventListener(MouseEvent.CLICK, clickHandler);
			this.addEventListener(Event.REMOVED_FROM_STAGE, onRemove);
			
		}
		
		private function clickHandler(e:MouseEvent):void 
		{
			switchStatus();
		}
		
		private function onRemove(e:Event):void 
		{
			this.removeEventListener(Event.REMOVED_FROM_STAGE, onRemove);
			this.removeEventListener(MouseEvent.CLICK, clickHandler);
		}
		
		public function switchStatus():void
		{
			if (this.currentFrame == 1)
			{
				this.gotoAndStop(2);
			}
			else
			this.gotoAndStop(1);
		}
		
		
		public function set selected(value:Boolean):void
		{
			gotoAndStop(int(value) + 1);
		}
		
		public function get selected():Boolean
		{
			return this.currentFrame==2;
		}
		
		public function get label():String
		{
			if(["labelText"])
				return this["labelText"].text;
			else
				return "";
		}
		
		public function set label(content:String):void
		{
			if(["labelText"])
				this["labelText"].text = content;
			
		}
		
		
	}
	
}
