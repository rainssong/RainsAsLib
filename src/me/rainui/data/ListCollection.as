/*
Feathers
Copyright 2012-2014 Joshua Tynjala. All Rights Reserved.

This program is free software. You can redistribute and/or modify it in
accordance with the terms of the accompanying license agreement.
*/
package me.rainui.data
{
	import flash.events.EventDispatcher;
	import me.rainui.events.ListEvent;
	//import me.rainui.events.ListEvent;
	import me.rainui.events.RainUIEvent;


	[Event(name = "change", type = "com.rainui.events.RainUIEvent")]
	[Event(name = "reset", type = "com.rainui.events.RainUIEvent")]
	[Event(name = "addItem", type = "com.rainui.events.RainUIEvent")]
	[Event(name = "removeItem", type = "com.rainui.events.RainUIEvent")]
	[Event(name = "replaceItem", type = "com.rainui.events.RainUIEvent")]
	[Event(name = "updateItem", type = "com.rainui.events.RainUIEvent")]

	[DefaultProperty("data")]
	
	public class ListCollection extends EventDispatcher
	{
		static public const UPDATE_ITEM:String = "updateItem";
		/**
		 * Constructor
		 */
		public function ListCollection(data:Array = null)
		{
			if(!data)
			{
				data = [];
			}
			this.data = data;
		}
		
		/**
		 * @private
		 */
		protected var _data:Array;
		
		/**
		 * The data source for this collection. May be any type of data, but a
		 * <code>dataDescriptor</code> needs to be provided to translate from
		 * the data source's APIs to something that can be understood by
		 * <code>ListCollection</code>.
		 * 
		 * <p>Data sources of type Array, Vector, and XMLList are automatically
		 * detected, and no <code>dataDescriptor</code> needs to be set if the
		 * <code>ListCollection</code> uses one of these types.</p>
		 */
		public function get data():Array
		{
			return _data;
		}
		
		/**
		 * @private
		 */
		public function set data(value:Array):void
		{
			if(this._data == value)
			{
				return;
			}
			this._data = value;
			
			this.sendEvent(RainUIEvent.CHANGE);
		}
		
		

		/**
		 * The number of items in the collection.
		 */
		public function get length():int
		{
			if (_data == null) return 0;
			return _data.length;
		}
		
		public function set length(value:int):void
		{
			_data.length = value;
			sendEvent(RainUIEvent.CHANGE);
		}

		public function updateItemAt(index:int):void
		{
			sendEvent(ListEvent.UPDATE_ITEM,index, false );
		}
		
		public function sendEvent(type:String, data:*=null, bubbles:Boolean = false, cancelable:Boolean = false):void
		{
			dispatchEvent(new RainUIEvent(type, data, bubbles, cancelable));
		}
		
		/**
		 * Returns the item at the specified index in the collection.
		 */
		public function getItemAt(index:int):Object
		{
			return _data[index];
		}
		
		/**
		 * Determines which index the item appears at within the collection. If
		 * the item isn't in the collection, returns <code>-1</code>.
		 */
		public function getItemIndex(item:Object):int
		{
			return _data.indexOf(item, 0);
		}
		
		public function addItemAt(item:Object, index:int):void
		{
			_data.splice(index,0,item)
			this.sendEvent(RainUIEvent.CHANGE);
			//this.sendEvent(ListEvent.ADD_ITEM, false, index);
		}
		
		/**
		 * Removes the item at the specified index from the collection and
		 * returns it.
		 */
		public function removeItemAt(index:int):Object
		{
			var item:Object=_data.splice(index,1)
			//this.sendEvent(RainUIEvent.CHANGE,null,true);
			dispatchEvent(new RainUIEvent(RainUIEvent.CHANGE,null,true))
			//this.sendEvent(CollectionEventType.REMOVE_ITEM, false, index);
			return item;
		}
		
		public function removeItem(item:Object):Object
		{
			var index:int = this.getItemIndex(item);
			if(index >= 0)
			{
				return this.removeItemAt(index);
			}
			return null;
		}

		/**
		 * Removes all items from the collection.
		 */
		public function removeAll():void
		{
			if(this.length == 0)
			{
				return;
			}
			this.sendEvent(RainUIEvent.CHANGE);
			//this.sendEvent(CollectionEventType.RESET, false);
		}
		
		/**
		 * Replaces the item at the specified index with a new item.
		 */
		public function setItemAt(item:Object, index:int):void
		{
			_data[index] = item;
			this.sendEvent(RainUIEvent.CHANGE);
			//this.sendEvent(CollectionEventType.REPLACE_ITEM, false, index);
		}

		/**
		 * Adds an item to the end of the collection.
		 */
		public function push(item:Object):void
		{
			this.addItemAt(item, this.length);
		}

		/**
		 * Adds all items from another collection.
		 */
		public function addAll(collection:ListCollection):void
		{
			var otherCollectionLength:int = collection.length;
			for(var i:int = 0; i < otherCollectionLength; i++)
			{
				var item:Object = collection.getItemAt(i);
				this.push(item);
			}
			//_data.concat()
		}

		/**
		 * Adds all items from another collection, placing the items at a
		 * specific index in this collection.
		 */
		public function addAllAt(collection:ListCollection, index:int):void
		{
			var otherCollectionLength:int = collection.length;
			var currentIndex:int = index;
			for(var i:int = 0; i < otherCollectionLength; i++)
			{
				var item:Object = collection.getItemAt(i);
				this.addItemAt(item, currentIndex);
				currentIndex++;
			}
		}
		
		/**
		 * Removes the item from the end of the collection and returns it.
		 */
		public function pop():Object
		{
			return _data.pop();
		}
		
		/**
		 * Adds an item to the beginning of the collection.
		 */
		public function unshift(item:Object):void
		{
			_data.unshift(item);
			sendEvent(RainUIEvent.CHANGE);
		}
		
		/**
		 * Removed the item from the beginning of the collection and returns it. 
		 */
		public function shift():Object
		{
			return _data.shift();
		}

		/**
		 * Determines if the specified item is in the collection.
		 */
		public function contains(item:Object):Boolean
		{
			return this.getItemIndex(item) >= 0;
		}

		/**
		 * Calls a function for each item in the collection that may be used
		 * to dispose any properties on the item. For example, display objects
		 * or textures may need to be disposed.
		 *
		 * <p>The function is expected to have the following signature:</p>
		 * <pre>function( item:Object ):void</pre>
		 *
		 * <p>In the following example, the items in the collection are disposed:</p>
		 *
		 * <listing version="3.0">
		 * collection.dispose( function( item:Object ):void
		 * {
		 *     var accessory:DisplayObject = DisplayObject(item.accessory);
		 *     accessory.dispose();
		 * }</listing>
		 *
		 * @see http://doc.starling-framework.org/core/starling/display/DisplayObject.html#dispose() starling.display.DisplayObject.dispose()
		 * @see http://doc.starling-framework.org/core/starling/textures/Texture.html#dispose() starling.textures.Texture.dispose()
		 */
		public function dispose(disposeItem:Function):void
		{
			var itemCount:int = this.length;
			for(var i:int = 0; i < itemCount; i++)
			{
				var item:Object = this.getItemAt(i);
				disposeItem(item);
			}
		}
	}
}