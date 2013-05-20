package cn.flashk.net
{
	import cn.flashk.core.Config;
	import cn.flashk.core.Core;
	import cn.flashk.core.DisplayRefs;
	import cn.flashk.core.Language;
	import cn.flashk.eventManager.EventCenter;
	import cn.flashk.events.CoreEvent;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.display.Shape;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import flash.utils.getTimer;
	import flash.utils.setTimeout;
	
	import flashx.textLayout.elements.BreakElement;

	public class StartFilesLoader
	{
		private var xml:XML;
		private var ui:MovieClip;
		private var loadScreen:Loader;
		private var screenMode:int;
		private var scrWidth:Number;
		private var scrHeight:Number;
		private var fillShape:Shape;
		private var fillBD:BitmapData;
		private var barAlignMode:String;
		private var nowIndex:int;
		private var uldr:URLLoader;
		private var totalSize:Number;
		private var completeSize:Number;
		private var uldrMax:uint = 3;
		private var uldrs:Array;
		private var uldrIDs:Array;
		private var filesState:Array;
		private var datas:Array;
		private var lastHasLoad:Number=0;
		private var timer:int=0;
		private var tipLdr:Loader;
		
		public function StartFilesLoader()
		{
		}
		public function init(uiMC:MovieClip,data:Object,loadScreenFile:String,loadScreenScaleMode:Object,barAlign:Object):void
		{
			var req:URLRequest = new URLRequest(loadScreenFile);
			
			xml = new XML(data);
			ui = uiMC;
			ui.stop();
			screenMode = int(loadScreenScaleMode);
			barAlignMode = String(barAlign);
			toCenter();
			ui.stage.addEventListener(Event.RESIZE,toCenter);
			//加载LoadScreen
			loadScreen = new Loader();
			DisplayRefs.swfRootSprite.addChildAt(loadScreen,0);
			EventCenter.eventRadio.addEventListener(CoreEvent.LOAD_SCREEN_REMOVE,removeLoadScreen);
			loadScreen.contentLoaderInfo.addEventListener(Event.COMPLETE,scaleLoadScreen);
			loadScreen.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,loadScreenLoadError);
			loadScreen.load(req);
		}
		
		protected function scaleLoadScreen(event:Event):void
		{
			if(loadScreen.content is Bitmap){
				Bitmap(loadScreen.content).smoothing = true;
				scrWidth = loadScreen.width;
				scrHeight = loadScreen.height;
			}else{
				scrWidth = loadScreen.contentLoaderInfo.width;
				scrHeight = loadScreen.contentLoaderInfo.height;
			}
			if(screenMode==4){
				fillBD = new BitmapData(scrWidth,scrHeight,true,0x00FFFFFF);
				fillBD.draw(loadScreen);
				loadScreen.visible = false;
				fillShape = new Shape();
				DisplayRefs.swfRootSprite.addChildAt(fillShape,0);
			}
			loadScreen.stage.addEventListener(Event.RESIZE,rescaleLoadScreen);
			rescaleLoadScreen();
			startLoad();
		}
		private function rescaleLoadScreen(event:Event=null):void{
			switch(screenMode)
			{
				case 1:

					loadScreen.scaleX = loadScreen.stage.stageWidth/scrWidth;
					loadScreen.scaleY = loadScreen.stage.stageHeight/scrHeight;
					if(loadScreen.scaleX>=loadScreen.scaleY){
						loadScreen.scaleY = loadScreen.scaleX;
					}else{
						loadScreen.scaleX=loadScreen.scaleY;
					}
					loadScreen.x = int((loadScreen.stage.stageWidth-scrWidth*loadScreen.scaleX)/2);
					loadScreen.y = int((loadScreen.stage.stageHeight-scrHeight*loadScreen.scaleY)/2);
					break;
				
				case 2:
					
					loadScreen.scaleX = loadScreen.stage.stageWidth/scrWidth;
					loadScreen.scaleY = loadScreen.stage.stageHeight/scrHeight;
					break;
				
				case 3:
					
					loadScreen.x = int((loadScreen.stage.stageWidth-scrWidth)/2);
					loadScreen.y = int((loadScreen.stage.stageHeight-scrHeight)/2);
					break;
				
				case 4:
					fillShape.graphics.clear();
					fillShape.graphics.beginBitmapFill(fillBD,null,true,false);
					fillShape.graphics.drawRect(0,0,fillShape.stage.stageWidth,fillShape.stage.stageHeight);
					break;
					
				case 5:
					loadScreen.x = 0;
					loadScreen.y = 0;
					break;
	
				default:
					//
			}
		}
		private function loadScreenLoadError(event:IOErrorEvent):void{
			startLoad();
		}
		private function toCenter(event:Event=null):void{
			ui.x = int(ui.stage.stageWidth/2);
			if(barAlignMode == "bottom"){
				ui.y = ui.stage.stageHeight;
			}else{
				ui.y = int(ui.stage.stageHeight/2);
			}
		}
		private function startLoad():void{
			nowIndex = 0;
			totalSize = 0;
			completeSize = 0;
			uldr = new URLLoader();
			uldr.addEventListener(ProgressEvent.PROGRESS,checkSize);
			uldr.load(new URLRequest(xml.file[nowIndex]));
			ui.info_txt.text = xml.@text;
			
			tipLdr = new Loader();
			tipLdr.load(new URLRequest(Config.getInstance().tips));
			ui.addChild(tipLdr);
		}
		private function checkSize(event:ProgressEvent):void{
			if(event.bytesTotal>0){
				totalSize+=event.bytesTotal;
				checkNext();
			}
		}
		private function checkNext():void{
			nowIndex ++;
			if(nowIndex<xml.file.length()){
				uldr.load(new URLRequest(xml.file[nowIndex]));
			}else{
				uldr.close();
				startUldrs();
			}
		}
		private function startUldrs():void{
			uldrs = new Array();
			uldrIDs = new Array();
			filesState = new Array();
			datas = new Array();
			for(var j:int=0;j<xml.file.length();j++){
				filesState[j] = 0;
			}
			for(var i:int=0;i<uldrMax;i++){
				uldrs[i] = new URLLoader();
				URLLoader(uldrs[i]).dataFormat = URLLoaderDataFormat.BINARY;
				URLLoader(uldrs[i]).addEventListener(Event.COMPLETE,uldrComplete);
				URLLoader(uldrs[i]).load(new URLRequest(xml.file[0+i]));
				uldrIDs[i] = i;
				filesState[i] = 1;
			}
			ui.addEventListener(Event.ENTER_FRAME,updateInfo);
		}
		private function getNextNeedLoadID():int{
			var id:int=-1;
			for(var j:int=0;j<filesState.length;j++){
				if(filesState[j] == 0){
					id = j;
					break;
				}
			}
			return id;
		}
		private function uldrComplete(event:Event):void{
			completeSize += URLLoader(event.currentTarget).bytesLoaded;
			var avaID:int = getNextNeedLoadID();
			var indexUldr:int;indexUldr=-1;
			for(var i:int=0;i<uldrMax;i++){
				if(uldrs[i] == event.currentTarget){
					indexUldr = i;
					break;
				}
			}
			datas[uldrIDs[indexUldr]]= URLLoader(event.currentTarget).data;
			filesState[uldrIDs[indexUldr]]=3;
			checkAllComplete();
			if(avaID != -1){
				uldrIDs[indexUldr] = avaID;
				filesState[avaID] = 1;
				URLLoader(event.currentTarget).load(new URLRequest(xml.file[avaID]));
			}
		}
		private function updateInfo(event:Event):void{
			ui.info_txt.text = "";
			var length:int = filesState.length;
			var per:int;
			var hasLoad:Number = completeSize;
			for(var i:int=0;i<uldrMax;i++){
				per = int(URLLoader(uldrs[i]).bytesLoaded/URLLoader(uldrs[i]).bytesTotal*100);
				ui.info_txt.text += xml.file[uldrIDs[i]].@text+" ("+per+"%) "+(uldrIDs[i]+1)+"/"+length+"\n";
				if(URLLoader(uldrs[i]).bytesLoaded < URLLoader(uldrs[i]).bytesTotal){
					hasLoad += URLLoader(uldrs[i]).bytesLoaded;
				}
			}
			if(getTimer()-timer>1000){
				ui.speed_txt.text = int((hasLoad-lastHasLoad)/1024*100)/100 + " KB/s";
				lastHasLoad = hasLoad;
				timer = getTimer();
			}
			var per2:int = int(hasLoad/totalSize*100);
			ui.gotoAndStop(per2);
			ui.allPer_txt.text = per2+"%";
		}
		private function checkAllComplete():void{
			var count:int = 0;
			for(var j:int=0;j<filesState.length;j++){
				if(filesState[j] == 3){
					count++;
				}
			}
			trace(count);
			if(count== xml.file.length()){
				//已经全部完成加载
				trace("all OK");
				setTimeout(startInit,100);
			}
		}
		private function startInit():void{
			ui.removeEventListener(Event.ENTER_FRAME,updateInfo);
			ui.info_txt.text = Language.getStringByCode(1001);
			
			clear();
			Core.getInstance().initGame(datas);
		}
		private function clear():void{
			for(var i:int=0;i<uldrMax;i++){
				URLLoader(uldrs[i]).removeEventListener(Event.COMPLETE,uldrComplete);
				uldrs[i] = null;
			}
			uldr.removeEventListener(ProgressEvent.PROGRESS,checkSize);
			ui.stage.removeEventListener(Event.RESIZE,toCenter);
			ui = null;
			xml = null;
			uldr = null;
			uldrs = null;
			uldrIDs = null;
			filesState = null;
		}
		private function removeLoadScreen(event:Event):void{
			if(screenMode==4){
				DisplayRefs.swfRootSprite.removeChild(fillShape);
			}
			loadScreen.stage.removeEventListener(Event.RESIZE,rescaleLoadScreen);
			DisplayRefs.swfRootSprite.removeChild(loadScreen);
			loadScreen.unload();
		}
	}
}