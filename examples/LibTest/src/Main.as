package
{
	import adobe.utils.CustomActions;
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
			if (stage)
				init();
			else
				addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			var arr:Array = [];
			var arr2:Array = ArrayCore.getIntArray(0, 10000);
			//functionTiming(arr.push,1000,arr2);
			//functionTiming(arr.concat,1000,[arr2]);
			
			
			var start:Number = getTimer();
			//var arr3:Array = arr.slice();
			var arr3:Array
			//for (var i:int = 0; i < 1000; i++) 
			//{
				//arr3=arr.concat(arr2);
				//arr3.push.apply(null,arr2);
				arr3 = ArrayCore.concat(arr, arr2);
			//}
			powerTrace(arr3.length);
			powerTrace(getTimer() - start);
			//ArrayCore.concat
		
		}
		
		
		
		
	}

}