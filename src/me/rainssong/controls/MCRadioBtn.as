package  me.rainssong.controls
{
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import me.rainssong.display.SmartMovieClip;
	import me.rainssong.utils.superTrace;
	
	
	public class MCRadioBtn extends SmartMovieClip {
		
		
		private var _groupName:String="default";
		public function MCRadioBtn() {
			// constructor code
			super();
			stop();
			MyRadioButtonGroup.addBtn(this);
			this.addEventListener(MouseEvent.CLICK, clickHandler);
			
		
		}
		
		private function clickHandler(e:MouseEvent):void 
		{
			select();
		}
		
		override protected function onRemove(e:Event):void 
		{
			super.onRemove(e);
		}
		
		private function selectHandler(e:Event):void 
		{
			
			if (MyRadioButtonGroup.selection != this)
			{
				unselect();
			}
		}
		
		public function switchStatus():void
		{
			if (this.currentFrame == 1)
			{
				select();
			}
			else
			unselect();
		}
		
		public function select():void
		{
			this.gotoAndStop(2);
			MyRadioButtonGroup.selection = this;
			
		}
		
		public function unselect():void
		{
			this.gotoAndStop(1);
		}
		
		public function get selected():Boolean
		{
			return this.currentFrame==2;
		}
		
		public function set selected(value:Boolean):void
		{
			if (value) select();
			else unselect();
		}
		
		public function get label():String
		{
			if(this["labelTF"])
			return this["labelTF"].text;
			
			return "";
		}
		
		public function set label(content:String):void
		{
			if(this["labelTF"])
			this["labelTF"].text=content;
		}
		
		public function get groupName():String 
		{
			return _groupName;
		}
	}
	
}
