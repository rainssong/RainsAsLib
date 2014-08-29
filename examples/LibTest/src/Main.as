package
{
	import com.nocircleno.graffiti.GraffitiCanvas;
	import com.nocircleno.graffiti.tools.BrushTool;
	import com.nocircleno.graffiti.tools.BrushType;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.text.TextField;
	import flash.utils.Dictionary;
	import me.rainssong.math.ArrayCore;
	import me.rainssong.utils.Color;
	import me.rainssong.utils.Draw;
	import me.rainssong.utils.ObjectCore;
	import utils.GamePad;
	import utils.Logitech;
	
	public class Main extends Sprite
	{
		
		//public const mathSin:Function = Math.sin;
		private var _dic:Dictionary = new Dictionary();
		
		public function Main():void
		{
			
			var myXML:XML = new XML();
			
			myXML =
				<Item ID="3132131" Name="我的我的" Type="14">
					<Tip>我们强大武器道具\n带去我的钱我决定去忘记</Tip>
				</Item>
				
			var temp:*= myXML.Tip[0].toString();
			trace(temp);
		}
	
	}

}