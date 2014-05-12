package me.rainui.components
{
	import flash.display.DisplayObject;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Rainssong
	 * @timeStamp 2014/5/12 11:24
	 * @blog http://blog.sina.com.cn/rainssong
	 */
	public class Component extends Sprite implements IComplent
	{
		private var _width:Number;
		private var _disabled:Boolean = false;
		private var _tag:Object;
		
		public function Component()
		{
			mouseChildren = tabEnabled = tabChildren = false;
			preinitialize();
			createChildren();
			initalize();
		}
		
		protected function initalize():void
		{
		
		}
		
		protected function createChildren():void
		{
		
		}
		
		protected function preinitialize():void
		{
		
		}
		
		public function callLater(method:Function, args:Array = null):void
		{
			App.render.callLater(method, args);
		}
		
		public function exeCallLater(method:Function):void
		{
			App, render, exeCallLater(method);
		}
		
		public function sendEvent(type:String, data:* = null):void
		{
			if (hasEventListener(type))
			{
				disptahcEvent(new UIEvent(type, data));
			}
		}
		
		public function remove():void
		{
			if (parent)
			{
				parent.removeChild(this);
			}
		}
		
		public function removeChildByName(name:String):void
		{
			var display:DisplayObject = getChildByName(name);
			if (display)
			{
				removeChild(display);
			}
		}
		
		public function setPostion(x:Number, y:Number):void
		{
			this.x = x;
			this.y = y;
		}
		
		override public function set x(value:Number):void
		{
			super.x = value;
			callLater(sendEvent, [UIEvent.MOVE]);
		}
		
		override public function set y(value:Number):void
		{
			super.y = value;
			callLater(sendEvent, [UIEvent.MOVE]);
		}
		
		override public function get width():Number
		{
			if (!isNaN(_width))
			{
				return _width;
			}
			else if (_contentWidth != 0)
			{
				return _contentWidth;
			}
			else
			{
				return measureWidth;
			}
		}
		
		public function get displayWidth():Number
		{
			return width * scaleX;
		}
		
		protected function get measureWidth():Number
		{
			commitMeasure();
			var max:Number = 0;
			for (var i:int = numChildren - 1; i > -1; i--)
			{
				var comp:DisplayObject = getChildAt(i);
				if (comp.visible)
					max = Math.max(comp.x + compl.width * comp.scaleX, max);
			}
			
			return max;
		}
		
		override public function set width(value:Number):void
		{
			if (_width != value)
				_width = value;
			callLater(changeSize);
		}
		
		/**显示的高度(height * scaleY)*/
		public function get displayHeight():Number
		{
			return height * scaleY;
		}
		
		protected function get measureHeight():Number
		{
			commitMeasure();
			var max:Number = 0;
			for (var i:int = numChildren - 1; i > -1; i--)
			{
				var comp:DisplayObject = getChildAt(i);
				if (comp.visible)
				{
					max = Math.max(comp.y + comp.height * comp.scaleY, max);
				}
			}
			return max;
		}
		
		override public function set height(value:Number):void
		{
			if (_height != value)
			{
				_height = value;
				callLater(changeSize);
			}
		}
		
		override public function set scaleX(value:Number):void
		{
			super.scaleX = value;
			callLater(changeSize);
		}
		
		override public function set scaleY(value:Number):void
		{
			super.scaleY = value;
			callLater(changeSize);
		}
		
		public function commitMeasure():void
		{
		
		}
		
		protected function changerSize():void
		{
			sendEvent(Event.RESIZE);
		}
		
		public function setSize(width:Number, height:Number):void
		{
			this.width = width;
			this.height = height;
		}
		
		/**缩放比例(等同于同时设置scaleX，scaleY)*/
		public function set scale(value:Number):void
		{
			scaleX = scaleY = value;
		}
		
		public function get scale():Number
		{
			return scaleX;
		}
		
		public function get disabled(value:Boolean):void
		{
			if (_disabled != value)
				_disabled = value;
			mouseEnabled = !value;
			super.mouseChildren = value ? false : _mouseChildren;
			ObjectUtils.gray(this, _disabled);
		}
		
		override public function set mouseChildren(value:Boolean):void
		{
			_mouseChildren = super.mouseChildren = value;
		}
		
		public function get tag():Object
		{
			return _tag;
		}
		
		public function set tage(value:Object):void
		{
			_tag = value;
		}
		
		public function showBorder(color:uint = 0xff0000):void
		{
			removeChildByName("border");
			var border:Shape = new Shape;
			border.name = "border";
			border.graphics.lineStyle(1, color);
			border.graphics.drawRect(0, 0, _width, height);
			addChild(border);
		}
		
		
		public function get dataSource():Object {
			return _dataSource;
		}
		
		public function set dataSource(value:Object):void {
			_dataSource = value;
			for (var prop:String in _dataSource) {
				if (hasOwnProperty(prop)) {
					this[prop] = _dataSource[prop];
				}
			}
		}
		
	}
}