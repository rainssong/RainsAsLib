package cn.flashk.controls
{
	import cn.flashk.controls.events.MenuEvent;
	import cn.flashk.controls.managers.DefaultStyle;
	import cn.flashk.controls.managers.SkinLoader;
	import cn.flashk.controls.managers.SkinManager;
	import cn.flashk.controls.managers.SourceSkinLinkDefine;
	import cn.flashk.controls.managers.ThemesSet;
	import cn.flashk.controls.skin.ActionDrawSkin;
	import cn.flashk.controls.skin.SimpleItemBackground;
	import cn.flashk.controls.skin.SkinThemeColor;
	import cn.flashk.controls.skin.sourceSkin.MenuBarSourceSkin;
	import cn.flashk.controls.support.UIComponent;
	
	import flash.display.DisplayObject;
	import flash.display.GradientType;
	import flash.display.Shape;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Matrix;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	
	/**
	 * 当用户选择某一菜单项时调度
	 * @eventType cn.flashk.controls.events.MenuEvent.ITEM_CLICK
	 **/
	[Event(name="itemClick",type="cn.flashk.controls.events.MenuEvent")]

	/**
	 * MenuBar 组件件定义包含一个或多个菜单的顶级水平菜单栏。
	 */ 
	public class MenuBar extends UIComponent
	{
		protected var xml:XML;
		protected var _dataProvider:XML;
		protected var txts:Array = new Array();
		protected var bgs:Array = new Array();
		protected var tf:TextFormat;
		protected var menu:Menu;
		protected var isAct:Boolean = false;
		protected var openedTarget:Object;
		protected var sh:Shape;
		
		public function MenuBar()
		{
			super();
			_compoHeight = 19;
			tf = new TextFormat();
			tf.font = DefaultStyle.font;
			tf.size = DefaultStyle.fontSize;
			tf.color = DefaultStyle.textColor;
			tf.align = TextFormatAlign.CENTER;
			sh = new Shape();
			showBG();
			if(SkinManager.isUseDefaultSkin == true){
				backgroundAlpha = 0.5;
				this.addChildAt(sh,0);
			}
		}
		public function set dataProvider(value:XML):void{
			_dataProvider = value;
			xml = _dataProvider[0];
			initMenuBar();
		}
		public function set backgroundAlpha(value:Number):void{
			if(SkinManager.isUseDefaultSkin == true){
				sh.alpha = value;
			}else{
				skin.sc9Bitmap.alpha = value;
			}
		}
		override public function setSourceSkin():void {
			setSkin(SkinLoader.getClassFromSkinFile(SourceSkinLinkDefine.MENU_BAR_BACKGROUND));
		}
		override public function setSkin(Skin:Class):void {
			if(SkinManager.isUseDefaultSkin == true){
				skin = new Skin();
				ActionDrawSkin(skin).init(this,styleSet);
			}else{
				var sous:MenuBarSourceSkin = new MenuBarSourceSkin();
				sous.init(this,styleSet,Skin);
				skin = sous;
			}
		}
		private function initMenuBar():void{
			var txt:TextField;
			var bg:DisplayObject;
			for(var i:int=0;i<xml.children().length();i++){
				txt = new TextField();
				txt.height = tf.size+8;
				txt.text = xml.children()[i].@label;
				txt.selectable = false;
				txt.width = txt.textWidth+25;
				this.addChild(txt);
				if(i>0){
					txt.x = TextField(txts[i-1]).x + TextField(txts[i-1]).width;
				}else{
					txt.x = 5;
				}
				txt.setTextFormat(tf);
				txt.addEventListener(MouseEvent.MOUSE_OVER,showMenuOver);
				txt.addEventListener(MouseEvent.MOUSE_OUT,showMenuOut);
				txt.addEventListener(MouseEvent.CLICK,openMenu);
				txt.name = "txt"+i;
				txts.push(txt);
				//
				bg = new SimpleItemBackground();
				this.addChildAt(bg,1);
				bg.x = txt.x;
				Object(bg).setSize(txt.width,_compoHeight);
				bg.alpha = 0;
				bgs.push(bg);
			}
		}
		
		protected function showMenuOver(event:MouseEvent):void
		{
			var na:String = event.currentTarget.name as String;
			var id:uint = uint(na.slice(3));
			openedTarget = null;
			if(isAct == false){
				DisplayObject(bgs[id]).alpha = 0.4;
			}else{
				DisplayObject(bgs[id]).alpha = 0.9;
			}
			if(isAct == true && event.currentTarget != openedTarget){
				openMenu(event);
			}
		}
		protected function showMenuOut(event:MouseEvent):void
		{
			var na:String = event.currentTarget.name as String;
			var id:uint = uint(na.slice(3));
			DisplayObject(bgs[id]).alpha = 0;
		}
		override protected function updateSkinPro():void{
			showBG();
		}
		private function showBG():void{
			if(SkinManager.isUseDefaultSkin == true){
				var colors:Array = [ SkinThemeColor.bottom,SkinThemeColor.top];
				var alphas:Array = [1.0, 1.0];
				
				var ratios:Array;
				
				ratios = [0, 255];
				
				sh.graphics.clear();
				var mat:Matrix = new Matrix();
				var width:Number =_compoWidth;
				var height:Number = _compoHeight;
				mat.createGradientBox(width, height, 90* Math.PI/180);
				sh.graphics.lineStyle(0, 0,0);
				sh.graphics.beginGradientFill(GradientType.LINEAR, colors, alphas, ratios, mat);
				sh.graphics.drawRect(0,0,100,_compoHeight);
			}
		}
		
		override public function setSize(newWidth:Number, newHeight:Number):void{
			super.setSize(newWidth,newHeight);
			sh.width = newWidth;
			sh.height = newHeight;
			for(var i:int=0;i<bgs.length;i++){
				var dis:DisplayObject = bgs[i] as DisplayObject;
				dis.height = newHeight;
			}
		}
		private function openMenu(event:MouseEvent):void{
			if(event.currentTarget == openedTarget){
				
					openedTarget = null;
					return;
				
			}
			if(menu != null && menu.parent != null){
				menu.parent.removeChild(menu);
			}
			var na:String = event.currentTarget.name as String;
			var id:uint = uint(na.slice(3));
			menu = new Menu();
			this.stage.addChild(menu);
			menu.y = this.y + this.height;
			menu.x = DisplayObject(event.currentTarget).x;
			menu.dataProvider = xml.children()[id];
			menu.addEventListener(Event.REMOVED_FROM_STAGE,resetAct);
			menu.addEventListener(MenuEvent.ITEM_CLICK,disEvent);
			isAct = true;
			openedTarget = event.currentTarget;
		}
		
		protected function disEvent(event:MenuEvent):void
		{
			trace("bar",event is MenuEvent);
			this.dispatchEvent(event);
		}
		
		protected function resetAct(event:Event):void
		{
			isAct = false;
			//menu.removeEventListener(MenuEvent.ITEM_CLICK,disEvent);
			menu = null;
		}
	}
}