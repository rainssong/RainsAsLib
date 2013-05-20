package cn.flashk.controls
{
	import cn.flashk.controls.events.MenuEvent;
	import cn.flashk.controls.interfaces.IListItemRender;
	import cn.flashk.controls.managers.DefaultStyle;
	import cn.flashk.controls.skin.SkinThemeColor;
	import cn.flashk.controls.support.MenuItemRender;
	import cn.flashk.controls.support.SWFDefinition;
	import cn.flashk.controls.support.UIComponent;
	import cn.flashk.conversion.ColorConversion;
	
	import flash.display.DisplayObject;
	import flash.display.InteractiveObject;
	import flash.display.Shape;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.filters.DropShadowFilter;
	
	/**
	 * 当用户选择某一菜单项时调度
	 * @eventType cn.flashk.controls.events.MenuEvent.ITEM_CLICK
	 **/
	[Event(name="itemClick",type="cn.flashk.controls.events.MenuEvent")]

	/**
	 * Menu 组件创建可分别选择的选项的弹出菜单，此弹出菜单类似于大多数软件应用程序中的“文件”或“编辑”菜单。
	 */ 
	public class Menu extends UIComponent
	{
		/**
		 * 图标获取函数
		 * 
		 * @default SWFDefinition.getDefinitionBitmapDataByName
		 * @see cn.flashk.controls.support.SWFDefinition
		 */ 
		public var iconGetFunction:Function = SWFDefinition.getDefinitionBitmapDataByName;
		/**
		 * 菜单背景的滤镜，默认为距离为6，45度角 alpha=0.4的投影 [ new DropShadowFilter(6,45,0,1,4,4,0.4,1)]
		 */ 
		public var backgroundFilter:Array;
		protected var _dataProvider:XML;
		protected var xml:XML;
		protected var _itemRender:Class;
		protected var bg:Shape;
		protected var subMenu:Menu;
		
		public function Menu()
		{
			_itemRender = MenuItemRender;
			
			styleSet["ellipse"] = 0;
			styleSet["borderColor"] = ColorConversion.transUintToWeb(SkinThemeColor.border);
			styleSet["borderAlpha"] = 0.5;
			styleSet["backgroundColor"] = "#FDFDFD";
			styleSet["backgroundAlpha"] = 1.0;
			styleSet["textPadding"] = 30;
			styleSet["iconPadding"] = 7;
			
			bg = new Shape();
			
			backgroundFilter =[ new DropShadowFilter(8,45,0,1,4,4,0.4,2)];
			
			this.addEventListener(Event.ADDED_TO_STAGE,addStageLis);
			this.addEventListener(Event.REMOVED_FROM_STAGE,clearLis);
		}
		
		protected function clearLis(event:Event):void
		{
			this.stage.removeEventListener(MouseEvent.MOUSE_DOWN,checkClose);
			if(subMenu != null){
				subMenu.parent.removeChild(subMenu);
				subMenu = null;
			}
		}
		
		protected function addStageLis(event:Event):void
		{
			this.stage.addEventListener(MouseEvent.MOUSE_DOWN,checkClose);
		}
		
		protected function checkClose(event:MouseEvent):void
		{
			if(this.stage == null) return;
			if(this.hitTestPoint(this.stage.mouseX,this.stage.mouseY)== false){
				this.parent.removeChild(this);
			}
		}
		
		public function set dataProvider(value:XML):void{
			_dataProvider = value;
			xml = _dataProvider[0];
			initMenu();
		}
		public function set itemRender(value:Class):void{
			_itemRender = value;
		}
		public function get itemRender():Class{
			return _itemRender;
		}
		private function initMenu():void{
			var item:DisplayObject;
			var maxWidth:Number = 10;
			if(bg.parent == this) this.removeChild(bg);
			for(var i:int=0;i<xml.children().length();i++){
				item = new _itemRender() as DisplayObject;
				Object(item).menu = this;
				IListItemRender(item).data = xml.children()[i];
				this.addChild(item);
				if(i>0){
					item.y = this.getChildAt(i-1).y + IListItemRender(this.getChildAt(i-1)).itemHeight;
				}else{
					item.y = 1;
				}
				InteractiveObject(item).addEventListener(MouseEvent.CLICK,checkSelect);
				InteractiveObject(item).addEventListener(MouseEvent.MOUSE_OVER,checkLevelMenu);
				if(Object(item).textWidth > maxWidth){
					maxWidth = Object(item).textWidth;
				}
			}
			for(i=0;i<this.numChildren;i++){
				item = this.getChildAt(i);
				IListItemRender(item).setSize(maxWidth+styleSet["textPadding"]+25,0);
			}
			_compoWidth = maxWidth+styleSet["textPadding"]+25;
			_compoHeight = this.height+1;
			drawBG();
		}
		
		protected function checkLevelMenu(event:MouseEvent):void
		{
			var item:IListItemRender = IListItemRender(event.currentTarget);
			if(subMenu != null){
				subMenu.parent.removeChild(subMenu);
				subMenu = null;
			}
			if(item.data.children().length()>0){
				subMenu = new Menu();
				this.stage.addChild(subMenu);
				subMenu.y = this.y + DisplayObject(item).y;
				subMenu.x = this.x+_compoWidth-3;
				subMenu.dataProvider =item.data as XML;
				//subMenu.addEventListener(Event.REMOVED_FROM_STAGE,resetAct);
				subMenu.addEventListener(MenuEvent.ITEM_CLICK,disEvent);
			}
		}
		
		protected function checkSelect(event:MouseEvent):void
		{
			var da:Object = event.currentTarget.data;
			if(String(da.@enabled) == "false"){
				return;
			}
			if(String(da.@type) == "separator"){
				return;
			}
			this.parent.removeChild(this);
			this.dispatchEvent(new MenuEvent(MenuEvent.ITEM_CLICK,event.currentTarget.data));
		}
		protected function drawBG():void{
			this.addChildAt(bg,0);
			bg.graphics.clear();
			bg.graphics.lineStyle(0.1,SkinThemeColor.border,0.3);
			bg.graphics.beginFill(0xFFFFFF,1);
			bg.graphics.drawRect(-1,0,_compoWidth+1,_compoHeight);
			bg.graphics.beginFill(ColorConversion.transformWebColor(DefaultStyle.menuBackgroundColor),15);
			bg.graphics.drawRect(-1,0,_compoWidth+1,_compoHeight);
			bg.filters = backgroundFilter;
		}
		protected function disEvent(event:MenuEvent):void
		{
			this.dispatchEvent(event);
		}
	}
}