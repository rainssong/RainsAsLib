package cn.flashk.controls 
{
	import cn.flashk.controls.managers.DefaultStyle;
	import cn.flashk.controls.managers.SkinLoader;
	import cn.flashk.controls.managers.SkinManager;
	import cn.flashk.controls.managers.SourceSkinLinkDefine;
	import cn.flashk.controls.modeStyles.ButtonMode;
	import cn.flashk.controls.modeStyles.ButtonStyle;
	import cn.flashk.controls.skin.ActionDrawSkin;
	import cn.flashk.controls.skin.ButtonSkin;
	import cn.flashk.controls.skin.sourceSkin.ButtonSourceSkin;
	import cn.flashk.controls.support.BaseButton;
	import cn.flashk.conversion.ColorConversion;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.BlendMode;
	import flash.display.DisplayObject;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	
	/**
	 * 设置按钮文本的颜色（默认和鼠标划出）
	 * 
	 * @default DefaultStyle.buttonOutTextColor
	 * 
	 * @see cn.flashk.controls.modeStyles.ButtonStyle
	 * @see cn.flashk.controls.managers.DefaultStyle
	 *
	 * @langversion 3.0
	 * @playerversion Flash 9.0
	 */
	[Style(name="textColor", type="String")]
	/**
	 * 设置鼠标在按钮上时文本的颜色
	 * 
	 * @default DefaultStyle.buttonOverTextColor
	 * 
	 * @see cn.flashk.controls.modeStyles.ButtonStyle
	 * @see cn.flashk.controls.managers.DefaultStyle
	 *
	 * @langversion 3.0
	 * @playerversion Flash 9.0
	 */
	[Style(name="textOverColor", type="String")]
	/**
	 * 设置按钮按下时文本的颜色
	 * 
	 * @default DefaultStyle.buttonDownTextColor
	 * 
	 * @see cn.flashk.controls.modeStyles.ButtonStyle
	 * @see cn.flashk.controls.managers.DefaultStyle
	 *
	 * @langversion 3.0
	 * @playerversion Flash 9.0
	 */
	[Style(name="textDownColor", type="String")]
	/**
	 * 按钮文本的边距（左对齐和右对齐时）
	 * 
	 * 
	 * @see cn.flashk.controls.modeStyles.ButtonStyle
	 * @see cn.flashk.controls.managers.DefaultStyle
	 *
	 * @langversion 3.0
	 * @playerversion Flash 9.0
	 */
	[Style(name="textPadding", type="Number")]
	/**
	 * 文本的对齐模式
	 * 
	 * 
	 * @see cn.flashk.controls.modeStyles.ButtonStyle
	 * @see cn.flashk.controls.managers.DefaultStyle
	 *
	 * @langversion 3.0
	 * @playerversion Flash 9.0
	 */
	[Style(name="textAlign", type="String")]
	/**
	 * 鼠标经过时要显示的图标（替换划开时图标），用此样式创建鼠标划入和划出具有不同图标的按钮
	 * 
	 * 
	 * @see cn.flashk.controls.modeStyles.ButtonStyle
	 * @see cn.flashk.controls.managers.DefaultStyle
	 *
	 * @langversion 3.0
	 * @playerversion Flash 9.0
	 */
	[Style(name="iconOver", type="Object")]
	/**
	 * 鼠标按下时要显示的图标（替换划开时图标）
	 * 
	 * 
	 * @see cn.flashk.controls.modeStyles.ButtonStyle
	 * @see cn.flashk.controls.managers.DefaultStyle
	 *
	 * @langversion 3.0
	 * @playerversion Flash 9.0
	 */
	[Style(name="iconDown", type="Object")]
	/**
	 * 按钮上部的圆角宽度值
	 * 
	 * @default 3.5
	 * 
	 * @see cn.flashk.controls.modeStyles.ButtonStyle
	 *
	 * @langversion 3.0
	 * @playerversion Flash 9.0
	 */
	[Style(name="defaultSkinEllipseWidth", type="Number")]
	/**
	 * 按钮上部的圆角高度值
	 * 
	 * @default 3.5
	 * 
	 * @see cn.flashk.controls.modeStyles.ButtonStyle
	 *
	 * @langversion 3.0
	 * @playerversion Flash 9.0
	 */
	[Style(name="defaultSkinEllipseHeight", type="Number")]
	/**
	 * 按钮下部的圆角宽度值
	 * 
	 * @default 3.5
	 * 
	 * @see cn.flashk.controls.modeStyles.ButtonStyle
	 *
	 * @langversion 3.0
	 * @playerversion Flash 9.0
	 */
	[Style(name="defaultSkinEllipseBottomWidth", type="Number")]
	/**
	 * 按钮下部的圆角高度值
	 * 
	 * @default 3.5
	 * 
	 * @see cn.flashk.controls.modeStyles.ButtonStyle
	 *
	 * @langversion 3.0
	 * @playerversion Flash 9.0
	 */
	[Style(name="defaultSkinEllipseBottomHeight", type="Number")]
	
	
	//events
	/**
	 * 当用户点击按钮时触发
	 * @eventType flash.events.MouseEvent.CLICK
	 **/
	[Event(name="click",type="flash.events.MouseEvent")]
	
	/**
	 * Button 组件表示常用的矩形按钮。 Button 组件可显示文本标签、图标或同时显示两者。
	 *  
	 * @langversion ActionScript 3.0
	 * @playerversion Flash 9.0
	 * 
	 * @see cn.flashk.controls.support.UIComponent
	 * 
	 * @author flashk
	 */
	public class Button extends BaseButton
	{
		/**
		 * 设置按钮显示是否使用皮肤默认的大小，设置此属性为true将忽略setSize方法而一直使用皮肤定义的大小1:1显示，并且关闭九宫格缩放，但按钮的compoWidth和compoHeight值仍然是setSize传递的值。
		 * 设置此值可以在不知道皮肤按钮大小的情况下使用，只影响皮肤的显示。
		 */ 
		public static var defaultHeihgt:Number = 19;
		public var useSkinSize:Boolean = false;
		protected var txt:TextField;
		protected var txtDrop:TextField;
		protected var tf:TextFormat;
		protected var iconClassSet:Object;
		protected var iconBD:DisplayObject;
		protected var iconOverClassSet:Object;
		protected var iconDownClassSet:Object;
		protected var _mode:String = ButtonMode.JUST_LABEL;
		protected var mouseState:String = MouseEvent.MOUSE_OUT;
		protected var _isOutSkinHide:Boolean = false;
		protected var _skinUseCatch:Boolean = false;
		
		public function Button() 
		{
			super();
			
			_compoWidth = 69;
			_compoHeight = defaultHeihgt;
			
			new ButtonStyle(styleSet);
			txt = new TextField();
			txtDrop = new TextField();
			txtDrop.textColor = 0xFFFFFF;
			txtDrop.selectable = false;
			txtDrop.mouseEnabled = false;
			txtDrop.blendMode = BlendMode.LAYER;
			txtDrop.alpha = DefaultStyle.buttonTextDropAlpha;;
			this.addChild(txtDrop);
			this.addChild(txt);
			tf = new TextFormat();
			tf.align = TextFormatAlign.CENTER;
			tf.size = DefaultStyle.fontSize;
			tf.color = ColorConversion.transformWebColor(styleSet[ButtonStyle.TEXT_COLOR]);
			tf.font = DefaultStyle.font;
			txt.height = DefaultStyle.fontSize + 8;
			txt.selectable = false;
			txt.mouseEnabled = false;
			txt.setTextFormat(tf);
			txt.blendMode = BlendMode.LAYER;
			txtDrop.height = txt.height;
			txt.filters = DefaultStyle.buttonTextFilters;
			label = "按钮";
			setSize(_compoWidth, _compoHeight);
			this.addEventListener(MouseEvent.MOUSE_OVER, showOver);
			this.addEventListener(MouseEvent.MOUSE_OUT, showOut);
			this.addEventListener(MouseEvent.MOUSE_DOWN, showDown);
			this.addEventListener(MouseEvent.MOUSE_UP, showUp);
			
		}
		override public function setDefaultSkin():void {
			setSkin(ButtonSkin);
		}
		override public function setSourceSkin():void {
			_skinUseCatch = true;
			setSkin(SkinLoader.getClassFromSkinFile(SourceSkinLinkDefine.BUTTON));
		}
		override public function setSkin(Skin:Class):void {
			if(SkinManager.isUseDefaultSkin == true){
				skin = new Skin();
				ActionDrawSkin(skin).init(this,styleSet);
			}else{
				if((skin as ButtonSourceSkin)==null){
					var sous:ButtonSourceSkin = new ButtonSourceSkin();
					skin = sous;
				}
				skin.useSkinSize = useSkinSize;
				skin.useCatch = _skinUseCatch;
				skin.init(this,styleSet,Skin);
			}
			_skinUseCatch = false;
		}
		/**
		 * 设置/访问按钮要显示的文本
		 */
		public function set label(value:String):void {
			txt.text = value;
			txt.setTextFormat(tf);
			var bak:Object = tf.color;
			txtDrop.text = txt.text;
			tf.color = ColorConversion.transformWebColor(DefaultStyle.buttonTextDropColor);
			txtDrop.setTextFormat(tf);
			tf.color = bak;
		}
		public function get label():String{
			return txt.text;
		}
		/**
		 * 设置问按钮要显示的图标，接受3种格式：库链接名、BitmapData数据，DisplayObject(Bitmap、Sprite、Shape、MovieClip等）。
		 * 
		 * <p>要使鼠标经过时显示不同的图标，请使用setStyle("iconOver",value)方法</p>
		 */
		public function set icon(value:Object):void {
			if (_mode == ButtonMode.JUST_LABEL) {
				_mode = ButtonMode.ICON_LABEL;
			}
			if(iconBD!=null && iconBD.parent==this){
				this.removeChild(iconBD);
			}
			if(value is DisplayObject){
				iconBD = value as DisplayObject;
			}
			if(value is BitmapData){
				iconBD = new Bitmap();
				iconClassSet = value;
				setBitmap(value);
			}
			if(value is Class){
				iconClassSet = new value();
			}
			if (iconClassSet  is BitmapData) {
				iconBD = new Bitmap();
				setBitmap(iconClassSet);
			}
			if(iconClassSet is DisplayObject){
				iconBD = iconClassSet as DisplayObject;
			}
			this.addChild(iconBD);
				
			reAlign();
				
			
		}
		/**
		 * 获取按钮文本框实例的引用
		 */ 
		public function get textField():TextField {
			return txt;
		}
		/**
		 * 设置按钮的显示模式：justLabel 值显示文本、justIcon只显示图标，iconLabel图标和文本混排，此值为ButtonMode类的几个静态常量，设置此值能获得更高的显示性能。
		 * 
		 * @see cn.flashk.controls.modeStyles.ButtonMode
		 */ 
		public function set mode(value:String):void {
			_mode = value;
			if (_mode == ButtonMode.JUST_ICON) {
				this.removeChild(txt);
				this.removeChild(txtDrop);
				txt = null;
				txtDrop = null;
				setSize(_compoWidth, _compoHeight);
			}
		}
		/**
		 * 设置按钮的弹起（鼠标划开）状态是否隐藏外观（也就是工具栏的按钮模式，此模式下按钮本身只是个图标或者文字，只有在鼠标划过时才显示为按钮外观）
		 */ 
		public function set isOutSkinHide(value:Boolean):void {
			_isOutSkinHide = value;
			if (_isOutSkinHide == true) {
				
					skin.hideOutState();
				
			}
		}
		override public function setSize(newWidth:Number, newHeight:Number):void {
			super.setSize(newWidth, newHeight);
			reAlign();
		}
		private function reAlign():void{
			if (_mode == ButtonMode.JUST_ICON) {
				if(iconBD != null){
					iconBD.x = int((_compoWidth - iconBD.width) / 2)+1;
					iconBD.y = int((_compoHeight-iconBD.height)/2);
				}
			}
			if(_mode == ButtonMode.JUST_LABEL){
				txt.x = Number(styleSet[ButtonStyle.TEXT_PADDING]);
				txt.width = _compoWidth -txt.x*2;
				txt.y = int((_compoHeight - txt.height) / 2)-1;
				txtDrop.width = txt.width;
				txtDrop.x = txt.x;
				txtDrop.y = txt.y+1;
			}
			if(_mode == ButtonMode.ICON_LABEL) {
				iconBD.y = Math.round((_compoHeight - iconBD.height) / 2)-1;
				iconBD.x = (_compoWidth-iconBD.width-5-txt.textWidth)/2;
				if(styleSet [ "align" ] == "left"){
					iconBD.x = styleSet [ "padding" ];
				}
				tf.align = TextFormatAlign.LEFT;
				txt.x = iconBD.x + iconBD.width+5-2;
				txt.y = int((_compoHeight - txt.height) / 2)-1;
				txt.width = _compoWidth - txt.x;
				txt.setTextFormat(tf);
				txtDrop.width = txt.width;
				txtDrop.x = txt.x;
				txtDrop.y = txt.y+1;
				var bak:Object = tf.color;
				txtDrop.text = txt.text;
				tf.color = ColorConversion.transformWebColor(DefaultStyle.buttonTextDropColor);
				txtDrop.setTextFormat(tf);
				tf.color = bak;
			}
		}
		override public function update():void{
			reAlign();
		}
		public function setTextFormat(format:TextFormat, beginIndex:int = -1, endIndex:int = -1):void {
			txt.setTextFormat(format, beginIndex, endIndex);
		}
		override public function setStyle(styleName:String, value:Object):void {
			super.setStyle(styleName, value);
			switch(styleName) {
				case ButtonStyle.TEXT_COLOR:
					if (mouseState == MouseEvent.MOUSE_OUT) {
						showOut();
					}
					break;
					
				case ButtonStyle.DEFAULT_SKIN_ELLIPSE_WIDTH:
					if (skin is ActionDrawSkin) ActionDrawSkin(skin).reDraw();
					break;
					
				case ButtonStyle.DEFAULT_SKIN_ELLIPSE_HEIGHT:
					if (skin is ActionDrawSkin) {
						ActionDrawSkin(skin).reDraw();
					}
					break;
				
				case ButtonStyle.DEFAULT_SKIN_ELLIPSE_BOTTOM_WIDTH:
					if (skin is ActionDrawSkin) ActionDrawSkin(skin).reDraw();
					break;
				
				case ButtonStyle.DEFAULT_SKIN_ELLIPSE_BOTTOM_HEIGHT:
					if (skin is ActionDrawSkin) ActionDrawSkin(skin).reDraw();
					break;
					
				case ButtonStyle.ICON_OVER:
					if(value is BitmapData){
						iconOverClassSet = value;
					}else{
						iconOverClassSet = new value();
					}
					break;
					
				case ButtonStyle.ICON_DOWN:
					if(value is BitmapData){
						iconDownClassSet = value;
					}else{
						iconDownClassSet = new value();
					}
					break;
				
				case ButtonStyle.TEXT_ALIGN:
					tf.align = String(value);
					txt.setTextFormat(tf);
					
					
				case ButtonStyle.TEXT_PADDING:
					txt.x = Number(value);
					txt.width = _compoWidth-txt.x*2;
					
				default:
					break;
			}
		}
		override public function updateSkin():void {
		
			super.updateSkin();
			
			if (findStyleUserSet(ButtonStyle.TEXT_COLOR) == false) {
				
				styleSet[ ButtonStyle.TEXT_COLOR ] = DefaultStyle.buttonOutTextColor;
			}
			if (findStyleUserSet(ButtonStyle.TEXT_OVER_COLOR) == false) {
				styleSet[ ButtonStyle.TEXT_OVER_COLOR ] = DefaultStyle.buttonOverTextColor;
			}
			if (findStyleUserSet(ButtonStyle.TEXT_DOWN_COLOR) == false) {
				styleSet[ ButtonStyle.TEXT_DOWN_COLOR ] = DefaultStyle.buttonDownTextColor;
			}
			initTextColor();
		}
		protected function showOver(event:MouseEvent = null):void {
			mouseState = MouseEvent.MOUSE_OVER;
			if (iconOverClassSet != null)
			{
				setBitmap(iconOverClassSet);
			}
			if (_mode == ButtonMode.JUST_LABEL || _mode == ButtonMode.ICON_LABEL) {
				tf.color = ColorConversion.transformWebColor(styleSet[ButtonStyle.TEXT_OVER_COLOR]);
				txt.setTextFormat(tf);
			}
		}
		protected function showUp(event:MouseEvent = null):void {
			mouseState = MouseEvent.MOUSE_OVER;
			if (iconOverClassSet != null)
			{
				setBitmap(iconOverClassSet);
			}
			if (_mode == ButtonMode.JUST_LABEL || _mode == ButtonMode.ICON_LABEL) {
				tf.color = ColorConversion.transformWebColor(styleSet[ButtonStyle.TEXT_OVER_COLOR]);
				txt.setTextFormat(tf);
			}
		}
		protected function showOut(event:MouseEvent = null):void {
			mouseState = MouseEvent.MOUSE_OUT;
			if (iconClassSet != null) {
				setBitmap(iconClassSet);
			}
			if (_mode == ButtonMode.JUST_LABEL || _mode == ButtonMode.ICON_LABEL) {
				tf.color = ColorConversion.transformWebColor(styleSet[ButtonStyle.TEXT_COLOR]);
				txt.setTextFormat(tf);
			}
		}
		protected function initTextColor():void {
			
			tf.color = ColorConversion.transformWebColor(styleSet[ButtonStyle.TEXT_COLOR]);
			if(txt != null){
				txt.setTextFormat(tf);
			}
		}
		protected function showDown(event:MouseEvent = null):void {
			mouseState = MouseEvent.MOUSE_DOWN;
			if (iconDownClassSet != null) {
				setBitmap(iconDownClassSet);
			}
			if (_mode == ButtonMode.JUST_LABEL || _mode == ButtonMode.ICON_LABEL) {
				tf.color = ColorConversion.transformWebColor(styleSet[ButtonStyle.TEXT_DOWN_COLOR]);
				txt.setTextFormat(tf);
			}
		}
		protected function setBitmap(bd:Object):void {
			if ( iconBD == null) {
				iconBD = new Bitmap();
			}
			Bitmap(iconBD).bitmapData = bd as BitmapData;
		}
	}

}