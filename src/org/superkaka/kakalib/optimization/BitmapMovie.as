package org.superkaka.kakalib.optimization 
{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.Event;
	import org.superkaka.kakalib.interfaces.IRecycle;
	import org.superkaka.kakalib.struct.BitmapFrameInfo;
	
	/**
	 * 位图缓存显示对象基类
	 * @author ｋａｋａ
	 */
	public class BitmapMovie extends Sprite implements IRecycle
	{
		
		/**
		 * 用户自定义的数据
		 */
		public var customData:Object = { };
		
		protected var bitmap:Bitmap;
		
		protected var v_frame:Vector.<BitmapFrameInfo>;
		
		protected var curIndex:int;
		
		protected var maxIndex:int;
		
		protected var _isPlaying:Boolean;
		
		public function BitmapMovie(frameInfo:Vector.<BitmapFrameInfo> = null):void
		{
			
			bitmap = new Bitmap();
			
			init();
			
			this.frameInfo = frameInfo;
			
			addEventListener(Event.ADDED_TO_STAGE, updatePlayStatus);
			addEventListener(Event.REMOVED_FROM_STAGE, updatePlayStatus);
			
		}
		
		protected function init():void
		{
			
			this.x = 0;
			this.y = 0;
			//此处还需要重置多个显示相关属性，待寻找简便方式
			this.alpha = 1;
			this.rotation = 0;
			this.visible = true;
			this.scaleX = 1;
			this.scaleY = 1;
			
			addChild(bitmap);
			
			curIndex = 0;
			maxIndex = 0;
			
			play();
			
		}
		
		/**
		 * 播放
		 */
		public function play():void
		{
			
			_isPlaying = true;
			
			updatePlayStatus();
			
		}
		
		/**
		 * 停止
		 */
		public function stop():void
		{
			
			_isPlaying = false;
			
			updatePlayStatus();
			
		}
		
		protected function updatePlayStatus(evt:Event = null):void
		{
			
			if (_isPlaying && maxIndex != 0 && stage != null)
			{
				addEventListener(Event.ENTER_FRAME, enterFrameHandler);
			}
			else
			{
				removeEventListener(Event.ENTER_FRAME, enterFrameHandler);
			}
			
		}
		
		/**
		 * 跳转到下一帧
		 */
		public function nextFrame():void
		{
			
			///循环播放
			if (curIndex == maxIndex)
			{
				
				gotoFrame(0);
				
			}
			else
			{
				
				gotoFrame(curIndex + 1);
				
			}
			
			//if (curIndex == maxIndex)
			//{
				//
				///发送播放完成事件
				//dispatchEvent(new Event(Event.COMPLETE));
				//
			//}
			
		}
		
		/**
		 * 跳转到指定帧并播放
		 * @param	frameIndex
		 */
		public function gotoAndPlay(frameIndex:int):void
		{
			
			goto(frameIndex);
			
			play();
			
		}
		
		/**
		 * 跳转到指定帧并停止
		 * @param	frameIndex
		 */
		public function gotoAndStop(frameIndex:int):void
		{
			
			goto(frameIndex);
			
			stop();
			
		}
		
		/**
		 * 跳转到指定帧
		 * @param	frameIndex
		 */
		public function goto(frameIndex:int):void
		{
			
			///用户指定的帧数从1开始，程序内部的数组索引从0开始  因此减1
			gotoFrame(frameIndex - 1);
			
		}
		
		
		private function enterFrameHandler(evt:Event):void
		{
			
			nextFrame();
			
		}
		
		
		/**
		 * 位图帧序列
		 */
		public function get frameInfo():Vector.<BitmapFrameInfo> 
		{
			
			return v_frame; 
			
		}
		
		/**
		 * 位图帧序列
		 */
		public function set frameInfo(value:Vector.<BitmapFrameInfo>):void
		{
			
			v_frame = value;
			
			bitmap.bitmapData = null;
			
			if (v_frame == null)
			{
				
				curIndex = 0;
				maxIndex = 0;
				
				updatePlayStatus();
				
			}
			else
			{
				
				maxIndex = v_frame.length - 1;
				
				gotoFrame(curIndex);
				
				updatePlayStatus();
				
			}
			
		}
		
		/**
		 * 跳转到指定索引的帧
		 * @param	frameIndex
		 */
		protected function gotoFrame(frameIndex:int):void
		{
			
			curIndex = frameIndex;
			
			if (curIndex > maxIndex)
			{
				curIndex = maxIndex;
			}
			else
			if (curIndex < 0)
			{
				curIndex = 0;
			}
			
			var f_info:BitmapFrameInfo = v_frame[curIndex];
			bitmap.bitmapData = f_info.bitmapData;
			bitmap.x = f_info.x;
			bitmap.y = f_info.y;
			
		}
		
		/**
		 * 获取当前帧索引
		 */
		public function get currentFrame():int
		{
			
			///用户指定的帧数从1开始，程序内部的数组索引从0开始  因此加1
			return curIndex + 1;
			
		}
		
		/**
		 * 获取总的帧数
		 */
		public function get totalFrames():int
		{
			
			return v_frame == null ? 0 : maxIndex + 1;
			
		}
		
		/**
		 * 获取或设置位图是否启用平滑处理
		 */
		public function get smoothing():Boolean 
		{ 
			return bitmap.smoothing; 
		}
		
		public function set smoothing(value:Boolean):void 
		{
			bitmap.smoothing = value;
		}
		
		/**
		 * 指示动画当前是否正在播放
		 */
		public function get isPlaying():Boolean 
		{
			return _isPlaying;
		}
		
		/**
		 * 获取当前位图帧信息
		 */
		public function getCurrentBitmapFrameInfo():BitmapFrameInfo
		{
			return v_frame[curIndex];
		}
		
		/**
		 * 获取指定索引的位图帧信息
		 * @param	index
		 * @return
		 */
		public function getBitmapFrameInfoByIndex(index:int):BitmapFrameInfo
		{
			///用户指定的帧数从1开始，程序内部的数组索引从0开始  因此减1
			return v_frame[index - 1];
		}
		
		/**
		 * 回收
		 */
		public function recycle():void
		{
			
			dispose();
			
			init();
			
		}
		
		/**
		 * 销毁对象，释放资源
		 */
		protected function dispose():void
		{
			
			stop();
			
			this.frameInfo = null;
			
			if(contains(bitmap))
			removeChild(bitmap);
			
		}
		
	}

}