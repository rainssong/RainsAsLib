/**
 * 2014-11-04
 * 无法监视视图赋值情况，对于皮肤的显示问题，需要提交到redraw根据stats统一处理
 *
 */
package me.rainui.components
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.Shape;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.ColorTransform;
	import flash.geom.Rectangle;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	import me.rainssong.manager.SystemManager;
	import me.rainssong.media.RainStageWebView;
	import me.rainssong.system.SystemCore;
	import me.rainssong.utils.Draw;
	import me.rainui.RainTheme;
	import me.rainui.RainUI;
	//import morn.core.handlers.Handler;
	//import morn.core.utils.ObjectUtils;
	//import morn.core.utils.StringUtils;
	
	/**选择改变后触发*/
	[Event(name="select",type="flash.events.Event")]
	
	/**按钮类*/
	public class Button extends Container
	{
		//public var defaultTextFormat:TextFormat = RainTheme.getTextFormat(RainTheme.WHITE_TEXT_FORMAT);
		//public var defaultSkin:DisplayObject = RainUI.btnSkin;
		public var darkColorTrans:ColorTransform = RainUI.darkColorTrans;
		
		static public const SELECTED:String = "selected";
		static public const MOUSE_DOWN:String = "mouseDown";
		static public const HOVER:String = "hover";
		static public const NORMAL:String = "normal";
		static public const DISABLED:String = "disabled";
		
		protected var _label:Label;
		protected var _normalSkin:DisplayObject;
		protected var _downSkin:DisplayObject;
		protected var _hoverSkin:DisplayObject;
		protected var _disabledSkin:DisplayObject;
		protected var _selectedSkin:DisplayObject;
		protected var _iconSkin:DisplayObject;
		
		protected var _showIcon:Boolean = false;
		
		protected var _handler:Function
		//protected var _labelColors:Array = Styles.buttonLabelColors;
		//protected var _labelMargin:Array = Styles.buttonLabelMargin;
		//protected var _showLabel:Boolean = true;
		protected var _state:String = NORMAL;
		protected var _toggle:Boolean = false;
		protected var _selected:Boolean = false;
		private var _normalColorTrans:ColorTransform;
		
		public function Button(text:String = "",dataSource:Object=null)
		{
			super(dataSource);
			this.text = text;
		}
		
		override protected function preinitialize():void
		{
			super.preinitialize();
			
			this.buttonMode = true;
			this.useHandCursor = true;
			this.mouseChildren = false
			this.mouseEnabled = true;
			
			_normalColorTrans = this.transform.colorTransform;
			
			this._width = 200;
			this._height = 60;
		}
		
		override protected function createChildren():void
		{
			if (this.numChildren == 1)
			{
				_normalSkin = this.getChildAt(0);
				//_width = _normalSkin.width;
				//_height = _normalSkin.height;
			}
			if (_normalSkin == null)
			{
				var shape:Shape = new Shape();
				Draw.rect(shape, 0, 0, 100, 100, RainTheme.BLUE);
				Draw.rect(shape, 0, 96, 100, 4, RainTheme.DARK_BLUE);
				shape.scale9Grid = new Rectangle(4, 4, 92, 92);
				_normalSkin = shape;
				_normalSkin.name = "normalSkin";
			}
			addChild(_normalSkin);
			
			if (_downSkin)
			{
				addChild(this._downSkin)
				_downSkin.visible = false;
			}
			
			if (this._label == null)
			{
				_label = new Label();
				//label.dataSource = {left: 4, right: 4, top:4,bottom:4};
				_label.centerX = 0;
				_label.centerY = 0;
				//_label.autoSize = true;
				if (RainUI.theme)
					_label.format = RainUI.theme.getTextFormat("whiteTextFormat");
				else
					_label.format = new TextFormat(null, 32, 0xffffff, null, null, null, null, null, TextFormatAlign.CENTER);
			}
			
			addChild(_label);
		}
		
		override protected function initialize():void
		{
			addEventListener(MouseEvent.ROLL_OVER, onRollOver);
			addEventListener(MouseEvent.ROLL_OUT, onRollOut);
			addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
			addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
			addEventListener(MouseEvent.RELEASE_OUTSIDE, onMouseUp);
			addEventListener(MouseEvent.CLICK, onClick);
			
			callLater(redraw);
		}
		
		override public function resize():void
		{
			super.resize();
			this._normalSkin.width = _width;
			this._normalSkin.height = _height;
			if (this._downSkin)
			{
				this._downSkin.width = _width;
				this._downSkin.height = _height;
			}
			
			
			//this.scrollRect = new Rectangle(0, 0, _width, _height);
		}
		
		protected function onRollOver(e:MouseEvent):void
		{
			//含redraw
			state = HOVER;
		}
		
		protected function onRollOut(e:MouseEvent):void
		{
			state = NORMAL;
		}
		
		protected function onMouseDown(e:MouseEvent):void
		{
			state = MOUSE_DOWN;
		}
		
		protected function onMouseUp(e:MouseEvent):void
		{
			state = NORMAL;
		}
		
		protected function onClick(e:MouseEvent):void
		{
			if ((_toggle == false && _selected) || _disabled)
			{
				return;
			}
			if (_toggle)
			{
				selected = !_selected;
			}
			if (_handler!=null)
				_handler();
			//}
			//sendEvent(Event.SELECT);
		}
		
		/**皮肤*/ /*public function get skinName():String
		   {
		   return _skin;
		   }
		
		   public function set skinName(value:String):void
		   {
		   if (_skin != value)
		   {
		   _skin = value;
		   _bitmap.clips = App.asset.getClips(_skin, 1, 3);
		   if (_autoSize)
		   {
		   _contentWidth = _bitmap.width;
		   _contentHeight = _bitmap.height;
		   }
		   callLater(changeLabelSize);
		   }
		 }*/
		
		protected function changeLabelSize():void
		{
			//label.width = width - _label.left - _label.right;
			//label.height = ObjectUtils.getTextField(label.format).height;
			//label.x = _label.left;
			//label.y = (height - _label.height) * 0.5 + _label.top - _label.bottom;
		}
		
		/**是否是选择状态*/
		[Inspectable(name="selected",type="Bealoon",defaultValue=false)]
		public function get selected():Boolean
		{
			return _selected;
		}
		
		public function set selected(value:Boolean):void
		{
			if (_selected != value)
			{
				_selected = value;
				//state = _selected ? stateMap["selected"] : stateMap["rollOut"];
				if (_selected)
				{
					if (_selectedSkin)
					{
						_normalSkin.visible = false;
						_selectedSkin.visible = true;
					}
					else
					{
						this.transform.colorTransform = darkColorTrans;
					}
				}
				else
				{
					if (_selectedSkin)
					{
						_normalSkin.visible = true;
						_selectedSkin.visible = false;
					}
					else
						this.transform.colorTransform = _normalColorTrans;
				}
			}
		}
		
		protected function get state():String
		{
			return _state;
		}
		
		protected function set state(value:String):void
		{
			_state = value;
			callLater(redraw);
		}
		
		override public function redraw():void
		{
			switch (_state)
			{
				case MOUSE_DOWN: 
					if (_downSkin)
					{
						if(_downSkin.parent==null)
							addChild(_downSkin);
						_downSkin.visible = true;
					}
					else
					{
						if (_normalSkin.parent == null)
							addChildAt(_normalSkin, 0);
						_normalSkin.visible = true;
						this.transform.colorTransform = darkColorTrans;
					}
					break;
				case NORMAL: 
					_normalSkin.visible = true;
					if(_downSkin)_downSkin.visible = false;
					if (_selected)
						this.transform.colorTransform = darkColorTrans;
					else
						this.transform.colorTransform = _normalColorTrans;
					break;
				default: 
			}
			
			super.redraw();
		
			//if (icon && _showIcon)
			//{
			//addChild(icon);
			//icon.x = 10;
			//icon.y = 10;
			//icon.height = _height - 20;
			//icon.scaleX = icon.scaleY;
			//}
		}
		
		/**是否是切换状态*/
		public function get toggle():Boolean
		{
			return _toggle;
		}
		
		public function set toggle(value:Boolean):void
		{
			_toggle = value;
		}
		
		/**按钮标签字体*/
		public function get labelFont():String
		{
			return _label.font;
		}
		
		public function set labelFont(value:String):void
		{
			_label.font = value
			callLater(changeLabelSize);
		}
		
		/**按钮标签颜色(格式:upColor,overColor,downColor,disableColor)*/
		//public function get _labelColors():String
		//{
		//return String(labelColors);
		//}
		//
		//public function set _labelColors(value:String):void
		//{
		//labelColors = StringUtils.fillArray(labelColors, value);
		//callLater(redraw);
		//}
		
		/**按钮标签边距(格式:左边距,上边距,右边距,下边距)*/
		//public function get _labelMargin():String
		//{
		//return String(labelMargin);
		//}
		//
		//public function set _labelMargin(value:String):void
		//{
		//labelMargin = StringUtils.fillArray(labelMargin, value, int);
		//callLater(changeLabelSize);
		//}
		
		/**按钮标签描边(格式:color,alpha,blurX,blurY,strength,quality)*/
		//public function get _labelStroke():String
		//{
		//return _label.stroke;
		//}
		//
		//public function set _labelStroke(value:String):void
		//{
		//label.stroke = value;
		//}
		
		/**按钮标签大小*/
		public function get labelSize():Object
		{
			return _label.size;
		}
		
		public function set labelSize(value:Object):void
		{
			_label.size = value
			callLater(changeLabelSize);
		}
		
		/**按钮标签粗细*/
		public function get labelBold():Object
		{
			return _label.bold;
		}
		
		public function set labelBold(value:Object):void
		{
			_label.bold = value
			callLater(changeLabelSize);
		}
		
		/**字间距*/
		public function get letterSpacing():Object
		{
			return _label.letterSpacing;
		}
		
		public function set letterSpacing(value:Object):void
		{
			_label.letterSpacing = value
			callLater(changeLabelSize);
		}
		
		/**点击处理器(无默认参数)*/
		//public function get clickHandler():Handler
		//{
		//return _clickHandler;
		//}
		//
		//public function set clickHandler(value:Handler):void
		//{
		//_clickHandler = value;
		//}
		
		/**按钮标签控件*/
		//public function get _label():Label
		//{
		//return _label;
		//}
		
		/**九宫格信息(格式:左边距,上边距,右边距,下边距)*/
		//public function get sizeGrid():String
		//{
		//if (_bitmap.sizeGrid)
		//{
		//return _bitmap.sizeGrid.join(",");
		//}
		//return null;
		//}
		//
		//public function set sizeGrid(value:String):void
		//{
		//_bitmap.sizeGrid = StringUtils.fillArray(Styles.defaultSizeGrid, value);
		//}
		
		override public function set width(value:Number):void
		{
			super.width = value;
			if (_autoSize)
			{
				//_bitmap.width = value;
			}
			callLater(changeLabelSize);
		}
		
		override public function set height(value:Number):void
		{
			super.height = value;
			if (_autoSize)
			{
				//_bitmap.height = value;
			}
			callLater(changeLabelSize);
		}
		
		override public function set dataSource(value:Object):void
		{
			_dataSource = value;
			if (value is Number || value is String)
			{
				text = String(value);
			}
			else
			{
				super.dataSource = value;
			}
		}
		
		public function set text(value:String):void
		{
			_label.text = value;
			
		}
		
		public function get text():String
		{
			return _label.text;
		}
		
		public function get showIcon():Boolean
		{
			return _showIcon;
		}
		
		public function set showIcon(value:Boolean):void
		{
			if (_showIcon == value) return;
			_showIcon = value;
			callLater(redraw);
		}
		
		public function get label():Label 
		{
			return _label;
		}
		
		public function set label(value:Label):void 
		{
			_label = value;
		}
		
		public function get normalSkin():DisplayObject 
		{
			return _normalSkin;
		}
		
		public function set normalSkin(value:DisplayObject):void 
		{
			if (_normalSkin == value) return;
			swapContent(_normalSkin, value);
			_normalSkin = value;
			callLater(redraw);
		}
		
		public function get downSkin():DisplayObject 
		{
			return _downSkin;
		}
		
		public function set downSkin(value:DisplayObject):void 
		{
			_downSkin = value;
		}
		
		override public function showBorder(color:uint = 0xff0000, contentColor:int = -1):void 
		{
			_border.graphics.clear();
			_border.graphics.lineStyle(1, color);
			_border.graphics.drawRect(0, 0, width, height);
			
			if (contentColor > 0)
			{
				_label.showBorder(contentColor);
			}
			
			addChild(_border);
		}
	
	}
}