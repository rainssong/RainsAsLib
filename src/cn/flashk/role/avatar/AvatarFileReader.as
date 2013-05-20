package cn.flashk.role.avatar
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.BitmapDataChannel;
	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import flash.utils.ByteArray;
	import flash.utils.getTimer;

	public class AvatarFileReader extends EventDispatcher
	{
		public static const DECODE_ALL_COMPLETE:String = "decodeAllComplete";
		
		private var uldr:URLLoader;
		private var byteArr:ByteArray;
		private var isJPG:Boolean;
		private var frameNum:uint;
		private var imageStartAt:uint;
		private var xs:Array;
		private var ys:Array;
		private var ilens:Array;
		private var mlens:Array;
		private var bds:Array;
		private var ldr1:Loader;
		private var ldr2:Loader;
		private var lodrLoadedNum:int;
		private var decodeIndex:uint;
		private var t:int;
		private var t2:int;
		private var bp:Bitmap;
		
		public function AvatarFileReader()
		{
			uldr = new URLLoader();
			uldr.dataFormat = URLLoaderDataFormat.BINARY;
			uldr.addEventListener(Event.COMPLETE,startDecode);
			ldr1 = new Loader();
			ldr2 = new Loader();
			bp = new Bitmap();
		}
		public function get totalFrames():int{
			return frameNum;
		}
		public function load(file:String):void{
			xs = new Array();
			ys = new Array();
			ilens = new Array();
			mlens = new Array();
			bds = new Array();
			decodeIndex = 1;
			var req:URLRequest = new URLRequest(file);
			uldr.load(req);
		}
		public function getBitmapAt(frame:uint):Bitmap{
			bp.x = xs[frame];
			bp.y = ys[frame];
			bp.bitmapData = bds[frame];
			return bp;
		}
		public function getBitmapDataAt(frame:uint):BitmapData{
			return bds[frame] as BitmapData;
		}
		public function getXAt(frame:uint):Number{
			return xs[frame];
		}
		public function getYAt(frame:uint):Number{
			return ys[frame];
		}
		private function startDecode(event:Event):void{
			byteArr = uldr.data as ByteArray;
			byteArr.uncompress();
			isJPG = byteArr.readBoolean();
			frameNum = byteArr.readUnsignedInt();
			imageStartAt = byteArr.readUnsignedInt();
			for(var i:int=1;i<=frameNum;i++){
				xs[i] = byteArr.readUnsignedInt();
				ys[i] = byteArr.readUnsignedInt();
				ilens[i] = byteArr.readUnsignedInt();
				mlens[i] = byteArr.readUnsignedInt();
				bds[i] = null;
			}
			trace(byteArr.length,isJPG,frameNum,imageStartAt);
			this.dispatchEvent(new Event(Event.COMPLETE));
			
			t = getTimer();
			decodeBitmapDataAt(decodeIndex);
		}
		public function decodeBitmapDataAt(frame:uint):void{
			var mpos:Number = 0;
			for(var i:int=1;i<frame;i++){
				mpos += ilens[i];
				mpos += mlens[i];
			}
			byteArr.position = imageStartAt+mpos;
			var ibytes:ByteArray = new ByteArray();
			byteArr.readBytes(ibytes,0,ilens[frame]);
			var mbytes:ByteArray = new ByteArray();
			byteArr.readBytes(mbytes,0,mlens[frame]);
			//trace(ibytes.length);
			//trace(mbytes.length);
			lodrLoadedNum = 0;
			ldr1.contentLoaderInfo.addEventListener(Event.COMPLETE,checkAll);
			ldr2.contentLoaderInfo.addEventListener(Event.COMPLETE,checkAll);
			//t2= getTimer();
			ldr1.loadBytes(ibytes);
			ldr2.loadBytes(mbytes);
		}
		private function checkAll(event:Event):void{
			lodrLoadedNum++;
			if(lodrLoadedNum == 2){
				//trace("OK");
				var bd1:BitmapData = Bitmap(ldr1.content).bitmapData;
				var bd:BitmapData;
				bd = new BitmapData(bd1.width,bd1.height,true,0x00000000);
				bd.copyPixels(bd1,new Rectangle(0,0,bd.width,bd.height),new Point(0,0));
				//bd = bd1;
				var bd2:BitmapData = Bitmap(ldr2.content).bitmapData;
				bd.copyChannel(bd2,new Rectangle(0,0,bd.width,bd.height),new Point(0,0),BitmapDataChannel.RED,BitmapDataChannel.ALPHA);
				bds[decodeIndex] = bd;
				//trace(decodeIndex +":"+bd1.width,bd1.height);
				//trace(getTimer()-t2);
				if(decodeIndex< frameNum){
					decodeIndex++;
					decodeBitmapDataAt(decodeIndex);
				}else{
					trace("解码共用时："+(getTimer()-t)+"毫秒");
					
					this.dispatchEvent(new Event(DECODE_ALL_COMPLETE));
				}
			}
		}
	}
}