package view 
{
	import flash.display.DisplayObject;
	import flash.display.Shape;
	import flash.events.Event;
	import flash.events.NetStatusEvent;
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
	public class VideoPlayer extends Component 
	{
		private var _duration:Number = NaN;
		public var video:Video;
		public var nc:NetConnection = new NetConnection();
		public var ns:NetStream;
		public var bgSkin:DisplayObject
		private var _replay:Boolean = false;
		
		public function VideoPlayer() 
		{
			super();
			addEventListener(Event.ADDED_TO_STAGE, onAddToStage);
			
		}
		
		private function onEnterFrame(e:Event):void 
		{
			if (replay && _duration)
			{
				if (_duration - ns.time < 0.3)
					ns.seek(0);
			}
		}
		
		private function onAddToStage(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAddToStage);
			resize();
		}
		
		override protected function createChildren():void 
		{
			super.createChildren();
			
			if (bgSkin == null)
			{
				var shape:Shape = new Shape()
				Draw.rect(shape, 0, 0, 100, 100, 0);
				//addChild(shape);
				bgSkin=shape;
			}
			
			video = new Video();
			addChild(video);
			//nc.client = { onMetadata:null };
			
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
			//video.viewPort = new Rectangle(0, 768 * 0.5 - 576 * 0.5, 1024, 576);
			//video.width = 1024;
			//video.height = 638-60;
			//video.x = 0;
			video.smoothing = true;
			
			
		}
		
		private function onCuePoint(item:Object):void 
		{
			
		}
		
		public function play(url:String = ""):void
		{
			ns.play(url );
		}
		
		
		
		override public function resize():void 
		{
			super.resize();
			if (video.videoHeight != 0 )
			{
				video.width = video.videoWidth;
				video.height = video.videoHeight;
				var scaleX:Number = _height / video.videoHeight;
				var scaleY:Number = _width / video.videoWidth;
				video.width *= Math.min(scaleX, scaleY);
				video.height *= Math.min(scaleX, scaleY);
			}
			
			video.x = _width * 0.5 - video.width * 0.5;
			video.y = _height * 0.5 - video.height * 0.5;
			video.smoothing = true;
			bgSkin.width = _width;
			bgSkin.height = _height;
		}
		
		private function netStatusHandler(e:NetStatusEvent):void
		{
			switch (e.info.code)
			{
				case "NetStream.Play.Stop": 
					dispatchEvent(new ObjectEvent("stop"));
					break;
				case "NetStream.Play.Start": 
					dispatchEvent(new ObjectEvent("start"));
					
					break;
			}
		}
		
		public function onMetaData(metadataObj:Object):void
		{
			var meta:Object = metadataObj;
			//powerTrace(meta);
			_duration = meta.duration;
			resize();
		}
		
		
		override public function destroy():void 
		{
			removeEventListener(Event.ENTER_FRAME, onEnterFrame);
			nc.removeEventListener(NetStatusEvent.NET_STATUS, netStatusHandler);
			ns.removeEventListener(NetStatusEvent.NET_STATUS, netStatusHandler);
			ns.close();
			ns.dispose();
			nc.close();
			if(video.parent)
				removeChild(video);
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
		
		/* DELEGATE flash.net.NetStream */
		
		public function seek(offset:Number):void 
		{
			ns.seek(offset);
		}
		
		public function get replay():Boolean 
		{
			return _replay;
		}
		
		public function set replay(value:Boolean):void 
		{
			_replay = value;
			if (_replay)
				addEventListener(Event.ENTER_FRAME, onEnterFrame);
			else
				removeEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
		
		
		
	}

}