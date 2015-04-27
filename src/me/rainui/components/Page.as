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
		
		public function Page(dataSource:Object=null)
		{
			super(dataSource);
		}
		
		override protected function onAdded(e:Event):void 
		{
			super.onAdded(e);
		}
		
		override protected function preinitialize():void 
		{
			super.preinitialize();
			this._percentWidth = 1;
			this._percentHeight = 1;
			this.mouseChildren = true;
		}
		
		
		override public function resize():void 
		{
			super.resize();
		}
		
		override protected function onRemoved(e:Event):void 
		{
			super.onRemoved(e);
			
		}
		
		
	}

}