package cn.flashk.map
{
	import cn.flashk.events.LoaderManagerEvent;
	import cn.flashk.image.ImageDecode;
	import cn.flashk.image.LessPNG;
	import cn.flashk.net.LoaderManager;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.BitmapDataChannel;
	import flash.events.Event;
	import flash.geom.ColorTransform;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.utils.setTimeout;

	public class ObjectDisplay extends Bitmap
	{
		private var fileURL:String;
		private var isInit:Boolean = false;
		private var sortX:Number;
		private var sortY:Number;
		private var sortRotation:Number;
		private var cutBD:BitmapData;
		private var lessPNG:LessPNG;
		private var mode:int=2;
		private var showAlpha:Number = 0.65;
		private var imaDecode:ImageDecode;
		/**
		 * 建筑物遮挡的透明度，取ARGB的A值
		 **/
		private var alphaNum:uint = 0xBB000000;
		
		public function ObjectDisplay()
		{
			LoaderManager.getInstance().addEventListener(LoaderManagerEvent.COMPLETE,checkFile);
			MapEngine.getInstance().backgroundLayer.addEventListener("gridAllLoaded",drawToBG);
		}
		public function init(dataXML:XML):void{
			fileURL = dataXML.@url;
			this.x = int(dataXML.@x);
			this.y = int(dataXML.@y);
			sortX = dataXML.@sortX;
			sortY = dataXML.@sortY;
			sortRotation = dataXML.@sortRotation;
			if(mode == 2){
				fileURL = fileURL.slice(0,-4)+"-na-mask.png";
			}else{
				if(dataXML.@mask != ""){
					lessPNG = new LessPNG();
					lessPNG.addEventListener(Event.COMPLETE,startCompute);
					lessPNG.load(fileURL,".png",false,dataXML.@mask);
				}else{
					LoaderManager.getInstance().load(fileURL,"ObjectDisplay");
				}
			}
		}
		public function get depthX():Number{
			return this.x+sortX;
		}
		public function get depthY():Number{
			return this.y + sortY;
		}
		private function startCompute(event:Event):void{
			this.bitmapData = lessPNG.bitmapData;
			isInit = true;
		}
		private function checkFile(event:LoaderManagerEvent):void{
			if(isInit == true) return;
			if(event.fileURL == fileURL){
				//trace("OK",fileURL);
				imaDecode = new ImageDecode(event.data,initBD);
				isInit = true;
			}
			
		}
		private function initBD(bp:Bitmap):void{
			this.bitmapData = bp.bitmapData.clone();
			if(mode == 2){
				copyFromBG();
			}
			imaDecode.clear();
			imaDecode = null;
			bp.bitmapData.dispose();
		}
		private function drawToBG(event:Event):void{
			/**
			 * 操作分散时间
			 */ 
			if(mode == 2){
				LoaderManager.getInstance().add(fileURL,"ObjectDisplay");
			}else{
				setTimeout(drawToBGMain,Math.random()*900);
			}
			//drawToBGMain();
		}
		private function copyFromBG():void{
			//trace("copyFromBG");
			var bd:BitmapData = new BitmapData(this.bitmapData.width,this.bitmapData.height,true,0);
			bd.copyPixels(MapEngine.getInstance().backgroundLayer.bigBitmapData,new Rectangle(this.x,this.y,bd.width,bd.height),new Point());
			bd.copyChannel(this.bitmapData,new Rectangle(0,0,bd.width,bd.height),new Point(),BitmapDataChannel.RED,BitmapDataChannel.ALPHA);
			bd.colorTransform(new Rectangle(0,0,bd.width,bd.height),new ColorTransform(1,1,1,showAlpha));
			this.bitmapData.dispose();
			this.bitmapData = bd;
		}
		private function drawToBGMain():void{
			this.alpha = 1;
			var bd:BitmapData = this.bitmapData;
			
			MapEngine.getInstance().backgroundLayer.copyObjectView(bd,new Rectangle(0,0,bd.width,bd.height),new Point(this.x,this.y));
			if(this.parent != null){
				//this.parent.removeChild(this);
			}
			
			cutBD = new BitmapData(this.width,sortY,true,0);
			var alphaBD:BitmapData = new BitmapData(this.width,sortY,true,alphaNum);
			cutBD.copyPixels(bd,new Rectangle(0,0,cutBD.width,cutBD.height),new Point(0,0));
			var w:int = cutBD.width;
			var h:int = cutBD.height;
			var ARGB:uint;
			for(var j:int=0;j<h;j++){
				for(var i:int=0;i<w;i++){
					ARGB = cutBD.getPixel32(i,j);
					if(ARGB > 0xFF000000  ||  ARGB<0x33FFFFFF ){
						
					}else{
						cutBD.setPixel32(i,j,0x00000000);
						
					}
				}
			}
			cutBD.copyPixels(cutBD,new Rectangle(0,0,cutBD.width,cutBD.height),new Point(0,0),alphaBD);
			alphaBD.dispose();
			this.bitmapData.dispose();
			this.bitmapData = cutBD;
		}
	}
}