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
	import flash.media.Sound;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	import me.rainssong.manager.SystemManager;
	import me.rainssong.media.RainStageWebView;
	import me.rainssong.utils.Draw;
	import me.rainssong.utils.ScaleMode;
	import me.rainui.events.RainUIEvent;
	import me.rainui.RainTheme;
	import me.rainui.RainUI;
	//import morn.core.handlers.Handler;
	//import morn.core.utils.ObjectUtils;
	//import morn.core.utils.StringUtils;
	
	/**选择改变后触发*/
	[Event(name="select",type="flash.events.Event")]
	
	/**按钮类*/
	dynamic  public class TestButton extends Container
	{
		public var darkColorTrans:ColorTransform = RainUI.darkColorTrans;
		
		static public const SELECTED:String = "selected";
		static public const MOUSE_DOWN:String = "mouseDown";
		static public const HOVER:String = "hover";
		static public const NORMAL:String = "normal";
		static public const DISABLED:String = "disabled";
		public var clickHandler:Function;
		public var upHandler:Function;
		public var downHandler:Function;
		public var overHandler:Function;
		public var outHandler:Function;
		public var selectHandler:Function;
		public var unselectHandler:Function;
		public var soundOver:Sound;
		public var soundDown:Sound;
		public var soundUp:Sound;
		public var soundOut:Sound;
		
		protected var _label:Label;
		protected var _normalSkin:DisplayObject;
		protected var _downSkin:DisplayObject;
		protected var _hoverSkin:DisplayObject;
		protected var _disabledSkin:DisplayObject;
		protected var _selectedSkin:DisplayObject;
		protected var _iconSkin:DisplayObject;
		
		protected var _showIcon:Boolean = false;
		
		protected var _state:String = NORMAL;
		protected var _toggle:Boolean = false;
		protected var _selected:Boolean = false;
		protected var _normalColorTrans:ColorTransform = new ColorTransform();
		
		//要考虑用户已经设置的情况
		public static var defaultStyleFactory:Function;
		
		public function TestButton(text:String = "",dataSource:Object=null)
		{
			super(dataSource);
			this.text = text;
		}
		
		override protected function preinitialize():void
		{
			super.preinitialize();
			
			//this.buttonMode = true;
			//this.useHandCursor = true;
			//this.mouseChildren = false
			//this.mouseEnabled = true;
			
			//this._width = 200*RainUI.scale;
			//this._height = 60*RainUI.scale;
		}
		
		override protected function createChildren():void
		{
			
			
			//if (this.numChildren == 1 && _normalSkin==null)
			//{
				//_normalSkin = this.getChildAt(0);
			//}
			 //if (_normalSkin == null)
			//{
				//_normalSkin = RainUI.getSkin("buttonNormal");
				//addChild(_normalSkin);
				//this._width = 200*RainUI.scale;
				//this._height = 60*RainUI.scale;
			//}
			//else
			//{
				//_normalSkin.scaleX *=  RainUI.scale;
				//_normalSkin.scaleY *=  RainUI.scale;
			//}
			//
			//if (isNaN(_width))
			//{
				//this._width = _normalSkin.width
				//this._height = _normalSkin.height
			//}
			//
			//if (_downSkin)
				//_downSkin.visible = false;
			//if (_selectedSkin)
				//_selectedSkin.visible = false;
			//
			if (label == null)
			{
				_label = new Label();
				_label.centerX = 0;
				_label.centerY = 0;
				_label.autoSize = true;
				_label.size = RainUI.scale * 32;
				_label.color = 0xffffff;
				addChild(_label);
			}
			
			//if (defaultStyleFactory!=null)
				//defaultStyleFactory(this);
			
			//_normalColorTrans = _normalSkin.transform.colorTransform;
			
			super.createChildren();
		}
		
		override protected function initialize():void
		{
			super.initialize();
			
			//clickHandler = null;
			//upHandler = null;
			//downHandler = null;
			//outHandler = null;
			//overHandler = null;
			//
			//soundOver = null;
			//soundOut = null;
			//soundDown = null;
			//soundUp = null;
			//
			//addEventListener(MouseEvent.ROLL_OVER, onRollOver);
			//addEventListener(MouseEvent.ROLL_OUT, onRollOut);
			//addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
			//addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
			//addEventListener(MouseEvent.RELEASE_OUTSIDE, onMouseUp);
			//addEventListener(MouseEvent.CLICK, onClick);
			//callLater(redraw);
		}
		
		override public function resize():void
		{
			super.resize();
			//if (_normalSkin)
			//{
				//this._normalSkin.width = _width;
				//this._normalSkin.height = _height;
			//}
			//if (this._downSkin)
			//{
				//this._downSkin.width = _width;
				//this._downSkin.height = _height;
			//}
			//if (this._selectedSkin)
			//{
				//this._selectedSkin.width = _width;
				//this._selectedSkin.height = _height;
			//}
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
		
		/**是否是选择状态*/
		//[Inspectable(name="selected",type="Boolean",defaultValue=false)]
		//public function get selected():Boolean
		//{
			//return _selected;
		//}
		//
		//public function set selected(value:Boolean):void
		//{
			//
			//var e:RainUIEvent 
			//
			//if (_selected != value)
			//{
				//_selected = value;
				//if (_selected)
				//{
					//_state = SELECTED;
					//sendEvent(RainUIEvent.SELECT);
					//if (selectHandler != null)
					//{
						//e= new RainUIEvent(RainUIEvent.SELECT, null, true, false);
						//selectHandler(e );
					//}
						//
				//}
				//else
				//{
					//_state = NORMAL;
					//if (unselectHandler != null)
					//{
						//e= new RainUIEvent(RainUIEvent.SELECT, null, true, false);
						//unselectHandler(e);
					//}
				//}
				//sendEvent(RainUIEvent.CHANGE);
				//callLater(redraw);
		//}
			//}
		//
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
			if(_normalSkin)_normalSkin.visible = false;
			if(_downSkin)_downSkin.visible = false;
			if(_selectedSkin)_selectedSkin.visible = false;
			if (_hoverSkin)_hoverSkin.visible = false;
			
			switch (_state)
			{
				case MOUSE_DOWN: 
					if (_downSkin)
					{
						_downSkin.visible = true;
					}
					else
					{
						_normalSkin.visible = true;
						_normalSkin.transform.colorTransform = darkColorTrans;
					}
					break;
				case NORMAL: 
					if (_normalSkin)
					{
						_normalSkin.visible = true;
						_normalSkin.transform.colorTransform = _normalColorTrans;
					}
					break;
				case HOVER: 
					if (_hoverSkin)
						_hoverSkin.visible = true;
					else
						_normalSkin.visible = true;
					break;
				case SELECTED:
					if (_selectedSkin)
						_selectedSkin.visible = true;
					else
					{
						_normalSkin.visible = true;
						_normalSkin.transform.colorTransform = darkColorTrans;
					}
					break;
				default: 
			}
			
			
			super.redraw();
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
			callLater(redraw);
		}
		
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
			callLater(redraw);
		}
		
		/**按钮标签粗细*/
		public function get labelBold():Object
		{
			return _label.bold;
		}
		
		public function set labelBold(value:Object):void
		{
			_label.bold = value
			callLater(redraw);
		}
		
		/**字间距*/
		public function get letterSpacing():Object
		{
			return _label.letterSpacing;
		}
		
		public function set letterSpacing(value:Object):void
		{
			_label.letterSpacing = value
			callLater(redraw);
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
		public function get label():Label
		{
			return _label;
		}
		
		public function set label(value:Label):void
		{
			swapContent(_label, value);
			_label = value;
			callLater(redraw);
		}
		
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
			//callLater(changeLabelSize);
		}
		
		override public function set height(value:Number):void
		{
			super.height = value;
			if (_autoSize)
			{
				//_bitmap.height = value;
			}
			callLater(redraw);
		}
		
		public function set text(value:String):void
		{
			_label.text = value;
			callLater(resize);
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
		
		public function get normalSkin():DisplayObject 
		{
			return _normalSkin;
		}
		
		public function set normalSkin(value:DisplayObject):void 
		{
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
		
		public function get selectedSkin():DisplayObject 
		{
			return _selectedSkin;
		}
		
		public function set selectedSkin(value:DisplayObject):void 
		{
			swapContent(_selectedSkin, value);
			_selectedSkin = value;
			callLater(redraw);
		}
		
		public function get iconSkin():DisplayObject 
		{
			return _iconSkin;
		}
		
		public function set iconSkin(value:DisplayObject):void 
		{
			
			swapContent(_iconSkin, value);
			_iconSkin = value;
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
		
		/* DELEGATE me.rainui.components.Label */
		
		public function get htmlText():String 
		{
			return _label.htmlText;
		}
		
		public function set htmlText(value:String):void 
		{
			_label.htmlText = value;
		}
		
		public function get hoverSkin():DisplayObject 
		{
			return _hoverSkin;
		}
		
		public function set hoverSkin(value:DisplayObject):void 
		{
			swapContent(_hoverSkin, value);
			_hoverSkin = value;
			callLater(redraw);
		}
		
		
	
	}
}