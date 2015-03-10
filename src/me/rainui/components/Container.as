package me.rainui.components
{
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.geom.Rectangle;
	import me.rainssong.math.MathCore;
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
		protected var _percentHeight:Number = NaN;
		
		protected var _top:Number = NaN;
		protected var _percentTop:Number = NaN;
		protected var _bottom:Number = NaN;
		protected var _percentBottom:Number = NaN;
		protected var _left:Number = NaN;
		protected var _percentLeft:Number = NaN;
		protected var _right:Number = NaN;
		protected var _percentRight:Number = NaN;
		
		protected var _centerX:Number = NaN;
		protected var _percentCenterX:Number = NaN;
		protected var _centerY:Number = NaN;
		protected var _percentCenterY:Number = NaN;
		
		protected var _minHeight:Number = 0;
		protected var _maxHeight:Number = Infinity;
		
		protected var _minWidth:Number = 0;
		protected var _maxWidth:Number = Infinity;
		
		public function Container(dataSource:Object=null)
		{
			//this.scrollRect = new Rectangle(0, 0, 100, 100);
			super(dataSource)
			addEventListener(Event.ADDED, onAdded);
			addEventListener(Event.REMOVED, onRemoved);
			
		}
		
		override protected function preinitialize():void 
		{
			super.preinitialize();
			this.mouseChildren = true;
		}
		
		
		protected function onRemoved(e:Event):void
		{
			if (e.target == this)
				parent.removeEventListener(Event.RESIZE, onParentResize);
		}
		
		protected function onAdded(e:Event):void
		{
			if (e.target == this)
			{
				parent.addEventListener(Event.RESIZE, onParentResize);
				callLater(resize);
			}
			else
				return;
		}
		
		protected function onParentResize(e:Event):void
		{
			callLater(resize);
		}
		
		/**添加显示对象*/
		public function addElement(element:DisplayObject, x:Number, y:Number):void
		{
			element.x = x;
			element.y = y;
			addChild(element);
		}
		
		/**增加显示对象到index层*/
		public function addElementAt(element:DisplayObject, index:int, x:Number, y:Number):void
		{
			element.x = x;
			element.y = y;
			addChildAt(element, index);
		}
		
		/**批量增加显示对象*/
		public function addElements(elements:Array):void
		{
			for (var i:int = 0, n:int = elements.length; i < n; i++)
			{
				var item:DisplayObject = elements[i];
				addChild(item);
			}
		}
		
		/**删除子显示对象，子对象为空或者不包含子对象时不抛出异常*/
		public function removeElement(element:DisplayObject):void
		{
			if (element && contains(element))
			{
				removeChild(element);
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
			super.width = value;
			_percentWidth = NaN;
			_percentLeft = NaN;
			_percentRight = NaN;
			callLater(resize);
			//var sc:Rectangle = this.scrollRect;
			//sc.width = value;
			//this.scrollRect = sc;
		}
		
		//TODO:减少percent和固定值的冲突，兼容
		override public function set height(value:Number):void
		{
			super.height = value;
			_percentHeight = NaN;
			//_percentTop = NaN;
			//_percentBottom = NaN;
			//var sc:Rectangle = this.scrollRect;
			//sc.height = value;
			//this.scrollRect = sc;
			callLater(resize);
		}
		
		/**居父容器顶上的距离*/
		[Inspectable(name="top",type="Number",defaultValue=NaN)]
		public function get top():Number
		{
			return _top;
		}
		
		public function set top(value:Number):void
		{
			_top = value;
			//_percentHeight = NaN;
			_percentTop = NaN;
			//_percentBottom = NaN;
			
			_centerY = NaN;
			_percentCenterY = NaN;
			
			callLater(resize);
		}
		
		/**居父容器底部的距离*/
		public function get bottom():Number
		{
			return _bottom;
		}
		[Inspectable(name="bottom",type="Number",defaultValue=NaN)]
		public function set bottom(value:Number):void
		{
			_bottom = value;
			//_percentHeight = NaN;
			//_percentTop = NaN;
			_percentBottom = NaN;
			
			_centerY = NaN;
			_percentCenterY = NaN;
			
			callLater(resize);
		}
		
		/**居父容器左边的距离*/
		public function get left():Number
		{
			return _left;
		}
		
		[Inspectable(name="left",type="Number",defaultValue=NaN)]
		public function set left(value:Number):void
		{
			_left = value;
			_percentWidth = NaN;
			_percentLeft = NaN;
			_percentRight = NaN;
			
			_centerX = NaN;
			_percentCenterX = NaN;
			callLater(resize);
			
		}
		
		/**居父容器右边的距离*/
		public function get right():Number
		{
			return _right;
		}
		
		[Inspectable(name="right",type="Number",defaultValue=NaN)]
		public function set right(value:Number):void
		{
			_right = value;
			_percentWidth = NaN;
			_percentLeft = NaN;
			_percentRight = NaN;
			_centerX = NaN;
			_percentCenterX = NaN;
			callLater(resize);
		}
		
		/**水平居中偏移位置*/
		public function get centerX():Number
		{
			return _centerX;
		}
		[Inspectable(name="centerX",type="Number",defaultValue=NaN)]
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
		[Inspectable(name="centerY",type="Number",defaultValue=NaN)]
		public function set centerY(value:Number):void
		{
			_centerY = value;
			_percentCenterY = NaN;
			
			_percentTop = NaN;
			_percentBottom = NaN;
			_top = NaN;
			_bottom=NaN
			callLater(resize);
		}
		
		public function get percentWidth():Number 
		{
			return _percentWidth;
		}
		[Inspectable(name="percentWidth",type="Number",defaultValue=NaN)]
		public function set percentWidth(value:Number):void 
		{
			_percentWidth = value;
			callLater(resize);
		}
		
		public function get percentHeight():Number 
		{
			return _percentHeight;
		}
		[Inspectable(name="percentHeight",type="Number",defaultValue=NaN)]
		public function set percentHeight(value:Number):void 
		{
			_percentHeight = value;
			callLater(resize);
		}
		
		public function get percentTop():Number 
		{
			return _percentTop;
		}
		[Inspectable(name="percentTop",type="Number",defaultValue=NaN)]
		public function set percentTop(value:Number):void 
		{
			_percentTop = value;
			callLater(resize);
		}
		
		public function get percentBottom():Number 
		{
			return _percentBottom;
		}
		[Inspectable(name="percentBottom",type="Number",defaultValue=NaN)]
		public function set percentBottom(value:Number):void 
		{
			_percentBottom = value;
			callLater(resize);
		}
		
		public function get percentLeft():Number 
		{
			return _percentLeft;
		}
		[Inspectable(name="percentLeft",type="Number",defaultValue=NaN)]
		public function set percentLeft(value:Number):void 
		{
			_percentLeft = value;
			callLater(resize);
		}
		
		public function get percentRight():Number 
		{
			return _percentRight;
		}
		[Inspectable(name="percentRight",type="Number",defaultValue=NaN)]
		public function set percentRight(value:Number):void 
		{
			_percentRight = value;
			callLater(resize);
		}
		
		public function get minHeight():Number 
		{
			return _minHeight;
		}
		[Inspectable(name="minHeight",type="Number",defaultValue=NaN)]
		public function set minHeight(value:Number):void 
		{
			_minHeight = value;
		}
		
		public function get maxHeight():Number 
		{
			return _maxHeight;
		}
		[Inspectable(name="maxHeight",type="Number",defaultValue=NaN)]
		public function set maxHeight(value:Number):void 
		{
			_maxHeight = value;
		}
		
		public function get percentCenterX():Number 
		{
			return _percentCenterX;
		}
		[Inspectable(name="percentCenterX",type="Number",defaultValue=NaN)]
		public function set percentCenterX(value:Number):void 
		{
			_percentCenterX = value;
		}
		
		public function get percentCenterY():Number 
		{
			return _percentCenterY;
		}
		[Inspectable(name="percentCenterY",type="Number",defaultValue=NaN)]
		public function set percentCenterY(value:Number):void 
		{
			_percentCenterY = value;
		}
		
		//resize后自动更新位置，注意super.resize必须先行
		override public function resize():void
		{
			if (parent == null)
				return;
			
			if (!isNaN(_percentWidth))
				_width = parent.width * _percentWidth;
			if (!isNaN(_percentHeight))
				_height = parent.height * _percentHeight;
			
			if (!isNaN(_percentLeft))
				x = _percentLeft * parent.width;
			else if ( !isNaN(_left))
				x = _left;
				
			if (!isNaN(_percentRight))
				if (!isNaN(_percentLeft))
					_width = parent.width*(1-_percentRight - _percentLeft);
				else
					x = parent.width - (_percentRight * parent.width) - displayWidth;
			else if ( !isNaN(_right))
				if (!isNaN(_left))
					_width = parent.width - _left - _right;
				else
					x = parent.width - _right - displayWidth;
				
				
			if (!isNaN(_percentCenterX))
				x = (parent.width - displayWidth) * 0.5 + (_percentCenterX * parent.width);
			else if (!isNaN(_centerX))
				x = (parent.width - displayWidth) * 0.5 + _centerX;
			
			if (!isNaN(_percentTop))
				y = _percentTop * parent.height;
			else if (!isNaN(_top))
				y = _top;
				
			if (!isNaN(_percentCenterY))
				y = (parent.height - displayHeight) * 0.5 + (_percentCenterY*parent.height);
			else if (!isNaN(_centerY))
				y = (parent.height - displayHeight) * 0.5 + _centerY;
				
			if (!isNaN(_percentBottom))
				if (!isNaN(_percentTop))
					_width = parent.width * (1 - _percentTop - _percentBottom);
				else
					y = parent.height - (_percentBottom * parent.height) - displayHeight;
			else if (!isNaN(_bottom))
				if (!isNaN(_top))
					_height = parent.height - _top - _bottom;
				else
					y = parent.height - _bottom - displayHeight;
			
			_height = MathCore.getRangedNumber(_height, _minHeight, _maxHeight);
			_width = MathCore.getRangedNumber(_width, _minWidth, _maxWidth);
			
			super.resize();
		}
	
	}

}