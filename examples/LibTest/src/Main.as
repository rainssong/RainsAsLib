package
{


	import flash.display.MovieClip;
	import flash.display.Sprite;
	import me.rainssong.application.ApplicationManager;
	import me.rainssong.manager.EnterFrameManager;
	import me.rainssong.utils.getSingleton;
	import me.rainssong.utils.RevDictionary;
	
	/**
	 * ...
	 * @author Rainssong
	 */
	public class Main extends Sprite
	{
		
		public function Main()
		{
			Debug.init(this,this.stage)
			Debug.changeTopTextState("show");
			
			Debug.log("log");
			Debug.trace("trace");
			Debug.trace2("trace2");
			Debug.traceColor(0xFFAA00);
			Debug.traceToConsole("traceToConsole");
			Debug.updateTopText("updateTopText");
			Debug.updateTopText(Debug.logInfo,1);
			Debug.updateTopText(Debug.operateInfo,2);
			Debug.updateTopText(Debug.errorInfo, 3);
			
			var p = 12;
		}
	
	}

}