package   me.rainssong.application
{
	
	/**
	 * ...
	 * @author Rainssong
	 */
	public interface IGame
	{
		 function reset():void
		 function pause():void
		 function resume():void
		 function gameOver():void
		 function gameStart():void
		 function restart():void
		 function save(index:uint=0):void
		 function load(index:uint=0):void
		
	}
	
}