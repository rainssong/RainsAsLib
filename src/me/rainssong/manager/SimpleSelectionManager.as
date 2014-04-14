package me.rainssong.manager
{
	/**
	 * 选择
	 */
	[Event(name="selectObject", type="com.codeTooth.actionscript.interaction.selection.SimpleSelectionManagerEvent")]
	
	/**
	 * 取消选择
	 */
	[Event(name="unselectObject", type="com.codeTooth.actionscript.interaction.selection.SimpleSelectionManagerEvent")]
	
	import com.codeTooth.actionscript.lang.exceptions.NullPointerException;
	import com.codeTooth.actionscript.lang.utils.destroy.IDestroy;
	import flash.display.Shape;
	
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.events.EventDispatcher;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	
	/**
	 * 简单的鼠标选择
	 */
	public class SimpleSelectionManager extends EventDispatcher 
																		implements IDestroy
	{
		/**
		 * 构造函数
		 * 
		 * @param	container 鼠标选择对象所在的容器
		 * 
		 * @throws	com.codeTooth.actionscript.lang.exceptions.NullPointerException 
		 * 指定的container是null
		 */
		public function SimpleSelectionManager(container:DisplayObjectContainer)
		{
			if (container == null)
			{
				throw new NullPointerException();
			}
			
			initializeContainer(container);
		}
		
		//---------------------------------------------------------------------------------------------------------------------------------------------------
		// 是否可用
		//---------------------------------------------------------------------------------------------------------------------------------------------------
		
		private var _enabled:Boolean = true;
		
		public function set enabled(bool:Boolean):void
		{
			_enabled = bool;
			if (!_enabled)
			{
				_container.removeEventListener(MouseEvent.MOUSE_UP, containerMouseUpHandler);
				_mouseDownObject = null;
				_listenersAdded = false;
				_container.removeEventListener(MouseEvent.MOUSE_DOWN, containerMouseDownHandler);
				removeCanvas();
			}
		}
		
		public function get enabled():Boolean
		{
			return _enabled;
		}
		
		//---------------------------------------------------------------------------------------------------------------------------------------------------
		// Bounds
		//---------------------------------------------------------------------------------------------------------------------------------------------------
		
		/**
		 * 重绘选框
		 * 
		 * @return 返回是否成功重绘
		 */
		public function redrawBounds():Boolean
		{
			if(_canvas != null && _selectableObject != null)
			{
				var bounds:Rectangle = _selectableObject.getBounds(_canvas);
				_canvas.graphics.clear();
				_canvas.graphics.lineStyle(_boundsWide, _boundsColor, _boundsAlpha);
				_canvas.graphics.drawRect(bounds.x, bounds.y, bounds.width, bounds.height);
				_canvas.graphics.endFill();
				
				return true;
			}
			else
			{
				return false;
			}
		}
		
		// Color
		private var _boundsColor:uint = 0x000000;
		
		/**
		 * 选框颜色
		 */
		public function get boundsColor():uint
		{
			return _boundsColor;
		}
		
		/**
		 * @private
		 */
		public function set boundsColor(value:uint):void
		{
			_boundsColor = value;
		}
		
		// Wide
		private var _boundsWide:Number = 2;

		/**
		 * 选框的线宽
		 */
		public function get boundsWide():Number
		{
			return _boundsWide;
		}
	
		/**
		 * @private
		 */
		public function set boundsWide(value:Number):void
		{
			_boundsWide = value;
		}

		// Alpha
		private var _boundsAlpha:Number = 1;

		/**
		 * 选框透明度
		 */
		public function get boundsAlpha():Number
		{
			return _boundsAlpha;
		}

		/**
		 * @private
		 */
		public function set boundsAlpha(value:Number):void
		{
			_boundsAlpha = value;
		}
		
		//---------------------------------------------------------------------------------------------------------------------------------------------------
		// Container
		//---------------------------------------------------------------------------------------------------------------------------------------------------
		
		private var _container:DisplayObjectContainer = null;
		
		private var _listenersAdded:Boolean = false;
		
		private var _mouseDownObject:Object = null;
		
		private var _selectableObject:Object = null;
		
		// 画选框的画布，画布被添加到容器的显示列表中
		private var _canvas:Shape = null;
		
		public function get selectabledObject():Object
		{
			return _selectableObject;
		}
		
		/**
		 * 手动取消一个当前选中的对象
		 * 
		 * @param	willDispatchEvent 是否抛出事件
		 * 
		 * @return 返回被取消选择的对象。如果当前没有被选择的对象，返回null
		 */
		public function unselectObject(willDispatchEvent:Boolean = false):Object
		{
			if(_selectableObject != null)
			{
				var obj:Object = _selectableObject;
				_selectableObject = null;
				removeCanvas();
				_listenersAdded = false;
				_container.removeEventListener(MouseEvent.MOUSE_UP, containerMouseUpHandler);
				
				if(willDispatchEvent)
				{
					dispatchEventInternal(SimpleSelectionManagerEvent.UNSELECT_OBJECT, null);
				}
				
				return obj;
			}
			else
			{
				return null;
			}
		}
		
		private function dispatchEventInternal(type:String, selectableObject:Object):void
		{
			var newEvent:SimpleSelectionManagerEvent = new SimpleSelectionManagerEvent(type);
			newEvent.selectableObject = selectableObject;
			dispatchEvent(newEvent);
		}
		
		private function getSelectableObject(target:Object):Object
		{
			while(true)
			{
				if(target == null || target == _container)
				{
					target = null;
					break;
				}
				else
				{
					if(target is ISimpleSelectable)
					{
						break;
					}
					else
					{
						if(target.parent == null)
						{
							target = null;
							break;
						}
						else
						{
							target = target.parent;
						}
					}
				}
			}
			
			return target;
		}
		
		private function containerMouseDownHandler(event:MouseEvent):void
		{	
			if (!_enabled)
			{
				return;
			}
			
			var obj:Object = getSelectableObject(event.target);
			if (_selectableObject == null)
			{
				if (obj == null)
				{
					_mouseDownObject = null;
				}
				else
				{
					_mouseDownObject = obj;
					if (!_listenersAdded)
					{
						_listenersAdded = true;
						_container.addEventListener(MouseEvent.MOUSE_UP, containerMouseUpHandler);
					}
				}
			}
			else
			{
				if (obj == null)
				{
					dispatchEventInternal(SimpleSelectionManagerEvent.UNSELECT_OBJECT, _selectableObject);
					_selectableObject = null;
					_mouseDownObject = null;
					removeCanvas();
				}
				else
				{
					if (obj != _selectableObject)
					{
						removeCanvas();
						dispatchEventInternal(SimpleSelectionManagerEvent.UNSELECT_OBJECT, _selectableObject);
						_selectableObject = null;
					}
					
					_mouseDownObject = obj;
					if (!_listenersAdded)
					{
						_listenersAdded = true;
						_container.addEventListener(MouseEvent.MOUSE_UP, containerMouseUpHandler);
					}
				}
			}
		}
		
		private function containerMouseUpHandler(event:MouseEvent):void
		{
			var obj:Object = getSelectableObject(event.target);
			if(obj == _mouseDownObject)
			{
				_canvas.x = 0;
				_canvas.y = 0;
				_container.addChild(_canvas);
				_selectableObject = _mouseDownObject;
				redrawBounds();
				dispatchEventInternal(SimpleSelectionManagerEvent.SELECT_OBJECT, _selectableObject);
			}
			
			_mouseDownObject = null;
			_listenersAdded = false;
			_container.removeEventListener(MouseEvent.MOUSE_UP, containerMouseUpHandler);
		}
		
		private function removeCanvas():void
		{
			if(_container.contains(_canvas))
			{
				_canvas.graphics.clear();
				_container.removeChild(_canvas);
			}
		}
		
		private function initializeContainer(container:DisplayObjectContainer):void
		{
			_container = container;
			_container.addEventListener(MouseEvent.MOUSE_DOWN, containerMouseDownHandler);
			_canvas = new Shape();
		}
		
		private function destroyContainer():void
		{
			if(_container != null)
			{
				removeCanvas();
				_canvas = null;
				
				_container.removeEventListener(MouseEvent.MOUSE_UP, containerMouseUpHandler)
				_container.removeEventListener(MouseEvent.MOUSE_DOWN, containerMouseDownHandler);
				_container = null;
				_selectableObject = null;
				_mouseDownObject = null;
			}
		}
		
		//---------------------------------------------------------------------------------------------------------------------------------------------------
		// 实现 IDestroy 接口
		//---------------------------------------------------------------------------------------------------------------------------------------------------
		
		/**
		 * @inheritDoc
		 */
		public function destroy():void
		{
			destroyContainer();
		}
	}
}