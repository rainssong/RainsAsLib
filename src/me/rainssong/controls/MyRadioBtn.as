package  {
	
	import com.vsdevelop.proxy.ViewControl;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	public class MyRadioBtn extends MovieClip {
		
		
		
		public function MyRadioBtn() {
			// constructor code
			stop();
			
			this.addEventListener(MouseEvent.CLICK, clickHandler);
			this.addEventListener(Event.REMOVED_FROM_STAGE, onRemove);
			MyRadioButtonGroup.dispatcher.addEventListener(MyRadioButtonGroup.Selected, selectHandler);
		}
		
		private function clickHandler(e:MouseEvent):void 
		{
			select();
		}
		
		
		
		private function onRemove(e:Event):void 
		{
			removeEventListener(MouseEvent.CLICK, clickHandler);
			removeEventListener(Event.REMOVED_FROM_STAGE, onRemove);
			MyRadioButtonGroup.dispatcher.removeEventListener(MyRadioButtonGroup.Selected, selectHandler);
		}
		
		private function selectHandler(e:Event):void 
		{
			if (MyRadioButtonGroup.selection != this)
			{
				unSelect();
			}
		}
		
		public function switchStatus():void
		{
			if (this.currentFrame == 1)
			{
				select();
			}
			else
			unSelect();
		}
		
		public  function select():void
		{
			this.gotoAndStop(2);
			MyRadioButtonGroup.selection = this;
		
			MyRadioButtonGroup.dispatcher.dispatchEvent(new Event(MyRadioButtonGroup.Selected));
		}
		
		public function unSelect():void
		{
			this.gotoAndStop(1);
		}
		
		public function get selected():Boolean
		{
			return this.currentFrame==2;
		}
		
		public function get label():String
		{
			return this.labelText.text;
		}
		
		public function set label(content:String):void
		{
			this.labelText.text=content;
		}
	}
	
}
