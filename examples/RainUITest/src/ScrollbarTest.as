package 
{
	import flash.display.DisplayObject;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.display.StageScaleMode;
	import flash.events.KeyboardEvent;
	import flash.geom.Rectangle;
	import flash.ui.Keyboard;
	import flash.utils.setTimeout;
	import me.rainssong.utils.Align;
	import me.rainssong.utils.Color;
	import me.rainssong.utils.Draw;
	import me.rainui.components.List;
	import me.rainui.components.ListItem;
	import me.rainui.components.Page;
	import me.rainui.components.ScrollBar;
	import me.rainui.components.ScrollBar;
	import me.rainui.components.ScrollContainer;
	import me.rainui.components.ScrollText;
	import me.rainui.components.SimpleScrollBar;
	import me.rainui.components.TextArea;
	import me.rainui.components.TextInput;
	import me.rainui.RainTheme;
	import me.rainui.RainUI;
	
	
	/**
	 * @date 2017-05-08 23:19:19
	 * @author rainssong
	 * @blog http://blog.sina.com.cn/rainssong
	 * @homepage http://rainsgameworld.sinaapp.com
	 * @weibo http://www.weibo.com/rainssong
	 */
	public class ScrollbarTest extends Sprite 
	{
		public var sc:SimpleScrollBar
		
		
		public function ScrollbarTest() 
		{
			super();
			
			//stage.scaleMode=StageScaleMode.NO_SCALE
			
			RainUI.init(stage);
			
			
			//sc.borderVisible = true;
			
			setTimeout(init,500)
		}
		
		private function init():void 
		{
			//var p:Page = new Page( { parent:stage } );
			//p.borderVisible = true;
			
			
			sc = new SimpleScrollBar({ parent:this } );
			sc.width = 600;
			sc.height = 40;
			sc.borderVisible = true;
			
			
			stage.addEventListener(KeyboardEvent.KEY_DOWN, onKey);
		}
		
		private function onKey(e:KeyboardEvent):void 
		{
			switch (e.keyCode) 
			{
				case Keyboard.A:
					sc.value++;
				break;
				case Keyboard.S:
					sc.page++;
				break;
				case Keyboard.D:
					sc.maximum++;
				break;
				case Keyboard.F:
					sc.minimum++;
				break;
				case Keyboard.Z:
					sc.value--
				break;
				case Keyboard.X:
					sc.page--
				break;
				case Keyboard.C:
					sc.maximum--
				break;
				case Keyboard.V:
					sc.minimum--
				break;
				default:
			}
		}
		
		
		
		
	}

}