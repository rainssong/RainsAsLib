package cn.flashk.map
{
	import cn.flashk.events.LoaderManagerEvent;
	import cn.flashk.image.ImageDecode;
	import cn.flashk.net.LoaderManager;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.BitmapDataChannel;
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.events.Event;
	import flash.filters.BitmapFilter;
	import flash.filters.BlurFilter;
	import flash.geom.ColorTransform;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.utils.getTimer;

	public class Background extends Bitmap
	{
		private var smallFileURL:String;
		private var loaderTypeName:String = "mapBackground";
		private var smallBD:BitmapData;
		private var smallFixBD:BitmapData;
		private var data:XML;
		private var newX:Number;
		private var newY:Number;
		private var gridWidth:Number;
		private var gridHeight:Number;
		private var maxW:int;
		private var maxH:int;
		private var needShows:Array;
		private var loadedCout:uint;
		private var gridNumW:uint;
		private var gridNumH:uint;
		private var bdBak:BitmapData;
		/**
		 * 要对放大的缩略图应用的滤镜，默认使用一个2px的模糊
		 */ 
		public static var scaleFilter:BitmapFilter =  new BlurFilter(2,2,1);
		/**
		 * 在放大缩略图时是否开启平滑过渡，关闭则显示类似块状的马赛克，设置为打开将消耗更多的CPU，但在某些背景上能获得更好的表现
		 */ 
		public static var scaleSmooth:Boolean = false;
		
		public function Background()
		{
			LoaderManager.getInstance().addEventListener(LoaderManagerEvent.COMPLETE,checkFile);
			needShows = new Array();
			
			opaqueBackground = 0x000000;
		}
		public function get bigBitmapData():BitmapData{
			return smallFixBD;
		}
		public function init(dataXML:XML):void{
			//trace(data.skin);
			data = dataXML;
			loadedCout = 0;
			gridWidth = Number(data.skin.gridWidth);
			gridHeight = Number(data.skin.gridHeight);
			gridNumW = Math.ceil(MapEngine.getInstance().mapWidth/gridWidth);
			gridNumH = Math.ceil(MapEngine.getInstance().mapHeight/gridHeight);
			smallFileURL = data.skin.floder.toString()+data.skin.beginString+data.skin.smallFileName+data.skin.endString+data.skin.fileType;
			LoaderManager.getInstance().load(smallFileURL,loaderTypeName);
			
			smallFixBD = new BitmapData(MapEngine.getInstance().mapWidth,MapEngine.getInstance().mapHeight,false,0);
		}
		public function moveTo(nx:Number,ny:Number):void{
			var po:Point = MapEngine.getInstance().getPoint(1);
			var X:int = int(po.x/gridWidth);
			var Y:int = int(po.y/gridHeight);
			maxW = Math.ceil(MapEngine.getInstance().viewSize.width/gridWidth);
			maxH = Math.ceil(MapEngine.getInstance().viewSize.height/gridHeight);
			var midX:int = Math.ceil(maxW/2)+X;
			var midY:int = Math.ceil(maxH/2)+Y;
			needShows = new Array();
			var numW:int = gridNumW;
			var numH:int = gridNumH;
			for(var i:int=1;i<=numW;i++){
				for(var j:int=1;j<=numH;j++){
					var ra:Number = Math.sqrt(Math.pow(i-midX,2)+Math.pow(j-midY,2));
					//trace(i,j,ra);
					needShows.push({range:ra,x:i,y:j});
				}
			}
			needShows.sortOn("range",Array.NUMERIC);
			//trace(po,gridWidth,gridHeight);
			//trace(X,Y,maxW,maxH,midX,midY);
			for(i=0;i<needShows.length;i++){
				//trace(needShows[i].range,needShows[i].x,needShows[i].y);
				var str:String = data.skin.floder.toString()+data.skin.beginString+needShows[i].y+data.skin.spaceString+needShows[i].x+data.skin.endString+data.skin.fileType;
				needShows[i].fileURL = str;
				LoaderManager.getInstance().add(str,loaderTypeName);
			}
		}
		
		public function copyObjectView(bd:BitmapData,rect:Rectangle,destPoint:Point):void{
			smallFixBD.copyPixels(bd,rect,destPoint,null,null,true);
		}
		private function checkFile(event:LoaderManagerEvent):void{
			if(event.typeName == loaderTypeName){
				if(event.fileURL == smallFileURL){
					ImageDecode.toBitmapData(event.data).contentLoaderInfo.addEventListener(Event.INIT,initSmallBD);
				}
				var index:int = -1;
				for(var i:int=0;i<needShows.length;i++){
					if(needShows[i].fileURL == event.fileURL){
						index = i;
					}
				}
				//trace("checkFile",index);
				if(index != -1){
					var ldr:Loader = ImageDecode.toBitmapData(event.data)
					ldr.name = "gridLoader-"+needShows[index].x + "-"+ needShows[index].y;
					ldr.contentLoaderInfo.addEventListener(Event.INIT,initGridBD);
				}
			}
		}
		private function initSmallBD(event:Event):void{
			var ldr:Loader =LoaderInfo(event.currentTarget).loader;
			smallBD = Bitmap(ldr.content).bitmapData.clone();
			LoaderInfo(event.currentTarget).removeEventListener(Event.INIT,initSmallBD);
			Bitmap(ldr.content).bitmapData.dispose();
			ldr.unload();
			var mat:Matrix = new Matrix();
			mat.scale(Number(data.skin.samllPixel),Number(data.skin.samllPixel));
			smallFixBD.draw(smallBD,mat,null,null,null,scaleSmooth);
			//883 442
			var blurF:BlurFilter = new BlurFilter(2,2,1);
			smallFixBD.applyFilter(smallFixBD,new Rectangle(0,0,smallFixBD.width,smallFixBD.height),new Point(0,0),blurF);
			if(scaleFilter != null){
				smallFixBD.applyFilter(smallFixBD,new Rectangle(0,0,smallFixBD.width,smallFixBD.height),new Point(0,0),scaleFilter);
			}
			for( var i:int=0;i<smallFixBD.width;i+=8){
				smallFixBD.colorTransform(new Rectangle(i,0,1,smallFixBD.height),new ColorTransform(0.90,0.90,0.90,1,26,26,26,0));
			}
			for(var j:int=0;j<smallFixBD.height;j+=8){
				smallFixBD.colorTransform(new Rectangle(0,j,smallFixBD.width,1),new ColorTransform(0.90,0.90,0.90,1,26,26,26,0));
			}
			this.bitmapData = smallFixBD;
			moveTo(MapEngine.getInstance().centerX,MapEngine.getInstance().centerY);
		}
		private function initGridBD(event:Event):void{
			var ldr:Loader =LoaderInfo(event.currentTarget).loader;
			var bd:BitmapData = Bitmap(ldr.content).bitmapData;
			LoaderInfo(event.currentTarget).removeEventListener(Event.INIT,initGridBD);
			//trace(ldr.name);
			var da:Array = ldr.name.split("-");
			var X:int = int(da[1])-1;
			var Y:int = int(da[2])-1;
			//trace(X,Y);
			smallFixBD.copyPixels(bd,new Rectangle(0,0,bd.width,bd.height),new Point(X*gridWidth,Y*gridHeight),null,null,false);
			bd = null;
			Bitmap(ldr.content).bitmapData.dispose();
			ldr.unload();
			try{
				ldr.unloadAndStop();
			}catch(e:Error){
				
			}
			loadedCout++;
			if(loadedCout == gridNumW*gridNumH){
				//bdBak = smallFixBD.clone();
				//this.cacheAsBitmap = true;
				var t:int = getTimer();
				this.dispatchEvent(new Event("gridAllLoaded"));
				//trace(getTimer()-t + "+++++");
			}
		}
	}
}