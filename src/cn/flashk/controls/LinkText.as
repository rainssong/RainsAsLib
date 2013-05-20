package cn.flashk.controls
{
	import cn.flashk.controls.managers.DefaultStyle;
	import cn.flashk.controls.skin.SkinThemeColor;
	import cn.flashk.controls.support.RoundRectAdvancedDraw;
	import cn.flashk.controls.support.UIComponent;
	import cn.flashk.conversion.ColorConversion;
	
	import flash.events.MouseEvent;
	import flash.net.URLRequest;
	import flash.net.navigateToURL;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	/**
	 * 设置Link文本的颜色（默认和鼠标划出）
	 * 
	 * @default "#000000"
	 *
	 * @langversion 3.0
	 * @playerversion Flash 9.0
	 */
	[Style(name="textColor", type="String")]
	/**
	 * 设置鼠标经过Link文本的颜色（默认和鼠标划出）
	 * 
	 * @default "#009100"
	 *
	 * @langversion 3.0
	 * @playerversion Flash 9.0
	 */
	[Style(name="textOverColor", type="String")]
	/**
	 * 设置鼠标经过矩形的圆角值
	 * 
	 * @default 3.5
	 *
	 * @langversion 3.0
	 * @playerversion Flash 9.0
	 */
	[Style(name="ellipse", type="Number")]
	/**
	 * 设置鼠标经过矩形的背景色
	 * 
	 * @default SkinThemeColor.bottom
	 * @see cn.flashk.controls.skin.SkinThemeColor
	 *
	 * @langversion 3.0
	 * @playerversion Flash 9.0
	 */
	[Style(name="color", type="uint")]
	
	/**
	 * LinkText 组件用来创建一个高效的网页链接。
	 *  
	 * @langversion ActionScript 3.0
	 * @playerversion Flash 9.0
	 * 
	 * @see cn.flashk.controls.support.UIComponent
	 * 
	 * @author flashk
	 */

	public class LinkText extends UIComponent
	{
		/**
		 * 设置/获取文本的链接地址（相对地址或绝对地址）
		 */
		public var linkURL:String ="";
		/**
		 * 设置/获取要在哪个窗口打开链接
		 */
		public var linkTarget:String = "_blank";
		/**
		 * 设置/获取链接文本鼠标经过时背景矩形的透明度
		 */
		public var backgroundAlpha:Number = 0.5;
		/**
		 * 设置/获取链接文本在鼠标经过时是否显示下划线
		 */
		public var overUnderLine:Boolean = false;
		
		protected var _outUnderLine:Boolean = true;
		protected var txt:TextField;
		protected var tf:TextFormat;
		
		public function LinkText()
		{
			super();
			
			_compoWidth = 100;
			_compoHeight = 20;
			styleSet["textColor"] = "#000000";
			styleSet["textOverColor"] = "#009100";
			styleSet["ellipse"] = 3.5;
			styleSet["color"] = SkinThemeColor.bottom;
			txt = new TextField();
			txt.text ="test";
			txt.height = _compoHeight;
			txt.width = _compoWidth;
			this.addChild(txt);
			tf = new TextFormat();
			tf.align = TextFormatAlign.CENTER;
			tf.color = ColorConversion.transformWebColor(styleSet["textColor"]);
			tf.underline = _outUnderLine;
			txt.defaultTextFormat = tf;
			txt.mouseEnabled = false;
			this.buttonMode = true;
			this.useHandCursor = true;
			this.addEventListener(MouseEvent.MOUSE_OVER,showOver);
			this.addEventListener(MouseEvent.MOUSE_OUT,showOut);
			this.addEventListener(MouseEvent.CLICK,openLink);
		}
		public function get outUnderLine():Boolean{
			return _outUnderLine;
		}
		/**
		 * 设置/获取链接文本在鼠标离开时是否显示下划线
		 * 
		 * @default true
		 */ 
		public function set outUnderLine(value:Boolean):void{
			_outUnderLine = value;
			tf.underline = _outUnderLine;
			txt.setTextFormat(tf);
		}
		protected function openLink(event:MouseEvent):void
		{
			if(linkURL == ""){
				return;
			}
			var req:URLRequest = new URLRequest(linkURL);
			flash.net.navigateToURL(req,linkTarget);
		}
		
		protected function showOver(event:MouseEvent):void
		{
			tf.color = ColorConversion.transformWebColor(styleSet["textOverColor"]);
			tf.underline = overUnderLine;
			txt.setTextFormat(tf);
			this.graphics.clear();
			this.graphics.beginFill(styleSet["color"],backgroundAlpha);
			var ew:Number = styleSet["ellipse"];
			var eh:Number = styleSet["ellipse"];
			var bw:Number = styleSet["ellipse"];
			var bh:Number = styleSet["ellipse"];
			RoundRectAdvancedDraw.drawAdvancedRoundRect(this.graphics, 0, 0, _compoWidth, _compoHeight, ew, eh,ew,eh,ew,eh,bw,bh,bw,bh);
		}
		protected function showOut(event:MouseEvent =null):void
		{
			tf.color = ColorConversion.transformWebColor(styleSet["textColor"]);
			tf.underline = _outUnderLine;
			txt.setTextFormat(tf);
			
			this.graphics.clear();
			
		}
		/**
		 * 设置/获取链接要显示的文本
		 */ 
		public function set label(value:String):void{
			txt.text = value;
			txt.setTextFormat(tf);
		}
		public function get label():String{
			return txt.text;
		}
		
		override public function setSize(newWidth:Number, newHeight:Number):void {
			super.setSize(newWidth, newHeight);
			
			txt.height = _compoHeight;
			txt.width = _compoWidth;
		}
		override public function setStyle(styleName:String, value:Object):void {
			super.setStyle(styleName, value);
			switch(styleName) {
				case "textColor":
					showOut();
					break;
			}
		}
	}
}