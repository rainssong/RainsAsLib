package 
{
	import flash.display.Sprite;
	import me.rainui.components.Button;
	import me.rainui.components.CheckBox;
	import me.rainui.components.RadioButton;
	import me.rainui.managers.RadioGroup;
	import me.rainui.managers.ToggleGroup;
	import me.rainui.RainUI;
	
	
	/**
	 * @date 2015/6/7 5:25
	 * @author rainssong
	 * @blog http://blog.sina.com.cn/rainssong
	 * @homepage http://rainsgameworld.sinaapp.com
	 * @weibo http://www.weibo.com/rainssong
	 */
	public class GroupTest extends Sprite 
	{
		private var group:ToggleGroup
		public function GroupTest() 
		{
			super();
			RainUI.init(stage);
			
			group = new ToggleGroup();
			group.addButton(new CheckBox("Check1", { parent:this, y:0 } ));
			group.addButton(new CheckBox("Check2", { parent:this, y:60 } ));
			group.addButton(new CheckBox("Check3", { parent:this, y:120 } ));
			group.addButton(new CheckBox("Check4", { parent:this, y:180 } ));
			
			group = new RadioGroup();
			group.addButton(new RadioButton("Radio1", { parent:this,x:400, y:0 } ));
			group.addButton(new RadioButton("Radio2", { parent:this,x:400, y:60 } ));
			group.addButton(new RadioButton("Radio3", { parent:this,x:400, y:120 } ));
			group.addButton(new RadioButton("Radio4", { parent:this,x:400, y:180 } ));
		}
		
	}

}