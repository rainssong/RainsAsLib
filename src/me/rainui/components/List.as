/**
 * Rain UI
 */
package me.rainui.components
{
	import com.greensock.motionPaths.Direction;
	import flash.display.DisplayObject;
	import flash.display.Graphics;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	import me.rainui.data.ListCollection;
	import me.rainui.events.CollectionEvent;
	import me.rainui.events.RainUIEvent;
	import me.rainui.managers.RadioGroup;
	import me.rainui.RainUI;
	
	/**选择单元格改变后触发*/
	[Event(name="select",type="me.rainui.events.RainUIEvent")]
	/**单元格渲染时触发*/
	[Event(name="change",type="me.rainui.events.RainUIEvent")]
	
	/**列表*/
	public class List extends ScrollContainer
	{
		public static var defaultStyleFactory:Function;
		//protected var _content:Box;
		//protected var _scrollContainer:ScrollContainer;
		protected var _itemRender:*;
		protected var _repeatX:int = 1;
		protected var _repeatY:int = 1;
		protected var _spaceX:int;
		protected var _spaceY:int;
		protected var _cells:Vector.<ListItem> = new Vector.<ListItem>();
		protected var _items:ListCollection
		//protected var _selectHandler:Handler;
		//protected var _renderHandler:Handler;
		//protected var _mouseHandler:Handler;
		protected var _selectEnable:Boolean = true;
		protected var _isVerticalLayout:Boolean = true;
		protected var _cellSize:Number = 60;
		
		protected var _btnGroup:RadioGroup 
		
		protected var _labelField:String = "";
		
		protected var _rendersFlag:Boolean = true;
		
		public function List(items:* = null, dataSource:Object = null)
		{
			super(null,dataSource);
			this.items = items;
		}
		
		override protected function createChildren():void
		{
			if (_itemRender == null)
				_itemRender = ListItem;
				
			_btnGroup = new RadioGroup();
			_btnGroup.addEventListener(RainUIEvent.SELECT, onSelect);
			_btnGroup.addEventListener(RainUIEvent.CHANGE, onChange);
			super.createChildren();
		}
		
		private function onSelect(e:RainUIEvent):void 
		{
			dispatchEvent(e.clone());
		}
		
		private function onChange(e:RainUIEvent):void 
		{
			dispatchEvent(e.clone());
		}
	
		
		public function select(index:int):void
		{
			
		}
		
		public function get items():ListCollection
		{
			return _items;
		}
		
		public function set items(value:*):void
		{
			if(this._items)
			{
				//this._dataProvider.removeEventListener(CollectionEvent.ADD_ITEM, onAddItem);
				//this._dataProvider.removeEventListener(CollectionEvent.REMOVE_ITEM, onRemoveItem);
				//this._dataProvider.removeEventListener(CollectionEvent.REPLACE_ITEM, onReplaceItem);
				//this._dataProvider.removeEventListener(CollectionEvent.RESET, onResetItem);
				this._items.removeEventListener(Event.CHANGE, onChange);
			}
			
			if (value is Array)
				_items = new ListCollection(value);
			else if ( value is ListCollection)
				_items = value;
			else 
				return;
				
				
				
			index =-1;
			_rendersFlag = true;
			
			
			if(this._items!=null)
			{
				//this._dataProvider.addEventListener(CollectionEvent.ADD_ITEM, dataProvider_addItemHandler);
				//this._dataProvider.addEventListener(CollectionEvent.REMOVE_ITEM, dataProvider_removeItemHandler);
				//this._dataProvider.addEventListener(CollectionEvent.REPLACE_ITEM, dataProvider_replaceItemHandler);
				//this._dataProvider.addEventListener(CollectionEvent.RESET, dataProvider_resetHandler);
				this._items.addEventListener(Event.CHANGE, onItemsChange);
			}
			
			if(_items != null)
				callLater(redraw);
		}
		
		private function onItemsChange(e:RainUIEvent):void 
		{
			_rendersFlag = true;
			callLater(redraw);
		}
		
		override protected function initialize():void 
		{
			super.initialize();
			this.direction = ScrollContainer.VERTICAL;
		}
		
		/**单元格渲染器，可以设置为XML或类或函数*/
		public function get itemRender():*
		{
			return _itemRender;
		}
		
		public function set itemRender(value:*):void
		{
			_itemRender = value;
			_rendersFlag = true;
			callLater(redraw);
		}
		
		public function getItemView():ListItem
		{
			if (_itemRender is Class)
				return new _itemRender();
			if (_itemRender is Function)
				return _itemRender();
			else
				return null;
		}
		
		/**X方向单元格数量*/
		public function get repeatX():int
		{
			return _repeatX;
		}
		
		public function set repeatX(value:int):void
		{
			_repeatX = value;
			callLater(redraw);
		}
		
		/**Y方向单元格数量*/
		public function get repeatY():int
		{
			return _repeatY;
		}
		
		public function set repeatY(value:int):void
		{
			_repeatY = value;
			callLater(redraw);
		}
		
		/**X方向单元格间隔*/
		public function get spaceX():int
		{
			return _spaceX;
		}
		
		public function set spaceX(value:int):void
		{
			_spaceX = value;
			callLater(redraw);
		}
		
		/**Y方向单元格间隔*/
		public function get spaceY():int
		{
			return _spaceY;
		}
		
		public function set spaceY(value:int):void
		{
			_spaceY = value;
			callLater(redraw);
		}
		
		override public function redraw():void
		{
			if (_itemRender && _rendersFlag)
			{
				_rendersFlag = false;
				//销毁老单元格
				for each (var cell:ListItem in _cells)
				{
					removeCell(cell);
				}
				_cells.length = 0;
				
				
				if (_items != null) 
					for (var i:int = 0; i < _items.length; i++)
					{
						var c:ListItem = getItemView();
						if (_labelField.length>0)
							c.text = String(_items.getItemAt(i)[_labelField]);
						else
							//可能会将没必要的东西显示出来
							c.text = String(_items.getItemAt(i));
						c.dataSource=_items.getItemAt(i);
						addContent(c);
						c.y = _cellSize * i;
						c.height = _cellSize;
						c.percentWidth = 1;
						cells.push(c);
						addCell(c);
						_btnGroup.addButton(c);
					}
			}
			super.redraw();
		}
		
		public function removeCell(cell:ListItem):void 
		{
			cell.removeEventListener(MouseEvent.CLICK, onCellMouse);
			cell.removeEventListener(MouseEvent.ROLL_OVER, onCellMouse);
			cell.removeEventListener(MouseEvent.ROLL_OUT, onCellMouse);
			cell.removeEventListener(MouseEvent.MOUSE_DOWN, onCellMouse);
			cell.removeEventListener(MouseEvent.MOUSE_UP, onCellMouse);
			_btnGroup.removeButton(cell);
			cell.remove();
		}
		
		protected function addCell(cell:ListItem):void
		{
			cell.addEventListener(MouseEvent.CLICK, onCellMouse);
			cell.addEventListener(MouseEvent.ROLL_OVER, onCellMouse);
			cell.addEventListener(MouseEvent.ROLL_OUT, onCellMouse);
			cell.addEventListener(MouseEvent.MOUSE_DOWN, onCellMouse);
			cell.addEventListener(MouseEvent.MOUSE_UP, onCellMouse);
			_cells.push(cell);
		}
		
		//public function initItems():void
		//{
			//if (!_itemRender)
			//{
				//for (var i:int = 0; i < int.MAX_VALUE; i++)
				//{
					//var cell:Box = getChildByName("item" + i) as Box;
					//if (cell)
					//{
						//addCell(cell);
						//continue;
					//}
					//break;
				//}
			//}
		//}
		
		///**设置可视区域大小*/
		//public function setContentSize(width:Number, height:Number):void
		//{
			//var g:Graphics = _content.graphics;
			//g.clear();
			//g.beginFill(0xffff00, 0);
			//g.drawRect(0, 0, width, height);
			//g.endFill();
			//_content.width = width;
			//_content.height = height;
			//_content.scrollRect = new Rectangle(0, 0, width, height);
		//}
		
		protected function onCellMouse(e:MouseEvent):void
		{
			//if (e.type == MouseEvent.CLICK || e.type == MouseEvent.ROLL_OVER || e.type == MouseEvent.ROLL_OUT)
			//{
				//var cell:ListItem = e.currentTarget as ListItem;
				////var index:int = _startIndex + _cells.indexOf(cell);
				//if (e.type == MouseEvent.CLICK)
				//{
					//if (_selectEnable)
					//{
						////selectedIndex = index;
					//}
					//else
					//{
						////redrawtate(cell, true, 0);
					//}
				//}
				//else if (_index != index)
				//{
					////redrawtate(cell, e.type == MouseEvent.ROLL_OVER, 0);
				//}
			//}
			//if (_mouseHandler != null)
			//{
				//_mouseHandler.executeWith([e.type, index]);
			//}
		}
		
		//protected function redrawtate(cell:Box, visable:Boolean, frame:int):void
		//{
			//var selectBox:Clip = cell.getChildByName("selectBox") as Clip;
			//if (selectBox)
			//{
				//selectBox.visible = visable;
				//selectBox.frame = frame;
			//}
		//}
		
		override public function resize():void 
		{
			super.resize();
		}
		
		protected function onScrollBarChange(e:Event):void
		{
			var rect:Rectangle = content.scrollRect;
			//var scrollValue:Number = _scrollContainer.;
			//var index:int = int(scrollValue / _cellSize) * (_isVerticalLayout ? _repeatX : _repeatY);
			//if (index != _startIndex)
			//{
				//startIndex = index;
			//}
			//if (_isVerticalLayout)
			//{
				//rect.y = scrollValue % _cellSize;
			//}
			//else
			//{
				//rect.x = scrollValue % _cellSize;
			//}
			//_content.scrollRect = rect;
		}
		
		/**是否可以选中，默认为true*/
		public function get selectEnable():Boolean
		{
			return _selectEnable;
		}
		
		public function set selectEnable(value:Boolean):void
		{
			_selectEnable = value;
		}
		
		/**选择索引*/
		public function get index():int
		{
			return _btnGroup.index;
		}
		
		public function set index(value:int):void
		{
			if (index != value)
			{
				_btnGroup.index = value;
				sendEvent(RainUIEvent.SELECT, value);
			}
		}
		

		
		/**选中单元格数据源*/
		public function get selectedItem():Object
		{
			return index != -1 ? _items.getItemAt(index): null;
		}
		
		public function set selectedItem(value:Object):void
		{
			index = _items.getItemIndex(value);
		}
		
		/**选择单元格组件*/
		public function get selection():ListItem
		{
			return getCell(index);
		}
		
		public function set selection(value:ListItem):void
		{
			index = _cells.indexOf(value);
		}
		
		/**选择被改变时执行的处理器(默认返回参数index:int)*/
		//public function get selectHandler():Handler
		//{
			//return _selectHandler;
		//}
		//
		//public function set selectHandler(value:Handler):void
		//{
			//_selectHandler = value;
		//}
		
		/**单元格渲染处理器(默认返回参数cell:Box,index:int)*/
		//public function get renderHandler():Handler
		//{
			//return _renderHandler;
		//}
		//
		//public function set renderHandler(value:Handler):void
		//{
			//_renderHandler = value;
		//}
		
		/**单元格鼠标事件处理器(默认返回参数type:String,index:int)*/
		//public function get mouseHandler():Handler
		//{
			//return _mouseHandler;
		//}
		//
		//public function set mouseHandler(value:Handler):void
		//{
			//_mouseHandler = value;
		//}
		
		/**开始索引*/
		//public function get startIndex():int
		//{
			//return _startIndex;
		//}
		//
		//public function set startIndex(value:int):void
		//{
			//_startIndex = value > 0 ? value : 0;
			//callLater(renderItems);
		//}
		
		//protected function renderItems():void
		//{
			//for (var i:int = 0, n:int = _cells.length; i < n; i++)
			//{
				//renderItem(_cells[i], _startIndex + i);
			//}
			//changeSelectStatus();
		//}
		
		//protected function renderItem(cell:Box, index:int):void
		//{
			//if (index < _items.length)
			//{
				//cell.visible = true;
				//cell.dataSource = _items[index];
			//}
			//else
			//{
				//cell.visible = false;
			//}
			//if (_renderHandler != null)
			//{
				//_renderHandler.executeWith([cell, index]);
			//}
			//sendEvent(UIEvent.ITEM_RENDER, [cell, index]);
		//}
		
		//
		//public function set items(value:Array):void
		//{
		//exeCallLater(redraw);
		//_items = value || [];
		//var length:int = _items.length;
		//_totalPage = Math.ceil(length / (_repeatX * _repeatY));
		////重设selectedIndex
		//_index = _index < length ? _index : length - 1;
		////重设startIndex
		//startIndex = _startIndex;
		////重设滚动条
		//if (_scrollContainer)
		//{
		////自动隐藏滚动条
		//var lineNum:int = _isVerticalLayout ? _repeatY : _repeatX;
		//var lineCount:int = Math.ceil(length / (_isVerticalLayout ? _repeatX : _repeatY));
		//_scrollContainer.visible = _totalPage > 1;
		//if (_scrollContainer.visible)
		//{
		//_scrollContainer.scrollSize = _cellSize;
		//_scrollContainer.thumbPercent = lineNum / lineCount;
		//_scrollContainer.setScroll(0, (lineCount - lineNum) * _cellSize, _startIndex * _cellSize);
		//}
		//}
		//}
		//
		/**最大分页数*/
		//public function get totalPage():int
		//{
			//return _totalPage;
		//}
		//
		//public function set totalPage(value:int):void
		//{
			//_totalPage = value;
		//}
		//
		///**当前页码*/
		//public function get page():int
		//{
			//return _page;
		//}
		//
		//public function set page(value:int):void
		//{
			//_page = value > 0 ? value : 0;
			//_page = _page < _totalPage ? _page : _totalPage - 1;
			//startIndex = _page * _repeatX * _repeatY;
		//}
		
		/**列表数据总数*/
		public function get length():int
		{
			return _items.length;
		}
		
		//override public function set dataSource(value:Object):void
		//{
			//_dataSource = value;
			//if (value is Array)
			//{
				//items = value as Array;
			//}
			//else
			//{
				//super.dataSource = value;
			//}
		//}
		
		/**单元格集合*/
		public function get cells():Vector.<ListItem>
		{
			exeCallLater(redraw);
			return _cells;
		}
		
		public function get btnGroup():RadioGroup 
		{
			return _btnGroup;
		}
		
		public function get labelField():String 
		{
			return _labelField;
		}
		
		public function set labelField(value:String):void 
		{
			_labelField = value;
		}
		
		public function get cellSize():Number 
		{
			return _cellSize;
		}
		
		public function set cellSize(value:Number):void 
		{
			_cellSize = value;
		}
		
		//override public function commitMeasure():void
		//{
			//exeCallLater(redraw);
		//}
		
		/**刷新列表*/
		public function refresh():void
		{
			items = _items;
		}
		
		/**获取单元格数据源*/
		public function getItem(index:int):Object
		{
			if (index > -1 && index < _items.length)
			{
				return _items.getItemAt(index);
			}
			return null;
		}
		
		/**修改单元格数据源*/
		//public function changeItem(index:int, source:Object):void
		//{
			//if (index > -1 && index < _items.length)
			//{
				//_items[index] = source;
				////如果是可视范围，则重新渲染
				//if (index >= _startIndex && index < _startIndex + _cells.length)
				//{
					//renderItem(getCell(index), index);
				//}
			//}
		//}
		
		/**添加单元格数据源*/
		//public function addItem(souce:Object):void
		//{
			//_items.push(souce);
			//array = _items;
		//}
		//
		///**添加单元格数据源*/
		//public function addItemAt(souce:Object, index:int):void
		//{
			//_items.splice(index, 0, souce);
			//array = _items;
		//}
		
		/**删除单元格数据源*/
		//public function deleteItem(index:int):void
		//{
			//_items.splice(index, 1);
			//array = _items;
		//}
		
		/**获取单元格*/
		public function getCell(index:int):ListItem
		{
			//exeCallLater(redraw);
			//if (index > -1 && _cells)
			//{
				//return _cells[(index - _startIndex) % _cells.length];
			//}
			return null;
		}
		
		/**滚动到某个索引位置*/
		public function scrollTo(index:int):void
		{
			//startIndex = index;
			//if (_scrollContainer)
			//{
				//_scrollContainer.value = index * _cellSize;
			//}
		}
	}
}