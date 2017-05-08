package  
{
	import flash.utils.*;
	import me.rainui.*;
	import me.rainui.components.*;
	import model.*;
	
	
	/**
	 * @date 2015/7/11 16:49
	 * @author rainssong
	 * @blog http://blog.sina.com.cn/rainssong
	 * @homepage http://rainsgameworld.sinaapp.com
	 * @weibo http://www.weibo.com/rainssong
	 */
	public class ButtonTest extends Page 
	{
		
		
		public function ButtonTest() 
		{
			
			
			super();
			
		}
		
		
		
		override protected function createChildren():void 
		{
			super.createChildren();
			
			this.bgSkin.visible = true;
			
			
			new Label("显示", { parent:this, right:20, top:20} );
			
			
		}
		
		
		
	}

}