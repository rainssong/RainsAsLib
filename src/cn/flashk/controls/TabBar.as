package cn.flashk.controls 
{
	import cn.flashk.controls.events.TabCloseEvent;
	import cn.flashk.controls.managers.SkinLoader;
	import cn.flashk.controls.managers.SkinManager;
	import cn.flashk.controls.managers.SourceSkinLinkDefine;
	import cn.flashk.controls.skin.ActionDrawSkin;
	import cn.flashk.controls.skin.TabBarSkin;
	import cn.flashk.controls.skin.sourceSkin.TabSourceSkin;
	import cn.flashk.controls.support.Tab;
	import cn.flashk.controls.support.UIComponent;
	
	import flash.display.DisplayObject;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	import flash.utils.setTimeout;

	/**
	 * 设置Tabs标签按钮的边距，对于左对齐的标签，是左边距，右对齐的标签是右边距，居中对齐，此设置无效。
	 * 
	 * @default 5
	 * 
	 * @see #align
	 *
	 * @langversion 3.0
	 * @playerversion Flash 9.0
	 */
	[Style(name="padding", type="Number")]
	
	/**
	 * 当标签被用户关闭或者以编程方式关闭时
	 * @cn.flashk.controls.events.TabCloseEven
	 **/
	[Event(name="tabClose",type="cn.flashk.controls.events.TabCloseEvent")]
	
	/**
	 * TabBar 组件表示一组选项卡，用户可以在这些选项卡里切换显示。当作为文档标签时，用户可以关闭这些标签。
	 *  
	 * @langversion ActionScript 3.0
	 * @playerversion Flash 9.0
	 * 
	 * @see cn.flashk.controls.support.UIComponent
	 * 
	 * @author flashk
	 */
	public class TabBar extends UIComponent
	{
		/**
		 * 设置选项卡按钮对齐的方式，接受下列3个值：
		 * left 左对齐、center 居中对齐、right 右对齐（要设置左右对齐的边距请查看setStyle方法中的padding样式）
		 */
		public var align:String = "center";
		public var isAutoResetXY:Boolean = true;
		public var isAutoClip:Boolean = true;
		protected var _padding:Number = 1;
		public static var selectUp:Number = 2;
		protected var tabs:Array;
		protected var _paddingTop:Number = 25;
		/**
		 * 设置选项卡之间的间距
		 */ 
		public static var tabSpace:Number = 0;
		public static var tabHeight:Number = 22;
		protected var nowContent:DisplayObject;
		protected var isHide:Boolean;
		protected var switchFun:Function;
		protected var index:uint=0;
		protected var hn:Number = 0.07;
		protected var sn:Number = 0.12;
		protected var _contents:Array;
		protected var _labels:Array;
		protected var _icons:Array;
		protected var box:Sprite;
		
		public function TabBar() 
		{
			
			super();
			_compoWidth = 400;
			_compoHeight = 500;
			tabs = [];
			_contents = [];
			box = new Sprite();
			box.y = _paddingTop;
			styleSet["padding"] = 5;
			this.addChild(box);
			if(SkinManager.isUseDefaultSkin == true){
				tabSpace = 2;
			}
			setSize(_compoWidth, _compoHeight);
		}
		public function set padding(value:Number):void{
			_padding = value;
			//box.x = _padding;
		}
		public function set paddingTop(value:Number):void{
			_paddingTop = value;
			if(box != null){
				box.y = _paddingTop;
			}
		}
		public function get contents():Array {
			return _contents;
		}
		/**
		 * 标签切换淡出的Alpha减少的值。如果内容区域过大，建议将此值设为1以关闭alpha过渡
		 */ 
		public function set alphaHideNum(value:Number):void {
			hn = value;
		}
		/**
		 * 标签切换淡入的Alpha增加的值。如果内容区域过大，建议将此值设为1以关闭alpha过渡
		 */
		public function set alphaShowNum(value:Number):void {
			sn = value;
		}
		/**
		 * 向TabBar动态添加一个tab
		 * 
		 * @param tabName 标签要显示的文本
		 * @param content 标签的显示内容
		 * @param icon 标签要显示的图标
		 * @param isAbleClose 是否显示关闭按钮以让用户关闭标签（不管显示此按钮与否，都可通过编程方式关闭标签）
		 */ 
		public function addTab(tabName:String,content:DisplayObject,icon:Object=null,isAbleClose:Boolean=false):void{
			var tab:Tab ;
			tab = new Tab();
			tab.index = tabs.length;
			tab.label = tabName;
			tab.btn.addEventListener(MouseEvent.CLICK, switchToTabClick);
			tabs[tabs.length] = tab;
			if(isAbleClose == false){
				tab.setSize(tabName.length*12+30,tabHeight);
			}else{
				tab.setSize(tabName.length*12+30+15,tabHeight);
			}
			if(icon != null) tab.icon = icon;
			if(isAbleClose == true){
				tab.showCloseButton();
			}
			if(SkinManager.isUseDefaultSkin == true){
				this.addChildAt(tab,0);
			}else{
				this.addChild(tab);
			}
			_contents[tabs.length-1] = content;
			if(content.parent != null) content.parent.removeChild(content);
			if(tabs.length ==1 ){
				viewContentByIndex(0);
			}
			alignTabs();
		}
		/**
		 * 关闭一个标签
		 */ 
		public function closeTab(tabIndex:uint):DisplayObject{
			if(tabIndex > tabs.length-1) return null;
			var tab:Tab = tabs[tabIndex] as Tab;
			this.removeChild(tab);
			var la:String = tab.label;
			tabs.splice(tabIndex,1);
			var arr:Array =  _contents.splice(tabIndex,1);
			if(tabs.length>0){
				alignTabs();
			}else{
				box.removeChild(box.getChildAt(0));
			}
			for(var i:int=0;i<tabs.length;i++){
				tab = Tab(tabs[i]);
				tab.index = i;
			}
			if(tabs.length>0 && tabIndex == index){
				this.mouseChildren = false;
				this.addEventListener(Event.ENTER_FRAME,nextFrameDo);
			}
			if(tabIndex<index) index -= 1;
			this.dispatchEvent(new TabCloseEvent(TabCloseEvent.TAB_CLOSE,tabIndex,la));
			return arr[0] as DisplayObject;
		}
		
		protected function nextFrameDo(event:Event):void
		{
			switchTab(0);
			this.removeEventListener(Event.ENTER_FRAME,nextFrameDo);
			setTimeout(ableClick,500);
		}
		private function ableClick():void{
			this.mouseChildren = true;
		}
		public function alphaMotionOff():void {
			hn = 1;
			sn = 1;
		}
		public function alphaMotionOn():void {
			hn = 0.07;
			sn = 0.12
		}
		override public function setDefaultSkin():void {
			setSkin(TabBarSkin);
		}
		override public function setSourceSkin():void {
			setSkin(SkinLoader.getClassFromSkinFile(SourceSkinLinkDefine.TAB_BACKGROUND));
		}
		override public function setSkin(Skin:Class):void {
			if(SkinManager.isUseDefaultSkin == true){
				skin = new Skin();
				ActionDrawSkin(skin).init(this,styleSet);
			}else{
				var sous:TabSourceSkin = new TabSourceSkin();
				sous.init(this,styleSet,Skin);
				skin = sous;
			}
		}
		override public function setSize(newWidth:Number, newHeight:Number):void {
			super.setSize(newWidth, newHeight);
			if(isAutoClip == true && nowContent!= null){
				box.scrollRect = new Rectangle(0,0,_compoWidth-_padding,_compoHeight-_paddingTop-10);
			}
			if(tabs.length>0){
				alignTabs();
			}
		}
		protected function viewContentByIndex(index:uint):void {
			if (nowContent != null && nowContent.parent == box) {
				box.removeChild(nowContent);
			}
			box.addChild(DisplayObject(_contents[index]));
			if (isAutoResetXY == true) {
				DisplayObject(_contents[index]).x = _padding;
				DisplayObject(_contents[index]).y = 0;
			}
			nowContent = DisplayObject(_contents[index]);
			if(isAutoClip == true){
				box.scrollRect = new Rectangle(0,0,_compoWidth-_padding,_compoHeight-_paddingTop-10);
			}
			Tab(tabs[index]).setSelectOn();
			Tab(tabs[index]).y -= selectUp;
		}
		protected function alignTabs():void {
			var i:int;
			var allWidth:Number = 0;
			var sx:int = 0;
			for ( i= 0; i < tabs.length; i++) {
				allWidth += Tab(tabs[i]).compoWidth+tabSpace;
			}
			if(align == "center"){
				sx = int((_compoWidth - allWidth) / 2);
			}
			if(align == "left"){
				sx = styleSet["padding"];
			}
			if(align == "right"){
				sx = int(_compoWidth - allWidth-styleSet["padding"]);
			}
			Tab(tabs[0]).x = sx;
			for ( i= 1; i < tabs.length; i++) {
				Tab(tabs[i]).x = Tab(tabs[i-1]).x+Tab(tabs[i-1]).compoWidth+TabBar.tabSpace;
			}
		}
		protected function switchToTabClick(event:MouseEvent):void {
			if(Tab(event.currentTarget.parent).isAble == false) return;
			switchTab(uint(Tab(event.currentTarget.parent).index));
		}
		
		protected function switchTab(newIndex:uint):void {
			if(Tab(tabs[index]) != null){
				Tab(tabs[index]).setSelectOff();
				Tab(tabs[index]).y = 0;
			}
			index = newIndex;
			switchFun = switchTabMain;
			alphaSwitch();
			this.mouseChildren = false;
			setTimeout(ableClick,500);
		}
		protected function switchTabMain():void {
			viewContentByIndex(index);
		}
		protected function alphaSwitch():void {
			isHide = true;
			this.addEventListener(Event.ENTER_FRAME, alphaShow);
		}
		protected function alphaShow(event:Event):void {
			if(isHide == true){
				box.alpha -= hn;
				if (box.alpha <= 0) {
					isHide = false;
					switchFun();
					alphaShow(event);
				}
			}else {
				box.alpha += sn;
				if (box.alpha >= 1) {
					this.removeEventListener(Event.ENTER_FRAME, alphaShow);
				}
			}
		}
	}

}