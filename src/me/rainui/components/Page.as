package me.rainui.components 
{
	import flash.display.Stage;
	import flash.events.Event;
	import me.rainui.RainUI;
	
	/**
	 * ...
	 * @author Rainssong
	 */
	public class Page extends Container 
	{
		//public var btnSkinClass:Class = Button;
		
		public function Page()
		{
			super();
			//addEventListener(Event.ADDED_TO_STAGE, onAddToStage);
		}
		
		override protected function onAdded(e:Event):void 
		{
			super.onAdded(e);
			if (this.parent is Stage && e.target==this)
			{
				stage.addEventListener(Event.RESIZE, onParentResize);
				this._height = RainUI.stageHeight;
				this._width = RainUI.stageWidth;
			}
		}
		
		override protected function preinitialize():void 
		{
			super.preinitialize();
			this._height = 640;
			this._width = 480;
			this.mouseChildren = true;
		}
		
		
		override public function resize():void 
		{
			_width = RainUI.stageWidth;
			_height = RainUI.stageHeight;
			super.resize();
		}
		
		override protected function onRemoved(e:Event):void 
		{
			if (this.parent is Stage)
			{
				stage.removeEventListener(Event.RESIZE, onParentResize);
			}
			super.onRemoved(e);
			
		}
		
		
	}

}