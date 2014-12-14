package
{
	import flash.display.Sprite;
	import flash.utils.Dictionary;
	import me.rainssong.math.MathCore;
	
	public class Main extends Sprite
	{
		
		
		public function Main():void
		{
			var dic:Dictionary = new Dictionary();
			for (var i:int = 0; i < 10000; i++) 
			{
				var value:int = MathCore.getRandomInt(0, 10);
				dic[value] ||= 0;
				dic[value]++;
			}
			powerTrace(dic);
		}
		
		
		
	
	
	}

}