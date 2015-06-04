package me.rainui.components 
{
	import flash.display.DisplayObject;
	import flash.events.Event;
	import me.rainssong.utils.Align;
	import me.rainssong.utils.ScaleMode;
	import me.rainui.RainUI;
	
	/**
	 * @date 2015/5/24 5:03
	 * @author rainssong
	 * @blog http://blog.sina.com.cn/rainssong
	 * @homepage http://rainsgameworld.sinaapp.com
	 * @weibo http://www.weibo.com/rainssong
	 */
	public class ProgressBar extends Container 
	{
		protected var _barContainer:DisplayResizer;
		protected var _barSkin:DisplayObject;
		protected var _value:Number = 0;
		protected var _min:Number = 0;
		protected var _max:Number = 100;
		protected var _label:Label;
		public function ProgressBar(text:String="",dataSource:Object=null) 
		{
			super(dataSource);
			_label.text = text;
		}
		
		override protected function preinitialize():void 
		{
			super.preinitialize();
			_width = 300;
			_height = 60;
		}
		
		override protected function createChildren():void 
		{
			if (_bgSkin == null)
			{
				_bgSkin = RainUI.getSkin("progressBarBg");
				addChild(_bgSkin)
			}
			if (_barContainer == null)
			{
				_barContainer = new DisplayResizer();
				_barContainer.left = 2;
				_barContainer.right = 2;
				_barContainer.top = 2;
				_barContainer.bottom = 2;
				_barContainer.contentAlign = Align.LEFT;
				_barContainer.contentScaleMode = ScaleMode.NONE;
				addChild(_barContainer);
			}
			if (_barSkin == null)
			{
				_barSkin = RainUI.getSkin("progressBar");
				_barContainer.content = _barSkin;
			}
			if (_label == null)
			{
				_label = new Label();
				_label.percentWidth = 1;
				_label.centerY = 0;
				_label.align = Align.CENTER;
				addChild(_label);
			}
			
			callLater(redraw);
		}
		
		override public function redraw():void 
		{
			var w:Number = _barContainer.width * percent;
			_barSkin.width = w;
			super.redraw();
		}
		
		override public function resize():void 
		{
			super.resize();
			_barSkin.height =  _barContainer.height;
		}
		
		public function get value():Number 
		{
			return _value;
		}
		
		public function set value(value:Number):void 
		{
			_value = value;
			callLater(redraw);
		}
		
		public function get min():Number 
		{
			return _min;
		}
		
		public function set min(value:Number):void 
		{
			_min = value;
			callLater(redraw);
		}
		
		public function get max():Number 
		{
			return _max;
		}
		
		public function set max(value:Number):void 
		{
			_max = value;
			callLater(redraw);
		}
		
		public function get percent():Number 
		{
			return _value/(_max-_min);
		}
		
		public function set percent(value:Number):void 
		{
			_value = (_max - _min) * value;
			callLater(redraw);
		}
		
		public function get barSkin():DisplayObject 
		{
			return _barSkin;
		}
		
		public function set barSkin(value:DisplayObject):void 
		{
			swapContent(_barSkin, value);
			_barSkin = value;
		}
	}

}