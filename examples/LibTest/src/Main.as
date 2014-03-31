package
{


	import flash.display.MovieClip;
	import flash.display.Sprite;
	import me.rainssong.application.ApplicationManager;
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
			trace(ApplicationManager.appVersion)
			trace(ApplicationManager.appNameSpace)
			trace(ApplicationManager.appId)
			trace(ApplicationManager.appName)
			
			trace(ApplicationManager.lastVersion);
			
		}
	
	}

}