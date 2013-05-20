package cn.flashk.controls
{
	import cn.flashk.controls.interfaces.IListItemRender;
	import cn.flashk.controls.support.DataGridItemRender;
	import cn.flashk.controls.support.SWFDefinition;
	import cn.flashk.controls.support.TreeItemRender;
	
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.InteractiveObject;
	import flash.events.MouseEvent;

	/**
	 * Tree 组件使用户可以查看排列为可扩展树的层次结构数据。树中的每个项目都可以是叶或分支。叶项目是树中的端点。分支项目可以包含叶或分支项目，也可以为空。 
	 *  
	 * @langversion ActionScript 3.0
	 * @playerversion Flash 9.0
	 * 
	 * @see cn.flashk.controls.support.UIComponent
	 * 
	 * @author flashk
	 */
	public class Tree extends List
	{
		
		/**
		 * 设置根项目的可见性。如果 dataProvider 数据包含根节点，并且根节点的设置为 false，则 Tree 控件不会显示根项目。仅显示根项目的后代。
		 */ 
		public var isShowRoot:Boolean = false;
		/**
		 * 自定义图标的获取函数，如果在XML中定义了自定义节点图标，渲染器会向这个函数发送图标名称，函数应该返回根据这个名称创建或引用的BitmapData实例，默认的函数是cn.flashk.controls.support.SWFDefinition.getDefinitionBitmapDataByName。如果图标需要从其它地方获得，可以定义自己的获取函数
		 * 
		 * @see cn.flashk.controls.support.SWFDefinition
		 */ 
		public var iconGetFunction:Function = SWFDefinition.getDefinitionBitmapDataByName;
		private var _floderIcon:BitmapData;
		private var _nodeIcon:BitmapData;
		private var _closedIcon:BitmapData;
		private var _openedIcon:BitmapData;
		private var xmlAll:XML;
		private var xml:XML;
		
		public function Tree()
		{
			super();
			
			_compoWidth = 300;
			_compoHeight = 23*8;
			
			labelField = "@label";
			iconField = "@icon";
			
			_itemRender = TreeItemRender;
			_allowMultipleSelection = true;
			styleSet["padding"] = 10;
			styleSet["textPadding"] = 20;
			setSize(_compoWidth, _compoHeight);
			scrollBar.setTarget(items,false,_compoWidth,_compoHeight-2);
		}
		/**
		 * 设置Tree的数据源， 它应该是个XML
		 */ 
		override public function set dataProvider(value:Object):void{
			if(value is XML){
				
			}else{
				return;
			}
			_dataProvider = value;
			removeAll();
			xmlAll = _dataProvider as XML;
			initListByXML();
		}
		/**
		 * 设置树中文件夹（含有有子项节点）的图标
		 */ 
		public function set floderIcon(bd:BitmapData):void{
			_floderIcon = bd;
		}
		public function get floderIcon():BitmapData{
			return _floderIcon;
		}
		/**
		 * 设置树中没有子项节点的图标
		 */ 
		public function set nodeIcon(bd:BitmapData):void{
			_nodeIcon = bd;
		}
		public function get nodeIcon():BitmapData{
			return _nodeIcon;
		}
		/**
		 * 设置树中没有展开的图标前面的小箭头
		 */ 
		public function set closedIcon(bd:BitmapData):void{
			_closedIcon = bd;
		}
		public function get closedIcon():BitmapData{
			return _closedIcon;
		}
		/**
		 * 设置树中已经展开的图标前面的小箭头
		 */ 
		public function set openedIcon(bd:BitmapData):void{
			_openedIcon = bd;
		}
		public function get openedIcon():BitmapData{
			return _openedIcon;
		}
		/**
		 * 打开指定的节点
		 */ 
		public function openItem(item:Object,animate:Boolean = false):void{
			for(var i:int=0;i<items.numChildren;i++){
				TreeItemRender(items.getChildAt(i)).checkOpenNode(item);
			}
		}
		/**
		 * 关闭指定的节点
		 */ 
		public function closeItem(item:Object,animate:Boolean = false):void{
			
			for(var i:int=0;i<items.numChildren;i++){
				TreeItemRender(items.getChildAt(i)).checkCloseNode(item);
			}
		}
		/**
		 * 打开或关闭指定的节点下所有的节点，如果不传递参数，则打开关闭整个树
		 */ 
		public function expandChildrenOf(item:Object=null, isOpen:Boolean=true):void{
			for(var i:int=0;i<items.numChildren;i++){
				TreeItemRender(items.getChildAt(i)).expandChildrenOf(item,isOpen);
			}
			if(item== null){
				selectedIndex = 0;
			}
		}
		/**
		 * 如果指定的项目分支处于打开状态（显示其子项），则返回 true。
		 */ 
		public function isItemOpen(item:Object):Boolean{
			return true;
		}
		private function initListByXML():void{
			if(isShowRoot == false){
				xml = xmlAll[0];
			}else{
				xml = xmlAll;
			}
			var item:IListItemRender;
			var itemWidth:Number = _compoWidth;
			if(scrollBar.visible == true){
				itemWidth =scrollBar.x;
			}
			for(var i:int=0;i<xml.children().length();i++){
				item = new TreeItemRender();
				item.list = this;
				item.data = xml.children()[i];
				item.setSize(itemWidth,0);
				items.addChild(item as DisplayObject);
				InteractiveObject(item).addEventListener(MouseEvent.CLICK,itemClick);
			}
			alignItems(items);
		}
		public function addItemRenderAt(render:IListItemRender,index:uint):void{
			
			items.addChildAt(render as DisplayObject,index);
			alignItems(items);
			InteractiveObject(render).addEventListener(MouseEvent.CLICK,itemClick);
		}
		public function removeItemRenderAt(render:IListItemRender):void{
			
			items.removeChild(render as DisplayObject);
			alignItems(items);
		}
		public function alignItems(itemsContainer:DisplayObjectContainer=null):void{
			if(itemsContainer == null) itemsContainer = items;
			itemsContainer.getChildAt(0).y = 0;
			var item:IListItemRender;
			var followItem:IListItemRender;
			for(var i:int=1;i<itemsContainer.numChildren;i++){
				item = itemsContainer.getChildAt(i) as IListItemRender;
				followItem = itemsContainer.getChildAt(i-1) as IListItemRender;
				DisplayObject(item).y = DisplayObject(followItem).y + followItem.itemHeight;
			}
			var maxHe:Number = DisplayObject(item).y  + item.itemHeight;
			if(maxHe > _compoHeight){
				scrollBar.setTarget(items,false,_compoWidth-17,_compoHeight-items.y-1);
				scrollBar.visible = true;
			}else{
				scrollBar.setTarget(items,false,_compoWidth,_compoHeight-items.y-1);
				scrollBar.visible = false;
			}
			scrollBar.updateSize(maxHe,true);
			scrollBar.updateScrollBarPostion();
			scrollBar.snapNum = IListItemRender(item).itemHeight;
			scrollBar.arrowClickStep = scrollBar.snapNum;
			
			
			if(scrollBar.visible != scrollBarLastVisible || 2>1){
				updateSkin();
			}
			scrollBarLastVisible = scrollBar.visible;
		}
	}
}