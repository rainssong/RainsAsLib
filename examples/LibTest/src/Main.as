package
{


	import flash.display.MovieClip;
	import flash.display.Sprite;
	import me.rainssong.manager.EnterFrameManager;
	import me.rainssong.utils.getSingleton;
	
	/**
	 * ...
	 * @author Rainssong
	 */
	public class Main extends Sprite
	{
		
		public function Main()
		{
			getSingleton(Sprite).visible = false;
			powerTrace(getSingleton(Sprite).visible);
			
			
		}
	
	}

}