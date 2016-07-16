package 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import me.rainssong.manager.ListenerManager;
	import me.rainui.components.Button;
	import me.rainui.components.ButtonGroup;
	import me.rainui.components.ButtonGroup;
	import me.rainui.components.Page;
	import me.rainui.data.ListCollection;
	
	
	/**
	 * @date 2016/4/12 5:27
	 * @author rainssong
	 * @blog http://blog.sina.com.cn/rainssong
	 * @homepage http://rainsgameworld.sinaapp.com
	 * @weibo http://www.weibo.com/rainssong
	 */
	public class ButtonGroupTest extends Sprite 
	{
		public function ButtonGroupTest() 
		{
			super();
			
			//this.bgSkin.visible = true;
			
			var btng:ButtonGroup = new ButtonGroup();
			addChild(btng);
			btng.items=new ListCollection([{text:"Start"},{text:"Stop"},{text:"Exit"}])
			
			
		}
		
		private function onShit(e:MouseEvent):void 
		{
			powerTrace(e.type)
		}
		

		
	}

}