package me.rainui.media 
{
	import flash.display.DisplayObject;
	import flash.display.Shape;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.NetStatusEvent;
	import flash.geom.Rectangle;
	import flash.media.StageVideo;
	import flash.media.Video;
	import flash.net.NetConnection;
	import flash.net.NetStream;
	import flash.utils.setTimeout;
	import me.rainssong.display.SmartSprite;
	import me.rainssong.events.ObjectEvent;
	import me.rainssong.utils.Draw;
	import me.rainui.components.Component;
	
	/**
	 * ...
	 * @author Rainssong
	 */
	public class StageVideoPlayer extends Component 
	{
		public var video:StageVideo;
		public var nc:NetConnection = new NetConnection();
		public var ns:NetStream;
		
		public function StageVideoPlayer() 
		{
			super();
			addEventListener(Event.ADDED_TO_STAGE, onAddToStage);
		}
		
		private function onAddToStage(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAddToStage);
			
			video = stage.stageVideos[0];
			
			_width = 320;
			_height = 240;
			
			nc.addEventListener(NetStatusEvent.NET_STATUS, netStatusHandler);
			nc.connect(null);
			//nc.client={onMetadata: metaDataHandler };
			ns = new NetStream(nc);
			//ns.inBufferSeek = true;
			ns.addEventListener(NetStatusEvent.NET_STATUS, netStatusHandler);
			//ns.client = this;
			ns.client = new Object(); 
			ns.client = {};
			ns.client.onMetaData = onMetaData;
			ns.client.onCuePoint = onCuePoint;
			
			video.attachNetStream(ns);
			
			resize();
		}
		
		override protected function createChildren():void 
		{
			super.createChildren();
			
			
			//addChild(video);
			//nc.client = { onMetadata:null };
			
			
			//video.viewPort = new Rectangle(0, 768 * 0.5 - 576 * 0.5, 1024, 576);
			//video.width = 1024;
			//video.height = 638-60;
			//video.x = 0;
			//video.smoothing = true;
			
			
		}
		
		private function onCuePoint(item:Object):void 
		{
			resize();
		}
		
		public function play(url:String = ""):void
		{
			ns.play(url );
		}
		
		
		
		override public function resize():void 
		{
			super.resize();
			
			var rect:Rectangle = new Rectangle(x, y, _width, _height);
			video.viewPort = rect;
		}
		
		private function netStatusHandler(e:NetStatusEvent):void
		{
			switch (e.info.code)
			{
				case "NetStream.Play.Stop": 
					dispatchEvent(new ObjectEvent("stop"));
					break;
					//ns.seek(0);
					//ns.play(File.applicationDirectory.resolvePath("assets/ZoomMovie.flv").url);
				case "NetStream.Play.Start": 
					
					resize();
					
					dispatchEvent(new ObjectEvent("start"));
					//ns.seek(0);
					//ns.play(File.applicationDirectory.resolvePath("assets/ZoomMovie.flv").url);
					
					break;
			}
		}
		
		public function onMetaData(metadataObj:Object):void
		{
			var meta:Object = metadataObj;
			meta = metadataObj; 
			
		}
		
		
		override public function destroy():void 
		{
			ns.close();
			ns.dispose();
			nc.close();
			super.destroy();
		}
	
	
		public function pause():void 
		{
			ns.pause();
		}
		
		public function resume():void 
		{
			ns.resume();
		}
		
		public function step(frames:int):void 
		{
			ns.step(frames);
		}
		
		public function togglePause():void 
		{
			ns.togglePause();
		}
		
		public function seek(offset:Number):void 
		{
			ns.seek(offset);
		}
		
		
		
	}

}