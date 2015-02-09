package
{
	import adobe.utils.CustomActions;
	import com.bit101.components.PushButton;
	import flash.desktop.NativeApplication;
	import flash.desktop.NativeProcess;
	import flash.desktop.NativeProcessStartupInfo;
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.filesystem.File;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.utils.getQualifiedClassName;
	import me.rainui.components.Button;
	import me.rainui.components.Label;
	import me.rainui.components.ScrollContainer;
	import me.rainui.components.TabBar;
	import me.rainui.components.TextInput;
	import me.rainui.RainTheme;
	import me.rainui.RainUI;
	
	/**
	 *  我一定是足够蛋痛才会来写这个
	 * @author Rainssong
	 */
	public class Main extends Sprite
	{
		public function Main():void
		{
			if (stage)
				init();
			else
				addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			RainUI.init(stage,new RainTheme);
			var btn:Button = new Button();
			btn.normalSkin = RainUI.theme.getSkin("darkBlueRoundSkin");
			addChild(btn);
			btn.top = 100;
			
			//this.dispatchEvent(new Event(Event.RESIZE));
		}
	}

}