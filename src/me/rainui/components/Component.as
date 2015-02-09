package me.rainui.components
{
	import flash.display.DisplayObject;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Rectangle;
	import me.rainui.events.RainUIEvent;
	import me.rainui.RainUI;
	
	/**
	 * ...
	 * @author Rainssong
	 * @timeStamp 2014/5/12 11:24
	 * @blog http://blog.sina.com.cn/rainssong
	 */
	public class Component extends Sprite
	{
		protected var _width:Number = NaN;
		
		protected var _height:Number = NaN;
		
		protected var _disabled:Boolean = false;
		
		protected var _dataSource:Object;
		
		protected var _mouseChildren:Boolean = false;
		protected var _mouseEnabled:Boolean = false;
		
		//只能等比缩放
		protected var _scaleLock:Boolean = false;
		
		protected var _border:Shape = new Shape();
		protected var _borderVisible:Boolean = false;
		
		protected var _autoSize:Boolean = false;
		
		protected var _bgSkin:DisplayObject;
		
		public function Component(dataSource:Object=null)
		{
			this.dataSource = dataSource;
			mouseChildren = tabEnabled = tabChildren = false;
			preinitialize();
			createChildren();
			initialize();
		
		}
		
		protected function initialize():void
		{
			
		}
		
		protected function createChildren():void
		{
			if (bgSkin == null)
			{
				bgSkin = new Shape();
				addChild(bgSkin);
			}
		}
		
		protected function preinitialize():void
		{
			//_width = 100;
			//_height = 100;
		}
		
		public function callLater(method:Function, args:Array = null):void
		{
			if (RainUI.render)
				RainUI.render.callLater(method, args);
			else
				method.apply(this, args);
		}
		
		public function exeCallLater(method:Function):void
		{
			if (RainUI.render)
				RainUI.render.exeCallLater(method);
			else
				method.apply(this);
		}
		
		public function clearCallLater(method:Function):void
		{
			if (RainUI.render)
				RainUI.render.clearCallLater(method);
		}
		
		
		public function sendEvent(type:String, data:* = null):void
		{
			if (hasEventListener(type))
				dispatchEvent(new RainUIEvent(type, data));
		}
		
		public function remove():void
		{
			if (parent)
				parent.removeChild(this);
		}
		
		public function removeChildByName(name:String):void
		{
			var display:DisplayObject = getChildByName(name);
			if (display)
				removeChild(display);
		}
		
		public function setPostion(x:Number, y:Number):void
		{
			this.x = x;
			this.y = y;
		}
		
		override public function set x(value:Number):void
		{
			super.x = Math.round(value);
			callLater(sendEvent, [RainUIEvent.MOVE]);
		}
		
		override public function set y(value:Number):void
		{
			super.y = Math.round(value);
			callLater(sendEvent, [RainUIEvent.MOVE]);
		}
		
		public function get contentX():Number
		{
			return this.getBounds(this).x;
		}
		
		public function get contentY():Number
		{
			return this.getBounds(this).y;
		}
		
		public function get displayWidth():Number
		{
			return width * scaleX;
		}
		
		override public function get width():Number
		{
			if (!isNaN(_width))
			{
				return _width;
			}
			//else if (_contentWidth != 0)
			//{
				//return _contentWidth;
			//}
			else
			{
				return contentWidth;
			}
		}
		
		override public function set width(value:Number):void
		{
			if (_width != value)
			{
				_width = value;
				callLater(resize);
			}
		}
		
		public function get contentWidth():Number
		{
			//var max:Number = 0;
			//for (var i:int = numChildren - 1; i > -1; i--)
			//{
				//var comp:DisplayObject = getChildAt(i);
				//if (comp.visible)
					//max = Math.max(comp.x + comp.width * comp.scaleX, max);
			//}
			//
			//return max;
			return this.getBounds(this).width
		}
		
		
		
		/**高度(值为NaN时，高度为自适应大小)*/
		override public function get height():Number
		{
			if (!isNaN(_height))
			{
				return _height;
			}
			//else if (_contentHeight != 0)
			//{
				//return _contentHeight;
			//}
			else
			{
				return contentHeight;
			}
		}
		
		override public function set height(value:Number):void
		{
			if (_height != value)
			{
				_height = value;
				callLater(resize);
			}
		}
		
		/**显示的高度(height * scaleY)*/
		public function get displayHeight():Number
		{
			return height * scaleY;
		}
		
		public function get contentHeight():Number
		{
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
			//return this.getBounds(this).height;
		}
		
		
		
		override public function set scaleX(value:Number):void
		{
			super.scaleX = value;
			//callLater(resize);
		}
		
		override public function set scaleY(value:Number):void
		{
			super.scaleY = value;
			//callLater(resize);
		}
		
		public function set scaleXY(value:Number):void
		{
			super.scaleX = super.scaleY = value;
			callLater(resize);
		}
		
		public function get scaleXY():Number
		{
			return scaleX;
		}
		
		//尺寸改变后调用
		//TODO:super.resize必须在底部，否则可能导致border和bgSkin宽高不正确
		public function resize():void
		{
			clearCallLater(resize);
			if (_bgSkin)
			{
				_bgSkin.width = _width;
				_bgSkin.height = _height;
			}
			
			sendEvent(Event.RESIZE);
			
			if(_borderVisible)
				showBorder();
		}
		
		//更新视图
		
		public function redraw():void
		{
			clearCallLater(redraw);
			resize();
		}
		
		public function setSize(width:Number, height:Number):void
		{
			this.width = width;
			this.height = height;
		}
		
		[Inspectable(name="disabled",type="Bealoon",defaultValue=false)]
		public function set disabled(value:Boolean):void
		{
			if (_disabled != value)
				_disabled = value;
			mouseEnabled = !value;
			super.mouseChildren = value ? false : _mouseChildren;
			//ObjectUtils.gray(this, _disabled);
		}
		
		public function get disabled():Boolean
		{
			return _disabled;
		}
		
		override public function set mouseChildren(value:Boolean):void
		{
			_mouseChildren = super.mouseChildren = value;
		}
		
		public function showBorder(color:uint = 0xff0000,conetntColor:int = -1):void
		{
			_border.graphics.clear();
			_border.graphics.lineStyle(1, color);
			_border.graphics.drawRect(0, 0, width, height);
			
			if (conetntColor > 0)
			{
				var contentRect:Rectangle = getBounds(this);
				_border.graphics.lineStyle(1, conetntColor);
				_border.graphics.drawRect(contentRect.x, contentRect.y, contentRect.width, contentRect.height);
			}
			
			addChild(_border);
		}
		
		public function hideBorder():void
		{
			if(_border && _border.parent)
				removeChild(_border);
		}
		
		public function get dataSource():Object
		{
			return _dataSource;
		}
		
		public function set dataSource(value:Object):void
		{
			_dataSource = value;
			for (var prop:String in _dataSource)
			{
				if (hasOwnProperty(prop))
				{
					this[prop] = _dataSource[prop];
				}
			}
		}
		
		public function get autoSize():Boolean 
		{
			return _autoSize;
		}
		
		public function set autoSize(value:Boolean):void 
		{
			_autoSize = value;
			callLater(resize);
		}
		
		public function get borderVisible():Boolean 
		{
			return _borderVisible;
		}
		
		public function set borderVisible(value:Boolean):void 
		{
			_borderVisible = value;
			if(value)
				showBorder();
			else
				hideBorder();
		}
		
		public function get bgSkin():DisplayObject 
		{
			return _bgSkin;
		}
		
		
		public function set bgSkin(value:DisplayObject):void 
		{
			//swapContent(_bgSkin, value);
			if (_bgSkin == value) return;
			if (_bgSkin && _bgSkin.parent)
			{
				_bgSkin.parent.removeChild(_bgSkin)
			}
			addChildAt(value, 0);
			_bgSkin = value;
			callLater(redraw);
		}
		
		public function swapContent(oldCon:DisplayObject, newCon:DisplayObject):DisplayObject
		{
			var index:int = this.numChildren
			if (oldCon && oldCon.parent)
			{
				index= getChildIndex(oldCon);
				oldCon.parent.removeChild(oldCon)
			}
			addChildAt(newCon, index);
			return newCon;
		}
		
		
		public function destroy():void
		{
			this.removeChildren();
		}
		
		
		
	
	}
}