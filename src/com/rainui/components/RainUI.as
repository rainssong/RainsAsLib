package com.rainui.components 
{
	import flash.display.Sprite;
	/**
	 * ...
	 * @author Rainssong
	 * @timeStamp 2014/5/9 12:28
	 * @blog http://blog.sina.com.cn/rainssong
	 */
	public class RainUI 
	{
		
		public function RainUI() 
		{
			
		}
		
		public static function init(sprite:Sprite):void
		{
			stage = main.stage;
			stage.frameRate = Config.GAME_FPS;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			stage.stageFocusRect = false;
			stage.tabChildren = false;
		}
		
	}

}