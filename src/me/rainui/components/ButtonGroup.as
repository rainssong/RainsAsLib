/*
reference to Feathers
*/
package me.rainui.components
{
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	import me.rainssong.utils.Directions;
	import me.rainui.RainUI;
	import me.rainui.data.ListCollection;
	import me.rainui.events.CollectionEvent;
	import me.rainui.events.RainUIEvent;
	import me.rainui.layout.HorizontalOrVerticalLayoutGroup;
	import me.rainui.layout.LayoutGroup;



	/**
	 * Dispatched when one of the buttons is triggered. The <code>data</code>
	 * property of the event contains the item from the data provider that is
	 * associated with the button that was triggered.
	 *
	 * <p>The following example listens to <code>Event.TRIGGERED</code> on the
	 * button group instead of on individual buttons:</p>
	 *
	 * <listing version="3.0">
	 * group.dataProvider = new ListCollection(
	 * [
	 *     { label: "Yes" },
	 *     { label: "No" },
	 *     { label: "Cancel" },
	 * ]);
	 * group.addEventListener( Event.TRIGGERED, function( event:Event, data:Object ):void
	 * {
	 *    trace( "The button with label \"" + data.label + "\" was triggered." );
	 * }</listing>
	 *
	 * <p>The properties of the event object have the following values:</p>
	 * <table class="innertable">
	 * <tr><th>Property</th><th>Value</th></tr>
	 * <tr><td><code>bubbles</code></td><td>false</td></tr>
	 * <tr><td><code>currentTarget</code></td><td>The Object that defines the
	 *   event listener that handles the event. For example, if you use
	 *   <code>myButton.addEventListener()</code> to register an event listener,
	 *   myButton is the value of the <code>currentTarget</code>.</td></tr>
	 * <tr><td><code>data</code></td><td>The item associated with the button
	 *   that was triggered.</td></tr>
	 * <tr><td><code>target</code></td><td>The Object that dispatched the event;
	 *   it is not always the Object listening for the event. Use the
	 *   <code>currentTarget</code> property to always access the Object
	 *   listening for the event.</td></tr>
	 * </table>
	 *
	 * @eventType starling.events.Event.TRIGGERED
	 */
	[Event(name="click", type="flash.events.MouseEvent")]

	/**
	 * A set of related buttons with layout, customized using a data provider.
	 *
	 * <p>The following example creates a button group with a few buttons:</p>
	 *
	 * <listing version="3.0">
	 * var group:ButtonGroup = new ButtonGroup();
	 * group.dataProvider = new ListCollection(
	 * [
	 *     { label: "Yes", triggered: yesButton_triggeredHandler },
	 *     { label: "No", triggered: noButton_triggeredHandler },
	 *     { label: "Cancel", triggered: cancelButton_triggeredHandler },
	 * ]);
	 * this.addChild( group );</listing>
	 *
	 * @see ../../../help/button-group.html How to use the Feathers ButtonGroup component
	 * @see feathers.controls.TabBar
	 */
	public class ButtonGroup extends HorizontalOrVerticalLayoutGroup
	{
		


		/**
		 * @private
		 */
		protected static function defaultButtonFactory():Button
		{
			return new Button();
		}

		/**
		 * Constructor.
		 */
		public function ButtonGroup()
		{
			super();
		}

		
		protected var _buttons:Vector.<Button> = new <Button>[];

		/**
		 * @private
		 */
		protected var activeButtons:Vector.<Button> = new <Button>[];

		/**
		 * @private
		 */
		protected var inactiveButtons:Vector.<Button> = new <Button>[];

		/**
		 * @private
		 */
		protected var _items:ListCollection;

		/**
		 * The collection of data to be displayed with buttons.
		 *
		 * <p>The following example sets the button group's data provider:</p>
		 *
		 * <listing version="3.0">
		 * group.dataProvider = new ListCollection(
		 * [
		 *     { label: "Yes", triggered: yesButton_triggeredHandler },
		 *     { label: "No", triggered: noButton_triggeredHandler },
		 *     { label: "Cancel", triggered: cancelButton_triggeredHandler },
		 * ]);</listing>
		 *
		 * <p>By default, items in the data provider support the following
		 * properties from <code>Button</code></p>
		 *
		 * <ul>
		 *     <li>label</li>
		 *     <li>defaultIcon</li>
		 *     <li>upIcon</li>
		 *     <li>downIcon</li>
		 *     <li>hoverIcon</li>
		 *     <li>disabledIcon</li>
		 *     <li>defaultSelectedIcon</li>
		 *     <li>selectedUpIcon</li>
		 *     <li>selectedDownIcon</li>
		 *     <li>selectedHoverIcon</li>
		 *     <li>selectedDisabledIcon</li>
		 *     <li>isSelected (only supported by <code>ToggleButton</code>)</li>
		 *     <li>isToggle (only supported by <code>ToggleButton</code>)</li>
		 *     <li>isEnabled</li>
		 * </ul>
		 *
		 * <p>Additionally, you can add the following event listeners:</p>
		 *
		 * <ul>
		 *     <li>Event.TRIGGERED</li>
		 *     <li>Event.CHANGE (only supported by <code>ToggleButton</code>)</li>
		 * </ul>
		 * 
		 * <p>Event listeners may have one of the following signatures:</p>
		 * <pre>function(event:Event):void</pre>
		 * <pre>function(event:Event, eventData:Object):void</pre>
		 * <pre>function(event:Event, eventData:Object, dataProviderItem:Object):void</pre>
		 *
		 * <p>To use properties and events that are only supported by
		 * <code>ToggleButton</code>, you must provide a <code>buttonFactory</code>
		 * that returns a <code>ToggleButton</code> instead of a <code>Button</code>.</p>
		 *
		 * <p>You can pass a function to the <code>buttonInitializer</code>
		 * property that can provide custom logic to interpret each item in the
		 * data provider differently. For example, you could use it to support
		 * additional properties or events.</p>
		 *
		 * @default null
		 *
		 * @see Button
		 * @see #buttonInitializer
		 */
		public function get items():ListCollection
		{
			return this._items;
		}

		/**
		 * @private
		 */
		public function set items(value:ListCollection):void
		{
			if(this._items == value)
			{
				return;
			}
			if(this._items)
			{
				this._items.removeEventListener(CollectionEvent.UPDATE_ALL, dataProvider_updateAllHandler);
				this._items.removeEventListener(CollectionEvent.UPDATE_ITEM, dataProvider_updateItemHandler);
				this._items.removeEventListener(Event.CHANGE, dataProvider_changeHandler);
			}
			this._items = value;
			if(this._items)
			{
				this._items.addEventListener(CollectionEvent.UPDATE_ALL, dataProvider_updateAllHandler);
				this._items.addEventListener(CollectionEvent.UPDATE_ITEM, dataProvider_updateItemHandler);
				this._items.addEventListener(Event.CHANGE, dataProvider_changeHandler);
			}
			callLater(refreshButtons);
		}

		/**
		 * @private
		 */
		//protected var layout:ILayout;

		

		/**
		 * @private
		 */
		protected var _direction:String = Directions.VERTICAL;

		[Inspectable(type="String",enumeration="horizontal,vertical")]
		/**
		 * The button group layout is either vertical or horizontal.
		 * 
		 * <p>If the <code>direction</code> is
		 * <code>ButtonGroup.DIRECTION_HORIZONTAL</code> and
		 * <code>distributeButtonSizes</code> is <code>false</code>, the buttons
		 * may be displayed in multiple rows, if they won't fit in one row
		 * horizontally.</p>
		 *
		 * <p>The following example sets the layout direction of the buttons
		 * to line them up horizontally:</p>
		 *
		 * <listing version="3.0">
		 * group.direction = ButtonGroup.DIRECTION_HORIZONTAL;</listing>
		 *
		 * @default ButtonGroup.DIRECTION_VERTICAL
		 *
		 * @see #DIRECTION_HORIZONTAL
		 * @see #DIRECTION_VERTICAL
		 */
		//public function get direction():String
		//{
			//return _direction;
		//}

		/**
		 * @private
		 */
		//public function set direction(value:String):void
		//{
			//if(this._direction == value)
			//{
				//return;
			//}
			//this._direction = value;
			//callLater(redraw);
		//}

		/**
		 * @private
		 */
		//protected var _distributeButtonSizes:Boolean = true;






		/**
		 * @private
		 */
		protected var _buttonFactory:Function = defaultButtonFactory;

		/**
		 * Creates a new button. A button must be an instance of <code>Button</code>.
		 * This factory can be used to change properties on the buttons when
		 * they are first created. For instance, if you are skinning Feathers
		 * components without a theme, you might use this factory to set skins
		 * and other styles on a button.
		 *
		 * <p>This function is expected to have the following signature:</p>
		 *
		 * <pre>function():Button</pre>
		 *
		 * <p>The following example skins the buttons using a custom button
		 * factory:</p>
		 *
		 * <listing version="3.0">
		 * group.buttonFactory = function():Button
		 * {
		 *     var button:Button = new Button();
		 *     button.defaultSkin = new Image( texture );
		 *     return button;
		 * };</listing>
		 *
		 * @default null
		 *
		 * @see feathers.controls.Button
		 * @see #firstButtonFactory
		 * @see #lastButtonFactory
		 */
		public function get buttonFactory():Function
		{
			return this._buttonFactory;
		}

		/**
		 * @private
		 */
		public function set buttonFactory(value:Function):void
		{
			if(this._buttonFactory == value)
			{
				return;
			}
			this._buttonFactory = value;
			callLater(redraw)
		}

		/**
		 * @private
		 */
		protected var _buttonInitializer:Function = defaultButtonInitializer;

		/**
		 * Modifies a button, perhaps by changing its label and icons, based on the
		 * item from the data provider that the button is meant to represent. The
		 * default buttonInitializer function can set the button's label and icons if
		 * <code>label</code> and/or any of the <code>Button</code> icon fields
		 * (<code>defaultIcon</code>, <code>upIcon</code>, etc.) are present in
		 * the item. You can listen to <code>Event.TRIGGERED</code> and
		 * <code>Event.CHANGE</code> by passing in functions for each.
		 *
		 * <p>This function is expected to have the following signature:</p>
		 *
		 * <pre>function( button:Button, item:Object ):void</pre>
		 *
		 * <p>The following example provides a custom button initializer:</p>
		 *
		 * <listing version="3.0">
		 * group.buttonInitializer = function( button:Button, item:Object ):void
		 * {
		 *     button.label = item.label;
		 * };</listing>
		 *
		 * @see #dataProvider
		 */
		public function get buttonInitializer():Function
		{
			return this._buttonInitializer;
		}

		/**
		 * @private
		 */
		public function set buttonInitializer(value:Function):void
		{
			if(this._buttonInitializer == value)
			{
				return;
			}
			this._buttonInitializer = value;
			callLater(redraw)
		}

		/**
		 * @inheritDoc
		 */
		//public function get baseline():Number
		//{
			//if(!this.activeButtons || this.activeButtons.length === 0)
			//{
				//return this.scaledActualHeight;
			//}
			//var firstButton:Button = this.activeButtons[0];
			//return this.scaleY * (firstButton.y + firstButton.baseline);
		//}

		/**
		 * @private
		 */
		override public function destroy():void
		{
			this.items = null;
			super.destroy();
		}

		/**
		 * @private
		 */
		override public function redraw():void
		{
			super.redraw();
		}

		/**
		 * @private
		 */


		/**
		 * @private
		 */
		protected function defaultButtonInitializer(button:Button, item:Object):void
		{
			button.dataSource = item;
			
			//button.addEventListener(MouseEvent.CLICK, onClick);
		}

		/**
		 * @private
		 */
		protected function refreshButtons():void
		{
			while(_buttons.length>0)
				_buttons.pop().remove();
			
			//var pushIndex:int = 0;
			var itemCount:int = this._items ? this._items.length : 0;
			//var lastItemIndex:int = itemCount - 1;
			
			for(var i:int = 0; i < itemCount; i++)
			{
				var item:Object = this._items.getItemAt(i);
				
				this._buttons[i] = this.createButton(item);
			}
			
			callLater(redraw);
		}

		
		/**
		 * @private
		 */
		protected function createButton(item:Object):Button
		{
			var isNewInstance:Boolean = false;
			
			var button:Button = this._buttonFactory();
				
			this.addChild(button);
			
			this._buttonInitializer(button, item);
			
			button.addEventListener(MouseEvent.CLICK, onClick);
			
			return button;
		}

		/**
		 * @private
		 */
		protected function destroyButton(button:Button):void
		{
			button.removeEventListener(MouseEvent.CLICK, onClick);
			var i:int = _buttons.indexOf(button);
			if (i)
				_buttons.splice(i, 1);
				
			button.remove();
		}

		/**
		 * @private
		 */
		//protected function layoutButtons():void
		//{
			//if(_direction==Directions.HORIZONTAL)
				//for (var i:int = 0; i < _buttons.length; i++) 
				//{
					//_buttons[i].x = i * (_buttons[i].width + gap);
					//_buttons[i].y = 0;
				//}
			//else
				//for (i = 0; i < _buttons.length; i++) 
				//{
					//_buttons[i].x =0;
					//_buttons[i].y = i * (_buttons[i].height + gap);
				//}
		//}
		


		/**
		 * @private
		 */
		//protected function childProperties_onChange(proxy:PropertyProxy, name:String):void
		//{
			//callLater(redraw);
		//}

		/**
		 * @private
		 */
		protected function dataProvider_changeHandler(event:Event):void
		{
			callLater(redraw);
		}

		/**
		 * @private
		 */
		protected function dataProvider_updateAllHandler(event:Event):void
		{
			callLater(redraw);
		}

		/**
		 * @private
		 */
		protected function dataProvider_updateItemHandler(event:Event, index:int):void
		{
			callLater(redraw);
		}

		/**
		 * @private
		 */
		protected function onClick(event:MouseEvent):void
		{
			//if this was called after dispose, ignore it
			if(!this._items)
			{
				return;
			}
			var button:Button = Button(event.currentTarget);
			var index:int = _buttons.indexOf(button);
			var item:Object = this._items.getItemAt(index);
			sendEvent(RainUIEvent.SELECT,item);
		}

		
	}
}
