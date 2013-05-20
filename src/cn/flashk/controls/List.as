package cn.flashk.controls
{
	import cn.flashk.controls.interfaces.IListItemRender;
	import cn.flashk.controls.managers.SkinLoader;
	import cn.flashk.controls.managers.SkinManager;
	import cn.flashk.controls.managers.SourceSkinLinkDefine;
	import cn.flashk.controls.proxy.DataProvider;
	import cn.flashk.controls.skin.ActionDrawSkin;
	import cn.flashk.controls.skin.ListSkin;
	import cn.flashk.controls.skin.SkinThemeColor;
	import cn.flashk.controls.skin.sourceSkin.ListSourceSkin;
	import cn.flashk.controls.support.ItemsSelectControl;
	import cn.flashk.controls.support.ListItemRender;
	import cn.flashk.controls.support.UIComponent;
	import cn.flashk.conversion.ColorConversion;
	
	import flash.display.DisplayObject;
	import flash.display.InteractiveObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.ui.Keyboard;
	
	
	//events
	/**
	 * 当List的selectIndex值改变时触发
	 * @eventType flash.events.Event.CHANGE
	 **/
	[Event(name="change",type="flash.events.Event")]
	
	/**
	 * List 组件将显示基于列表的信息，并且是适合显示信息数组的理想选择。默认显示一列文字、图标（如果有）。
	 *  
	 * @langversion ActionScript 3.0
	 * @playerversion Flash 9.0
	 * 
	 * @see cn.flashk.controls.support.UIComponent
	 * 
	 * @author flashk
	 */

	public class List extends UIComponent
	{
		/**
		 * 默认单个渲染器的高度，此属性仅提供给设置ComboBox.rowCount属性时使用
		 */ 
		public static var defaultItemHeight:Number=23;
		/**
		 * 获取或设置显示文本的字段名称，显示为 TextInput 字段和下拉列表的标签。
		 */ 
		public var labelField:String = "label";
		/**
		 * 获取或设置用于提供项的图标的项字段。
		 */ 
		public var iconField:String = "icon";
		protected var items:Sprite;
		protected var scrollBar:VScrollBar;
		protected var _itemRender:Class;
		protected var _allowMultipleSelection:Boolean = false;
		protected var _selectedIndex:uint;
		protected var isFouceInMe:Boolean = false;
		protected var _dataProvider:Object;
		protected var scrollBarLastVisible:Boolean = false;
		protected var isDpAdd:Boolean = false;
		
		private var boxSelectControler:ItemsSelectControl;
		
		public function List()
		{
			super();
			_compoWidth = 300;
			_compoHeight = 300;
			_dataProvider = new DataProvider();
			
			styleSet["ellipse"] = 0;
			styleSet["borderColor"] = ColorConversion.transUintToWeb(SkinThemeColor.border);
			styleSet["borderAlpha"] = 0.5;
			styleSet["backgroundColor"] = "#FDFDFD";
			styleSet["backgroundAlpha"] = 1.0;
			styleSet["textPadding"] = 5;
			styleSet["iconPadding"] = 5;
			items = new Sprite();
			items.y= 1;
			this.addChild(items);
			scrollBar = new VScrollBar();
			scrollBar.setTarget(items,false,_compoWidth,_compoHeight-2);
			scrollBar.smoothNum = 1;
			scrollBar.updateSize(100);
			scrollBar.smoothScroll = false;
			scrollBar.mousemouseWheelDelta = 1;
			scrollBar.visible = false;
			this.addChild(scrollBar);
			_itemRender = ListItemRender;
			setSize(_compoWidth, _compoHeight);
			boxSelectControler = new ItemsSelectControl();
			boxSelectControler.initViewPanel(this,items);
			
			this.addEventListener(MouseEvent.CLICK,checkSelectNone);
			this.addEventListener(Event.ADDED_TO_STAGE,addKeyLis);
			this.addEventListener(Event.REMOVED_FROM_STAGE,clearLis);
		}
		/**
		 * 设置List的数据源，对于List、DataGrid, TileList它应该是个DataProvider对象（可以直接将二维数组转为DataProvider，请参见DataProvider构造函数）,对于 Tree 它应该是个XML
		 * 
		 * @see cn.flashk.controls.proxy.DataProvider
		 */ 
		public function set dataProvider(value:Object):void{
			
			_dataProvider = value;
			removeAll();
			isDpAdd = true;
			for(var i:int=0;i<_dataProvider.length;i++){
				addItem(_dataProvider.getItemAt(i));
			}
			isDpAdd = false;
		}
		public function get dataProvider():Object{
			return _dataProvider;
		}
		public function get selectedIndices():Array{
			var arr:Array = [];
			var render:DisplayObject;
			for(var i:int = 0;i<items.numChildren;i++){
				render = items.getChildAt(i);
				if(IListItemRender(render).selected == true){
					arr.push(i);
				}
			}
			return arr;
		}
		/**
		 * 获取或设置一个数组，其中包含从多选列表中选定的项目。
		 */ 
		public function set selectedIndices(value:Array):void{
			var render:DisplayObject;
			for(var i:int = 0;i<items.numChildren;i++){
				render = items.getChildAt(i);
				IListItemRender(render).selected = false;
			}
			for(var j:int=0;j<value.length;j++){
				render = items.getChildAt(value[j]);
				IListItemRender(render).selected = true;
			}
		}
		/**
		 * 获取包含多选列表中的已选定项目数据的数组。
		 */ 
		public function get selectedItems():Array{
			var arr:Array = [];
			var render:DisplayObject;
			for(var i:int = 0;i<items.numChildren;i++){
				render = items.getChildAt(i);
				if(IListItemRender(render).selected == true){
					arr.push(IListItemRender(render).data);
				}
			}
			return arr;
		}
		/**
		 * 获得索引位置的列表渲染器的实例，你可以对获得的实例访问其公开方法，比如设置图标
		 * 
		 * @see cn.flashk.controls.support.ListItemRender
		 * @see cn.flashk.controls.support.TreeItemRender
		 * @see cn.flashk.controls.support.TileListThumbnail
		 */ 
		public function getItemRenderAt(index:uint):IListItemRender{
			var render:IListItemRender;
			render = items.getChildAt(index) as IListItemRender;
			return render;
		}
		protected function clearLis(event:Event):void
		{
			this.stage.removeEventListener(KeyboardEvent.KEY_UP,checkSelectAll);
			this.stage.removeEventListener(MouseEvent.MOUSE_DOWN,checkFocus);
			isFouceInMe = false;
		}
		protected function addKeyLis(event:Event):void{
			this.stage.addEventListener(KeyboardEvent.KEY_UP,checkSelectAll);
			this.stage.addEventListener(MouseEvent.MOUSE_DOWN,checkFocus);
		}
		private function checkFocus(event:MouseEvent):void{
			if(this.mouseX < -5 || this.mouseY<-5 || this.mouseX>_compoWidth || this.mouseY>_compoHeight){
				isFouceInMe = false;
			}
		}
		protected function checkSelectNone(event:MouseEvent):void
		{
			isFouceInMe = true;
			if(event.target == this) boxSelectControler.selectNone();
			
		}
		protected function checkSelectAll(event:KeyboardEvent):void{
			if(isFouceInMe == false) return;
			if(event.ctrlKey == true){
				if(event.keyCode == 65){
					boxSelectControler.selectAll();
				}
				if(event.keyCode == 68){
					boxSelectControler.selectNone();
				}
			}
		}
		override public function setDefaultSkin():void {
			setSkin(ListSkin)
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
		public function get selectedIndex():uint{
			return _selectedIndex;
		}
		/**
		 * 获取或设置单选列表中的选定项目的索引。
		 */ 
		public function set selectedIndex(value:uint):void{
			_selectedIndex = value;
			if(value < items.numChildren){
				itemClick({currentTarget:items.getChildAt(value)});
			}
		}
		/**
		 * 获取或设置从单选列表中选择的项目。
		 */ 
		public function get selectedItem():Object{
			return IListItemRender(items.getChildAt(_selectedIndex)).data;
		}
		public function set selectedItem(value:Object):void{
			for(var i:int = 0;i<items.numChildren;i++){
				if(IListItemRender(items.getChildAt(i)).data == value){
					itemClick({currentTarget:items.getChildAt(i)});
				}
			}
		}
		/**
		 * 指定List要使用哪个类作为单元格渲染器，默认为ListItemRender，你可以使用自己的单元格渲染器以实现更多的功能，如果需要自定义渲染，请在向List添加数据（addItem或设置dataProvider）前设置。
		 * 
		 * <p>自定义的渲染器类必须实现IListItemRender接口，以便接受/访问data，并提供渲染器的高度，详细请参阅IListItemRender。</p>
		 * 
		 * @see cn.flashk.controls.support.ListItemRender
		 * @see cn.flashk.controls.interfaces.IListItemRender
		 */ 
		public function set itemRender(value:Class):void{
			_itemRender = value;
		}
		public function get itemRender():Class{
			return _itemRender;
		}
		/**
		 * 获得对List组件的竖向滚动条实例的引用
		 */ 
		public function get scrollBarRef():VScrollBar{
			return scrollBar;
		}
		public function get allowMultipleSelection():Boolean{
			return _allowMultipleSelection;
		}
		/**
		 * 是否允许用户对List进行多选，当允许多选时用户可以使用按下Ctrl键连续选择多个项，也可以使用按下鼠标+移动鼠标进行框选，同时也支持快捷键的选择：Ctrl + A 全选，Ctrl + D 全部取消选择
		 */ 
		public function set allowMultipleSelection(value:Boolean):void{
			_allowMultipleSelection = value;
		}
		/**
		 * 获取数据提供者中的项目数（List的总长度）。
		 */ 
		public function get length():uint{
			return uint(items.numChildren);
		}
		/**
		 * <p>向项目列表的末尾追加项目。 </p>
		 * 使用默认渲染器的情况下，项目应包含 label 和 data 属性，但包含其它属性的项目也可以添加到列表。 项目的 label 属性用于显示行的标签；data 属性用于存储行的数据。 
		 * 
		 * @param item 要添加到数据提供者的项目。 
		 */ 
		public function addItem(item:Object):void{
			addItemAt(item,items.numChildren);
		}
		/**
		 * 在指定索引位置处将项目插入列表。 位于指定索引位置处或之后的项目的索引将增加 1。
		 * @param item 要添加到列表的项目。
		 * @param index 要添加项目处的索引。
		 * 
		 * @see #addItem()
		 */ 
		public function addItemAt(item:Object,index:uint):void{
			var render:DisplayObject = new _itemRender() as DisplayObject;
			if(isDpAdd == false){
				_dataProvider.addItemAt(item,index);
			}
			IListItemRender(render).list = this;
			IListItemRender(render).data = item;
			var itemWidth:Number = _compoWidth;
			if(scrollBar.visible == true){
				itemWidth =scrollBar.x;
			}
			IListItemRender(render).setSize(itemWidth,0);
			InteractiveObject(render).addEventListener(MouseEvent.CLICK,itemClick);
			if(items.numChildren == 0 || index == 0){
				DisplayObject(render).y = 0;
			}else{
				DisplayObject(render).y = items.getChildAt(index-1).y + IListItemRender(items.getChildAt(index-1)).itemHeight;
			}
			items.addChildAt(render,index);
			for(var i:int=index+1;i<items.numChildren;i++){
				items.getChildAt(i).y += IListItemRender(render).itemHeight;
			}
			if(IListItemRender(render).itemHeight*items.numChildren > _compoHeight){
				scrollBar.setTarget(items,false,_compoWidth-17,_compoHeight-items.y-1);
				scrollBar.visible = true;
			}else{
				scrollBar.setTarget(items,false,_compoWidth,_compoHeight-items.y-1);
				scrollBar.visible = false;
			}
			scrollBar.snapNum = IListItemRender(render).itemHeight;
			scrollBar.arrowClickStep = scrollBar.snapNum;
			scrollBar.updateSize(IListItemRender(render).itemHeight*items.numChildren);
			if(index == _selectedIndex){
				this.dispatchEvent(new Event("getSelectIndexData"));
			}
			if(scrollBar.visible != scrollBarLastVisible){
				updateSkin();
			}
			scrollBarLastVisible = scrollBar.visible;
		}
		/**
		 * 用其它项目替换指定索引位置处的项目。 此方法会修改 List 组件的数据提供者。 如果与其它组件共享数据提供者，则向这些组件提供的数据也会更新。 
		 * 
		 * @param item 要替换指定索引位置处的项目的项目。
		 * @param index 要替换的项目的索引位置。 
		 * @return 被替换的项目。
		 */ 
		public function replaceItemAt(item:Object, index:uint):Object{
			addItemAt(item,index);
			return removeItemAt(index+1);
		}
		/**
		 * 删除指定索引位置处的项目。 位于指定索引位置之后的项目的索引将减少 1。 
		 * 
		 * @param index 数据提供者中要删除的项目的索引。
		 * @return 被删除的项目。 
		 */ 	
		public function removeItemAt(index:uint):Object{
			var render:DisplayObject;
			render = items.getChildAt(index);
			for(var i:int=index+1;i<items.numChildren;i++){
				items.getChildAt(i).y -= IListItemRender(render).itemHeight;
			}
			items.removeChild(render);
			if(isDpAdd == false){
				_dataProvider.removeItemAt(index);
			}
			return IListItemRender(render).data;
		}
		/**
		 * 删除列表中的所有项目。 
		 */ 
		public function removeAll():void{
			for(var i:int=items.numChildren-1;i>=0;i--){
				items.removeChildAt(i);
			}
		}
		/**
		 * 检索指定索引处的项目。 
		 * 
		 * @param index 要检索的项目的索引。
		 * @return 位于指定索引位置处的对象。
		 */ 
		public function getItemAt(index:uint):Object{
			return IListItemRender(items.getChildAt(index)).data;
		}
		/**
		 * 将列表滚动至位于指定索引处的项目。 如果索引超出范围，则滚动到最底部（大于总数）或者最顶部（负数）。 
		 */ 
		public function scrollToIndex(newCaretIndex:int):void{
			scrollBar.scrollToPosition(newCaretIndex*IListItemRender(items.getChildAt(0)).itemHeight);
		}
			
		override public function updateSkin():void {
			super.updateSkin();
			var render:DisplayObject;
			var itemWidth:Number = _compoWidth;
			if(scrollBar.visible == true){
				itemWidth =scrollBar.x;
			}
			for(var i:int = 0;i<items.numChildren;i++){
				render = items.getChildAt(i);
				IListItemRender(render).setSize(itemWidth,0);
			}
		}
		override public function setSize(newWidth:Number, newHeight:Number):void {
			super.setSize(newWidth, newHeight);
			scrollBar.setTarget(items,false,_compoWidth,_compoHeight-2);
			scrollBar.y = 1;
			scrollBar.x = int(_compoWidth - VScrollBar.defaultWidth);
			scrollBar.setSize(VScrollBar.defaultWidth,_compoHeight-2);
			if(items.numChildren >0){
				var render:DisplayObject = items.getChildAt(0);
				scrollBar.updateSize(IListItemRender(render).itemHeight*items.numChildren);
			}
			
			var itemWidth:Number = _compoWidth;
			if(scrollBar.visible == true){
				itemWidth =scrollBar.x;
			}
			for(var i:int=0;i<items.numChildren;i++){
				IListItemRender(items.getChildAt(i)).setSize(itemWidth,0);
			}
		}
		protected function itemClick(event:Object):void{
			var render:DisplayObject;
			if(_allowMultipleSelection == false || UIComponent.isCtrlKeyDown == false){
				for(var i:int = 0;i<items.numChildren;i++){
					render = items.getChildAt(i);
					IListItemRender(render).selected = false;
				}
			}
			IListItemRender(event.currentTarget).selected = !IListItemRender(event.currentTarget).selected;
			_selectedIndex = items.getChildIndex(event.currentTarget as DisplayObject);
			this.dispatchEvent(new Event(Event.CHANGE));
		}
	}
}