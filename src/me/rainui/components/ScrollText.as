package me.rainui.components 
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	import me.rainssong.utils.Align;
	import me.rainui.components.Label
	import me.rainui.RainUI;
	
	/**
	 * @date 2015/1/14 16:08
	 * @author Rainssong
	 * @blog http://blog.sina.com.cn/rainssong
	 * @homepage http://rainsgameworld.sinaapp.com
	 * @weibo http://www.weibo.com/rainssong
	 */
	public class ScrollText extends ScrollContainer 
	{
		private var _label:Label;
		
		public function ScrollText(text:String="", dataSource:Object=null) 
		{
			super(null , dataSource);
			this.text = text;
		}
		
		override protected function preinitialize():void 
		{
			super.preinitialize();
			this._width = 300;
			this._height = 200;
		}
		
		override protected function createChildren():void
		{
			_label = new Label();
			_label.width = 300;
			_label.height = 200;
			_label.align = Align.TOP_LEFT;
			_label.autoSize = false;
			_label.wordWrap = true;
			_label.multiline = true;
			_label.bgSkin.alpha = 0;
			//_label.borderVisible = true;
			//content = _label;
			addChild(_label)
			
			this.bgSkin = RainUI.getSkin("textInput");
		
			super.createChildren();
		}
		
		override protected function initialize():void 
		{
			super.initialize();
			this.direction=ScrollContainer.VERTICAL
		}
		
		/* DELEGATE me.rainui.components.TextInput */
		
		public function get format():TextFormat 
		{
			return _label.format;
		}
		
		public function set format(value:TextFormat):void 
		{
			_label.format = value;
		}
		
		public function get isHtml():Boolean 
		{
			return _label.isHtml;
		}
		
		public function set isHtml(value:Boolean):void 
		{
			_label.isHtml = value;
		}
		
		public function get text():String 
		{
			return _label.text;
		}
		
		public function set text(value:String):void 
		{
			_label.text = value;
		}
		
		public function get label():Label 
		{
			return _label;
		}
		
		public function set label(value:Label):void 
		{
			swapContent(_label, value)
			_label = value;
		}
		
		
	}

}