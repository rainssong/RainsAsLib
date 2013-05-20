package cn.flashk.video
{
	import flash.events.EventDispatcher;
	import flash.events.NetStatusEvent;
	import flash.events.SecurityErrorEvent;
	import flash.media.Video;
	import flash.net.NetConnection;
	import flash.net.NetStream;
	
	/**
	 * 当视频的长度和宽度等信息可用时将调度
	 * @eventType VideoDisplay.WIDTH_HEIGHT_ALLOWED_GET
	 **/
	[Event(name="videoInfoGet",type="flash.events.Event")]
	
	/**
	 * VideoConnecter 类包装了NetConnection和NetStream对象。以使VideoDisplay能播放http渐进式视频流。
	 * 
	 * <p>不能直接从VideoDisplay访问到此类，请直接访问VideoDisplay类的netStream和netConnection属性。</p>
	 * <p>此类也可以单独使用。通过设置video属性当NetStream开始播放时将自动附加到Video对象中。同样，你也可以使用此类播放AAC音频。</p>
	 * 
	 * @langversion ActionScript 3.0
	 * @playerversion Flash 9.0
	 * 
	 * @see cn.flashk.video.VideoDisplay
	 * 
	 * @author flashk
	 */

	public class VideoConnecter extends EventDispatcher
	{
		/**
		 * 视频头文件指示的视频宽度值
		 */
		public var videoWidth:Number;
		/**
		 * 视频头文件指示的视频高度值
		 */
		public var videoHeight:Number;
		
		private var _video:Video;
		private var nc:NetConnection;
		private var ns:NetStream;
		
		/**	 
		 *创建VideoConnecter对象,将自动创建NetConnection和NetStream对象，并将NetConnection连接至null
		 */
		public function VideoConnecter()
		{
			nc = new NetConnection();
			nc.addEventListener(NetStatusEvent.NET_STATUS, netStatusHandler);
			nc.addEventListener(SecurityErrorEvent.SECURITY_ERROR, securityErrorHandler);
			nc.connect(null);
		}
		/**
		 * 设置VideoConnecter自动绑定的Video显示对象，当使用play播放视频时，将自动附加视频图像到设定的Video对象中
		 * @see #play()
		 */
		public function set video(value:Video):void{
			_video = value;
		}
		/**
		 * 访问包装器使用的NetStream视频/音频流对象，通过访问netStream的soundTransform属性，你可以控制此流中的声音。或者从NetStream对象中获得/控制更多。
		 * @see flash.net.NetStream
		 */
		public function get netStream():NetStream{
			return ns;
		}
		/**
		 * 访问包装器使用的NetConnection网络连接对象
		 * @see flash.net.NetConnection
		 */
		public function get netConnection():NetConnection{
			return nc;
		}
		/**
		 * 使用NetStream播放指定视频/音频文件
		 * @param fileURL 文件地址
		 */
		public function play(fileURL:String):void{
			ns.play(fileURL);
			if(_video != null){
				_video.attachNetStream(ns);
			}
		}
		/**
		 * 关闭VideoConnecter所使用的连接，将销毁NetConnection和NetStream连接并释放其资源，同时NetConnection和NetStream对象本身也清除
		 */ 
		public function destroy():void{
			ns.close();
			nc.close();
			ns.client = null;
			ns = null;
			nc = null;
			_video = null;
		}
		private function netStatusHandler(event:NetStatusEvent):void {
			switch (event.info.code) {
				case "NetConnection.Connect.Success":
					connectStream();
					break;
				case "NetStream.Play.StreamNotFound":
					trace("Stream not found ");
					break;
			}
		}
		
		private function securityErrorHandler(event:SecurityErrorEvent):void {
			trace("securityErrorHandler: " + event);
		}
		private function connectStream():void{
			ns = new NetStream(nc);
			ns.client = new CustomClient(this);
		}
	}
}
import cn.flashk.video.VideoConnecter;

import flash.events.Event;

class CustomClient {
	private var _tar:VideoConnecter;
	
	public function CustomClient(tar:VideoConnecter){
		_tar = tar;
	}
	public function onMetaData(info:Object):void {
		_tar.videoWidth = info.width;
		_tar.videoHeight = info.height;
		_tar.dispatchEvent(new Event("videoInfoGet"));
		// info.duration info.width info.height  info.framerate;
	}
	public function onCuePoint(info:Object):void {
		//info.time  info.name  info.type;
	}
}