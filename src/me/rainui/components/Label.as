
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
	import me.rainssong.utils.Align;
	import me.rainssong.utils.ScaleMode;
	import me.rainui.RainUI;
	//import morn.core.utils.ObjectUtils;
	//import morn.core.utils.StringUtils;
	//
	/**文本发生改变后触发*/
	[Event(name="change",type="flash.events.Event")]
	
	/**文字标签*/
	public class Label extends DisplayResizer
	{
		//public var deftaultTextFormat:TextFormat = new TextFormat("微软雅黑", 24, 0, null, null, null, null, null, TextFormatAlign.CENTER);
		public var textField:TextField;
		//TODO:这里应该代理？
		protected var _format:TextFormat;
		protected var _text:String = "";
		protected var _isHtml:Boolean;
		protected var _stroke:String;
		protected var _skinName:String;
		//protected var _bitmap:AutoBitmap;
		protected var _margin:Array = [0, 0, 0, 0];
		
		static public var defaultStyleFactory:Function;
		
		public function Label(text:String = "Label", dataSource:Object = null)
		{
			
			super(null,dataSource)
			this.text = text;
		}
		
		override protected function preinitialize():void
		{
			
			super.preinitialize();
			mouseEnabled = false;
			mouseChildren = true;
			
			//BUG:会覆盖掉原本的文字
			
			
			this._width = 200*RainUI.scale;
			this._height = 60*RainUI.scale;
			_autoSize = false;
			_contentScaleMode = ScaleMode.NONE;
		}
		
		override protected function createChildren():void
		{
			
			if (numChildren == 1 && getChildAt(0) is TextField)
			{
				textField = getChildAt(0) as TextField;
				//_contentAlign = Align.LEFT;
				//textField.autoSize = TextFieldAutoSize.NONE;
			}
			
			if (textField == null)
			{
				addChild(textField = new TextField());
				_contentAlign = Align.LEFT;
				textField.autoSize = TextFieldAutoSize.NONE;
				_content = textField;
				textField.height = 60 * RainUI.scale;
				_format = RainUI.getTextFormat("label");
				size = 32 * RainUI.scale;
				
				this._width = 200*RainUI.scale;
				this._height = 60*RainUI.scale;
			}
			else
			{
				
				_width = textField.width;
				_height = textField.height;

				_text = textField.text;
				_format = textField.getTextFormat();
				_content = textField;
				
				size = textField.getTextFormat().size;
				
				switch(_format.align)
				{
					case TextFormatAlign.CENTER:
					case TextFormatAlign.JUSTIFY:
						_contentAlign = Align.CENTER;
					break;
					case TextFormatAlign.START:
					case TextFormatAlign.LEFT:
						_contentAlign = Align.LEFT;
					break;
					case TextFormatAlign.RIGHT:
					case TextFormatAlign.END:
						_contentAlign = Align.RIGHT;
					break;
					default:
						_contentAlign = Align.CENTER;
				}
				
				//_autoSize = textField.autoSize
				
			}
			
			super.createChildren();
		}
		
		//public function get styleFactory():void
		//{
			//
		//}
		
		override protected function initialize():void
		{
			textField.defaultTextFormat = _format;
			//textField.setTextFormat(_format);
			textField.selectable = false;
			callLater(resize);
			
			if (defaultStyleFactory!=null)
				defaultStyleFactory(this);
				
			super.initialize();
		}
		
		/**显示的文本*/
		public function get text():String
		{
			redraw();
			return textField.text;
		}
		
		public function set text(value:String):void
		{
			if (text != value)
			{
				if (value == null)
					value = "";
					
				_text = value;
				//textField.text = value;
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
			if (textField)
			{
				//BUG:多色由富文本组件完成
				textField.defaultTextFormat = _format;
				//BUG:可能会导致iOS上框选
				//textField.setTextFormat(_format);
			}
			
			textField.text = _text;
			
			super.redraw();
		}
		
		override public function resize():void
		{
			if (textField == null) return;
			if (_autoSize)
			{
				if (wordWrap)
				{
					textField.height = textField.textHeight + 4;
				}
				else
				{
					textField.height = _height;
				}
				textField.x = 0;
				textField.y = 0;
				textField.width = textField.textWidth + 4;
				textField.height = textField.textHeight + 4;
				_width=textField.width;
				_height=textField.height;
			}
			else
			{
				//BUG:这样会导致变高，垂直局中无效
				//textField.height = Math.max(_height,textField.textHeight+4);
				textField.height =textField.textHeight+4;
				textField.width = _width;
			}
			
			super.resize();
		}
		
		override public function showBorder(color:uint = 0xff0000, conetntColor:int =-1):void
		{
			super.showBorder(color, conetntColor);
			_border.graphics.lineStyle(1, 0x00FF00);
			if(conetntColor && textField)
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
			
			//此方案用于全局填色，一次执行，所以不可放入redraw中
			textField.setTextFormat(_format);
			textField.defaultTextFormat = _format;
			//redraw();
			//callLater(redraw)
		}
		
		/**字体类型*/
		public function get font():String
		{
			return _format.font;
		}
		
		public function set font(value:String):void
		{
			_format.font = value;
			textField.defaultTextFormat = _format;
			callLater(redraw);
			//redraw();
		}
		
		/**对齐方式*/
		public function get align():String
		{
			return _contentAlign;
		}
		
		public function set align(value:String):void
		{
			contentAlign = value
			
			switch (_contentAlign) 
			{
				case Align.LEFT:
				case Align.TOP_LEFT:
				case Align.BOTTOM_LEFT:
					_format.align = TextFormatAlign.LEFT;
					break;
				case Align.TOP:
				case Align.CENTER:
				case Align.BOTTOM:
					_format.align = TextFormatAlign.CENTER;
					break;
				case Align.RIGHT:
				case Align.TOP_RIGHT:
				case Align.BOTTOM_RIGHT:
					_format.align = TextFormatAlign.RIGHT;
					break;
				break;
				default:
			}
			
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
			//redraw();
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
		
		/* DELEGATE flash.text.TextField */
		
		public function getTextFormat(beginIndex:int = -1, endIndex:int = -1):flash.text.TextFormat 
		{
			return textField.getTextFormat(beginIndex, endIndex);
		}
		
		public function setTextFormat(format:TextFormat, beginIndex:int = -1, endIndex:int = -1):void 
		{
			textField.setTextFormat(format, beginIndex, endIndex);
		}
		
		/* DELEGATE flash.text.TextField */
		
		public function get embedFonts():Boolean 
		{
			return textField.embedFonts;
		}
		
		public function set embedFonts(value:Boolean):void 
		{
			textField.embedFonts = value;
			callLater(resize);
		}
		
		/* DELEGATE flash.text.TextField */
		
		public function get htmlText():String 
		{
			return textField.htmlText;
		}
		
		public function set htmlText(value:String):void 
		{
			if (textField.htmlText != value)
			{
				//textField.htmlText = value;
				if (value == null)
					powerTrace("null");
				_text = value;
				sendEvent(Event.CHANGE);
				callLater(redraw);
			}
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
			if (!isNaN(_height) || Boolean(text))
			{
				return super.height;
			}
			return 0;
		}
		
		override public function set height(value:Number):void
		{
			super.height = value;
		}
		
		//override public function get autoSize():Boolean 
		//{
			//return super.autoSize;
		//}
		//
		//override public function set autoSize(value:Boolean):void 
		//{
			//super.autoSize = value;
		//}
		
		
	}
}