// Copyright 2007. Adobe Systems Incorporated. All Rights Reserved.
package cn.flashk.controls.proxy
{
		import flash.events.EventDispatcher;
		import cn.flashk.controls.events.DataChangeEvent;
		import cn.flashk.controls.events.DataChangeType;
		import RangeError;
		
		
		/**
		 * 在更改数据之前调度。
		 *
		 * @see #event:dataChange dataChange event
		 *
		 * @eventType cn.flashk.controls.events.DataChangeEvent.PRE_DATA_CHANGE
		 *
		 * @langversion 3.0
		 * @playerversion Flash 9.0
		 */
		[Event(name="preDataChange", type="cn.flashk.controls.events.DataChangeEvent")]
		
		/**
		 * 在更改数据之后调度。
		 *
		 * @see #event:preDataChange preDataChange event
		 *
		 * @eventType cn.flashk.controls.events.DataChangeEvent.DATA_CHANGE
		 *
		 * @langversion 3.0
		 * @playerversion Flash 9.0
		 */
		[Event(name="dataChange", type="cn.flashk.controls.events.DataChangeEvent")]
		
		
		/**
		 * <p>DataProvider 类提供一些方法和属性，这些方法和属性允许您查询和修改任何基于列表的组件（例如，List、DataGrid、TileList 或 ComboBox 组件）中的数据。 </p>
		 * <p>数据提供者 是用作数据源的项目的线性集合，例如，一个数组。 数据提供者中的每个项目都是包含一个或多个数据字段的对象或 XML 对象。 </p>
		 * <p>通过使用 DataProvider.getItemAt() 方法，可以按索引访问数据提供者中包含的项目。</p>
		 *
		 * @includeExample examples/DataProviderExample.as
		 *
		 * @langversion 3.0
		 * @playerversion Flash 9.0 
		 *  
		 */
		public class DataProvider extends EventDispatcher {
			/**
			 * @private (protected)
			 *
			 * @langversion 3.0
			 * @playerversion Flash 9.0
			 */
			protected var data:Array;
			
			
			/**
			 * 将一个二维数组、XML、 DataProvider转化为DataProvider（如果提供了value值）
			 * 
			 * @param data The data that is used to create the DataProvider.
			 *
			 * @includeExample examples/DataProvider.constructor.1.as -noswf
			 * @includeExample examples/DataProvider.constructor.2.as -noswf
			 * @includeExample examples/DataProvider.constructor.3.as -noswf
			 * @includeExample examples/DataProvider.constructor.4.as -noswf
			 *
			 * @langversion 3.0
			 * @playerversion Flash 9.0
			 *  
			 */
			public function DataProvider(value:Object=null) {			
				if (value == null) {
					data = [];
				} else {
					data = getDataFromObject(value);				
				}
			}
			
			/**
			 * 数据提供者包含的项目数。
			 *
			 * @includeExample examples/DataProvider.length.1.as -noswf
			 *
			 * @langversion 3.0
			 * @playerversion Flash 9.0
			 *  
			 */
			public function get length():uint {
				return data.length;
			}
			
			/**
			 * 使指定索引处的项目失效。
			 *
			 * @param index Index of the item to be invalidated.
			 *
			 * @throws RangeError The specified index is less than 0 or greater than 
			 *         or equal to the length of the data provider.
			 *
			 * @see #invalidate()
			 * @see #invalidateItem()
			 *
			 * @langversion 3.0
			 * @playerversion Flash 9.0
			 *  
			 */
			public function invalidateItemAt(index:int):void {
				checkIndex(index,data.length-1)
				dispatchChangeEvent(DataChangeType.INVALIDATE,[data[index]],index,index);
			}
			
			/**
			 * 使指定的项目失效。
			 *
			 * @param item Item to be invalidated.
			 *
			 * @see #invalidate()
			 * @see #invalidateItemAt()
			 *
			 * @langversion 3.0
			 * @playerversion Flash 9.0
			 *  
			 */
			public function invalidateItem(item:Object):void {
				var index:uint = getItemIndex(item);
				if (index == -1) { return; }
				invalidateItemAt(index);
			}
			
			/**
			 * 使 DataProvider 包含的所有数据项失效，并调度 DataChangeEvent.INVALIDATE_ALL 事件。
			 *
			 * @see #invalidateItem()
			 * @see #invalidateItemAt()
			 *
			 * @langversion 3.0
			 * @playerversion Flash 9.0
			 *  
			 */
			public function invalidate():void {
				dispatchEvent(new DataChangeEvent(DataChangeEvent.DATA_CHANGE, DataChangeType.INVALIDATE_ALL,data.concat(),0,data.length));
			}
			
			
			/**
			 * 将新项目添加到数据提供者的指定索引处。 如果指定的索引超过数据提供者的长度，则忽略该索引。 
			 *
			 * @param item 包含要添加的项目数据的对象。
			 *
			 * @param index  要在其位置添加项目的索引。 
			 *
			 * @throws RangeError The specified index is less than 0 or greater than or equal 
			 *         to the length of the data provider.
			 *
			 * @see #addItem()
			 * @see #addItems()
			 * @see #addItemsAt()
			 * @see #getItemAt()
			 * @see #removeItemAt()
			 *
			 * @langversion 3.0
			 * @playerversion Flash 9.0
			 *  
			 */
			public function addItemAt(item:Object,index:uint):void {
				checkIndex(index,data.length);
				dispatchPreChangeEvent(DataChangeType.ADD,[item],index,index);
				data.splice(index,0,item);
				dispatchChangeEvent(DataChangeType.ADD,[item],index,index);
			}
			
			/**
			 * 将项目追加到数据提供者的结尾。 
			 *
			 * @param item 要追加到当前数据提供者的结尾的项目。 
			 *
			 * @includeExample examples/DataProvider.constructor.1.as -noswf
			 *
			 * @see #addItemAt()
			 * @see #addItems()
			 * @see #addItemsAt()
			 *
			 * @langversion 3.0
			 * @playerversion Flash 9.0
			 *  
			 */
			public function addItem(item:Object):void {
				dispatchPreChangeEvent(DataChangeType.ADD,[item],data.length-1,data.length-1);
				data.push(item);
				dispatchChangeEvent(DataChangeType.ADD,[item],data.length-1,data.length-1);
			}
			
			/**
			 * 向数据提供者的指定索引处添加若干项目，并调度 DataChangeType.ADD 事件。 
			 *
			 * @param items 要添加到数据提供者的项目。
			 *
			 * @param index 要在其位置插入项目的索引。  
			 *
			 * @throws RangeError The specified index is less than 0 or greater than or equal 
			 *                    to the length of the data provider.
			 *
			 * @see #addItem()
			 * @see #addItemAt()
			 * @see #addItems()
			 *
			 * @langversion 3.0
			 * @playerversion Flash 9.0
			 *  
			 */
			public function addItemsAt(items:Object,index:uint):void {
				checkIndex(index,data.length);
				var arr:Array = getDataFromObject(items);
				dispatchPreChangeEvent(DataChangeType.ADD,arr,index,index+arr.length-1);			
				data.splice.apply(data, [index,0].concat(arr));
				dispatchChangeEvent(DataChangeType.ADD,arr,index,index+arr.length-1);
			}
			
			/**
			 * 向 DataProvider 的末尾追加多个项目，并调度 DataChangeType.ADD 事件。 按照指定项目的顺序添加项目。 
			 * 
			 * @param items 要追加到数据提供者的项目。
			 *
			 * @includeExample examples/DataProvider.addItems.1.as -noswf
			 * 
			 * @see #addItem()
			 * @see #addItemAt()
			 * @see #addItemsAt()
			 *
			 * @langversion 3.0
			 * @playerversion Flash 9.0
			 *  
			 */
			public function addItems(items:Object):void {
				addItemsAt(items,data.length);
			}
			
			/**
			 * 将指定项目连接到当前数据提供者的结尾。 此方法调度 DataChangeType.ADD 事件。 
			 *
			 * @param items 要添加到数据提供者的项目。 
			 *
			 * @langversion 3.0
			 * @playerversion Flash 9.0
			 *
			 * @see #addItems()
			 * @see #merge()
			 *
			 */
			public function concat(items:Object):void {
				addItems(items);
			}
			
			/**
			 * 将指定数据追加到数据提供者包含的数据，并删除任何重复的项目。 此方法调度 DataChangeType.ADD 事件。 
			 *
			 * @param data 要合并到数据提供者的数据。 
			 *
			 * @see #concat()
			 *
			 * @langversion 3.0
			 * @playerversion Flash 9.0
			 *  
			 */
			public function merge(newData:Object):void {
				var arr:Array = getDataFromObject(newData);
				var l:uint = arr.length;
				var startLength:uint = data.length;
				
				dispatchPreChangeEvent(DataChangeType.ADD,data.slice(startLength,data.length),startLength,this.data.length-1);
				
				for (var i:uint=0; i<l; i++) {
					var item:Object = arr[i];
					if (getItemIndex(item) == -1) {
						data.push(item);
					}
				}
				if (data.length > startLength) {
					dispatchChangeEvent(DataChangeType.ADD,data.slice(startLength,data.length),startLength,this.data.length-1);
				} else {
					dispatchChangeEvent(DataChangeType.ADD,[],-1,-1);
				}
			}
			
			/**
			 * 返回指定索引处的项目。 
			 *
			 * @param index 要返回的项目的位置。 
			 *
			 * @return 指定索引处的项目。 
			 *
			 * @throws RangeError 指定的索引小于 0 或大于等于数据提供者的长度。 
			 *
			 * @see #getItemIndex()
			 * @see #removeItemAt()
			 *
			 * @langversion 3.0
			 * @playerversion Flash 9.0
			 *  
			 */
			public function getItemAt(index:uint):Object {
				checkIndex(index,data.length-1);
				return data[index];
			}
			
			/**
			 * 返回指定项目的索引。 
			 *
			 * @param item 要查找的项目。 
			 *
			 * @return 指定项目的索引；如果没有找到指定项目，则为 -1。 
			 *
			 * @see #getItemAt()
			 *
			 * @langversion 3.0
			 * @playerversion Flash 9.0
			 *  
			 */
			public function getItemIndex(item:Object):int {
				return data.indexOf(item);;
			}
			
			/**
			 * 删除指定索引处的项目，并调度 DataChangeType.REMOVE 事件。 
			 *
			 * @param index 要删除的项目的索引。 
			 *
			 * @return 被删除的项目。 
			 *
			 * @throws RangeError 指定的索引小于 0 或大于等于数据提供者的长度。 
			 *
			 * @see #removeAll()
			 * @see #removeItem()
			 *
			 * @langversion 3.0
			 * @playerversion Flash 9.0
			 *  
			 */
			public function removeItemAt(index:uint):Object {
				checkIndex(index,data.length-1);
				dispatchPreChangeEvent(DataChangeType.REMOVE, data.slice(index,index+1), index, index);
				var arr:Array = data.splice(index,1);
				dispatchChangeEvent(DataChangeType.REMOVE,arr,index,index);
				return arr[0];
			}
			
			/**
			 * 从数据提供者中删除指定项目，并调度 DataChangeType.REMOVE 事件。 
			 *
			 * @param item 要删除的项目。 
			 *
			 * @return 被删除的项目。 
			 *
			 * @see #removeAll()
			 * @see #removeItemAt()
			 *
			 * @langversion 3.0
			 * @playerversion Flash 9.0
			 *  
			 */
			public function removeItem(item:Object):Object {
				var index:int = getItemIndex(item);
				if (index != -1) {
					return removeItemAt(index);
				}
				return null;
			}
			
			/**
			 * 从数据提供者中删除所有项目，并调度 DataChangeType.REMOVE_ALL 事件。 
			 *
			 * @see #removeItem()
			 * @see #removeItemAt()
			 *
			 * @langversion 3.0
			 * @playerversion Flash 9.0
			 *  
			 */
			public function removeAll():void {
				var arr:Array = data.concat();
				
				dispatchPreChangeEvent(DataChangeType.REMOVE_ALL,arr,0,arr.length);
				data = [];
				dispatchChangeEvent(DataChangeType.REMOVE_ALL,arr,0,arr.length);
			}
			
			/**
			 * 用新项目替换现有项目，并调度 DataChangeType.REPLACE 事件。 
			 *
			 * @param oldItem 被替换的项目。
			 *
			 * @param newItem 要替换的项目。
			 *
			 * @return 被替换的项目。 
			 *
			 * @throws RangeError 无法在数据提供者中找到项目。 
			 *
			 * @see #replaceItemAt()
			 *
			 * @langversion 3.0
			 * @playerversion Flash 9.0
			 *  
			 */
			public function replaceItem(newItem:Object,oldItem:Object):Object {
				var index:int = getItemIndex(oldItem);
				if (index != -1) {
					return replaceItemAt(newItem,index);
				}
				return null;
			}
			
			/**
			 *  替换指定索引处的项目，并调度 DataChangeType.REPLACE 事件。 
			 *
			 * @param newItem 替换项目。 
			 *
			 * @param index 要替换的项目的索引。
			 *
			 * @return 被替换的项目。 
			 * 
			 * @throws RangeError 指定的索引小于 0 或大于等于数据提供者的长度。
			 *
			 * @see #replaceItem()
			 *
			 * @langversion 3.0
			 * @playerversion Flash 9.0
			 *  
			 */
			public function replaceItemAt(newItem:Object,index:uint):Object {
				checkIndex(index,data.length-1);
				var arr:Array = [data[index]];
				dispatchPreChangeEvent(DataChangeType.REPLACE,arr,index,index);
				data[index] = newItem;
				dispatchChangeEvent(DataChangeType.REPLACE,arr,index,index);
				return arr[0];
			}
			
			/**
			 * 对数据提供者包含的项目进行排序，并调度 DataChangeType.SORT 事件。 
			 *
			 * @param sortArg 用于排序的参数。 
			 *
			 * @return 返回值取决于方法是否接收任何参数。 有关详细信息，请参阅 Array.sort() 方法。 当 sortOption 属性设置为 Array.UNIQUESORT 时，该方法返回 0。
			 *
			 * @see #sortOn()
			 * @see Array#sort() Array.sort()
			 *
			 * @langversion 3.0
			 * @playerversion Flash 9.0
			 *  
			 */
			public function sort(...sortArgs:Array):* {
				dispatchPreChangeEvent(DataChangeType.SORT,data.concat(),0,data.length-1);
				var returnValue:Array = data.sort.apply(data,sortArgs);
				dispatchChangeEvent(DataChangeType.SORT,data.concat(),0,data.length-1);
				return returnValue;
			}
			
			/**
			 * 按指定字段对数据提供者包含的项目进行排序，并调度 DataChangeType.SORT 事件。 指定字段可以是字符串或字符串值数组，这些字符串值指定要按优先顺序对其进行排序的多个字段。
			 *
			 * @param fieldName 要按其进行排序的项目字段。 该值可以是字符串或字符串值数组。
			 *
			 * @param options 用于排序的选项。 
			 *
			 * @return 返回值取决于方法是否接收任何参数。 有关详细信息，请参阅“Array.sortOn() 方法”。 如果 sortOption 属性设置为 Array.UNIQUESORT，则该方法返回 0。
			 *
			 * @see #sort()
			 * @see Array#sortOn() Array.sortOn()
			 *
			 * @langversion 3.0
			 * @playerversion Flash 9.0
			 *  
			 */
			public function sortOn(fieldName:Object,options:Object=null):* {
				dispatchPreChangeEvent(DataChangeType.SORT,data.concat(),0,data.length-1);
				var returnValue:Array = data.sortOn(fieldName,options);
				dispatchChangeEvent(DataChangeType.SORT,data.concat(),0,data.length-1);
				return returnValue;
			}
			
			/**
			 * Creates a copy of the current DataProvider object.
			 *
			 * @return A new instance of this DataProvider object.
			 *
			 * @langversion 3.0
			 * @playerversion Flash 9.0
			 *  
			 */
			public function clone():DataProvider {
				return new DataProvider(data);
			}
			
			/**
			 * 创建数据提供者包含的数据的 Array 对象表示形式。 
			 *
			 * @return 数据提供者包含的数据的 Array 对象表示形式。 
			 *
			 * @langversion 3.0
			 * @playerversion Flash 9.0
			 *  
			 */
			public function toArray():Array {
				return data.concat();
			}
			
			/**
			 * 创建数据提供者包含的数据的字符串表示形式。
			 *
			 * @return 数据提供者包含的数据的字符串表示形式。
			 *
			 * @langversion 3.0
			 * @playerversion Flash 9.0
			 *  
			 */
			override public function toString():String {
				return "DataProvider ["+data.join(" , ")+"]";
			}
			
			/**
			 * @private (protected)
			 *
			 * @langversion 3.0
			 * @playerversion Flash 9.0
			 */
			protected function getDataFromObject(obj:Object):Array {
				var retArr:Array;
				if (obj is Array) {
					var arr:Array = obj as Array;
					if (arr.length > 0) {
						if (arr[0] is String || arr[0] is Number) {
							retArr = [];
							// convert to object array.
							for (var i:uint = 0; i < arr.length; i++) {
								var o:Object = {label:String(arr[i]),data:arr[i]}
								retArr.push(o);
							}
							return retArr;
						}
					}
					return obj.concat();
				} else if (obj is DataProvider) {
					return obj.toArray();
				} else if (obj is XML) {
					var xml:XML = obj as XML;
					retArr = [];
					var nodes:XMLList = xml.*;
					for each (var node:XML in nodes) {
						var obj:Object = {};
						var attrs:XMLList = node.attributes();
						for each (var attr:XML in attrs) {
							obj[attr.localName()] = attr.toString();
						}
						var propNodes:XMLList = node.*;
						for each (var propNode:XML in propNodes) {
							if (propNode.hasSimpleContent()) {
								obj[propNode.localName()] = propNode.toString();
							}
						}
						retArr.push(obj);
					}
					return retArr;
				} else {
					throw new TypeError("Error: Type Coercion failed: cannot convert "+obj+" to Array or DataProvider.");
					return null;
				}
			}
			
			/**
			 * @private (protected)
			 *
			 * @langversion 3.0
			 * @playerversion Flash 9.0
			 */
			protected function checkIndex(index:int,maximum:int):void {
				if (index > maximum || index < 0) {
					throw new RangeError("DataProvider index ("+index+") is not in acceptable range (0 - "+maximum+")");
				}
			}
			
			/**
			 * @private (protected)
			 *
			 * @langversion 3.0
			 * @playerversion Flash 9.0
			 */
			protected function dispatchChangeEvent(evtType:String,items:Array,startIndex:int,endIndex:int):void {
				dispatchEvent(new DataChangeEvent(DataChangeEvent.DATA_CHANGE,evtType,items,startIndex,endIndex));
			}
			
			/**
			 * @private (protected)
			 *
			 * @langversion 3.0
			 * @playerversion Flash 9.0
			 */
			protected function dispatchPreChangeEvent(evtType:String, items:Array, startIndex:int, endIndex:int):void {
				dispatchEvent(new DataChangeEvent(DataChangeEvent.PRE_DATA_CHANGE, evtType, items, startIndex, endIndex));
			}
		}
		
	}