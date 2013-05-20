package cn.flashk.controls
{
	import cn.flashk.controls.managers.DefaultStyle;
	import cn.flashk.controls.managers.SkinLoader;
	import cn.flashk.controls.managers.SkinManager;
	import cn.flashk.controls.managers.SourceSkinLinkDefine;
	import cn.flashk.controls.skin.ActionDrawSkin;
	import cn.flashk.controls.skin.SkinThemeColor;
	import cn.flashk.controls.skin.TextAreaSkin;
	import cn.flashk.controls.skin.sourceSkin.ListSourceSkin;
	import cn.flashk.controls.support.UIComponent;
	import cn.flashk.conversion.ColorConversion;
	
	import flash.events.Event;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	
	/**
	 * TextArea 组件是一个带有边框和可选滚动条的多行文本字段。 TextArea 组件支持 Adobe Flash Player 的 HTML 呈现功能。 
	 *  
	 * @langversion ActionScript 3.0
	 * @playerversion Flash 9.0
	 * 
	 * @see cn.flashk.controls.support.UIComponent
	 * 
	 * @author flashk
	 */
	public class TextArea extends UIComponent
	{
		private var txt:TextField;
		private var tf:TextFormat;
		private var hScrollBar:HScrollBar;
		
		public function TextArea()
		{
			super();
			
			_compoWidth = 300;
			_compoHeight = 200;
			styleSet["ellipse"] = 0;
			styleSet["borderColor"] = ColorConversion.transUintToWeb(SkinThemeColor.border);
			styleSet["borderAlpha"] = 0.5;
			styleSet["backgroundColor"] = "#FDFDFD";
			styleSet["backgroundAlpha"] = 1.0;
			styleSet["textPadding"] = 3;
			
			txt = new TextField();
			this.addChild(txt);
			txt.x = styleSet["textPadding"] ;
			txt.y = styleSet["textPadding"] ;
			txt.width = _compoWidth-txt.x *2 ;
			txt.height = _compoHeight-txt.y*2;
			
			
			tf = new TextFormat();
			tf.align = TextFormatAlign.LEFT;
			tf.size = DefaultStyle.fontSize;
			tf.color = ColorConversion.transformWebColor(DefaultStyle.textColor);
			tf.font = DefaultStyle.font;
			
			txt.defaultTextFormat = tf;
			
			hScrollBar = new HScrollBar();
			this.addChild(hScrollBar);
			hScrollBar.y = _compoHeight-1;
			hScrollBar.x = 1;
			hScrollBar.setSize(17,_compoWidth-2);
			hScrollBar.updateSize(600);
			hScrollBar.clipSize = _compoWidth;
			hScrollBar.addEventListener("scroll",scrollTextH);
			
			setSize(_compoWidth, _compoHeight);
			
			this.graphics.beginFill(0);
			//this.graphics.drawRect(0,0,500,300);
		}
		
		protected function scrollTextH(event:Event):void
		{
			//trace(hScrollBar.scrollPosition);
			txt.scrollH = int(hScrollBar.scrollPosition);
		}
		
		public function set text(value:String):void{
			txt.text = value;
			trace("text",txt.maxScrollH );
			hScrollBar.maxScrollPosition = txt.maxScrollH;
			hScrollBar.updateSize(600);
		}
		public function get text():String{
			return txt.text;
		}
		override public function setDefaultSkin():void {
			setSkin(TextAreaSkin)
		}
		
		override public function setSourceSkin():void {
			setSkin(SkinLoader.getClassFromSkinFile(SourceSkinLinkDefine.LIST));
		}
		override public function setSkin(Skin:Class):void {
			if(SkinManager.isUseDefaultSkin == true){
				skin = new Skin();
				ActionDrawSkin(skin).init(this,styleSet);
			}else{
				var sous:ListSourceSkin = new ListSourceSkin();
				sous.init(this,styleSet,Skin);
				skin = sous;
			}
		}
	}
}