package me.rainui.components
{
	import flash.display.DisplayObject;
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.geom.Rectangle;
	import me.rainssong.application.ApplicationBase;
	import me.rainssong.utils.Align;
	import me.rainssong.utils.Directions;
	import me.rainssong.utils.ScaleMode;
	
	/**
	 * @date 2014/12/14 18:43
	 * @author Rainssong
	 * @blog http://blog.sina.com.cn/rainssong
	 * @homepage http://rainsgameworld.sinaapp.com
	 * @weibo http://www.weibo.com/rainssong
	 * 还未解决主动赋值content的Bug;
	 */
	dynamic public class DisplayResizer extends Container
	{
		protected var _content:DisplayObject
		protected var _contentScaleMode:String = ScaleMode.SHOW_ALL;
		protected var _contentAlign:String = Align.CENTER;
		public var contentBorderColor:int = -1;
		
		public function DisplayResizer(content:DisplayObject=null,dataSource:Object=null)
		{
			super(dataSource);
			if(content)
				this.content = content;
		}
		
		override protected function onParentResize(param0:Event):void 
		{
			super.onParentResize(param0);
		}
		
		override protected function preinitialize():void 
		{
			super.preinitialize();
			_width = 100;
			_height = 100;
		}
		
		override protected function createChildren():void 
		{
			if (this.numChildren == 1)
					this._content = this.getChildAt(0);
					
			if (_content == null)
			{
				this._content = new Sprite();
			}
			else
			{
				_width = _content.width;
				_height = _content.height;
			}
			
			if (_content.parent == null)
				addChild(_content);
				
			super.createChildren();
		}
		
		override public function redraw():void 
		{
			if (this._content is Loader)
			{
				var l:Loader = this._content as Loader;
				l.contentLoaderInfo.addEventListener(Event.COMPLETE, onLoadComplete);
			}
			if (_content && _content.parent == null)
				addChild(_content);
			super.redraw();
		}
		
		private function onLoadComplete(e:Event):void
		{
			var l:Loader = this.content as Loader;
			l.contentLoaderInfo.removeEventListener(Event.COMPLETE, onLoadComplete);
			callLater(resize);
		}
		
		/**
		 * BUG：并未排除被除数为0的情况
		 */
		override public function resize():void
		{
			if (_content==null || _width==0 || _height==0 || _content.width==0 || _content.height==0)
				return;
			
			var _scaleX:Number = _width / _content.width*_content.scaleX;
			var _scaleY:Number = _height / _content.height*_content.scaleY;
			var minScale:Number = Math.min(_scaleX, _scaleY);
			var maxScale:Number = Math.max(_scaleX, _scaleY);
			
			switch (_contentScaleMode)
			{
				case ScaleMode.NONE:
					break;
				case ScaleMode.EXACT_FIT: 
					_content.scaleX = _scaleX;
					_content.scaleY = _scaleY;
					break;
				case ScaleMode.FULL_FILL: 
					_content.scaleX = _content.scaleY = maxScale;
					break;
				case ScaleMode.HEIGHT_ONLY:
					_content.scaleX = _content.scaleY = _scaleY;
					break;
				case ScaleMode.WIDTH_ONLY:
					_content.scaleX = _content.scaleY = _scaleX;
					break;
				case ScaleMode.SHOW_ALL:
					_content.scaleX = _content.scaleY = minScale;
					break;
				default: 
			}
			
			switch (_contentAlign) 
			{
				case Align.BOTTOM:
				case Align.BOTTOM_LEFT:
				case Align.BOTTOM_RIGHT:
					_content.y = _height - _content.height;
				break;
				case Align.TOP:
				case Align.TOP_LEFT:
				case Align.TOP_RIGHT:
					_content.y = 0;
				break;
				case Align.CENTER:
				case Align.LEFT:
				case Align.RIGHT:
					_content.y = (_height - _content.height)*0.5;
				break;
				default:
			}
			
			switch (_contentAlign) 
			{
				case Align.TOP_LEFT:
				case Align.LEFT:
				case Align.BOTTOM_LEFT :
					_content.x = 0;
				break;
				case Align.CENTER:
				case Align.TOP:
				case Align.BOTTOM:
					_content.x = (_width - _content.width)*0.5;
				break;
				case Align.TOP_RIGHT:
				case Align.RIGHT:
				case Align.BOTTOM_RIGHT:
					_content.x = _width - _content.width;
				break;
				default:
			}
			
			super.resize();
		}
		
		public function get contentScaleMode():String
		{
			return _contentScaleMode;
		}
		
		[Inspectable(name="contentScaleMode",type="String",defaultValue=ScaleMode.SHOW_ALL)]
		public function set contentScaleMode(value:String):void
		{
			if (_contentScaleMode == value) return;
			_contentScaleMode = value;
			callLater(calcSize);
		}
		
		public function get contentAlign():String
		{
			return _contentAlign;
		}
		
		[Inspectable(name="contentScaleMode",type="String",defaultValue=Align.CENTER)]
		public function set contentAlign(value:String):void
		{
			if (_contentAlign == value) return;
			_contentAlign = value;
			callLater(resize);
		}
		
		public function get content():DisplayObject 
		{
			return _content;
		}
		
		public function set content(value:DisplayObject):void 
		{
			swapContent(_content, value);
			_content = value;
			callLater(redraw);
		}
		
		override public function showBorder(param0:uint = 16711680, param1:int = -1):void 
		{
			
			super.showBorder(param0, param1);
			
			if (contentBorderColor > 0)
			{
				var contentRect:Rectangle = getBounds(this);
				_border.graphics.lineStyle(1, contentBorderColor);
				_border.graphics.drawRect(contentRect.x, contentRect.y, contentRect.width, contentRect.height);
			}
		}
	
	}

}