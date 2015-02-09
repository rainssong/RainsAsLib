package
{
	import flash.display.Sprite;
	import flash.utils.Dictionary;
	import me.rainssong.math.MathCore;
	import me.rainui.components.Label;
	
	public class Main extends Sprite
	{
		public var label1:Label = new Label("卧槽wocao");
		public var label2:Label = new Label("卧槽wocao");
		public var label3:Label = new Label("卧槽wocao");
		
		
		public function Main():void
		{
			label1.size = 18;
			label2.size = 24;
			label3.size = 48;
			label1.autoSize = true;
			label2.autoSize = true;
			label3.autoSize = true;
			
			addChild(label1);
			addChild(label2);
			addChild(label3);
			label2.y = 100;
			label3.y = 200;
			
			label1.showBorder();
			label2.showBorder();
			label3.showBorder();
			
			powerTrace(label1.textField.textHeight);
			powerTrace(label2.textField.textHeight);
			powerTrace(label3.textField.textHeight);
		}
		
		
		
	
	
	}

}