package
{
	import com.codeTooth.actionscript.display.PureLoading;
	
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageQuality;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	
	public class TestPureLoading extends Sprite
	{
		private var _loading:PureLoading = null;
		
		private var _percent:Number = 0;
		
		public function TestPureLoading()
		{
			stage.quality = StageQuality.LOW;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			
			_loading = new PureLoading(stage.stageWidth, stage.stageHeight, 20);
			addChild(_loading);
			
			stage.addEventListener(Event.RESIZE, stageResizeHandler);
			
			addEventListener(Event.ENTER_FRAME, enterFrameHandler);
		}
		
		private function enterFrameHandler(event:Event):void
		{
			_loading.value = _percent;
			_loading.label = Math.min(Math.max(_percent, 0), 100) + "%" + "   " + "加载中...";
			_percent += 1;
		}
		
		private function stageResizeHandler(event:Event):void
		{
			_loading.width = stage.stageWidth;
			_loading.height = stage.stageHeight;
		}
	}
}