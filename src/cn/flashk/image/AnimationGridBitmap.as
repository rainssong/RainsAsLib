package cn.flashk.image
{
	import cn.flashk.events.MovieEvent;
	
	import flash.display.DisplayObject;
	import flash.events.Event;

	/**
	 * AnimationGridBitmap 用来播放网格图片动画。
	 * 
	 *  
	 * @langversion ActionScript 3.0
	 * @playerversion Flash 9.0
	 * 
	 * @see cn.flashk.image.GridBitmap
	 * 
	 * @author flashk
	 */
	public class AnimationGridBitmap extends GridBitmap
	{
		protected var _playSpeed:Number = 1;
		/**
		 * 对于快放和慢放是否进行帧补偿，可以获得更好的慢放效果，但将会比较消耗CPU，默认false
		 */ 
		public var isUseFrameCompensation:Boolean = false;
		private var endFrame:uint;
		private var isCheckEnd:Boolean = false;
		protected var nowFrame:Number = 0;
		protected var isUserCall:Boolean = true;
		
		public function AnimationGridBitmap()
		{
		}
		/**
		 * 动画播放的速度，大于1为快放，0-1之间为慢放 设为负值将被重设为1，默认值为1
		 */ 
		public function set playSpeed(value:Number):void{
			_playSpeed = value;
			if(_playSpeed <0){
				_playSpeed = 1;
			}
		}
		public function get playSpeed():Number{
			return _playSpeed;
		}
		/**
		 * 获得当前播放头的位置
		 */ 
		public function get currentFrame():uint{
			return uint(nowFrame);
		}
		/**
		 * 播放网格动画
		 */ 
		public function play():void{
			isCheckEnd = false;
			this.removeEventListener(Event.ENTER_FRAME,prevFrame);
			this.addEventListener(Event.ENTER_FRAME,nextFrame);
		}
		/**
		 * 倒着播放网格动画
		 */ 
		public function backPlay():void{
			isCheckEnd = false;
			this.removeEventListener(Event.ENTER_FRAME,nextFrame);
			this.addEventListener(Event.ENTER_FRAME,prevFrame);
		}
		/**
		 * 从指定帧开始播放动画
		 */ 
		public function gotoAndPlay(frame:uint):void{
			if(frame > totalFrames) frame = totalFrames;
			viewByFrame(frame);
			nowFrame = frame-1;
			play();
		}
		/**
		 * 从指定帧开始倒着播放动画
		 */
		public function gotoAndBackPlay(frame:uint):void{
			if(frame > totalFrames) frame = totalFrames;
			viewByFrame(frame);
			nowFrame = frame+1;
			backPlay();
		}
		/**
		 * 从指定帧开始播放动画，并在指定的帧停止，如果不指定结束帧，则在最后一帧停止
		 */ 
		public function gotoAndPlayThenStop(playAt:uint,stopAt:uint=0):void{
			endFrame = stopAt;
			if(stopAt == 0) endFrame = totalFrames;
			if(endFrame < 1){
				endFrame = 1;
			}
			if(endFrame > totalFrames){
				endFrame = totalFrames;
			}
			gotoAndPlay(playAt);
			isCheckEnd = true;
			
		}
		/**
		 * 从指定帧开始倒着播放动画，并在指定的帧停止，如果不指定结束帧，则在第一帧停止
		 */
		public function gotoAndBackPlayThenStop(playAt:uint,stopAt:uint=0):void{
			endFrame = stopAt;
			if(endFrame < 1){
				endFrame = 1;
			}
			if(endFrame > totalFrames){
				endFrame = totalFrames;
			}
			gotoAndBackPlay(playAt);
			isCheckEnd = true;
		}
		/**
		 * 显示并在指定帧停止
		 */ 
		public function gotoAndStop(frame:uint):void{
			nowFrame = frame;
			checkAndResetNowFrame();
			this.removeEventListener(Event.ENTER_FRAME,prevFrame);
			this.removeEventListener(Event.ENTER_FRAME,nextFrame);
			viewByFrame(nowFrame);
		}
		/**
		 * 暂停动画播放
		 */ 
		public function pause():void{
			this.removeEventListener(Event.ENTER_FRAME,prevFrame);
			this.removeEventListener(Event.ENTER_FRAME,nextFrame);
		}
		/**
		 * 停止动画播放，与pause方法不同的是，播放头将设为1，并显示第1帧的画面
		 */
		public function stop():void{
			this.removeEventListener(Event.ENTER_FRAME,prevFrame);
			this.removeEventListener(Event.ENTER_FRAME,nextFrame);
			nowFrame = 1;
			viewByFrame(nowFrame);
		}
		/**
		 * 显示下一帧
		 */
		public function nextFrame(event:Event = null):void{
			nowFrame += playSpeed;
			if(nowFrame > totalFrames) nowFrame =nowFrame%totalFrames;
			isUserCall = false;
			if(nowFrame<1 && nowFrame >0) return;
			viewByFrame(nowFrame);
			if(BitmapTool.getNoAlphaArea(this.bitmapData,true).width == 0){
				nextFrame();
			}
			if(isCheckEnd == true && uint(nowFrame) == endFrame ){
				this.removeEventListener(Event.ENTER_FRAME,nextFrame);
				this.dispatchEvent(new MovieEvent(MovieEvent.PLAY_ENDED));
			}
		}
		/**
		 * 显示上一帧
		 */
		public function prevFrame(event:Event = null):void{
			nowFrame-= playSpeed;
			if(nowFrame<1) nowFrame = totalFrames+nowFrame ;
			isUserCall = false;
			if(nowFrame>totalFrames ) return;
			if(nowFrame == uint(nowFrame)+0.5) return;
			viewByFrame(nowFrame);
			if(isCheckEnd == true && uint(nowFrame) == endFrame ){
				this.removeEventListener(Event.ENTER_FRAME,prevFrame);
				this.dispatchEvent(new MovieEvent(MovieEvent.BACK_PLAY_ENDED));
			}
		}
		private function checkAndResetNowFrame():void{
			if(nowFrame <1){
				nowFrame = 1;
			}
			if(nowFrame > totalFrames){
				nowFrame = totalFrames;
			}
		}
		/**
		 * @copy GridBitmap
		 */ 
		override public function viewByXY(X:uint,Y:uint):void{
			super.viewByXY(X,Y);
			if(isUserCall == true){
				this.removeEventListener(Event.ENTER_FRAME,prevFrame);
				this.removeEventListener(Event.ENTER_FRAME,nextFrame);
			}
			isUserCall = true;
		}
		override public function viewByFrame(frame:uint):void{
			if(isUserCall == true){
				nowFrame = frame;
				this.removeEventListener(Event.ENTER_FRAME,prevFrame);
				this.removeEventListener(Event.ENTER_FRAME,nextFrame);
			}
			super.viewByFrame(frame);
			isUserCall = true;
		}
	}
}