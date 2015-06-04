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
	import me.rainssong.utils.Align;
	import me.rainssong.utils.ScaleMode;
	import me.rainui.components.Button;
	import me.rainui.components.Label;
	import me.rainui.components.List;
	import me.rainui.components.Page;
	import me.rainui.components.ProgressBar;
	import me.rainui.components.ScrollContainer;
	import me.rainui.components.TabBar;
	import me.rainui.components.TextInput;
	import me.rainui.data.ListCollection;
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
			
			
			var page:Page = new Page( { parent:stage } );
			
			var btn:Button = new Button("Button", { parent:page, x:100, y:100 } );
			
			var label:Label = new Label("Label", { parent:page, x:100, y:200, align:Align.LEFT } );
			
			var progress:ProgressBar = new ProgressBar("ProgressBar", {parent:page, x:100, y:300} );
			progress.percent = 0.8;
			//new List(["11", "22", "33", "33", "33", "33", "33", "33"], { parent:this } );
			
			
			
			
		}
	}

}