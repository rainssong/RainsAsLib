package cn.flashk.controls
{
	import cn.flashk.controls.managers.DefaultStyle;
	import cn.flashk.controls.managers.SkinLoader;
	import cn.flashk.controls.managers.SkinManager;
	import cn.flashk.controls.managers.SourceSkinLinkDefine;
	import cn.flashk.controls.modeStyles.ButtonStyle;
	import cn.flashk.controls.skin.ActionDrawSkin;
	import cn.flashk.controls.skin.SkinThemeColor;
	import cn.flashk.controls.skin.TitleSkin;
	import cn.flashk.controls.skin.sourceSkin.PanelSourceSkin;
	import cn.flashk.controls.support.RoundRectAdvancedDraw;
	import cn.flashk.controls.support.UIComponent;
	import cn.flashk.conversion.ColorConversion;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.CapsStyle;
	import flash.display.DisplayObject;
	import flash.display.JointStyle;
	import flash.display.LineScaleMode;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.filters.DropShadowFilter;
	import flash.filters.GlowFilter;
	import flash.geom.Rectangle;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	/**
	 * Panel 容器包括标题栏、标题、边框及其子项的内容区域。通常，您使用 Panel 容器包围顶级应用程序模块或一个不可移动的面板。
	 */ 

	public class Panel extends UIComponent
	{
		public static var titleTextAlign:String = "left";
		public static var titleTextFilter:Array = [ new GlowFilter(0xFFFFFF,1,12,12,2,2)];
		/**
		 * 
		 * 背景的滤镜，默认为距离为6，90度角 alpha=0.4的投影 [ new DropShadowFilter(6,45,0,1,4,4,0.4,1)]
		 */ 
		public var backgroundFilter:Array;
		public var backgroundColor:uint = 0xFFFFFF;
		public var backgroundAlpha:Number = 1;
		public var borderAlpha:Number = 0.7;
		public var borderColor:uint;
		public var borderThickness:Number = 1;
		
		public var titleBold:Boolean = true;
		
		protected var bg:Shape;
		protected var filterBG:Shape;
		protected var tiHeight:Number;
		
		protected var txt:TextField;
		protected var tf:TextFormat;
		
		protected var _content:DisplayObject;
		
		protected var iconDis:DisplayObject;
		
		
		protected var _autoClipContent:Boolean = true;
		
		
		protected var _paddingLeft:Number = 0;
		protected var _paddingBottom:Number = 0;
		
		
		public function Panel()
		{
			tiHeight = DefaultStyle.windowTitleHeight;
			super();
			_compoWidth = 300;
			_compoHeight = 200;
			//
			backgroundFilter =[ new DropShadowFilter(2,90,0,1,16,16,0.7,2,false,true,false)];
			//backgroundFilter = [];
			filterBG = new Shape();
			this.addChildAt(filterBG,0);
			bg = new Shape();
			this.addChild(bg);
			styleSet[ButtonStyle.DEFAULT_SKIN_ELLIPSE_WIDTH] = 4.55;
			styleSet[ButtonStyle.DEFAULT_SKIN_ELLIPSE_HEIGHT] = 4.55;
			styleSet[ButtonStyle.DEFAULT_SKIN_ELLIPSE_BOTTOM_WIDTH] = 1;
			styleSet[ButtonStyle.DEFAULT_SKIN_ELLIPSE_BOTTOM_HEIGHT] = 1;
			
			txt = new TextField();
			txt.x = styleSet[ButtonStyle.DEFAULT_SKIN_ELLIPSE_WIDTH]+3;
			if(titleTextAlign == "center"){
				txt.x =0 ;
			}
			txt.height = tiHeight;
			txt.y = (tiHeight-25)/2;
			txt.mouseEnabled = false;
			txt.filters = titleTextFilter;
			this.addChild(txt);
			tf = new TextFormat();
			tf.font = DefaultStyle.font;
			tf.size = DefaultStyle.titleFontSize;
			tf.align = titleTextAlign;
			tf.color = ColorConversion.transformWebColor(DefaultStyle.buttonOutTextColor);
			
			borderColor = SkinThemeColor.border;
			

			
			autoClipContent = true;
			
			setSize(_compoWidth,_compoHeight);
			titleAlpha=DefaultStyle.windowTitleAlpha;
			//useOpaqueBackground= true;
		}
		public function set title(value:String):void{
			if(titleBold == true){
				txt.htmlText= "<b>"+value+"</b>";
			}else{
				txt.htmlText= value;
			}
			txt.setTextFormat(tf);
		}
		public function set icon(value:Object):void{
			if(value is Class){
				var icon:Object = new value();
				iconDis = new Bitmap();
				this.addChild(iconDis);
				Bitmap(iconDis).bitmapData = icon as BitmapData;
			}
			if(value is BitmapData){
				iconDis = new Bitmap();
				this.addChild(iconDis);
				Bitmap(iconDis).bitmapData = value as BitmapData;
			}
			if(value is DisplayObject){
				iconDis = value as DisplayObject;
				this.addChild(iconDis);
			}
			iconDis.x = styleSet[ButtonStyle.DEFAULT_SKIN_ELLIPSE_WIDTH]+3;
			iconDis.y = int((tiHeight-iconDis.height)/2);
			txt.x = iconDis.x + iconDis.width + 3;
			if(titleTextAlign == "center"){
				txt.x =0 ;
				iconDis.x = _compoWidth/2-txt.textWidth/2-7-iconDis.width;
			}
		}
		public function get textField():TextField{
			return txt;
		}
		public function get titleHeight():Number{
			return tiHeight;
		}
		
		public function set titleHeight(value:Number):void{
			tiHeight = value;
			//txt.y = 2+(tiHeight-27)/2;
		}
		public function set paddingLeft(value:Number):void{
			_paddingLeft = value;
		}
		
		public function get paddingLeft():Number{
			return _paddingLeft;
		}
		public function set paddingBottom(value:Number):void{
			_paddingBottom = value;
		}
		public function get paddingBottom():Number{
			return _paddingBottom;
		}
		public function set titleAlpha(value:Number):void{
			if(skin is ActionDrawSkin){
				Object(skin).skinDisplayObject.alpha = value;
			}
		}
		public function get titleDisplayObject():DisplayObject{
			return Object(skin).skinDisplayObject;
		}
		public function get iconDisplayObject():DisplayObject{
			return iconDis;
		}
		/**
		 * 设置此Panel中要显示的内容，设置完后此value自动加入到Panel的显示列表中，并将x坐标重置为0，如果希望坐标不是0，请在设置完content属性后自行调整value的坐标。
		 * 为了增强content内容的性能。content直接被放置在panel子级，并且在默认情况下开启了自动裁剪.如果希望制作一个比较特别的效果，可以设置autoClipContent关闭自动裁剪。
		 * 
		 * @see autoClipContent;
		 */ 
		public function set content(value:DisplayObject):void{
			if(_content != null ){
				this.removeChild(_content);
			}
			_content = value;
			if(value == null) return;
			this.addChild(_content);
			_content.x  = _paddingLeft;
			_content.y = tiHeight;
			autoClipContent = autoClipContent;
		}
		public function get content():DisplayObject{
			return _content;
		}
		/**
		 * 对于超出panel容器边界的内容，是否对起进行裁剪（不显示在panel的大小范围外的内容），默认开启。
		 */ 
		public function set autoClipContent(value:Boolean):void{
			_autoClipContent = value;
			if(_content == null) return;
			if(_autoClipContent == true){
				_content.scrollRect = new Rectangle(0,0,_compoWidth-_paddingLeft*2,_compoHeight-tiHeight-_paddingBottom);
			}else{
				_content.scrollRect = null;
			}
		}
		public function get autoClipContent():Boolean{
			return _autoClipContent;
		}
		/**
		 * 获得内容显示区域的高度
		 */ 
		public function get contentHeight():Number{
			return _compoHeight-tiHeight;
		}
		/**
		 * 获得放置content的显示对象容器的引用，它是一个Sprite
		 */ 
		public function get contentContainer():Sprite{
			return this;
		}
		/**
		 * 窗口的背景是否开启不透明加速显示，如果需要设置透明背景，请将此值设为false
		 * 
		 * @see #backgroundAlpha
		 */
		public function set useOpaqueBackground(value:Boolean):void{
			if(value == true){
				bg.opaqueBackground = backgroundColor;
			}else{
				bg.opaqueBackground = null;
			}
		}
		override public function setDefaultSkin():void {
			setSkin(TitleSkin)
		}
		override public function setSourceSkin():void {
			setSkin(SkinLoader.getClassFromSkinFile(SourceSkinLinkDefine.PANEL));
		}
		override public function setSkin(Skin:Class):void {
			if(SkinManager.isUseDefaultSkin == true){
				skin = new Skin();
				ActionDrawSkin(skin).init(this,styleSet);
			}else{
				var sous:PanelSourceSkin = new PanelSourceSkin();
				sous.init(this,styleSet,Skin);
				skin = sous;
			}
		}
		override public function setSize(newWidth:Number, newHeight:Number):void {
			super.setSize(newWidth, newHeight);
			txt.width = _compoWidth-5;
			if(isUseSourceSkin == false){
				drawBackground();
			}
			if(titleTextAlign == "center"){
				if(iconDis != null){
					iconDis.x = _compoWidth/2-txt.textWidth/2-7-iconDis.width;
				}
			}
		}
		override protected function updateSkinPro():void{
			borderColor = SkinThemeColor.border;
			drawBackground(false);
		}
		private function drawBackground(isAll:Boolean = true):void{
			var ew:Number = styleSet[ButtonStyle.DEFAULT_SKIN_ELLIPSE_WIDTH];
			var eh:Number = styleSet[ButtonStyle.DEFAULT_SKIN_ELLIPSE_HEIGHT];
			var bw:Number = styleSet[ButtonStyle.DEFAULT_SKIN_ELLIPSE_BOTTOM_WIDTH];
			var bh:Number = styleSet[ButtonStyle.DEFAULT_SKIN_ELLIPSE_BOTTOM_HEIGHT];
			if(isAll == true){
				filterBG.graphics.clear();
				filterBG.graphics.beginFill(0xFFFFFF,1);
				RoundRectAdvancedDraw.drawAdvancedRoundRect(filterBG.graphics, -borderThickness, -borderThickness+1.5, _compoWidth+borderThickness*2, _compoHeight+borderThickness*2-2, ew, eh,ew,eh,ew,eh,bw,bh,bw,bh);
				filterBG.filters = backgroundFilter;
				bg.graphics.clear();
				bg.graphics.beginFill(backgroundColor,backgroundAlpha);
			//bg.graphics.lineStyle(0.1,SkinThemeColor.border,backgroundBorderAlpha,true,LineScaleMode.NORMAL,CapsStyle.ROUND,JointStyle.ROUND,3);
			
				RoundRectAdvancedDraw.drawAdvancedRoundRect(bg.graphics, 0.5, tiHeight, _compoWidth-1, _compoHeight-tiHeight-1, ew, eh,0,0,0,0,bw,bh,bw,bh);
			}

			this.graphics.clear();
			this.graphics.lineStyle(borderThickness,borderColor,borderAlpha,true,LineScaleMode.NORMAL,CapsStyle.ROUND,JointStyle.ROUND,3);
			this.graphics.beginFill(0,0);
			RoundRectAdvancedDraw.drawAdvancedRoundRect(this.graphics, -borderThickness/2, -borderThickness/2+0.5, _compoWidth+borderThickness, _compoHeight+borderThickness-1, ew, eh,ew,eh,ew,eh,bw,bh,bw,bh);
		}
	}
}