package
{
	import flash.display.Sprite;
	import flash.utils.getTimer;
	import flash.utils.setTimeout;
	import me.rainssong.utils.functionTiming;
	
	/**
	 *  我一定是足够蛋痛才会来写这个
	 * @author Rainssong
	 */
	public class Main extends Sprite
	{
		
		public function Main():void
		{
			setTimeout(testFunc, 1000);
		}
		
		private function testFunc():void
		{
			functionTiming(calc);
			//var t:Number = getTimer();
			//calc();
			//trace(getTimer() - t);
		}
		
		private function calc():void
		{
			for (var k:int = 499; k > 0; k--)
				for (var j:int = k - 1; j > (1000 - k - j); j--)
				{
					var i:int = 1000 - k - j;
					if (i * i + j * j == k * k)
					{
						trace(i, j, k);
						return;
					}
				}
		}
		
		private function calc2():void
		{
			var a:int;
			var b:int;
			var c:int;
			test();
			trace( a, b, c);
			function test():void
			{
				for (a = 333; a < 500; a++)
				{
					b = (500000-a)/(a-1)
					c = 1000 - a - b;
					if (a * a + b * b == c * c)
					{
						return;
					}
				}
			}
		}
	
	}

}