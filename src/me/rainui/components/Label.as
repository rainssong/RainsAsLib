
package me.rainui.components
{
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.filters.GlowFilter;
	import flash.geom.Rectangle;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	import me.rainui.RainUI;
	//import morn.core.utils.ObjectUtils;
	//import morn.core.utils.StringUtils;
	//
	/**文本发生改变后触发*/
	[Event(name="change",type="flash.events.Event")]
	
	/**文字标签*/
	public class Label extends Container
	{
		//public var deftaultTextFormat:TextFormat = new TextFormat("微软雅黑", 24, 0, null, null, null, null, null, TextFormatAlign.CENTER);
		public var textField:TextField;
		protected var _format:TextFormat;
		protected var _text:String = "";
		protected var _isHtml:Boolean;
		protected var _stroke:String;
		protected var _skinName:String;
		//protected var _bitmap:AutoBitmap;
		protected var _margin:Array = [0, 0, 0, 0];
		
		public function Label(text:String = "", dataSource:String = null)
		{
			super(dataSource)
			this.text = text;
			//this.skinName = _skinName;
		}
		
		override protected function preinitialize():void
		{
			mouseEnabled = false;
			mouseChildren = true;
			_format = new TextFormat("微软雅黑", 24, 0, null, null, null, null, null, TextFormatAlign.CENTER);
			_width = 200;
			_height = 60;
			_autoSize = false;
		}
		
		override protected function createChildren():void
		{
			//addChild(_bitmap = new AutoBitmap());
			addChild(textField = new TextField());
		}
		
		override protected function initialize():void
		{
			textField.defaultTextFormat = _format;
			//_format.font = Styles.fontName;
			//_format.size = Styles.fontSize;
			//_format.color = Styles.labelColor;
			textField.selectable = false;
			textField.autoSize = TextFieldAutoSize.LEFT;
			
			//_bitmap.sizeGrid = [2, 2, 2, 2];
			callLater(resize);
		}
		
		/**显示的文本*/
		public function get text():String
		{
			return _text;
		}
		
		public function set text(value:String):void
		{
			if (_text != value)
			{
				_text = value || "";
				callLater(redraw);
				sendEvent(Event.CHANGE);
			}
		}
		
		//protected function changeText():void
		//{
			//textField.setTextFormat(_format);
			//_isHtml ? textField.htmlText = App.lang.getLang(_text) : textField.text = App.lang.getLang(_text);
		//}
		
		override public function redraw():void 
		{
			
			textField.defaultTextFormat = _format;
			textField.setTextFormat(_format);
			textField.text = _text;
			super.redraw();
		}
		
		override public function resize():void
		{
			super.resize();
			
			textField.x = 2;
			textField.y = 2;
			if (_autoSize)
			{
				if (wordWrap)
				{
					textField.width = _width;
					textField.height = textField.textHeight + 2;
				}
				else
				{
					textField.height = _height;
					textField.width = textField.textWidth + 2;
				}
				_height = textField.height + 4 + textField.x;
				_width = textField.width + 4 + textField.y;
			}
			else
			{
				textField.width = _width;
				textField.height = _height;
			}
		}
		
		override public function showBorder(color:uint = 0xff0000, conetntColor:int =-1):void
		{
			super.showBorder(color, conetntColor);
			_border.graphics.lineStyle(1, 0x00FF00);
			if(conetntColor)
				_border.graphics.drawRect(textField.x, textField.y, textField.width, textField.height);
		}
		
		/**是否是html格式*/
		public function get isHtml():Boolean
		{
			return _isHtml;
		}
		
		public function set isHtml(value:Boolean):void
		{
			if (_isHtml != value)
			{
				_isHtml = value;
				//callLater(redraw);
				callLater(redraw);
			}
		}
		
		/**描边(格式:color,alpha,blurX,blurY,strength,quality)*/
		//public function get stroke():String {
		//return _stroke;
		//}
		//
		//public function set stroke(value:String):void {
		//if (_stroke != value) {
		//_stroke = value;
		//ObjectUtils.clearFilter(textField, GlowFilter);
		//if (Boolean(_stroke)) {
		//var a:Array = StringUtils.fillArray(Styles.labelStroke, _stroke);
		//ObjectUtils.addFilter(textField, new GlowFilter(a[0], a[1], a[2], a[3], a[4], a[5]));
		//}
		//}
		//}
		
		/**是否是多行*/
		public function get multiline():Boolean
		{
			return textField.multiline;
		}
		
		public function set multiline(value:Boolean):void
		{
			textField.multiline = value;
		}
		
		/**是否是密码*/
		public function get asPassword():Boolean
		{
			return textField.displayAsPassword;
		}
		
		public function set asPassword(value:Boolean):void
		{
			textField.displayAsPassword = value;
		}
		
		/**宽高是否自适应*/
		//public function get textAlign():String
		//{
			//return textField.autoSize;
		//}
		//
		//public function set textAlign(value:String):void
		//{
			//textField.autoSize = value;
			//callLater(resize);
		//}
		
		/**是否自动换行*/
		public function get wordWrap():Boolean
		{
			return textField.wordWrap;
		}
		
		public function set wordWrap(value:Boolean):void
		{
			textField.wordWrap = value;
		}
		
		/**是否可选*/
		public function get selectable():Boolean
		{
			return textField.selectable;
		}
		
		public function set selectable(value:Boolean):void
		{
			textField.selectable = value;
			mouseEnabled = value;
		}
		
		/**是否具有背景填充*/
		public function get background():Boolean
		{
			return textField.background;
		}
		
		public function set background(value:Boolean):void
		{
			textField.background = value;
		}
		
		/**文本字段背景的颜色*/
		public function get backgroundColor():uint
		{
			return textField.backgroundColor;
		}
		
		public function set backgroundColor(value:uint):void
		{
			textField.backgroundColor = value;
		}
		
		/**字体颜色*/
		public function get color():Object
		{
			return _format.color;
		}
		
		public function set color(value:Object):void
		{
			_format.color = value;
			callLater(redraw);
		}
		
		/**字体类型*/
		public function get font():String
		{
			return _format.font;
		}
		
		public function set font(value:String):void
		{
			_format.font = value;
			callLater(redraw);
		}
		
		/**对齐方式*/
		public function get align():String
		{
			return _format.align;
		}
		
		public function set align(value:String):void
		{
			_format.align = value;
			callLater(redraw);
		}
		
		/**粗体类型*/
		public function get bold():Object
		{
			return _format.bold;
		}
		
		public function set bold(value:Object):void
		{
			_format.bold = value;
			callLater(redraw);
		}
		
		/**垂直间距*/
		public function get leading():Object
		{
			return _format.leading;
		}
		
		public function set leading(value:Object):void
		{
			_format.leading = value;
			callLater(redraw);
		}
		
		/**第一个字符的缩进*/
		public function get indent():Object
		{
			return _format.indent;
		}
		
		public function set indent(value:Object):void
		{
			_format.indent = value;
			callLater(redraw);
		}
		
		/**字体大小*/
		public function get size():Object
		{
			return _format.size;
		}
		
		public function set size(value:Object):void
		{
			_format.size = value;
			callLater(redraw);
		}
		
		/**下划线类型*/
		public function get underline():Object
		{
			return _format.underline;
		}
		
		public function set underline(value:Object):void
		{
			_format.underline = value;
			callLater(redraw);
		}
		
		/**字间距*/
		public function get letterSpacing():Object
		{
			return _format.letterSpacing;
		}
		
		public function set letterSpacing(value:Object):void
		{
			_format.letterSpacing = value;
			callLater(redraw);
		}
		
		/**边距(格式:左边距,上边距,右边距,下边距)*/
		public function get margin():String
		{
			return _margin.join(",");
		}
		
		public function set margin(value:String):void
		{
			//_margin = StringUtils.fillArray(_margin, value, int);
			textField.x = _margin[0];
			//textField.y = _margin[1];
			//callLater(changeSize);
		}
		
		/**格式*/
		public function get format():TextFormat
		{
			return _format;
		}
		
		public function set format(value:TextFormat):void
		{
			_format = value;
			callLater(redraw);
		}
		
		/**将指定的字符串追加到文本的末尾*/
		public function appendText(newText:String):void
		{
			text += newText;
		}
		
		/**皮肤*/
		//public function get skinName():String
		//{
			//return _skinName;
		//}
		//
		//public function set skinName(value:String):void
		//{
			//if (_skinName != value)
			//{
				//_skinName = value;
				//_bitmap.bitmapData = RainUI.asset.getBitmapData(_skin);
				//_contentWidth = _bitmap.bitmapData.width;
				//_contentHeight = _bitmap.bitmapData.height;
			//}
		//}
		
		/**九宫格信息(格式:左边距,上边距,右边距,下边距)*/
		//public function get sizeGrid():String {
		//return _bitmap.sizeGrid.join(",");
		//}
		//
		//public function set sizeGrid(value:String):void {
		//_bitmap.sizeGrid = StringUtils.fillArray(Styles.defaultSizeGrid, value, int);
		//}
		
		//override public function get width():Number
		//{
			//if (!isNaN(_width) || Boolean(_skinName) || Boolean(_text))
			//{
				//return super.width;
			//}
			//return 0;
		//}
		
		//override public function set width(value:Number):void
		//{
			//super.width = value;
			//_bitmap.width = value;
		//}
		
		override public function get height():Number
		{
			if (!isNaN(_height) || Boolean(_skinName) || Boolean(_text))
			{
				return super.height;
			}
			return 0;
		}
		
		//override public function set height(value:Number):void
		//{
			//super.height = value;
			//_bitmap.height = value;
		//}
		
		override public function set dataSource(value:Object):void
		{
			_dataSource = value;
			if (value is Number || value is String)
			{
				text = String(value);
			}
			else
			{
				super.dataSource = value;
			}
		}
	}
}