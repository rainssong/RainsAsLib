package me.rainui.components 
{
	import flash.display.DisplayObject;
	import flash.display.Shape;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
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

		private var _content:DisplayObject
		private var _container:Container=new Container();
		private var _scrollY:Number = 0;
		private var _scrollX:Number = 0;
		private var _onDrag:Boolean = false;
		private var _startX:Number = 0;
		private var _lastX:Number = 0;
		private var _speedX:Number = 0;
		private var _startY:Number = 0;
		private var _lastY:Number = 0;
		private var _speedY:Number = 0;
		public var direction:String = ALL;
		//public var lockDirection:Boolean = true;
		public var allowOverload:Boolean = true;
		
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
			this.scrollRect = new Rectangle(0, 0, _width, _height);
		}
		
		override protected function createChildren():void 
		{
			//_container = new Container();
			_container.percentWidth = 1;
			_container.percentHeight = 1;
			super.addChild(_container);
			
			if (_content)
				addChild(_content);
			
			if (_bgSkin == null)
			{
				var shape:Shape = new Shape();
				Draw.rect(shape, 0, 0, 100, 100,RainTheme.WHITE);
				_bgSkin = shape;
			}
			else
			{
				_width = bgSkin.width;
				_height = bgSkin.height;
			}
			//redraw();
			super.createChildren();
		}
		
		override protected function initialize():void 
		{
			super.initialize();
			addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
			addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
			addEventListener(MouseEvent.RELEASE_OUTSIDE, onMouseUp);
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
		
		private function onEnterFrame(e:Event):void 
		{
			if (_onDrag)
				onDrag();
			else
				offDrag();
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
			
			
			//if (Math.abs(_speedY) < 0.5)
			//{
				//_speedY
			//}
			
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
		
		private function onMouseDown(e:MouseEvent):void 
		{
			_startX = mouseX;
			_startY = mouseY;
			_lastX = mouseX;
			_lastY = mouseY;
			
			_onDrag = true;
			
			
		}
		
		
		override public function addChild(child:DisplayObject):DisplayObject 
		{
			_container.addChild(child);
			//var rect:Rectangle = _container.getRect(this);
			return child;
		}
		
		override public function removeChild(child:DisplayObject):DisplayObject 
		{
			return _container.removeChild(child);
		}
		
		public function get overloadX():Number
		{
			if (_container.x < 0 && _container.contentWidth+_container.x <_width)
			{
				return Math.max(_container.contentWidth+_container.x - _height,_container.x);
			}
			if (_container.x >0)
			{
				return _container.x;
			}
			else 
				return 0;
		}
		
		public function get overloadY():Number
		{
			if (_container.y < 0 && _container.contentHeight+_container.y <_height)
			{
				return Math.max(_container.contentHeight+_container.y - _height,_container.y);
			}
			//if (_container.y >0 && _container.height+_container.y>_height)
			//{
				//return Math.min(_container.height+_container.y - _height,_container.y);
			//}
			if (_container.y >0)
			{
				return _container.y;
			}
			else 
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
					removeChild(_content)
			}
			_content = value;
			addChild(_content);
		}
		
		override public function showBorder(color:uint = 0xff0000,conetntColor:int = -1):void 
		{
			super.showBorder()
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