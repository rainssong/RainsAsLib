package me.rainui
{
	import flash.display.DisplayObject;
	import flash.display.Stage;
	import flash.display.StageScaleMode;
	import flash.display.StageAlign;
	
	/**
	 * ...
	 * @author Rainssong
	 */
	public class App
	{
		public static var stage:Stage
		
		public function App()
		{
		
		}
		
		public static function init(sprite:DisplayObject):void
		{
			stage = sprite.stage;
			stage.frameRate = Config.frameRate;
			stage.scaleMode = StageScaleMode.NO_SCALE
			stage.align = StageAlign.TOP_LEFT;
			stage.tabChildren = false;
			
			stage.addChild(dialog);
			stage.addChild(tip);
			stage.addChild(log);
		
		}
		
		public static function getResPath(url:String):String
		{
			return /^http:\/\//g.test(url) ? url : Config.resPath + url;
		}
	}

}