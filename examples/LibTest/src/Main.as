package
{
	import adobe.utils.CustomActions;
	import ascb.units.Converter;
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
	import flash.utils.getTimer;
	import me.rainssong.math.ArrayCore;
	import me.rainssong.math.MathCore;
	import me.rainssong.utils.functionTiming;
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
			var sum:int = 100;
			
			for (var i:int = 0; i < 10; ++i)
			{
				if (i % 2)
					continue;
				sum++;
			}
			trace(sum);
		}
	
	}

}