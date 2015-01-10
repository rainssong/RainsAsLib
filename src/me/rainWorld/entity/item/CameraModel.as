package me.rainWorld.entity.item 
{
	import me.rainWorld.entity.EntityModel;
	
	/**
	 * @date 2014/12/17 22:33
	 * @author Rainssong
	 * @blog http://blog.sina.com.cn/rainssong
	 * @homepage http://rainsgameworld.sinaapp.com
	 * @weibo http://www.weibo.com/rainssong
	 */
	public class CameraModel
	{
		private var _zoom:Number = 1;
		public var target:EntityModel
		
		protected var _viewWidth:Number = 640;
		protected var _viewHeight:Number = 480;
		//焦距、颜色、曝光等参数
		
		public function CameraModel() 
		{
			
		}
		
		public function get zoom():Number 
		{
			return _zoom;
		}
		
		public function set zoom(value:Number):void 
		{
			_zoom = value;
		}
		
		public function get viewWidth():Number 
		{
			return _viewWidth;
		}
		
		public function set viewWidth(value:Number):void 
		{
			_viewWidth = value;
		}
		
		public function get viewHeight():Number 
		{
			return _viewHeight;
		}
		
		public function set viewHeight(value:Number):void 
		{
			_viewHeight = value;
		}
		
	}

}