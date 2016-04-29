package 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import me.rainssong.manager.ListenerManager;
	import me.rainui.components.Button;
	import me.rainui.components.Page;
	
	
	/**
	 * @date 2016/4/12 5:27
	 * @author rainssong
	 * @blog http://blog.sina.com.cn/rainssong
	 * @homepage http://rainsgameworld.sinaapp.com
	 * @weibo http://www.weibo.com/rainssong
	 */
	public class ListenerManagerTest extends Page 
	{
		private var _lm:ListenerManager
		public function ListenerManagerTest() 
		{
			super();
			
			//this.bgSkin.visible = true;
			
			var btn:Button = new Button("Test", { parent:this } );
			
			
			addExternalListener(btn,MouseEvent.CLICK, onShit);
			addExternalListener(btn,MouseEvent.MOUSE_DOWN, onShit2,false);
			addExternalListener(btn,MouseEvent.MOUSE_UP, onShit2);
			addExternalListener(btn,MouseEvent.RIGHT_CLICK, onShit);
		}
		
		private function onShit(e:MouseEvent):void 
		{
			powerTrace(e.type)
		}
		
		private function onShit2(e:MouseEvent):void 
		{
			powerTrace(e.type);
			removeAllEventListener(this);
		}
		
	}

}