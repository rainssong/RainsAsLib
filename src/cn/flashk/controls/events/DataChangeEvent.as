// Copyright 2007. Adobe Systems Incorporated. All Rights Reserved.
package cn.flashk.controls.events {

	import flash.events.Event;

	/**
	 * DataChangeEvent 类定义事件，该事件在与组件关联的数据更改时调度。List、DataGrid、TileList 和 ComboBox 组件使用该事件。 
	 *
	 * <p>该类提供下列事件：</p>
	 * <ul>
	 *     <li>DataChangeEvent.DATA_CHANGE：在组件数据更改时调度。</li>
	 * </ul>
     *
	 * @includeExample examples/DataChangeEventExample.as
	 *
     * @see DataChangeType
     *
     * @langversion 3.0
     * @playerversion Flash 9.0
	 *  
	 */
	public class DataChangeEvent extends Event {
		/**
         * 定义 dataChange 事件对象的 type 属性值。 
		 *
		 * <p>此事件具有以下属性：</p>
		 *  <table class="innertable" width="100%">
		 *     <tr><th>Property</th><th>Value</th></tr>
		 * 	   <tr><td><code>bubbles</code></td><td><code>false</code></td></tr>
		 *     <tr><td><code>cancelable</code></td><td><code>false</code>; there is no default behavior to cancel.</td></tr>
		 *     <tr><td><code>changeType</code></td><td>Identifies the type of change that was made.</td></tr>
		 *	   <tr><td><code>currentTarget</code></td><td>The object that is actively processing 
		 * 			the event object with an event listener.</td></tr>
		 *     <tr><td><code>endIndex</code></td><td>Identifies the index of the last changed item.</td></tr>
		 *     <tr><td><code>items</code></td><td>An array that lists the items that were changed.</td></tr>
		 *     <tr><td><code>startIndex</code></td><td>Identifies the index of the first changed item.</td></tr>
    	 *     <tr><td><code>target</code></td><td>The object that dispatched the event. The target is 
         *           not always the object listening for the event. Use the <code>currentTarget</code>
		 * 			property to access the object that is listening for the event.</td></tr>
		 *  </table>
         *
         * @eventType dataChange
         *
         * @see #PRE_DATA_CHANGE
         *
         * @langversion 3.0
         * @playerversion Flash 9.0.28.0
		 *  
		 *  @playerversion AIR 1.0
		 *  @productversion Flash CS3
		 */
		public static const DATA_CHANGE:String = "dataChange";
		
		/**
		 * 定义 preDataChange 事件对象的 type 属性值。该事件对象在更改组件数据之前调度。 
		 *
		 * <p>此事件具有以下属性：</p>
		 *  <table class="innertable" width="100%">
		 *     <tr><th>Property</th><th>Value</th></tr>
		 * 	   <tr><td><code>bubbles</code></td><td><code>false</code></td></tr>
		 *     <tr><td><code>cancelable</code></td><td><code>false</code>; there is no default behavior to cancel.</td></tr>
		 * 	   <tr><td><code>changeType</code></td><td>Identifies the type of change to be made.</td></tr>
		 *	   <tr><td><code>currentTarget</code></td><td>The object that is actively processing 
		 * 			the event object with an event listener.</td></tr>
		 *     <tr><td><code>endIndex</code></td><td>Identifies the index of the last item to be
		 * 			changed.</td></tr>
		 *     <tr><td><code>items</code></td><td>An array that lists the items to be changed.</td></tr>
		 *     <tr><td><code>startIndex</code></td><td>Identifies the index of the first item to be
		 *         changed.</td></tr>
	     *     <tr><td><code>target</code></td><td>The object that dispatched the event. The target is 
         *          not always the object listening for the event. Use the <code>currentTarget</code>
		 * 			property to access the object that is listening for the event.</td></tr>
		 *  </table>
		 * 
         * @eventType preDataChange
         *
         * @see #DATA_CHANGE
         *
         * @langversion 3.0
         * @playerversion Flash 9.0.28.0
		 *  
		 *  @playerversion AIR 1.0
		 *  @productversion Flash CS3
		 */
		public static const PRE_DATA_CHANGE:String = "preDataChange";


        /**
         * @private (protected)
         *
         * @langversion 3.0
         * @playerversion Flash 9.0.28.0
		 */
		protected var _startIndex:uint;


        /**
         * @private (protected)
         *
         * @langversion 3.0
         * @playerversion Flash 9.0.28.0
		 */
		protected var _endIndex:uint;


        /**
         * @private (protected)
         *
         * @langversion 3.0
         * @playerversion Flash 9.0.28.0
		 */
		protected var _changeType:String;


        /**
         * @private (protected)
         *
         * @langversion 3.0
         * @playerversion Flash 9.0.28.0
		 */
		protected var _items:Array;

		/**
		 * 使用指定的参数创建新的 DataChangeEvent 对象。
		 *
		 * @param eventType The type of change event.
		 *
		 * @param changeType The type of change that was made. The DataChangeType class defines the possible values for
		 *        this parameter.
		 *
		 * @param items A list of items that were changed.
		 * 
		 * @param startIndex The index of the first item that was changed.
         *
         * @param endIndex The index of the last item that was changed.
         *
         * @langversion 3.0
         * @playerversion Flash 9.0.28.0
		 *  
		 *  @playerversion AIR 1.0
		 *  @productversion Flash CS3
		 */
		public function DataChangeEvent(eventType:String, changeType:String, items:Array,startIndex:int=-1, endIndex:int=-1):void {
			super(eventType);
			_changeType = changeType;
			_startIndex = startIndex;
			_items = items;
			_endIndex = (endIndex == -1) ? _startIndex : endIndex;
		}

		/**
		 * 获取触发事件的更改类型。
         *
         * @see DataChangeType
         *
         * @langversion 3.0
         * @playerversion Flash 9.0.28.0
		 
		 *  
		 
		 *  @playerversion AIR 1.0
		 
		 *  @productversion Flash CS3
		 
		 */
		public function get changeType():String {
			return _changeType;
		}

		/**
         * 获取包含更改的项目的数组。
         *
         * @langversion 3.0
         * @playerversion Flash 9.0.28.0
		 *  
		 *  @playerversion AIR 1.0
		 *  @productversion Flash CS3
		 */
		public function get items():Array {
			return _items;
		}

		/**
		 * 获取更改的项目数组中第一个更改的项目的索引。
         *
         * @see #endIndex
         *
         * @langversion 3.0
         * @playerversion Flash 9.0.28.0
		 *                   
		 *  
		 *  @playerversion AIR 1.0
		 *  @productversion Flash CS3
		 */
		public function get startIndex():uint {
			return _startIndex;
		}

		/**
         * 获取更改的项目数组中最后一个更改的项目的索引。
         *
         * @see #startIndex
         *
         * @langversion 3.0
         * @playerversion Flash 9.0.28.0
		 *  
		 *  @playerversion AIR 1.0
		 *  @productversion Flash CS3
		 */
		public function get endIndex():uint {
			return _endIndex;
		}


		/**
		 * 返回一个字符串，其中包含 DataChangeEvent 对象的所有属性。
		 * 
		 * <p>[<code>DataChangeEvent type=<em>value</em> changeType=<em>value</em> 
		 * startIndex=<em>value</em> endIndex=<em>value</em>
		 * bubbles=<em>value</em> cancelable=<em>value</em></code>]</p>
		 *
         * @return A string that contains all the properties of the DataChangeEvent object.
         *
         * @langversion 3.0
         * @playerversion Flash 9.0.28.0
		 *  
		 *  @playerversion AIR 1.0
		 *  @productversion Flash CS3
		 */
		override public function toString():String {
			return formatToString("DataChangeEvent", "type", "changeType", "startIndex", "endIndex", "bubbles", "cancelable");
		}



		/**
		 * 创建 DataEvent 对象的副本，并设置每个参数的值以匹配原始参数值。
		 *
		 * @return A new DataChangeEvent object with property values that match those of the
         *         original.
         *
         * @langversion 3.0
         * @playerversion Flash 9.0.28.0
		 *  
		 *  @playerversion AIR 1.0
		 *  @productversion Flash CS3
		 */
		override public function clone():Event {
			return new DataChangeEvent(type, _changeType, _items, _startIndex, _endIndex);
		}
	}
}