package me.rainui.components
{
	import flash.display.DisplayObject;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.geom.Rectangle;
	import me.rainssong.math.MathCore;
	import me.rainui.RainUI;
	import me.rainui.components.Component
	import me.rainui.events.RainUIEvent;
	
	/**
	 * 具有自适应能力的组件基类
	 * @author Rainssong
	 */
	public class Container extends Component
	{
		//百分比优先级高于绝对值
		protected var _percentWidth:Number = NaN;
		protected var _widthAnchorDisplayObject:DisplayObject;
		protected var _percentHeight:Number = NaN;
		protected var _heightAnchorDisplayObject:DisplayObject;
		//新增属性，免除计算像素的步骤
		protected var _dotWidth:Number = NaN;
		protected var _dotHeight:Number = NaN;
		
		protected var _top:Number = NaN;
		protected var _percentTop:Number = NaN;
		protected var _topAnchorDisplayObject:DisplayObject;
		
		protected var _bottom:Number = NaN;
		protected var _percentBottom:Number = NaN;
		protected var _bottomAnchorDisplayObject:DisplayObject;
		protected var _left:Number = NaN;
		protected var _percentLeft:Number = NaN;
		protected var _leftAnchorDisplayObject:DisplayObject;
		protected var _right:Number = NaN;
		protected var _percentRight:Number = NaN;
		protected var _rightAnchorDisplayObject:DisplayObject;
		
		protected var _centerX:Number = NaN;
		protected var _percentCenterX:Number = NaN;
		protected var _centerAnchorDisplayObject:DisplayObject;
		protected var _centerY:Number = NaN;
		protected var _percentCenterY:Number = NaN;
		protected var _centerYAnchorDisplayObject:DisplayObject;
		
		protected var _minHeight:Number = 0;
		protected var _maxHeight:Number = Infinity;
		
		protected var _minWidth:Number = 0;
		protected var _maxWidth:Number = Infinity;
		
		public var destroyOnRemove:Boolean = true;
		
		
		private var elements:Vector.<DisplayObject>=new Vector.<DisplayObject>();
		
		public function Container(dataSource:Object = null)
		{
			super(dataSource)
		}
		
		
		protected function onScaleChange(e:RainUIEvent):void
		{
			callLater(calcSize);
		}
		
		override protected function preinitialize():void
		{
			super.preinitialize();
			this.mouseChildren = true;
			addEventListener(Event.ADDED, onAdded);
			addEventListener(Event.REMOVED, onRemoved);
			addExternalListener(RainUI.dispatcher, RainUIEvent.SCALE_CHANGE, onScaleChange);
		}
		
		override protected function initialize():void
		{
			super.initialize();
			callLater(calcSize);
		}
		
		protected function onRemoved(e:Event):void
		{
			if (e.target == this)
			{
				parent.removeEventListener(Event.RESIZE, onParentResize);
				//等待事件
				if (destroyOnRemove)
					callLater(destroy);
			}
		}
		
		protected function onAdded(e:Event):void
		{
			if (e.target == this)
			{
				//powerTrace(this + "start listen");
				parent.addEventListener(Event.RESIZE, onParentResize);
				callLater(calcSize);
			}
			else
				return;
		}
		
		protected function onParentResize(e:Event):void
		{
			if (e.target == parent)
			{
				callLater(calcSize);
			}
		}
		
		/**添加显示对象*/
		public function addElement(element:DisplayObject, x:Number = 0, y:Number = 0):void
		{
			element.x = x;
			element.y = y;
			//elements.push(element);
			addChild(element);
		}
		
		/**增加显示对象到index层*/
		public function addElementAt(element:DisplayObject, index:int, x:Number = 0, y:Number = 0):void
		{
			element.x = x;
			element.y = y;
			//elements.push(element);
			addChildAt(element, index);
		}
		
		/**批量增加显示对象*/
		public function addElements(elements:Array):void
		{
			for (var i:int = 0, n:int = elements.length; i < n; i++)
			{
				var item:DisplayObject = elements[i];
				//addElement(item);
			}
		}
		
		/**删除子显示对象，子对象为空或者不包含子对象时不抛出异常*/
		public function removeElement(element:DisplayObject):void
		{
			if (element && contains(element))
			{
				removeChild(element);
				//for (var i:int = elements.length; i > 0;i-- ) 
				//{
					//element == elements[i]
					//elements.shift(i);
				//}
			}
		}
		
		/**删除所有子显示对象
		 * @param except 例外的对象(不会被删除)*/
		public function removeAllChild(except:DisplayObject = null):void
		{
			for (var i:int = numChildren - 1; i > -1; i--)
			{
				if (except != getChildAt(i))
				{
					removeChildAt(i);
				}
			}
		}
		
		/**增加显示对象到某对象上面*/
		public function insertAbove(element:DisplayObject, compare:DisplayObject):void
		{
			removeElement(element);
			var index:int = getChildIndex(compare);
			addChildAt(element, Math.min(index + 1, numChildren));
		}
		
		/**增加显示对象到某对象下面*/
		public function insertBelow(element:DisplayObject, compare:DisplayObject):void
		{
			removeElement(element);
			var index:int = getChildIndex(compare);
			addChildAt(element, Math.max(index, 0));
		}
		
		override public function set width(value:Number):void
		{
			_percentWidth = NaN;
			_percentLeft = NaN;
			_percentRight = NaN;
			_dotWidth = NaN;
			super.width = value;
		
		}
		
		override public function set height(value:Number):void
		{
			_percentHeight = NaN;
			_percentTop = NaN;
			_percentBottom = NaN;
			_dotHeight = NaN;
			
			super.height = value;
		}
		
		override public function get height():Number
		{
			return super.height;
		}
		
		/**居父容器顶上的距离*/
		[Inspectable(name = "top", type = "Number", defaultValue = NaN)]
		public function get top():Number
		{
			return _top;
		}
		
		public function set top(value:Number):void
		{
			_top = value;
			//_percentTop = NaN;
			_centerY = NaN;
			_percentCenterY = NaN;
			
			callLater(calcSize);
		}
		
		/**居父容器底部的距离*/
		public function get bottom():Number
		{
			return _bottom;
		}
		
		[Inspectable(name = "bottom", type = "Number", defaultValue = NaN)]
		public function set bottom(value:Number):void
		{
			_bottom = value;
			
			_centerY = NaN;
			_percentCenterY = NaN;
			
			callLater(calcSize);
		}
		
		/**居父容器左边的距离*/
		public function get left():Number
		{
			return _left;
		}
		
		[Inspectable(name = "left", type = "Number", defaultValue = NaN)]
		public function set left(value:Number):void
		{
			_left = value;
			_percentWidth = NaN;
			//_percentLeft = NaN;
			_percentRight = NaN;
			
			_centerX = NaN;
			_percentCenterX = NaN;
			callLater(calcSize);
		
		}
		
		/**居父容器右边的距离*/
		public function get right():Number
		{
			return _right;
		}
		
		[Inspectable(name = "right", type = "Number", defaultValue = NaN)]
		public function set right(value:Number):void
		{
			_right = value;
			_percentWidth = NaN;
			_percentLeft = NaN;
			//_percentRight = NaN;
			_centerX = NaN;
			_percentCenterX = NaN;
			callLater(calcSize);
		}
		
		/**水平居中偏移位置*/
		public function get centerX():Number
		{
			return _centerX;
		}
		
		[Inspectable(name = "centerX", type = "Number", defaultValue = NaN)]
		public function set centerX(value:Number):void
		{
			_centerX = value;
			_percentCenterX = NaN;
			
			_percentLeft = NaN;
			_percentRight = NaN;
			_left = NaN;
			_right = NaN
			
			callLater(resize);
		}
		
		/**垂直居中偏移位置*/
		public function get centerY():Number
		{
			return _centerY;
		}
		
		[Inspectable(name = "centerY", type = "Number", defaultValue = NaN)]
		public function set centerY(value:Number):void
		{
			_centerY = value;
			_percentCenterY = NaN;
			
			_percentTop = NaN;
			_percentBottom = NaN;
			_top = NaN;
			_bottom = NaN
			callLater(resize);
		}
		
		public function get percentWidth():Number
		{
			return _percentWidth;
		}
		
		[Inspectable(name = "percentWidth", type = "Number", defaultValue = NaN)]
		public function set percentWidth(value:Number):void
		{
			_percentWidth = value;
			callLater(calcSize);
		}
		
		public function get percentHeight():Number
		{
			return _percentHeight;
		}
		
		[Inspectable(name = "percentHeight", type = "Number", defaultValue = NaN)]
		public function set percentHeight(value:Number):void
		{
			_percentHeight = value;
			callLater(calcSize);
		}
		
		public function get percentTop():Number
		{
			return _percentTop;
		}
		
		[Inspectable(name = "percentTop", type = "Number", defaultValue = NaN)]
		public function set percentTop(value:Number):void
		{
			_percentTop = value;
			callLater(calcSize);
		}
		
		public function get percentBottom():Number
		{
			return _percentBottom;
		}
		
		[Inspectable(name = "percentBottom", type = "Number", defaultValue = NaN)]
		public function set percentBottom(value:Number):void
		{
			_percentBottom = value;
			callLater(calcSize);
		}
		
		public function get percentLeft():Number
		{
			return _percentLeft;
		}
		
		[Inspectable(name = "percentLeft", type = "Number", defaultValue = NaN)]
		public function set percentLeft(value:Number):void
		{
			_percentLeft = value;
			callLater(calcSize);
		}
		
		public function get percentRight():Number
		{
			return _percentRight;
		}
		
		[Inspectable(name = "percentRight", type = "Number", defaultValue = NaN)]
		public function set percentRight(value:Number):void
		{
			_percentRight = value;
			callLater(calcSize);
		}
		
		public function get minHeight():Number
		{
			return _minHeight;
		}
		
		[Inspectable(name = "minHeight", type = "Number", defaultValue = NaN)]
		public function set minHeight(value:Number):void
		{
			_minHeight = value;
		}
		
		public function get maxHeight():Number
		{
			return _maxHeight;
		}
		
		[Inspectable(name = "maxHeight", type = "Number", defaultValue = NaN)]
		public function set maxHeight(value:Number):void
		{
			_maxHeight = value;
		}
		
		public function get percentCenterX():Number
		{
			return _percentCenterX;
		}
		
		[Inspectable(name = "percentCenterX", type = "Number", defaultValue = NaN)]
		public function set percentCenterX(value:Number):void
		{
			_percentCenterX = value;
		}
		
		public function get percentCenterY():Number
		{
			return _percentCenterY;
		}
		
		[Inspectable(name = "percentCenterY", type = "Number", defaultValue = NaN)]
		public function set percentCenterY(value:Number):void
		{
			_percentCenterY = value;
		}
		
		public function get minWidth():Number
		{
			return _minWidth;
		}
		
		public function set minWidth(value:Number):void
		{
			_minWidth = value;
		}
		
		public function get maxWidth():Number
		{
			return _maxWidth;
		}
		
		public function set maxWidth(value:Number):void
		{
			_maxWidth = value;
		}
		
		public function get dotWidth():Number
		{
			return _dotWidth;
		}
		
		public function set dotWidth(value:Number):void
		{
			if (value == _dotWidth)
				return;
			
			_percentWidth = NaN;
			_percentLeft = NaN;
			_percentRight = NaN;
			_dotWidth = value;
			
			callLater(calcSize);
		}
		
		public function get dotHeight():Number
		{
			return _dotHeight;
		}
		
		public function set dotHeight(value:Number):void
		{
			if (value == _dotHeight)
				return;
			
			_percentHeight = NaN;
			_percentTop = NaN;
			_percentBottom = NaN;
			_dotHeight = value;
			
			callLater(calcSize);
		}
		
		public function get widthAnchorDisplayObject():DisplayObject
		{
			return _widthAnchorDisplayObject;
		}
		
		public function set widthAnchorDisplayObject(value:DisplayObject):void
		{
			if (value == _widthAnchorDisplayObject)
				return;
			_widthAnchorDisplayObject = value;
			callLater(calcSize);
		}
		
		public function get heightAnchorDisplayObject():DisplayObject
		{
			return _heightAnchorDisplayObject;
		}
		
		public function set heightAnchorDisplayObject(value:DisplayObject):void
		{
			if (value == _heightAnchorDisplayObject)
				return;
			_heightAnchorDisplayObject = value;
			callLater(calcSize);
		
		}
		
		//resize后自动更新位置，注意super.resize必须先行
		override public function calcSize():void
		{
			if (parent == null)
				return;
			
			var parentWidth:Number;
			var parentHeight:Number;
			if (parent is Stage)
			{
				parentWidth = stage.stageWidth;
				parentHeight = stage.stageHeight;
			}
			else
			{
				parentWidth = parent.width / parent.scaleX;
				parentHeight = parent.height / parent.scaleY;
			}
			
			if (_dotWidth)
				_width = _dotWidth * RainUI.scale;
			if (_dotHeight)
				_height = _dotHeight * RainUI.scale;
			
			if (_autoSize)
			{
				hideBorder();
				_width = contentWidth;
				_height = contentHeight
			}
			
			if (!isNaN(_percentWidth))
				_width = (_widthAnchorDisplayObject==null?parentWidth:_widthAnchorDisplayObject.width) * _percentWidth;
			if (!isNaN(_percentHeight))
				_height =  (_heightAnchorDisplayObject==null?parentHeight:_heightAnchorDisplayObject.height) * _percentHeight;
			
			if (!isNaN(_percentLeft))
				x = _percentLeft * parentWidth + (_left ? _left : 0);
			else if (!isNaN(_left))
				x = _left;
			
			if (!isNaN(_percentRight))
				if (!isNaN(_percentLeft))
					_width = parentWidth * (1 - _percentRight - _percentLeft);
				else
					x = parentWidth - (_percentRight * parentWidth) - (right ? right : 0) - displayWidth;
			else if (!isNaN(_right))
				if (!isNaN(_left))
					_width = parentWidth - _left - _right;
				else
					x = parentWidth - _right - displayWidth;
			
			if (!isNaN(_percentCenterX))
				x = (parentWidth - displayWidth) * 0.5 + (_percentCenterX * parentWidth);
			else if (!isNaN(_centerX))
				x = (parentWidth - displayWidth) * 0.5 + _centerX;
			
			if (!isNaN(_percentTop))
				y = _percentTop * parentHeight + (_top ? top : 0);
			else if (!isNaN(_top))
				y = _top;
			
			if (!isNaN(_percentCenterY))
				y = (parentHeight - displayHeight) * 0.5 + (_percentCenterY * parentHeight);
			else if (!isNaN(_centerY))
				y = (parentHeight - displayHeight) * 0.5 + _centerY;
			
			if (!isNaN(_percentBottom))
				if (!isNaN(_percentTop))
					_width = parentWidth * (1 - _percentTop - _percentBottom);
				else
					y = parentHeight - (_percentBottom * parentHeight) - displayHeight - (_bottom ? _bottom : 0);
			else if (!isNaN(_bottom))
				if (!isNaN(_top))
					_height = parentHeight - _top - _bottom;
				else
					y = parentHeight - _bottom - displayHeight;
			
			_height = MathCore.getRangedNumber(_height, _minHeight, _maxHeight);
			_width = MathCore.getRangedNumber(_width, _minWidth, _maxWidth);
			
			resize();
		}
	
	}

}