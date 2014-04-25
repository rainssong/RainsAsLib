package  
{
	import acheGesture.core.PropGesture;
	import flash.display.Sprite;
	import me.rainssong.math.MathCore;
	import me.rainssong.utils.Draw;
	import me.rainssong.utils.Pen;
	
	/**
	 * ...
	 * @author rainssong
	 */
	[SWF(width="1024",height="768",backgroundColor="#FFFFFF",frameRate="31")]
	public class Main extends Sprite 
	{
		private var openList:Array;
		private var closeList:Array = [];
		public function Main() 
		{
			super();
			var pen:Pen = new Pen(this.graphics);
			pen.lineStyle(1);
			pen.beginFill(0x000000);
			Draw.gridLines(this.graphics, 50, 50, 15, 15);
			
			for (var i:int = 0; i < 300; i++ )
			{
				var node:AstarNode = new AstarNode(MathCore.getRandomInt(0, 49), MathCore.getRandomInt(0, 49));
				closeList.push(node);
				pen.drawRect(node.x * 15, node.y * 15, 15, 15);
			}
		}
	}
}