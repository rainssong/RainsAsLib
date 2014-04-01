package
{


	import flash.display.MovieClip;
	import flash.display.Sprite;
	import me.rainssong.application.ApplicationManager;
	import me.rainssong.manager.EnterFrameManager;
	import me.rainssong.utils.getSingleton;
	import me.rainssong.utils.RevDictionary;
	import me.rainssong.utils.SonDictionary;
	
	/**
	 * ...
	 * @author Rainssong
	 */
	public class Main extends Sprite
	{
		private var r:RevDictionary = new RevDictionary();
		public function Main()
		{
			var mc:MovieClip = new MovieClip();
			mc.name="shit"
			r.setValue(mc, "ShitMc");
			powerTrace(r[mc]);
			var t:*= r.getKey("shitMC");
			
			powerTrace(t);
			
		}
	
	}

}