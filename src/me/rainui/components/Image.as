package me.rainui.components
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.display.Shape;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.geom.Rectangle;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import me.rainssong.display.BitmapDataCore;
	import me.rainssong.utils.ScaleMode;
	import me.rainui.components.Component;
	import me.rainui.events.RainUIEvent;
	
	/**
	 * ...
	 * @author Rainssong
	 * @timeStamp 2014/6/10 17:22
	 * @blog http://blog.sina.com.cn/rainssong
	 */
	public class Image extends DisplayResizer
	{
		//protected var _bitmap:SmartBitmap;
		protected var _url:String;
		protected var _loader:Loader = new Loader();
		protected var _scale9Rect:Rectangle;
		protected var _sourceBmd:BitmapData;
		
		public function Image(url:String = null,dataSource:Object=null)
		{
			
			super(null,dataSource);
			this.url = url;
		}
		
		override protected function preinitialize():void 
		{
			super.preinitialize();
			_contentScaleMode = ScaleMode.NONE;
		}
		
		override protected function createChildren():void
		{
			if (this.numChildren == 1 )
			{
				_width = getChildAt(0).width;
				_height =  getChildAt(0).height;
			}
			if (this.numChildren == 1 && getChildAt(0) is Bitmap)
			{
				//if (this.getChildAt(0) is Bitmap)
				_content = this.getChildAt(0) as Bitmap;
			}
		
			if(_content==null)
			{
				_content = new Bitmap(null,"auto",true);
				addChild(_content);
				_sourceBmd = bitmap.bitmapData;
			}
			else
			{
				_width = _content.width;
				_height = _content.height;
			}
			_loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onLoadComplete);
			_loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, onLoadError);
			//super.createChildren();
		}
		
		private function onLoadError(e:IOErrorEvent):void 
		{
			powerTrace(e.text);
			dispatchEvent(e.clone());
		}
		
		private function onLoadComplete(e:Event):void 
		{
			_sourceBmd = Bitmap( _loader.content).bitmapData;
			bitmap.bitmapData = _sourceBmd;
			//callLater(resize);
			callLater(redraw);
			
			dispatchEvent(e.clone());
		}
		
		/**图片地址*/
		public function get url():String
		{
			return _url;
		}
		
		public function set url(value:String):void
		{
			if (_url != value)
			{
				_url = value;
				if (Boolean(value))
				{
					//if (App.asset.hasClass(_url))
					//{
						//bitmapData = App.asset.getBitmapData(_url);
					//}
					//else
					//{
						//App.loader.loadBMD(_url, new Handler(setBitmapData, [_url]));
					//}
					_loader.load(new URLRequest(value));
				}
				else
				{
					_sourceBmd = null;
				}
			}
			
			if (_url == "")
			{
				_sourceBmd =null
			}
		}
		
		/**源位图数据*/
		public function get bitmapData():BitmapData
		{
			return _sourceBmd;
		}
		
		//仅改变源图
		public function set bitmapData(value:BitmapData):void
		{
			if (bitmap)
			{
				_sourceBmd =value;
				
			}
			callLater(resize);
			//sendEvent(RainUIEvent.IMAGE_LOADED);
		}
		
		override public function set width(value:Number):void
		{
			super.width = value;
		}
		
		override public function set height(value:Number):void
		{
			super.height = value;
		}
		
		
		/**是否对位图进行平滑处理*/
		public function get smoothing():Boolean
		{
			return bitmap.smoothing;
		}
		
		public function set smoothing(value:Boolean):void
		{
			bitmap.smoothing = value;
		}
		
		override public function set dataSource(value:Object):void
		{
			_dataSource = value;
			if (value is String)
			{
				url = String(value);
			}
			else
			{
				super.dataSource = value;
			}
		}
		
		public function get bitmap():Bitmap 
		{
			return _content as Bitmap;
		}
		
		//独占唯一
		//public function set bitmap(value:Bitmap):void 
		//{
			//_content = value;
//
			//_sourceBmd = bitmap.bitmapData;
		//}
		
		public function get scale9Rect():Rectangle 
		{
			return _scale9Rect;
		}
		
		public function set scale9Rect(value:Rectangle):void 
		{
			_scale9Rect = value;
			callLater(resize);
		}
		
		/**销毁资源
		 * @param	clearFromLoader 是否同时删除加载缓存*/
		public function dispose(clearFromLoader:Boolean = false):void
		{
			//App.asset.disposeBitmapData(_url);
			if (bitmap)
			{
				bitmap.bitmapData = null;
				_sourceBmd=null
			}
				
			if (clearFromLoader)
			{
				//App.loader.clearResLoaded(_url);
			}
		}
		
		
		override public function resize():void 
		{
			
			super.resize();
			
			callLater(runScale9);
			//powerTrace("Image", width, height);
		}
		
		private function runScale9():void 
		{
			if (_scale9Rect && bitmap && _sourceBmd)
				bitmap.bitmapData = BitmapDataCore.scale9Bmd(_sourceBmd, _scale9Rect, _width, _height)
			else
				bitmap.bitmapData  = _sourceBmd;
		}
		
		override public function redraw():void 
		{
			
			super.redraw();
			callLater(runScale9);
			//if (_scale9Rect && bitmap && _sourceBmd)
				//bitmap.bitmapData=BitmapDataCore.scale9Bmd(_sourceBmd,_scale9Rect,_width,_height)
		}
	
	}

}