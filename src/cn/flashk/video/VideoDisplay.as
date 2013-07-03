package cn.flashk.video
{
	import cn.flashk.conversion.ColorMatrix;
	
	import flash.events.Event;
	import flash.filters.ColorMatrixFilter;
	import flash.media.SoundTransform;
	import flash.media.Video;
	import flash.net.NetConnection;
	import flash.net.NetStream;
	import flash.utils.setTimeout;
	
	/**
	 * 当视频的长度和宽度等信息可用时将调度
	 * @eventType VideoDisplay.WIDTH_HEIGHT_ALLOWED_GET
	 **/
	[Event(name="widthHeightAllowedGet",type="flash.events.Event")]

	
	
	/**
	 * VideoDisplay 是一个非常轻量级的视频播放呈现器，使用VideoDisplay可以快速方便在你的应用中播放指定视频，并且拥有最好的性能。
	 * 
	 * <p>此类提供了快速调整视频亮度、对比度、色彩饱和度和色相偏移的方法。并且无需其它代码，Video将自动把宽高调整到相应100%大小（可设置比例及开启/关闭）。</p>
	 * <p>为了在执行时获得最高性能，VideoDisplay直接继承自DisplayObject的Video类，并且包装了NetConnection和NetStream，你无须写任何代码即可播放指定地址的视频</p>
	 * <p>VideoDisplay并不支持鼠标交互，要使用鼠标交互，请另外创建播放按钮。VideoDisplay本身提供了方法控制视频的暂停，快进，音量等 。</p>
	 * <p>另外，VideoDisplay也提供了一个简单的方法让你控制视频流的声音 </p>
	 * 
	 * @langversion ActionScript 3.0
	 * @playerversion Flash 9.0
	 * 
	 * @example 如何使用VideoDisplay
	 * * <listing version="3.0">
	 * var vd:VideoDisplay = new VideoDisplay();
	 * this.addChild(vd);
	 * vd.play("test.f4v");
	 * vd.autoResetSize = true;
	 * vd.scale = 1.5;
	 * </listing>
	 * <p>VideoDisplay是一个DisplayObject，所以你可以直接加入到显示列表，但不支持click鼠标事件</p>
	 
	 * @author flashk
	 
	 **/

	public class VideoDisplay extends Video
	{
		/**
		 * @eventType widthHeightAllowedGet
		 **/
		public static const WIDTH_HEIGHT_ALLOWED_GET:String = "widthHeightAllowedGet";
		
		/**
		 * 设置VideoDisplay是否自动匹配视频的宽高，当设值为true时一旦视频开始播放，VideoDisplay将自动设置大小为视频源的大小，默认开启
		 **/
		public var autoResetSize:Boolean = true;
		private var _scale:Number = 1;
		
		private var conn:VideoConnecter;
		private var cm:ColorMatrix;
		
		/**
		 * 创建一个VideoDisplay显示对象
		 */
		public function VideoDisplay()
		{
			conn = new VideoConnecter();
			conn.video = this;
			conn.addEventListener("videoInfoGet",disEventLater);
		}
		/**
		 * 视频整体缩放的比例，设为1时为100%缩放
		 **/
		public function set scale(value:Number):void{
			_scale = value;
			this.width = this.videoWidth*_scale;
			this.height = this.videoHeight*_scale;
		}
		/**
		 * @return 当前设置的缩放百分比
		 */
		public function get scale():Number{
			return _scale;
		}
		/**
		 * 获得对包装的NetStream的访问引用，通过netStream属性，你可以访问视频使用的NetStream对象，读取属性或者调用其方法，以对VideoDisplay进行更进一步的控制
		 **/
		public function get netStream():NetStream{
			return conn.netStream;
		}
		/**
		 * 获得对包装的NetConnection的访问引用
		 **/
		public function get netConnection():NetConnection{
			return conn.netConnection;
		}
		/**
		 * 
		* 调整视频的亮度、对比度、色彩饱和度、色相
		* 
		* @param bright 需要调整的亮度值 区间为-100到100
		* @param contrast 对比度值 区间为-100到100
		* @param saturation 饱和度值 区间为-100到100
		* @param hue 色相的偏移量 区间为-180到180
		**/
		public function setVideoColor(bright:Number,contrast:Number,saturation:Number,hue:Number):void{
			var array:Array =  [
				1,0,0,0,0,
				0,1,0,0,0,
				0,0,1,0,0,
				0,0,0,1,0,
				0,0,0,0,1
			]
			cm = new ColorMatrix(array);
			cm.adjustColor(bright,contrast,saturation,hue);
			this.filters = [new ColorMatrixFilter(cm)];
		}
		/**
		 * 使用http渐进流式播放指定相对/绝对地址的视频文件，支持的文件格式为MP4、FLV、部分3GP/MOV以及从标准 MPEG-4 容器格式（包括 F4V、MP4、M4A、MOV、MP4V、3GP 和 3G2）中派生的文件（如果文件包含 H.264 视频和/或 HEAAC v2 编码音频）
		 * @param fileURL 文件地址
		 **/
		public function play(fileURL:String):void{
			conn.play(fileURL);
		}
		/**
		 * 暂停视频回放
		 */
		public function pause():void{
			conn.netStream.pause();
		}
		/**
		 * 继续暂停的视频回放
		 */
		public function resume():void{
			conn.netStream.resume();
		}
		/**
		 * 将视频移动到指定的时间点播放，如果当前状态为暂停，则显示最近帧的静态图像
		 * @param offset 要移动到的时间位置，单位：秒
		 */
		public function seek(offset:Number):void{
			conn.netStream.seek(offset);
		}
		/**快速设置视频中的音量大小
		 * @param value 新的音量，值为0-1之间
		 */
		public function setVideoSoundVolume(value:Number):void{
			conn.netStream.soundTransform= new SoundTransform(value);
		}
		/**
		 * 销毁VideoDisplay对象，将销毁NetConnection和NetStream连接并释放其资源，同时NetConnection和NetStream对象本身也清除，最后将调用Video的clear方法
		 */ 
		public function destroy():void{
			conn.destroy();
			this.clear();
		}
		private function disEvent():void{
			if(autoResetSize == true){
				this.width = this.videoWidth*_scale;
				this.height = this.videoHeight*_scale;
			}
			this.dispatchEvent(new Event(VideoDisplay.WIDTH_HEIGHT_ALLOWED_GET));
			setVideoColor(50,0,0,0);
		}
		private function disEventLater(event:Event):void{
			setTimeout(disEvent,10);
		}
	}
}