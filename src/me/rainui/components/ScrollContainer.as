package me.rainui.components 
{
	import com.greensock.motionPaths.Direction;
	import flash.display.DisplayObject;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	import me.rainssong.utils.Directions;
	import me.rainssong.utils.Draw;
	import me.rainui.RainTheme;
	/**
	 * ...
	 * @author Rainssong
	 */
	public class ScrollContainer extends Container 
	{
		static public const HORIZONTAL:String = "horizontal";
		static public const VERTICAL:String = "vertical";
		static public const ALL:String = "all";
		
		static public var elasticCoefficient:Number = 0.5;

		protected var _content:DisplayObject
		protected var _container:Container=new Container();
		protected var _scrollY:Number = 0;
		protected var _scrollX:Number = 0;
		protected var _onDrag:Boolean = false;
		protected var _startX:Number = 0;
		protected var _lastX:Number = 0;
		protected var _speedX:Number = 0;
		protected var _startY:Number = 0;
		protected var _lastY:Number = 0;
		protected var _speedY:Number = 0;
		public var direction:String = ALL;
		//public var lockDirection:Boolean = true;
		public var allowOverload:Boolean = true;
		public var touchScroll:Boolean = true;
		
		
		protected var _mouseWheelScrollDirection:String = ALL;
		protected var _mouseWheelScrollStep:Number = 5;
		
		
		protected var _hasHorizontalScrollBar:Boolean = true;
		public var horizontalScrollBar:SimpleScrollBar;
		protected var _hasVerticalScrollBar:Boolean = true;
		public var verticalScrollBar:SimpleScrollBar;
		
		public function ScrollContainer(content:DisplayObject=null,dataSource:Object=null) 
		{
			super(dataSource);
			this.content=content;
		}
		
		override protected function preinitialize():void 
		{
			super.preinitialize();
			this._width = 400;
			this._height = 400;
			
		}
		
		override protected function createChildren():void 
		{
			//_container = new Container();
			
			//Bug：在获取内容之前，会将bgSkin作为Contnet
			//if (this.numChildren == 1)
			//{
				//this._content = this.getChildAt(0);
			//}
			
			_container.percentWidth = 1;
			_container.percentHeight = 1;
			addChild(_container);
			
			horizontalScrollBar = new SimpleScrollBar();
			horizontalScrollBar.direction = Directions.HORIZONTAL;
			horizontalScrollBar.percentWidth = 1;
			horizontalScrollBar.bottom = 0;
			
			verticalScrollBar = new SimpleScrollBar();
			verticalScrollBar.direction = Directions.VERTICAL;
			verticalScrollBar.percentHeight = 1;
			verticalScrollBar.right = 0;
			
			addChild(horizontalScrollBar)
			addChild(verticalScrollBar)
			
			if (_content)
			{
				addContent(_content);
				this._width = _content.width
				this._height = _content.height;
			}
			
			if (_bgSkin == null)
			{
				var shape:Sprite = new Sprite();
				Draw.rect(shape, 0, 0, _width, _height,RainTheme.WHITE);
				_bgSkin = shape;
				_bgSkin.alpha = 0;
			}
			//else
			//{
				//this._width = _bgSkin.width;
				//this._height = _bgSkin.height;
			//}
			
			//要更新滚动条
			//redraw();
			super.createChildren();
			
			callLater(redraw);
		}
		
		override protected function initialize():void 
		{
			super.initialize();
			addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
			addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
			addEventListener(MouseEvent.RELEASE_OUTSIDE, onMouseUp);
			addEventListener(MouseEvent.MOUSE_WHEEL, onMouseWheel);
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
			this.scrollRect = new Rectangle(0, 0, _width, _height);
		}
		
		override public function redraw():void 
		{

			if (verticalScrollBar != null && content!=null)
			{
				verticalScrollBar.page = this.height;
				verticalScrollBar.minimum = 0;
				verticalScrollBar.maximum = content.height;
			}
			if (horizontalScrollBar != null && content!=null)
			{
				horizontalScrollBar.page = this.width;
				horizontalScrollBar.minimum = 0;
				horizontalScrollBar.maximum = content.width;
			}
			
			
			horizontalScrollBar.visible=(direction == Directions.HORIZONTAL ||  direction == Directions.ANY ) && _hasHorizontalScrollBar && (_width<_container.contentWidth)
			verticalScrollBar.visible=(direction == Directions.VERTICAL ||  direction == Directions.ANY) && _hasVerticalScrollBar && (_height<_container.contentHeight)
			
			super.redraw();
		}
		
		private function onMouseWheel(e:MouseEvent):void 
		{
			if (_mouseWheelScrollDirection == VERTICAL)
				_speedY += e.delta * _mouseWheelScrollStep;
			else if (_mouseWheelScrollDirection == HORIZONTAL)
				_speedX += e.delta * _mouseWheelScrollStep;
			else
			{
				if (_container.contentWidth <= _width+10)
					_speedY += e.delta * _mouseWheelScrollStep;
				else
					_speedX += e.delta * _mouseWheelScrollStep;
			}
				
				
		}
		
		private function onEnterFrame(e:Event):void 
		{
			if (_onDrag)
				onDrag();
			else
				offDrag();
				
				
				
			if (verticalScrollBar != null && _container!=null)
			{
				verticalScrollBar.value = -_container.y/(_container.contentHeight-this.height)*_container.contentHeight;
			}
			
			if (horizontalScrollBar != null && _container!=null)
			{
				horizontalScrollBar.value = -_container.x/(_container.contentWidth-this.width)*_container.contentWidth;
			}
				
			//powerTrace(_container.x, _container.y);
		}
		
		public function onDrag():void 
		{
			_speedX = mouseX - _lastX;
			_speedY = mouseY - _lastY;
			_lastX = mouseX;
			_lastY = mouseY;
			
			var distanceX:Number = mouseX - _startX;
			var distanceY:Number = mouseY - _startY;
			if (Math.abs(distanceX) > 5 || Math.abs(distanceY) > 5)
				_container.mouseChildren = false;
			
			var _overloadY:Number = overloadY;
			var _overloadX:Number = overloadX;
			
			//var rect:Rectangle = _container.scrollRect;
			//rect.y += _speedX;
			//rect.x += _speedX;
			
			if (_overloadY * _speedY > 0)
			{
				_speedY *= 0.5;
			}
			if (_overloadX * _speedX > 0)
			{
				_speedX *= 0.5;
			}
			
			if(direction!=HORIZONTAL)
				_container.y += _speedY;
			if(direction!=VERTICAL)
				_container.x += _speedX;
			//_container.scrollRect = rect;
		}
		
		public function offDrag():void 
		{
			var _overloadY:Number = overloadY;
			var _overloadX:Number = overloadX;
			
			//powerTrace(_overloadX.toFixed(0),_overloadY.toFixed(0));
			
			if (_overloadY!=0)
			{
				//超载增加
				if (_overloadY * _speedY > 0)
				{
					_speedY += _overloadY * -0.5;
				}
				//回归
				else
				{
					
					_speedY = _overloadY * -0.5;
				}
			}
			//无超载
			else
				_speedY *= 0.9;
				
			if (_overloadX!=0)
			{
				//超载增加
				if (_overloadX * _speedX > 0)
				{
					_speedX += _overloadX * -0.5;
				}
				//回归
				else
				{
					_speedX = _overloadX * -0.5;
				}
			}
			//无超载
			else
				_speedX *= 0.9;
			
			
			if (Math.abs(_speedY) < 0.5)
			{
				_speedY = 0;
			}
			if (Math.abs(_speedX) < 0.5)
			{
				_speedX = 0;
			}
			
			if(direction!=HORIZONTAL)
				if (_overloadY<=1 && _overloadY>=-1 && _overloadY!=0)
					_container.y -= _overloadY;
				else
					_container.y += _speedY;
			
			if(direction!=VERTICAL)
				if (_overloadX<=1 && _overloadX>-1 && _overloadX!=0)
					_container.x -= _overloadX;
				else
					_container.x += _speedX;
				
			//rect.y += _speedX;
			//rect.x += _speedX;
			//_container.x += _speedX;
			//_container.y += _speedY;
			//_container.scrollRect = rect;
		}
		
		private function onMouseUp(e:MouseEvent):void 
		{
			_onDrag = false;
			_container.mouseChildren = true;
		}
		
		override public function stopDrag():void 
		{
			_onDrag = false;
			_container.mouseChildren = true;
		}
		
		private function onMouseDown(e:MouseEvent):void 
		{
			_startX = mouseX;
			_startY = mouseY;
			_lastX = mouseX;
			_lastY = mouseY;
			
			if(touchScroll)
				_onDrag = true;
		}
		
		override public function startDrag(lockCenter:Boolean=false, bounds:Rectangle=null):void 
		{
			_startX = mouseX;
			_startY = mouseY;
			_lastX = mouseX;
			_lastY = mouseY;
			
			_onDrag = true;
		}
		
		
		//override public function addChild(child:DisplayObject):DisplayObject 
		//{
			//_container.addChild(child);
			//var rect:Rectangle = _container.getRect(this);
			//return child;
		//}
		
		public function addContent(child:DisplayObject):DisplayObject
		{
			return _container.addChild(child);
		}
		
		public function removeContent(child:DisplayObject):DisplayObject 
		{
			return _container.removeChild(child);
		}
		
		public function removeContentAt(index:int):DisplayObject 
		{
			return _container.removeChildAt(index);
		}
		
		public function removeAllContent(exceptIndex:int):void 
		{
			_container.removeAllChild();
		}
		
		public function get overloadX():Number
		{
			if (_container.x < 0 && _container.contentWidth+_container.x <_width)
			{
				return Math.max(_container.contentWidth+_container.x - _width,_container.x);
			}
			if (_container.x >0 && _container.contentWidth+_container.x >_width)
			{
				return Math.min(_container.contentWidth+_container.x - _width,_container.x);
			}
			return 0;
		}
		
		public function get overloadY():Number
		{
			if (_container.y < 0 && _container.contentHeight+_container.y <_height)
			{
				return Math.max(_container.contentHeight+_container.y -_height ,_container.y);
			}
			if (_container.y >0 && _container.contentHeight+_container.y >_height)
			{
				return Math.min(_container.contentHeight+_container.y -_height ,_container.y);
			}
			return 0;
		}
		
		public function get content():DisplayObject 
		{
			return _content;
		}
		
		public function set content(value:DisplayObject):void 
		{
			if (value == null)
				return;
			if (_content != value)
			{
				if (_content != null && _content.parent)
					removeContent(_content)
			}
			_content = value;
			addContent(_content);
			
			callLater(redraw);
		}
		
		public function get container():Container 
		{
			return _container;
		}
		
		public function get scrollY():Number 
		{
			return -_container.y;
		}
		
		public function set scrollY(value:Number):void 
		{
			_container.y=-value;
		}
		
		public function get maxScrollY():Number 
		{
			return _container.contentHeight -_height ;
		}
		
		public function get scrollX():Number 
		{
			return -_container.x;
		}
		
		public function set scrollX(value:Number):void 
		{
			_container.x=-value;
		}
		
		public function get maxScrollX():Number 
		{
			return _container.contentWidth -_width ;
		}
		
		public function get hasHorizontalScrollBar():Boolean 
		{
			return _hasHorizontalScrollBar;
		}
		
		public function set hasHorizontalScrollBar(value:Boolean):void 
		{
			if (_hasHorizontalScrollBar == value)
			return;
			_hasHorizontalScrollBar = value;
			callLater(redraw);
		}
		
		public function get hasVerticalScrollBar():Boolean 
		{
			return _hasVerticalScrollBar;
		}
		
		public function set hasVerticalScrollBar(value:Boolean):void 
		{
			if (_hasVerticalScrollBar == value)
			return;
			_hasVerticalScrollBar = value;
			callLater(redraw);
		}
		
		override public function resize():void 
		{
			super.resize();
			if (_width && _height)
			{
				var rect:Rectangle = this.scrollRect;
				rect.width = _width;
				rect.height = _height;
				this.scrollRect = rect;
			}
			
			if (verticalScrollBar != null && _container!=null)
			{
				verticalScrollBar.page = this.height;
				verticalScrollBar.minimum = 0;
				verticalScrollBar.maximum = _container.contentHeight;
			}
			if (horizontalScrollBar != null && content!=null)
			{
				horizontalScrollBar.page = this.width;
				horizontalScrollBar.minimum = 0;
				horizontalScrollBar.maximum = _container.contentWidth;
			}
			
			
			bgSkin.width = _width;
			bgSkin.height = _height;
		}
		
		//override public function set width(value:Number):void 
		//{
			//super.width = value;
			//_container.width = value;
		//}
		//
		//override public function set height(value:Number):void 
		//{
			//super.height = value;
			//_container.height = value;
		//}
		
		
		
	}

}