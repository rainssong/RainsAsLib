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
	import me.rainssong.media.RainStageWebView;
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
		public var defaultTextFormat:TextFormat = RainTheme.getTextFormat(RainTheme.WHITE_TEXT_FORMAT);
		//public var defaultSkin:DisplayObject = RainUI.btnSkin;
		public var darkColorTrans:ColorTransform = RainUI.darkColorTrans;
		
		static public const SELECTED:String = "selected";
		static public const MOUSE_DOWN:String = "mouseDown";
		static public const HOVER:String = "hover";
		static public const NORMAL:String = "normal";
		static public const DISABLED:String = "disabled";
		
		public var normalSkin:DisplayObject;
		public var downSkin:DisplayObject;
		public var hoverSkin:DisplayObject;
		public var disabledSkin:DisplayObject;
		public var selectedSkin:DisplayObject;
		
		public var icon:DisplayObject;
		private var _showIcon:Boolean = false;
		
		public var label:Label;
		private var _showLabel:Boolean = true;
		
		//protected var _clickHandler:Handler;
		//protected var labelColors:Array = Styles.buttonLabelColors;
		//protected var labelMargin:Array = Styles.buttonLabelMargin;
		protected var _state:String = NORMAL;
		protected var _toggle:Boolean = false;
		protected var _selected:Boolean = false;
		
		
		private var _normalColorTrans:ColorTransform;
		
		public function Button(text:String = "")
		{
			super();
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
				normalSkin = this.getChildAt(0);
				_width = normalSkin.width;
				_height = normalSkin.height;
			}
			if (this.normalSkin == null)
			{
				var shape:Shape = new Shape();
				Draw.rect(shape, 0, 0, 100, 100, RainTheme.BLUE);
				Draw.rect(shape, 0, 96, 100, 4, RainTheme.DARK_BLUE);
				shape.scale9Grid = new Rectangle(4, 4, 92, 92);
				normalSkin = shape;
				normalSkin.name = "normalSkin";
			}
			addChild(normalSkin);
			
			if (this.downSkin)
			{
				addChild(this.downSkin)
				downSkin.visible = false;
			}
			
			if (this.label == null)
			{
				label = new Label();
				label.dataSource = {left: 4, right: 4, top:4,bottom:4};
				label.align = "center";
				label.format = defaultTextFormat;
			}
			
			addChild(label);
		
		}
		
		override protected function initialize():void
		{
			
			addEventListener(MouseEvent.ROLL_OVER, onRollOver);
			addEventListener(MouseEvent.ROLL_OUT, onRollOut);
			addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
			addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
			addEventListener(MouseEvent.RELEASE_OUTSIDE, onMouseUp);
			addEventListener(MouseEvent.CLICK, onClick);
			
			redraw();
			//resize();
		}
		
		override public function resize():void
		{
			super.resize();
			
			
			if (this.normalSkin)
			{
				var temp:DisplayObject = getChildByName("normalSkin");
				var index:int = 1;
				if (temp != normalSkin && temp!=null)
				{
					index = getChildIndex(temp);
					removeChildByName("normalSkin");
				}
				if (!normalSkin.parent)
				{
					normalSkin.name = "normalSkin";
					addChildAt(normalSkin,index);
				}
				
				this.normalSkin.width = _width;
				this.normalSkin.height = _height;
			}
		
			//this.scrollRect = new Rectangle(0, 0, _width, _height);
		}
		
		protected function onRollOver(e:MouseEvent):void
		{
			//powerTrace(e.type);
		}
		
		protected function onRollOut(e:MouseEvent):void
		{
			//powerTrace(e.type);
		}
		
		protected function onMouseDown(e:MouseEvent):void
		{
			//powerTrace(e.type);
			_state = MOUSE_DOWN;
			redraw();
		}
		
		protected function onMouseUp(e:MouseEvent):void
		{
			_state = NORMAL;
			redraw();
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
			//if (_clickHandler)
			//{
			//_clickHandler.execute();
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
			//label.width = width - label.left - label.right;
			//label.height = ObjectUtils.getTextField(label.format).height;
			//label.x = label.left;
			//label.y = (height - label.height) * 0.5 + label.top - label.bottom;
		}
		
		/**是否是选择状态*/
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
					if (selectedSkin)
					{
						normalSkin.visible = false;
						selectedSkin.visible = true;
					}
					else
					{
						this.transform.colorTransform = darkColorTrans;
					}
				}
				else
				{
					if (selectedSkin)
					{
						normalSkin.visible = true;
						selectedSkin.visible = false;
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
			//callLater(redraw);
		}
		
		override public function redraw():void
		{
			//super.redraw();
			//_bitmap.index = _state;
			//label.color = labelColors[_state];
			addChildAt(normalSkin, 0);
			normalSkin.visible = false;
			
			if (downSkin)
			{
				addChild(downSkin);
				downSkin.visible = false;
			}
			
			switch (_state)
			{
				case MOUSE_DOWN: 
					if (downSkin)
						downSkin.visible = true;
					else
					{
						normalSkin.visible = true;
						this.transform.colorTransform = darkColorTrans;
					}
					break;
				case NORMAL: 
					normalSkin.visible = true;
					if (_selected)
						this.transform.colorTransform = darkColorTrans;
					else
						this.transform.colorTransform = _normalColorTrans;
					break;
				default: 
			}
		
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
		
		override public function set disabled(value:Boolean):void
		{
			if (_disabled != value)
			{
				super.disabled = value;
					//state = _selected ? stateMap["selected"] : stateMap["rollOut"];
					//ObjectUtils.gray(this, _disabled);
			}
		}
		
		/**按钮标签字体*/
		public function get labelFont():String
		{
			return label.font;
		}
		
		public function set labelFont(value:String):void
		{
			label.font = value
			callLater(changeLabelSize);
		}
		
		/**按钮标签颜色(格式:upColor,overColor,downColor,disableColor)*/
		//public function get labelColors():String
		//{
		//return String(labelColors);
		//}
		//
		//public function set labelColors(value:String):void
		//{
		//labelColors = StringUtils.fillArray(labelColors, value);
		//callLater(redraw);
		//}
		
		/**按钮标签边距(格式:左边距,上边距,右边距,下边距)*/
		//public function get labelMargin():String
		//{
		//return String(labelMargin);
		//}
		//
		//public function set labelMargin(value:String):void
		//{
		//labelMargin = StringUtils.fillArray(labelMargin, value, int);
		//callLater(changeLabelSize);
		//}
		
		/**按钮标签描边(格式:color,alpha,blurX,blurY,strength,quality)*/
		//public function get labelStroke():String
		//{
		//return label.stroke;
		//}
		//
		//public function set labelStroke(value:String):void
		//{
		//label.stroke = value;
		//}
		
		/**按钮标签大小*/
		public function get labelSize():Object
		{
			return label.size;
		}
		
		public function set labelSize(value:Object):void
		{
			label.size = value
			callLater(changeLabelSize);
		}
		
		/**按钮标签粗细*/
		public function get labelBold():Object
		{
			return label.bold;
		}
		
		public function set labelBold(value:Object):void
		{
			label.bold = value
			callLater(changeLabelSize);
		}
		
		/**字间距*/
		public function get letterSpacing():Object
		{
			return label.letterSpacing;
		}
		
		public function set letterSpacing(value:Object):void
		{
			label.letterSpacing = value
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
		//public function get label():Label
		//{
		//return label;
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
			label.text = value;
			
		}
		
		public function get text():String
		{
			return label.text;
		}
		
		public function get showIcon():Boolean
		{
			return _showIcon;
		}
		
		public function set showIcon(value:Boolean):void
		{
			_showIcon = value;
			redraw();
		}
	
	}
}