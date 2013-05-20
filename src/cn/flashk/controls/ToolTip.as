package cn.flashk.controls
{
	import cn.flashk.controls.managers.DefaultStyle;
	import cn.flashk.controls.skin.ActionDrawSkin;
	import cn.flashk.controls.skin.SkinThemeColor;
	import cn.flashk.controls.skin.ToolTipSkin;
	import cn.flashk.controls.support.UIComponent;
	import cn.flashk.conversion.ColorConversion;
	
	import flash.display.BlendMode;
	import flash.display.DisplayObject;
	import flash.display.InteractiveObject;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.filters.DropShadowFilter;
	import flash.geom.Point;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.utils.Timer;
	import flash.utils.clearTimeout;
	import flash.utils.setTimeout;

	/**
	 * 设置工具提示的背景矩形圆角
	 * 
	 * @default 3.5
	 *
	 * @langversion 3.0
	 * @playerversion Flash 9.0
	 */
	[Style(name="ellipse", type="Number")]
	/**
	 * 设置工具提示的背景顶部的颜色（由上到下得渐变色）
	 * 
	 * @default cn.flashk.controls.skin.SkinThemeColor.top
	 * @see cn.flashk.controls.skin.SkinThemeColor
	 *
	 * @langversion 3.0
	 * @playerversion Flash 9.0
	 */
	[Style(name="backgroundTopColor", type="uint")]
	/**
	 * 设置工具提示的背景底部的颜色（由上到下得渐变色）
	 * 
	 * @default cn.flashk.controls.skin.SkinThemeColor.bottom
	 *
	 * @langversion 3.0
	 * @playerversion Flash 9.0
	 */
	[Style(name="backgroundBottomColor", type="uint")]
	/**
	 * 设置工具提示的背景顶部颜色的透明度
	 * 
	 * @default 0.7
	 *
	 * @langversion 3.0
	 * @playerversion Flash 9.0
	 */
	[Style(name="backgroundTopAlpha", type="Number")]
	/**
	 * 设置工具提示的背景底部颜色的透明度
	 * 
	 * @default 1.0
	 *
	 * @langversion 3.0
	 * @playerversion Flash 9.0
	 */
	[Style(name="backgroundBottomAlpha", type="Number")]
	/**
	 * 设置工具提示的边框的颜色
	 * 
	 * @default cn.flashk.controls.skin.SkinThemeColor.border
	 *
	 * @langversion 3.0
	 * @playerversion Flash 9.0
	 */
	[Style(name="borderColor", type="uint")]
	/**
	 * 设置工具提示边框的透明度
	 * 
	 * @default 0.6
	 *
	 * @langversion 3.0
	 * @playerversion Flash 9.0
	 */
	[Style(name="borderAlpha", type="Number")]
	
	/**
	 * 通过 ToolTip 控件，您可以为用户提供有用信息。当用户将鼠标指针移至图形组件上方时，将会弹出 ToolTip 控件，显示提供该组件相关信息的文本。
	 * 您可以使用 ToolTip 指导用户使用您的应用程序，也可以自定义 ToolTip 控件以提供附加功能。
	 * 
	 * <p>通常情况下你不需要自己创建ToolTip实例，全部的组件都支持直接设置toolTip属性自动显示ToolTip。</p>
	 * 对于非组件的显示对象（InteractiveObject子类），使用registerTip静态方法可以获得和组件一样的提示。也可以使用showAToolTipOnStage静态方法将一个ToolTip立即显示在舞台上。此方法会立即返回新创建的ToolTip实例。此ToolTip具有和其他ToolTip一样的行为（如淡入、淡出、鼠标跟随等）。
	 * 
	 * 如果需要自定义ToolTip的行为，可以创建一个ToolTip实例并自己用代码控制。并使用setStyle设置各种属性。textField和skinDisplayObject分别能获取文本和背景实例的引用。
	 * 
	 * 注意：setStyle方法只控制单个的ToolTip外观，如果需要控制全部的ToolTip外观，请使用setDefaultToolTipStyle静态方法。
	 * 无论如何设置外观，文本的TextFormat不受此设置的影响，要设置文本样式，请单独设置ToolTip的静态属性textFormat。此属性将改变所有ToolTip实例的文本样式。
	 * 
	 * 
	 * @see cn.flashk.controls.support.UIComponent
	 */ 

	public class ToolTip extends UIComponent
	{
		/**
		 * 新 ToolTip 控件的最大宽度（以像素为单位）。大于此宽度文本将自动换行。
		 */ 
		public static var maxWidth:Number=500;
		/**
		 * 是否让提示实时跟随鼠标移动
		 */ 
		public static var isFollowMouse:Boolean = true;
		/**
		 * 提示文本的全局样式（影响所有ToolTip实例）
		 */ 
		public static var textFormat:TextFormat;
		/**
		 * 提示文本的顶部边距（全局设置，影响所有ToolTip实例）
		 */ 
		public static var paddingTop:Number = 0;
		/**
		 * 提示文本的左边距（全局样设置，影响所有ToolTip实例）
		 */ 
		public static var paddingLeft:Number = 5;
		/**
		 * 提示文本的淡入的速度，如果需要关闭淡入，将此值设置为1，请勿使用0或者负数（全局设置，影响所有ToolTip实例）
		 */ 
		public static var alphaIn:Number = 0.1;
		/**
		 * 提示文本的淡出的速度，如果需要关闭淡出，将此值设置为1，请勿使用0或者负数（全局设置，影响所有ToolTip实例）
		 */ 
		public static var alphaOut:Number = 0.05;
		/**
		 * 提示文本背景的滤镜，默认是一个阴影滤镜（全局设置，影响所有ToolTip实例）
		 */ 
		public static var backgroundFilter:Array = [new DropShadowFilter(4,45,0,1,4,4,0.3,1)];
		
		private static var tips:Array = new Array();
		private static var timer:Timer = new Timer(1500);
		private static var isOn:Boolean = false;
		private static var target:InteractiveObject;
		private static var tip:Object;
		private static var ins:ToolTip;
		private static var timeOutID:uint;
		
		private static var defaultToolTipStyle:Object;
		
		private static var stage:Stage;
		
		private var txt:TextField;
		private var _tipValue:Object;
		
		/**
		 * 创建一个新的 ToolTip 组件实例
		 */ 
		public function ToolTip()
		{
			super();
			
			if(textFormat == null){
				textFormat = new TextFormat();
				textFormat.font = DefaultStyle.font;
				textFormat.size = DefaultStyle.fontSize;
			}
			textFormat.color = ColorConversion.transformWebColor(DefaultStyle.buttonOutTextColor);
			
			
			if(defaultToolTipStyle != null){
				styleSet["ellipse"] = defaultToolTipStyle.ellipse;
				styleSet["backgroundTopColor"] = defaultToolTipStyle.backgroundTopColor;
				styleSet["backgroundBottomColor"] = defaultToolTipStyle.backgroundBottomColor;
				styleSet["backgroundTopAlpha"] = defaultToolTipStyle.backgroundTopAlpha;
				styleSet["backgroundBottomAlpha"] = defaultToolTipStyle.backgroundBottomAlpha;
				styleSet["borderColor"] = defaultToolTipStyle.borderColor;
				styleSet["borderAlpha"] = defaultToolTipStyle.borderAlpha;
				
			}else{
				styleSet["ellipse"] = DefaultStyle.toolTipEllipse;
				styleSet["backgroundTopColor"] = SkinThemeColor.top;
				styleSet["backgroundBottomColor"] = SkinThemeColor.bottom;
				styleSet["backgroundTopAlpha"] = 0.7;
				styleSet["backgroundBottomAlpha"] = 1.0;
				styleSet["borderColor"] = SkinThemeColor.border;
				styleSet["borderAlpha"] = 0.6;
			}
			styleSet["textFormat"] = textFormat;
			_compoWidth = 69;
			_compoHeight = 20;
			
			trace(skinDisplayObject);
		}
		public function alphaInInit():void{
			this.alpha = 0;
			//this.removeEventListener(Event.ENTER_FRAME,alphaOutFrame);
			this.addEventListener(Event.ENTER_FRAME,alphaInFrame);
		}
		public function alphaOutInit():void{
			this.removeEventListener(Event.ENTER_FRAME,alphaInFrame);
			this.addEventListener(Event.ENTER_FRAME,alphaOutFrame);
		}
		
		/**
		 * 设置提示，接受简单String，HTML String，图像URL Request，BitmapData,库链接，DisplayObject
		 */
		public function set tip(value:Object):void{
			_tipValue =value;
			if(_tipValue is String){
				if(txt == null){
					txt = new TextField();
					this.addChild(txt);
					txt.htmlText = value as String;
					txt.setTextFormat(styleSet["textFormat"]);
					txt.x = paddingLeft;
					txt.y = paddingTop;
					txt.width =maxWidth;
					txt.wordWrap = true;
					txt.width = txt.textWidth+5;
					txt.height = txt.textHeight+5;
					txt.blendMode = BlendMode.LAYER;
					
					_compoWidth = txt.width+paddingLeft*2-3;
					_compoHeight = txt.height+paddingTop*2-1;
					
					setSize(_compoWidth,_compoHeight);
					skinDisplayObject.filters = backgroundFilter;
					if(this.x+_compoWidth+3>this.stage.stageWidth){
						this.x = this.stage.stageWidth - _compoWidth-3;
					}
					if(this.y + _compoHeight+3>this.stage.stageHeight){
						this.y = this.stage.mouseY-_compoHeight-5;
					}
				}
			}
		}
		public function get tip():Object{
			return _tipValue;
		}
		/**
		 * 获得文本框实例的引用
		 */ 
		public function get textField():TextField{
			return txt;
		}
		/**
		 * 获得背景实例的引用
		 */
		public function get skinDisplayObject():DisplayObject{
			return skin.skinDisplayObject as DisplayObject;
		}
		private function alphaInFrame(event:Event):void{
			this.alpha += alphaIn;
			if(this.alpha>=1){
				this.alpha = 1;
				this.removeEventListener(Event.ENTER_FRAME,alphaInFrame);
			}
		}
		private function alphaOutFrame(event:Event):void{
			this.alpha -= alphaOut;
			if(this.alpha<=0){
				this.alpha = 0;
				this.removeEventListener(Event.ENTER_FRAME,alphaOutFrame);
				if(this.parent != null){
					this.parent.removeChild(this);
				}
			}
		}
		override public function setDefaultSkin():void {
			setSkin(ToolTipSkin);
		}
		override public function setSourceSkin():void {
			setSkin(ToolTipSkin);
		}
		override public function setSkin(Skin:Class):void {
			skin = new Skin();
			if (skin is ActionDrawSkin) {
				ActionDrawSkin(skin).init(this,styleSet);
			}
		}
		/**
		 * 对一个可交互的显示对象启用提示，此提示将获得和组件一样的行为
		 */ 
		public static function registerTip(interDisplay:InteractiveObject,tip:Object):void{
			clearTip(interDisplay);
			interDisplay.addEventListener(MouseEvent.MOUSE_OVER,interOver);
			interDisplay.addEventListener(MouseEvent.MOUSE_OUT,interOut);
			tips.push([interDisplay,tip]);
			timer.addEventListener(TimerEvent.TIMER,showTip);
		}
		/**
		 * 对一个可交互的显示对象的提示删除，并清除EventListener和引用
		 */ 
		public static function clearTip(interDisplay:InteractiveObject):void{
			interDisplay.removeEventListener(MouseEvent.MOUSE_OVER,interOver);
			interDisplay.removeEventListener(MouseEvent.MOUSE_OUT,interOut);
			for(var i:Object in tips){
				if(tips[i][0] == interDisplay){
					tips.splice(uint(i),1);
					break;
				}
			}
		}
		/**
		 * 设置提示的延迟，单位：毫秒（提示将在此时间后才开始显示，如果在此时间内移开，则不显示提示，对于一组附近的按钮，如果第一个提示已经显示，则后面的提示直接显示，移开这组按钮将重新计时）
		 */ 
		public static function set showDelay(value:uint):void{
			timer.delay = value;
		}
		public static function get showDelay():uint{
			return uint(timer.delay);
		}
		/**
		 * 设置ToolTip的全局样式，影响所有ToolTip实例，样式说明参见Styles
		 */ 
		public static function setDefaultToolTipStyle(ellipse:Number,
													  backgroundTopColor:uint,
													  backgroundBottomColor:uint,
													  backgroundTopAlpha:Number,
													  backgroundBottomAlpha:Number,
													  borderColor:uint,
													  borderAlpha:Number):void{
			defaultToolTipStyle = new Object();
			defaultToolTipStyle.ellipse = ellipse;
			defaultToolTipStyle.backgroundTopColor = backgroundTopColor;
			defaultToolTipStyle.backgroundBottomColor = backgroundBottomColor;
			defaultToolTipStyle.backgroundTopAlpha = backgroundTopAlpha;
			defaultToolTipStyle.backgroundBottomAlpha = backgroundBottomAlpha;
			defaultToolTipStyle.borderColor = borderColor;
			defaultToolTipStyle.borderAlpha = borderAlpha;
		}
		public static function get toolTipInstance():ToolTip{
			return ins;
		}
		/**
		 * 立即在舞台上显示一个ToolTip实例
		 */ 
		public static function showAToolTipOnStage(stage:Stage,tip:Object):ToolTip{
			ToolTip.stage = stage;
			ToolTip.tip = tip;
			showTip();
			return ins;
		}
		private static function showTip(event:TimerEvent=null):void{
			timer.stop();
			ins = new ToolTip();
			stage.addChild(ins);
			ins.x = stage.mouseX;
			ins.y = stage.mouseY+18;
			ins.tip = tip;
			isOn = true;
			if(isFollowMouse == true){
				stage.addEventListener(MouseEvent.MOUSE_MOVE,updateToolTipXY);
			}
			ins.alphaInInit();
		}
		private static function updateToolTipXY(event:MouseEvent):void{
			
			ins.x = stage.mouseX;
			ins.y = stage.mouseY+18;
			if(ins.x+ins.compoWidth+3>stage.stageWidth){
				ins.x = stage.stageWidth - ins.compoWidth-3;
			}
			if(ins.y + ins.compoHeight+3>stage.stageHeight){
				ins.y = stage.mouseY-ins.compoHeight-5;
			}
			event.updateAfterEvent();
		}
		private static function reInitXY(tar:ToolTip):void{
			tar.x = stage.mouseX;
			tar.y = stage.mouseY+18;
			tar.visible = true;
			tar.alphaInInit();
			if(tar.x+tar.compoWidth+3>stage.stageWidth){
				tar.x = stage.stageWidth - tar.compoWidth-3;
			}
			if(tar.y + tar.compoHeight+3>stage.stageHeight){
				tar.y = stage.mouseY-tar.compoHeight-5;
			}
		}
		private static function interOver(event:MouseEvent):void{
			var tar:InteractiveObject = event.currentTarget as InteractiveObject;
			var index:uint = 0;
			for(var i:Object in tips){
				if(tips[i][0] == tar){
					index = uint(i) ;
					break;
				}
			}
			target = tips[index][0] as InteractiveObject;
			stage = target.stage;
			tip = tips[index][1];
			if(isOn == true){
				showTip();
				ins.visible = false;
				setTimeout(reInitXY,300,ins);
			}else{
				timer.start();
			}
			clearTimeout(timeOutID);
		}
		private static function interOut(event:MouseEvent):void{
			timer.reset();
			if(ins != null ){
				ins.alphaOutInit();
				stage.removeEventListener(MouseEvent.MOUSE_MOVE,updateToolTipXY);
			}
			timeOutID = setTimeout(offIsOnLater,500);
		}
		private static function offIsOnLater():void{
			isOn = false;
		}
	}
}