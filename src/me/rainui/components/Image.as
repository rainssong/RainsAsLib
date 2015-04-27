package me.rainui.components
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
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
		
		public function Image(url:String = null)
		{
			this.url = url;
		}
		
		override protected function preinitialize():void 
		{
			super.preinitialize();
			_contentScaleMode = ScaleMode.NONE;
		}
		
		override protected function createChildren():void
		{
			_content = new Bitmap();
			_loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onLoadComplete);
			_loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, onLoadError);
			super.createChildren();
		}
		
		private function onLoadError(e:IOErrorEvent):void 
		{
			powerTrace(e.text)
		}
		
		private function onLoadComplete(e:Event):void 
		{
			bitmap.bitmapData=Bitmap( _loader.content).bitmapData
			callLater(resize);
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
					bitmapData = null;
				}
			}
			
			if (_url == "")
			{
				bitmapData =null
			}
		}
		
		/**源位图数据*/
		public function get bitmapData():BitmapData
		{
			return bitmap.bitmapData;
		}
		
		public function set bitmapData(value:BitmapData):void
		{
			//if (!(value is BitmapData))
			//{
				//powerTrace("wrong value");
				//return;
			//}
			bitmap.bitmapData = value;
			callLater(resize);
			//sendEvent(RainUIEvent.IMAGE_LOADED);
		}
		
		override public function set width(value:Number):void
		{
			super.width = value;
			//bitmap.width = width;
		}
		
		override public function set height(value:Number):void
		{
			super.height = value;
			//bitmap.height = height;
		}
		
		/**九宫格信息(格式:左边距,上边距,右边距,下边距)*/
		//public function get sizeGrid():String
		//{
			//if (bitmap.sizeGrid)
			//{
				//return bitmap.sizeGrid.join(",");
			//}
			//return null;
		//}
		//
		//public function set sizeGrid(value:String):void
		//{
			////_bitmap.sizeGrid = StringUtils.fillArray(Styles.defaultSizeGrid, value);
		//}
		
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
		
		public function set bitmap(value:Bitmap):void 
		{
			_content = value;
		}
		
		/**销毁资源
		 * @param	clearFromLoader 是否同时删除加载缓存*/
		public function dispose(clearFromLoader:Boolean = false):void
		{
			//App.asset.disposeBitmapData(_url);
			bitmap.bitmapData = null;
			if (clearFromLoader)
			{
				//App.loader.clearResLoaded(_url);
			}
		}
	
	}

}