package me.rainui.components
{
	import flash.display.DisplayObject;
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
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
	public class DisplayResizer extends Container
	{
		protected var _content:DisplayObject
	
		private var _contentScaleMode:String = ScaleMode.FULL_FILL;
		private var _contentAlign:String = Align.CENTER;
		
		public function DisplayResizer(content:DisplayObject=null)
		{
			if(content)
				this.content = content;
		}
		
		override protected function preinitialize():void 
		{
			super.preinitialize();
			_width = 100;
			_height = 100;
		}
		
		override protected function createChildren():void 
		{
			if (_content != null)
				this._content = new Sprite();
			super.createChildren();
		}
		
		override public function redraw():void 
		{
			super.redraw();
			if (this._content is Loader)
			{
				var l:Loader = this._content as Loader;
				l.contentLoaderInfo.addEventListener(Event.COMPLETE, onLoadComplete);
			}
		}
		
		private function onLoadComplete(e:Event):void
		{
			var l:Loader = this.content as Loader;
			l.contentLoaderInfo.removeEventListener(Event.COMPLETE, onLoadComplete);
			callLater(resize);
		}
		
		/**
		 * 已知问题：并未排除被除数为0的情况
		 */
		override public function resize():void
		{
			super.resize();
			
			if (content==null || _width==0 || _height==0)
				return;
			
			var _scaleX:Number = _width / content.width*content.scaleX;
			var _scaleY:Number = _height / content.height*content.scaleY;
			var minScale:Number = Math.min(_scaleX, _scaleY);
			var maxScale:Number = Math.max(_scaleX, _scaleY);
			
			switch (_contentScaleMode)
			{
				case ScaleMode.NONE:
					break;
				case ScaleMode.EXACT_FIT: 
					content.width = _width;
					content.height = _height;
					break;
				case ScaleMode.FULL_FILL: 
					content.scaleX = content.scaleY = maxScale;
					break;
				case ScaleMode.HEIGHT_ONLY:
					content.scaleX = content.scaleY = _scaleY;
					break;
				case ScaleMode.WIDTH_ONLY:
					content.scaleX = content.scaleY = _scaleX;
					break;
				case ScaleMode.SHOW_ALL:
					content.scaleX = content.scaleY = minScale;
					break;
				default: 
			}
			
			switch (_contentAlign) 
			{
				case Align.BOTTOM:
				case Align.BOTTOM_LEFT:
				case Align.BOTTOM_RIGHT:
					content.y = _height - content.height;
				break;
				case Align.TOP:
				case Align.TOP_LEFT:
				case Align.TOP_RIGHT:
					content.y = 0;
				break;
				case Align.CENTER:
				case Align.LEFT:
				case Align.RIGHT:
					content.y = (_height - content.height)*0.5;
				break;
				default:
			}
			
			switch (_contentAlign) 
			{
				case Align.TOP_LEFT:
				case Align.LEFT:
				case Align.BOTTOM_LEFT :
					content.x = 0;
				break;
				case Align.CENTER:
				case Align.TOP:
				case Align.BOTTOM:
					content.x = (_width - content.width)*0.5;
				break;
				case Align.TOP_RIGHT:
				case Align.RIGHT:
				case Align.BOTTOM_RIGHT:
					content.x = _width - content.width;
				break;
				default:
			}
		}
		
		public function get contentScaleMode():String
		{
			return _contentScaleMode;
		}
		
		public function set contentScaleMode(value:String):void
		{
			if (_contentScaleMode == value) return;
			_contentScaleMode = value;
			callLater(resize);
		}
		
		public function get contentAlign():String
		{
			return _contentAlign;
		}
		
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
	
	}

}