package me.rainui.components
{
	import adobe.utils.CustomActions;
	import com.adobe.protocols.dict.events.DefinitionHeaderEvent;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.IEventDispatcher;
	import flash.filters.ColorMatrixFilter;
	import flash.geom.Rectangle;
	import flash.utils.Dictionary;
	import me.rainssong.manager.ListenerManager;
	import me.rainssong.model.ListenerModel;
	import me.rainui.events.RainUIEvent;
	import me.rainui.RainUI;
	import me.rainui.utils.ScaleMethod;
	
	/**
	 * ...
	 * @author Rainssong
	 * @timeStamp 2014/5/12 11:24
	 * @blog http://blog.sina.com.cn/rainssong
	 */
	dynamic public class Component extends Sprite
	{
		//绝对像素
		protected var _width:Number = NaN;
		protected var _height:Number = NaN;
		
		
		protected var _autoSize:Boolean = false;
		
		//stats
		protected var _disabled:Boolean = false;
		protected var _mouseChildren:Boolean = false;
		protected var _mouseEnabled:Boolean = true;
		
		//只能等比缩放
		//protected var _scaleLock:Boolean = false;
		
		//display
		protected var _border:Shape=new Shape();
		protected var _borderVisible:Boolean = false;
		protected var _bgSkin:DisplayObject;
		
		protected var _dataSource:Object;
		public static var defaultData:Object;
		
		protected var _listeners:Vector.<ListenerModel>=new Vector.<ListenerModel>
		
		
		
		protected var _autoExpand:Boolean = false;
		protected var _autoShrink:Boolean = false;
		
		public static var defaultStyleFactory:Function;
		
		protected var _styleFactory:Function;
		
		protected var _styleName:String = "Component";
		
		protected var _destroyed:Boolean = false;
		
		
		
		public function Component(dataSource:Object=null)
		{
			super();
			mouseChildren = tabEnabled = tabChildren = false;
			preinitialize();
			createChildren();
			initialize();
			this.dataSource = dataSource;
		}
		
		protected  function addExternalListener(target:IEventDispatcher,type:String, listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false):void
		{
			var lm:ListenerModel=new ListenerModel(target,type, listener, useCapture, priority, useWeakReference)
			lm.add()
			_listeners.push ( lm);
		}
		
		override public function addEventListener(type:String, listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false):void 
		{
			_listeners.push ( new ListenerModel(this,type, listener, useCapture, priority, useWeakReference));
			//_listeners[type+listener] = new ListenerModel(type, listener, useCapture, priority, useWeakReference);
			super.addEventListener(type, listener, useCapture, priority, useWeakReference);
		}
		
		override public function removeEventListener(type:String, listener:Function, useCapture:Boolean = false):void 
		{
			//delete _listeners[type];
			//super.removeEventListener(type, listener, useCapture);
			for (var i:int = _listeners.length-1; i >=0; i--) 
			{
				var lm:ListenerModel=_listeners[i]
				if (lm.type == type && lm.listener == listener && lm.useCapture == useCapture)
					_listeners.splice(i, 1);
			}
			super.removeEventListener(type, listener, useCapture);
		}
		
		/**
		 * 无target则全部清除
		 * @param	target
		 */
		public function removeAllEventListener(target:IEventDispatcher=null):void 
		{
			//for each (var item:ListenerModel in _listeners) 
				//removeEventListener(item.type, item.listener, item.useCapture);
			for (var i:int = _listeners.length-1; i >=0; i--) 
			{
				var lm:ListenerModel = _listeners[i];
				if(target==null || target ==lm.target)
					lm.target.removeEventListener(lm.type, lm.listener, lm.useCapture);
			}
		}
		
		protected function preinitialize():void
		{
			//_width = 100;
			//_height = 100;
			
			
		}
		
		protected function createChildren():void
		{
			if (_bgSkin == null)
			{
				_bgSkin = RainUI.getSkin("bg");
				_bgSkin.visible = false;
			}
			else
			{
				//BUG:将bgSkin对宽高的优先级不应是最高。
			}
			addChildAt(_bgSkin, 0);
			
		}
		
		protected function initialize():void
		{
			//2017-05-21:styleFactory优先级相对于默认低，但是比createChildren高
			if (styleFactory != null )
				styleFactory(this);
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
		
		public function sendEvent(type:String, data:* = null,bubbles:Boolean=false, cancelable:Boolean=false):void
		{
			if (hasEventListener(type))
				dispatchEvent(new RainUIEvent(type, data,bubbles,cancelable));
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
			//super.x = Math.round(value);
			super.x = value
			callLater(sendEvent, [RainUIEvent.MOVE]);
		}
		
		override public function set y(value:Number):void
		{
			//super.y = Math.round(value);
			super.y = value;
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
			
			return this.getBounds(this).width*scaleX;
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
			//var max:Number = 0;
			//for (var i:int = numChildren - 1; i > -1; i--)
			//{
				//var comp:DisplayObject = getChildAt(i);
				//if (comp && comp.visible)
				//{
					//max = Math.max(comp.y + comp.height * comp.scaleY, max);
				//}
			//}
			//return max;
			return this.getBounds(this).height*scaleY;
		}
		
		
		
		override public function set scaleX(value:Number):void
		{
			super.scaleX = value;
			sendEvent(Event.RESIZE);
		}
		
		override public function set scaleY(value:Number):void
		{
			super.scaleY = value;
			sendEvent(Event.RESIZE);
		}
		
		public function set scaleXY(value:Number):void
		{
			super.scaleX = super.scaleY = value;
			//callLater(resize);
		}
		
		public function get scaleXY():Number
		{
			return scaleX;
		}
		
		public function calcSize():void
		{
			
		}
		
		/**
		 * 尺寸改变后调用
		 * TIP:super.resize必须在底部，否则可能导致border和bgSkin宽高不正确
		**/
		public function resize():void
		{
			if (_bgSkin)
			{
				_bgSkin.width = _width;
				_bgSkin.height = _height;
			}
			
			if(_borderVisible)
				showBorder();
			
			//powerTrace(this,"dispatch resize")
			//sendEvent(Event.RESIZE);
			dispatchEvent(new Event(Event.RESIZE,true, false));
			
			clearCallLater(resize);
		}
		
		//更新视图
		
		public function redraw():void
		{
			clearCallLater(redraw);
			calcSize();
		}
		
		public function setSize(width:Number, height:Number):void
		{
			this.width = width;
			this.height = height;
		}
		
		[Inspectable(name="disabled",type="Boolean",defaultValue=false)]
		public function set disabled(value:Boolean):void
		{
			if (_disabled != value)
				_disabled = value;
			mouseEnabled =value ? false : _mouseEnabled;
			super.mouseChildren = value ? false : _mouseChildren;
			
			//BUG: change filters
			if (value)
			{
				this.filters = [ new ColorMatrixFilter([.33, .33, .33, 0, 0, .33, .33, .33, 0, 0, .33, .33, .33, 0, 0, 0, 0, 0, 1, 0])];
			}
			else
			{
				this.filters = [];
			}
			//ObjectUtils.gray(this, _disabled);
		}
		
		public function get disabled():Boolean
		{
			return _disabled;
		}
		
		[Inspectable(name="mouseChildren",type="Boolean",defaultValue=false)]
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
		
		[Inspectable(name="autoSize",type="Boolean",defaultValue=false)]
		public function set autoSize(value:Boolean):void 
		{
			_autoSize = value;
			callLater(resize);
		}
		
		public function get borderVisible():Boolean 
		{
			return _borderVisible;
		}
		
		[Inspectable(name="borderVisible",type="Boolean",defaultValue=false)]
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
				_bgSkin.parent.removeChild(_bgSkin)
			addChildAt(value, 0);
			_bgSkin = value;
			
			callLater(resize);
		}
		
		//FIXME:not really swap when oldView has no parent
		public function swapContent(oldCon:DisplayObject, newCon:DisplayObject):DisplayObject
		{
			var index:int = this.numChildren
			if (oldCon && oldCon.parent)
			{
				index = getChildIndex(oldCon);
				addChildAt(newCon, index);
				oldCon.parent.removeChild(oldCon)
			}
			else if(newCon && newCon.parent!=this)
				addChildAt(newCon, index);
			return newCon;
		}
		
		public function destroy():void
		{
			removeAllEventListener();
			this.removeChildren();
			_destroyed = true;
		}
		
		public function set parent(target:DisplayObjectContainer):void
		{
			//powerTrace(target + "add" + this);
			target.addChild(this);
		}
		
		public function get styleFactory():Function 
		{
			return _styleFactory || defaultStyleFactory;
		}
		
		public function set styleFactory(value:Function):void 
		{
			_styleFactory = value;
		}
		
		public function get destroyed():Boolean 
		{
			return _destroyed;
		}
		
		
		
		
	
	}
}