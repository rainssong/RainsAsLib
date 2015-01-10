package me.rainui.components
{
	import flash.display.BitmapData;
	import me.rainui.components.Component;
	import me.rainui.events.RainUIEvent;
	
	/**
	 * ...
	 * @author Rainssong
	 * @timeStamp 2014/6/10 17:22
	 * @blog http://blog.sina.com.cn/rainssong
	 */
	public class Image extends Component
	{
		protected var _bitmap:SmartBitmap;
		protected var _url:String;
		
		public function Image(url:String = null)
		{
			this.url = url;
		}
		
		override protected function createChildren():void
		{
			addChild(_bitmap = new SmartBitmap());
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
				}
				else
				{
					bitmapData = null;
				}
			}
		}
		
		/**源位图数据*/
		public function get bitmapData():BitmapData
		{
			return _bitmap.bitmapData;
		}
		
		public function set bitmapData(value:BitmapData):void
		{
			//if (value)
			//{
				//_contentWidth = value.width;
				//_contentHeight = value.height;
			//}
			_bitmap.bitmapData = value;
			//sendEvent(RainUIEvent.IMAGE_LOADED);
		}
		
		protected function setBitmapData(url:String, bmd:BitmapData):void
		{
			if (url == _url)
			{
				bitmapData = bmd;
			}
		}
		
		override public function set width(value:Number):void
		{
			super.width = value;
			_bitmap.width = width;
		}
		
		override public function set height(value:Number):void
		{
			super.height = value;
			_bitmap.height = height;
		}
		
		/**九宫格信息(格式:左边距,上边距,右边距,下边距)*/
		public function get sizeGrid():String
		{
			if (_bitmap.sizeGrid)
			{
				return _bitmap.sizeGrid.join(",");
			}
			return null;
		}
		
		public function set sizeGrid(value:String):void
		{
			//_bitmap.sizeGrid = StringUtils.fillArray(Styles.defaultSizeGrid, value);
		}
		
		/**位图控件实例*/
		public function get bitmap():SmartBitmap
		{
			return _bitmap;
		}
		
		/**是否对位图进行平滑处理*/
		public function get smoothing():Boolean
		{
			return _bitmap.smoothing;
		}
		
		public function set smoothing(value:Boolean):void
		{
			_bitmap.smoothing = value;
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
		
		/**销毁资源
		 * @param	clearFromLoader 是否同时删除加载缓存*/
		public function dispose(clearFromLoader:Boolean = false):void
		{
			//App.asset.disposeBitmapData(_url);
			_bitmap.bitmapData = null;
			if (clearFromLoader)
			{
				//App.loader.clearResLoaded(_url);
			}
		}
	
	}

}