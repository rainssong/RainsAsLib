package 
{
	import me.rainui.components.Button;
	import me.rainui.components.Page;
	import me.rainui.layout.VerticalLayoutGroup;
	
	/**
	 * @date 2019-01-02 18:59
	 * @author Rainssong
	 * @blog http://blog.sina.com.cn/rainssong
	 * @homepage http://rainsgameworld.sinaapp.com
	 * @weibo http://www.weibo.com/rainssong
	 */
	public class LayoutGroupTest  extends Page
	{
		
		public var vlg:VerticalLayoutGroup
		
		public function LayoutGroupTest() 
		{
			
		}
		
		
		override protected function createChildren():void 
		{
			super.createChildren();
			
			
			addChild(vlg = new VerticalLayoutGroup)
			
			vlg.addChild(new Button);
			vlg.addChild(new Button);
			vlg.addChild(new Button);
			vlg.addChild(new Button); 
			vlg.addChild(new Button); 
			vlg.childControlHeight = true;
			vlg.childForceExpandHeight = true;
			//vlg.childForceExpandWidth = true;
			vlg.childControlWidth = false;
			vlg.spacing = 10;
			vlg.runLayout();
		}
		
	}

}