package
{
	import com.hurlant.eval.ByteLoader;
	import com.hurlant.eval.CompiledESC;
	import com.hurlant.eval.Debug;
	import com.hurlant.test.ILogger;
	import com.hurlant.util.Hex;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFieldType;
	import flash.text.TextFormat;
	import flash.ui.Keyboard;
	import flash.utils.ByteArray;
	
	/**
	 * ...
	 * @author Rainssong
	 */
	
	public class Main extends Sprite
	{
		private var _inputTF:TextField = new TextField();
		private var esc:CompiledESC = new CompiledESC;
		public function Main():void
		{
			Debug.logger =new logger;
			Util.logger = new ILogger();
			
			if (stage)
				init();
			else
				addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			
			_inputTF.width = 400;
			_inputTF.height = 400;
			_inputTF.type = TextFieldType.INPUT;
			_inputTF.wordWrap=true
			_inputTF.defaultTextFormat = new TextFormat(null, 24, 0xFF0000);
			
			addChild(_inputTF);
			
			stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
		}
		
		private function onKeyDown(e:KeyboardEvent):void
		{
			if (e.keyCode == Keyboard.SPACE)
			{
				var bytes:ByteArray = esc.eval(_inputTF.text);
				ByteLoader.loadBytes(bytes);
			}
		}
	}
}