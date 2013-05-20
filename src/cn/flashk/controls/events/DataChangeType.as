// Copyright 2007. Adobe Systems Incorporated. All Rights Reserved.
package cn.flashk.controls.events {

	/**
	 * DataChangeType 类定义 DataChangeEvent.changeType 事件的常量。DataChangeEvent 类使用这些常量，来标识应用到基于列表的组件（例如 List、ComboBox、TileList 或 DataGrid）中数据的更改类型。 
	 *
     * @see DataChangeEvent#changeType
     *
     * @langversion 3.0
     * @playerversion Flash 9.0.28.0
	 *  
	 *  @playerversion AIR 1.0
	 *  @productversion Flash CS3
	 */
	public class DataChangeType {

		/**
         * 更改了组件数据。
         *
         * @eventType change
         *
         * @langversion 3.0
         * @playerversion Flash 9.0.28.0
		 *  
		 *  @playerversion AIR 1.0
		 *  @productversion Flash CS3
		 */
		public static const CHANGE:String = "change";
		
		/**
         * A change was made to the data contained in an item.
         *
         * @eventType invalidate
         *
         * @langversion 3.0
         * @playerversion Flash 9.0.28.0
		 *  
		 *  @playerversion AIR 1.0
		 *  @productversion Flash CS3
		 */
		public static const INVALIDATE:String = "invalidate";
		
		/**
         * The data set is invalid.
         *
         * @eventType invalidateAll
         *
         * @langversion 3.0
         * @playerversion Flash 9.0.28.0
		 *  
		 *  @playerversion AIR 1.0
		 *  @productversion Flash CS3
		 */
		public static const INVALIDATE_ALL:String = "invalidateAll";

		/**
         * Items were added to the data provider.
		 *
         * @eventType add
         *
         * @langversion 3.0
         * @playerversion Flash 9.0.28.0
		 * @internal The word "model" was replaced with "data provider" above. What should it say?
		 * @internal If this indicates "one or more" items were added, we should use that string.
		 *  
		 *  @playerversion AIR 1.0
		 *  @productversion Flash CS3
		 */
		public static const ADD:String = "add";

		/**
         * Items were removed from the data provider.
		 *
         * @eventType remove
         *
         * @langversion 3.0
         * @playerversion Flash 9.0.28.0
		 * @internal The word "model" was replaced with "data provider" above. What should it say?
		 * @internal If this indicates "one or more" items were removed, we should use that string.
		 *  
		 *  @playerversion AIR 1.0
		 *  @productversion Flash CS3
		 */
		public static const REMOVE:String = "remove";
		
		/**
         * All items were removed from the data provider.
		 *
         * @eventType removeAll
         *
         * @langversion 3.0
         * @playerversion Flash 9.0.28.0
		 * @internal The word "model" was replaced with "data provider" above. What should it say?
		 *  
		 *  @playerversion AIR 1.0
		 *  @productversion Flash CS3
		 */
		public static const REMOVE_ALL:String = "removeAll";

		/**
         * The items in the data provider were replaced by new items.
		 *
         * @eventType replace
         *
         * @langversion 3.0
         * @playerversion Flash 9.0.28.0
		 * @internal I used "data provider" here instead of the word "model". Correct?
		 *  
		 *  @playerversion AIR 1.0
		 *  @productversion Flash CS3
		 */
		public static const REPLACE:String = "replace";

		/**
         * The data provider was sorted. This constant is used to indicate
		 * a change in the order of the data, not a change in
		 * the data itself.
		 *
         * @eventType sort
         *
         * @langversion 3.0
         * @playerversion Flash 9.0.28.0
		 * @internal The word "model" was replaced with "data provider" above. What should it say?
		 *  
		 *  @playerversion AIR 1.0
		 *  @productversion Flash CS3
		 */
		public static const SORT:String = "sort";
	}
}