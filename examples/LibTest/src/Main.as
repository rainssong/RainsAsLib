package
{
	import ascb.util.StringUtilities;
	import com.kglad.MT;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import me.rainssong.manager.EnterFrameManager;
	
	/**
	 * ...
	 * @author Rainssong
	 */
	public class Main extends Sprite
	{
		private var mc:MovieClip = new MovieClip();
		public function Main()
		{
			super();
			addChild(mc)
			MT.init(mc, 2);
			MT.track(this);
			
			
		}
	
	}

}