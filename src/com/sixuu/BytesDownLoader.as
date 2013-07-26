package com.sixuu
{
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.events.ProgressEvent;
	import flash.events.EventDispatcher;
	import com.sixuu.events.SProgressEvent;
	import flash.net.URLRequestHeader;
	import flash.net.URLLoaderDataFormat;
	import flash.events.Event;
	import com.sixuu.events.SEvent;
	import flash.utils.ByteArray;
	import flash.events.IOErrorEvent;
	import com.sixuu.events.SErrorEvent;

	[Event(name = "progress",type = "com.sixuu.events.SProgressEvent")]
	[Event(name = "complete",type = "com.sixuu.events.SEvent")]
	[Event(name = "error",type = "com.sixuu.events.SErrorEvent")]
	public class BytesDownLoader extends EventDispatcher
	{

		public var fileLength:uint = 0;
		public var startPos:uint;
		public var endPos:uint;
		public var url:String;
		public var byteArray:ByteArray;
		private var lengthLoader:URLLoader;//用来获取文件长度
		private var pevt:SProgressEvent = new SProgressEvent("progress");
		private var cevt:SEvent = new SEvent("complete");
		private var bytesLoader:URLLoader;
		private var th;
		public function BytesDownLoader()
		{
			th = this;

		}
		public function downLoad(_url:String,startPointPos:uint=0,endPointPos:uint=0)
		{

			lengthLoader=new URLLoader();
			this.startPos = startPointPos;
			this.endPos = endPointPos;
			this.url = _url;
			lengthLoader.load(new URLRequest(_url));
			lengthLoader.addEventListener(ProgressEvent.PROGRESS,function getFileLength(e:ProgressEvent):void{
			  fileLength=e.bytesTotal
			  endPointPos==0?th.endPos=fileLength:endPointPos>=fileLength?endPos=fileLength:0
			  lengthLoader.close()
			  startLoadBody();
			  });
			lengthLoader.addEventListener(IOErrorEvent.IO_ERROR,function ioerr(e:IOErrorEvent){
			  var evt:SErrorEvent=new SErrorEvent("error")
			  evt.errorType="lengthLoaderIOError"
			  dispatchEvent(evt)
			});
		}
		private function startLoadBody():void
		{
			bytesLoader = new URLLoader  ;
			bytesLoader.dataFormat = URLLoaderDataFormat.BINARY;
			var req:URLRequest = new URLRequest(url);
			req.requestHeaders.push(new URLRequestHeader("Range","bytes="+startPos+"-"+endPos));
			bytesLoader.load(req);
			bytesLoader.addEventListener(ProgressEvent.PROGRESS,function onPro(e:ProgressEvent):void{
			  pevt=new SProgressEvent("progress")
			  pevt.bytesLoaded=e.bytesLoaded
			  pevt.bytesTotal=e.bytesTotal
			  dispatchEvent(pevt)
			 });
			bytesLoader.addEventListener(Event.COMPLETE,function onCom(e:Event):void{
			 // cevt.target=th
			 // cevt.currentTarget=th
			  cevt=new SEvent("complete")
			  th.byteArray=bytesLoader.data
			  //trace("bd:"+th.startPos,th.endPos)
			  bytesLoader.close()
			  dispatchEvent(cevt)
			 });
			bytesLoader.addEventListener(IOErrorEvent.IO_ERROR,function onErr(e:IOErrorEvent){
			 var evt:SErrorEvent=new SErrorEvent("error")
			  evt.errorType="bytesLoaderIOError"
			  dispatchEvent(evt)
			 });
		}



	}

}