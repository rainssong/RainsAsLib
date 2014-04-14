package me.rainssong.manager 
{
	import com.codeTooth.actionscript.lang.exceptions.NullPointerException;
	import com.codeTooth.actionscript.lang.utils.destroy.DestroyUtil;
	import com.codeTooth.actionscript.lang.utils.destroy.IDestroy;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.InteractiveObject;
	import flash.events.Event;
	import flash.events.FocusEvent;
	import flash.events.MouseEvent;
	import flash.ui.Mouse;
	import flash.utils.Dictionary;
	
	/**
	 * 光标管理类
	 */
	public class CursorManager implements IDestroy
	{
		/**
		 * 构造函数
		 * 
		 * @param	container 鼠标事件侦听容器
		 * @param	cursorContainer 显示光标的容器
		 * 
		 * @throws	com.codeTooth.actionscript.lang.exceptions.NullPointerException 
		 * 入参container或者cursorContainer是null
		 */
		public function CursorManager(container:DisplayObjectContainer, cursorContainer:DisplayObjectContainer, updateAfterEvent:Boolean = false) 
		{
			if (container == null || cursorContainer == null)
			{
				throw new NullPointerException();
			}
			
			initializeCursors();
			initialzeContainer(container, cursorContainer);
			_updateAfterEvent = updateAfterEvent;
		}
		
		//--------------------------------------------------------------------------------------------------------------------------------
		// 光标
		//--------------------------------------------------------------------------------------------------------------------------------
		
		// 所有的光标
		private var _cursors:Dictionary = null
		
		// 默认状态下额光标
		private var _normalCursorType:String = null;
		
		// 强制刷屏
		private var _updateAfterEvent:Boolean = false;
		
		/**
		 * 强制刷屏
		 */
		public function set updateAfterEvent(bool:Boolean):void
		{
			_updateAfterEvent = bool;
		}
		
		/**
		 * @private
		 */
		public function get updateAfterEvent():Boolean
		{
			return _updateAfterEvent;
		}
		
		/**
		 * 默认状态下的光标类型
		 */
		public function set normalCursorType(type:String):void
		{
			_normalCursorType = type;
		}
		
		/**
		 * @private
		 */
		public function get normalCursorType():String
		{
			return _normalCursorType;
		}
		
		/**
		 * 添加光标
		 * 
		 * @param	type 光标的类型
		 * @param	cursor
		 * 
		 * @return 
		 */
		public function addCursor(type:String, cursor:DisplayObject):DisplayObject
		{
			_cursors[type] = cursor;
			
			if (cursor != null)
			{
				if (cursor is DisplayObjectContainer)
				{
					DisplayObjectContainer(cursor).mouseChildren = false;
				}
				if (cursor is InteractiveObject)
				{
					InteractiveObject(cursor).mouseEnabled = false;
				}
			}
			
			return cursor;
		}
		
		/**
		 * 删除光标
		 * 
		 * @param	type 指定要删除的光标类型
		 * 
		 * @return
		 */
		public function removeCursor(type:String):DisplayObject
		{
			var cursor:DisplayObject = _cursors[type];
			delete _cursors[type];
			
			return cursor;
		}
		
		private function initializeCursors():void
		{
			_cursors = new Dictionary();
		}
		
		private function destroyCursor():void
		{
			if (_cursors != null)
			{
				DestroyUtil.breakMap(_cursors);
				_cursors = null;
			}
		}
		
		//--------------------------------------------------------------------------------------------------------------------------------
		// 容器
		//--------------------------------------------------------------------------------------------------------------------------------
		
		// 事件侦听容器
		private var _container:DisplayObjectContainer = null;
		
		// 显示光标的容器
		private var _cursorContainer:DisplayObjectContainer = null;
		
		// 当前鼠标下的光标对象
		private var _target:ICursorTarget = null;
		
		// 当前显示的光标
		private var _cursor:DisplayObject = null;
		
		// 当前获得焦点的文本光标对象
		private var _tfCursor:ITextFieldCursorTarget = null;
		
		// 当前鼠标下的文本光标对象
		private var _tfCursorUnderMouse:ITextFieldCursorTarget = null;
		
		private function mouseMoveHandler(event:MouseEvent):void
		{
			var tfCursor:Object = getTarget(event.target, ITextFieldCursorTarget);
			
			// 获得当前鼠标下的文本光标对象
			if (tfCursor != null)
			{
				_tfCursorUnderMouse = ITextFieldCursorTarget(tfCursor);
			}
			else
			{
				_tfCursorUnderMouse = null;
			}
			
			// 如果
			// 当前没有文本对象获得焦点，或，
			// 当前鼠标下没有文本光标对象，或，
			// 当前鼠标下的文本光标对象不可用，或
			// 当前鼠标下的文本光标对象不是正获得焦点的那个
			// 这些情况下，显示自定义的鼠标光标
			// 否则隐藏掉自定义鼠标光标，显示默认的 I 形光标
			if(_tfCursor == null || _tfCursorUnderMouse == null || !_tfCursorUnderMouse.underCursorManagerControl || _tfCursor != tfCursor)
			{
				// 获得当前鼠标下的实现了光标接口的对象
				var target:Object = getTarget(event.target, ICursorTarget);
				
				// 如果找到了光标接口对象
				if (target != null)
				{
					// 且和上次找到的不是同一个
					if (target != _target)
					{
						_target = ICursorTarget(target);
						
						// 且也能找到对应的光标
						if (_cursors[_target.cursorType] != null)
						{
							removeCurrentCursor();
							_cursor = _cursors[_target.cursorType];
							_cursorContainer.addChild(_cursor);
						}
					}
				}
				else
				{	
					// 没有找到设定的默认光标
					if (_cursors[_normalCursorType] == null)
					{	
						removeCurrentCursor();
						_target = null;
					}
					else
					{
						// 当前的还不是默认光标，如果已经是了就不用再换光标了
						if (_cursor != _cursors[_normalCursorType])
						{
							removeCurrentCursor();
							_cursor = _cursors[_normalCursorType];
							_cursorContainer.addChild(_cursor);
							_target = null;
						}
					}
				}
				
				if (_cursor != null)
				{
					// 更新光标的位置
					_cursor.x = _cursorContainer.mouseX;
					_cursor.y = _cursorContainer.mouseY;
					
					if (_updateAfterEvent)
					{
						event.updateAfterEvent();
					}
					
					Mouse.hide();
				}
				else
				{
					Mouse.show();
				}
			}
			else
			{
				removeCurrentCursor();
				_target = null;
			}
		}
		
		// 有对象获得或失去了焦点
		private function focusHandler(event:FocusEvent):void
		{
			var target:Object = getTarget(event.target, ITextFieldCursorTarget);
			// 看看是不是文本焦点对象
			// 把获得焦点的文本焦点对象设为可选，这样鼠标划过的时候会显示 I 形光标
			// 把失去焦点的文本焦点对象设为不可选，鼠标划过时不显示 I 形光标
			if (target != null)
			{
				var tf:ITextFieldCursorTarget = ITextFieldCursorTarget(target);
				if (tf.underCursorManagerControl)
				{
					if (event.type == FocusEvent.FOCUS_IN)
					{
						tf.selected = true;
						_tfCursor = tf;
						
						if (_tfCursorUnderMouse != null && _tfCursorUnderMouse == _tfCursor)
						{
							removeCurrentCursor();
						}
					}
					else if(event.type == FocusEvent.FOCUS_OUT)
					{
						tf.selected = false;
						_tfCursor = null;
					}
					else
					{
						// Do nothing
					}
				}
				else
				{
					_tfCursor = null;
				}
			}
		}
		
		private function mouseLeaveHandler(event:Event):void
		{
			removeCurrentCursor();
			_target = null;
		}
		
		private function removeCurrentCursor():void
		{
			if (_cursor != null)
			{
				_cursorContainer.removeChild(_cursor);
				_cursor = null;
			}
		}
		
		// 迭代显示列表，向上找到指定类型的对象
		private function getTarget(target:Object, definition:Class):Object
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
					if(target is definition)
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
		
		private function initialzeContainer(container:DisplayObjectContainer, cursorContainer:DisplayObjectContainer):void
		{
			_cursorContainer = cursorContainer;
			_cursorContainer.mouseChildren = false;
			_cursorContainer.mouseEnabled = false;
			_container = container;
			_container.addEventListener(MouseEvent.MOUSE_MOVE, mouseMoveHandler);
			_container.addEventListener(Event.MOUSE_LEAVE, mouseLeaveHandler);
			_container.addEventListener(FocusEvent.FOCUS_IN, focusHandler);
			_container.addEventListener(FocusEvent.FOCUS_OUT, focusHandler);
		}
		
		private function destroyContainer():void
		{
			if (_container != null)
			{
				removeCurrentCursor();
				_container.removeEventListener(MouseEvent.MOUSE_MOVE, mouseMoveHandler);
				_container.removeEventListener(Event.MOUSE_LEAVE, mouseLeaveHandler);
				_container.removeEventListener(FocusEvent.FOCUS_IN, focusHandler);
				_container.removeEventListener(FocusEvent.FOCUS_OUT, focusHandler);
				_container = null;
				_tfCursor = null;
				_tfCursorUnderMouse = null;
				_cursor = null;
			}
		}
		
		//--------------------------------------------------------------------------------------------------------------------------------
		// 实现 IDestroy 接口
		//--------------------------------------------------------------------------------------------------------------------------------
		
		public function destroy():void
		{
			destroyContainer();
			destroyCursor();
		}
	}

}