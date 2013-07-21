package me.rainssong.display
{
	
	/**
	 * 动画对象
	 * @author S_eVent
	 *
	 */
	public class AnimationBitmap extends Bitmap
	{
		public static const PLAY_OVER_EVENT:String = "play over event";
		
		public var imgList:Array = new Array();
		private var timer:Timer = new Timer(100);
		private var currentFrame:int = 0;
		private var _stopIndex:int = 0;
		
		public function AnimationBitmap(bitmapData:BitmapData = null, pixelSnapping:String = "auto", smoothing:Boolean = false)
		{
			super(bitmapData, pixelSnapping, smoothing);
			timer.addEventListener(TimerEvent.TIMER, onTimer);
		}
		
		/**
		 * 播放动画
		 *
		 */
		public function play():void
		{
			timer.reset();
			timer.start();
		}
		
		/**
		 * 停止动画
		 *
		 */
		public function stop():void
		{
			timer.stop();
		}
		
		/**
		 * 设置动画帧率
		 * @param value 多少时间切换一副图片，单位毫秒
		 *
		 */
		public function set frameRate(value:int):void
		{
			timer.delay = value;
		}
		
		/**
		 * 设置动画播放次数 ，若为0，则不断运行，默认为0
		 * @param value 动画播放次数，单位：次
		 *
		 */
		public function set repeatCount(value:int):void
		{
			timer.repeatCount = value * imgList.length;
		}
		
		/**
		 * 设置静止时动画所处帧
		 * @param value
		 *
		 */
		public function set stopIndex(value:int):void
		{
			_stopIndex = value;
			currentFrame = _stopIndex;
			this.bitmapData = imgList[_stopIndex];
		}
		
		private function onTimer(event:TimerEvent):void
		{
			this.bitmapData = imgList[currentFrame];
			currentFrame++;
			if (imgList.length == 6)
				trace(currentFrame);
			if (currentFrame > imgList.length - 1)
			{
				currentFrame = _stopIndex;
				this.bitmapData = imgList[_stopIndex];
				dispatchEvent(new Event(PLAY_OVER_EVENT));
			}
		}
	}
}