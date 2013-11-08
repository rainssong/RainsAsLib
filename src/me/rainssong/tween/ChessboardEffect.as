package me.rainssong.tween
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.utils.Timer;
	
	public class ChessboardEffect extends Sprite
	{
		public var currentFadeOut:int = 0;
		public var currentSquares:int = 1;
		public var pauseTime:int = 1;
		public var tempNum:int = 0;
		public var fading:String = "in";
		public var fadeinTimer:Timer;
		public var fadeoutTimer:Timer;
		public var fadeArray:Array;
		public var squaresArray:Array;
		
		public function ChessboardEffect()
		{
			this.fadeinTimer = new Timer(100);
			this.fadeoutTimer = new Timer(100);
			this.fadeArray = [[[1, 1, 1, 1, 1, 1, 1, 1, 1, 1], [2, 2, 2, 2, 2, 2, 2, 2, 2, 2], [3, 3, 3, 3, 3, 3, 3, 3, 3, 3], [4, 4, 4, 4, 4, 4, 4, 4, 4, 4], [5, 5, 5, 5, 5, 5, 5, 5, 5, 5]], [[5, 5, 5, 5, 5, 5, 5, 5, 5, 5], [4, 4, 4, 4, 4, 4, 4, 4, 4, 4], [3, 3, 3, 3, 3, 3, 3, 3, 3, 3], [2, 2, 2, 2, 2, 2, 2, 2, 2, 2], [1, 1, 1, 1, 1, 1, 1, 1, 1, 1]], [[1, 2, 3, 4, 5, 6, 7, 8, 9, 10], [1, 2, 3, 4, 5, 6, 7, 8, 9, 10], [1, 2, 3, 4, 5, 6, 7, 8, 9, 10], [1, 2, 3, 4, 5, 6, 7, 8, 9, 10], [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]], [[10, 9, 8, 7, 6, 5, 4, 3, 2, 1], [10, 9, 8, 7, 6, 5, 4, 3, 2, 1], [10, 9, 8, 7, 6, 5, 4, 3, 2, 1], [10, 9, 8, 7, 6, 5, 4, 3, 2, 1], [10, 9, 8, 7, 6, 5, 4, 3, 2, 1]], [[1, 2, 3, 4, 5, 6, 7, 8, 9, 10], [2, 3, 4, 5, 6, 7, 8, 9, 10, 11], [3, 4, 5, 6, 7, 8, 9, 10, 11, 12], [4, 5, 6, 7, 8, 9, 10, 11, 12, 13], [5, 6, 7, 8, 9, 10, 11, 12, 13, 14]], [[10, 9, 8, 7, 6, 5, 4, 3, 2, 1], [11, 10, 9, 8, 7, 6, 5, 4, 3, 2], [12, 11, 10, 9, 8, 7, 6, 5, 4, 3], [13, 12, 11, 10, 9, 8, 7, 6, 5, 4], [14, 13, 12, 11, 10, 9, 8, 7, 6, 5]], [[5, 6, 7, 8, 9, 10, 11, 12, 13, 14], [4, 5, 6, 7, 8, 9, 10, 11, 12, 13], [3, 4, 5, 6, 7, 8, 9, 10, 11, 12], [2, 3, 4, 5, 6, 7, 8, 9, 10, 11], [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]], [[14, 13, 12, 11, 10, 9, 8, 7, 6, 5], [13, 12, 11, 10, 9, 8, 7, 6, 5, 4], [12, 11, 10, 9, 8, 7, 6, 5, 4, 3], [11, 10, 9, 8, 7, 6, 5, 3, 3, 2], [10, 9, 8, 7, 6, 5, 4, 3, 2, 1]]];
			this.squaresArray = new Array();
			this.fadeinTimer.addEventListener("timer", this.fadeSquaresInTimer);
			this.fadeinTimer.start();
			addEventListener(Event.ENTER_FRAME, this.enterFrame);
			return;
		}
		
		public function fadeSquaresInTimer(e:Event)
		{
			fadeSquaresIn(fadeArray[6]);
			currentSquares += 1;
		}
		
		public function fadeSquaresIn(s:Array):void
		{
			for (var row = 0; row < s[0].length; row++)
			{
				for (var col = 0; col < s.length; col++)
				{
					if (int(s[col][row]) == currentSquares)
					{
						var s1:Sprite = new Square();
						s1.x = 20 + (row * 40);
						s1.y = 20 + (col * 40);
						addChild(s1);
						squaresArray.push(s1);
					}
				}
			}
			
			if (this.squaresArray.length == s[0].length * s.length)
			{
				this.fadeinTimer.stop();
				addEventListener(Event.ENTER_FRAME, this.pauseBetween);
			}
		}
		
		public function fadeSquaresOut(s:Array)
		{
			for (var row = 0; row < s[0].length; row++)
			{
				for (var col = 0; col < s.length; col++)
				{
					if (int(s[col][row]) == currentSquares)
					{
						currentFadeOut += 1;
					}
				}
			}
			
			if (this.currentFadeOut == s[0].length * s.length)
			{
				this.fadeoutTimer.stop();
				this.pauseTime = 1;
				addEventListener(Event.ENTER_FRAME, this.delayedRemove);
			}
		}
		
		public function fadeSquaresOutTimer(e:Event)
		{
			fadeSquaresOut(fadeArray[6]);
			currentSquares += 1;
		}
		
		public function pauseBetween(e:Event)
		{
			pauseTime += 1;
			if (pauseTime == 60)
			{
				currentSquares = 01;
				fading = "out";
				fadeoutTimer.addEventListener("timer", fadeSquaresOutTimer);
				fadeoutTimer.start();
				removeEventListener(Event.ENTER_FRAME, pauseBetween);
			}
		}
		
		public function delayedRemove(e:Event)
		{
			pauseTime += 1;
			if (pauseTime == 30)
			{
				
				removeEventListener(Event.ENTER_FRAME, delayedRemove);
				stage.removeChild(this);
			}
		}
		
		public function enterFrame(e:Event)
		{
			for each (var s1 in squaresArray)
			{
				tempNum += 1;
				if (fading == "in")
				{
					if (s1.scaleX <= 1)
					{
						s1.scaleX += 0.05;
						s1.scaleY += 0.05;
					}
				}
				else if (fading == "out")
				{
					if (tempNum <= currentFadeOut)
					{
						if (s1.scaleX >= 0.1)
						{
							s1.scaleX -= 0.05;
							s1.scaleY -= 0.05;
						}
						else
						{
							if (s1.visible == true)
							{
								s1.visible = false;
							}
						}
					}
				}
			}
			tempNum = 00;
		}
	}
}
import flash.display.Shape;
import flash.display.Sprite;

class Square extends Sprite
{
	public var squareShape:Shape;
	
	public function Square()
	{
		this.squareShape = new Shape();
		addChild(this.squareShape);
		this.squareShape.graphics.beginFill(0, 1);
		this.squareShape.graphics.drawRect(-20, -20, 40, 40);
		this.squareShape.graphics.endFill();
		this.scaleX = 0.1;
		this.scaleY = 0.1;
		return;
	} // end function

}