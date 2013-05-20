package cn.flashk.map
{
	import cn.flashk.conversion.ColorMatrix;
	import cn.flashk.core.DisplayRefs;
	import cn.flashk.eventManager.EventCenter;
	import cn.flashk.events.CoreEvent;
	import cn.flashk.map.effect.Shake;
	import cn.flashk.map.move.AutoRoad;
	import cn.flashk.map.move.MoveClick;
	import cn.flashk.role.player.PlayerSelf;
	import cn.flashk.test.MapTest;
	import cn.flashk.zipPack.FileTxtZiperDecoder;
	
	import flash.display.BitmapData;
	import flash.display.BitmapDataChannel;
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.filters.ColorMatrixFilter;
	import flash.filters.DisplacementMapFilter;
	import flash.filters.DisplacementMapFilterMode;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.system.LoaderContext;
	import flash.text.TextField;

	public class MapEngine extends Sprite
	{
		public var keys:Array = [false,false,false,false];
		private var ftzip:FileTxtZiperDecoder;
		private var background:Background;
		private var layer:DynamicLayer;
		private var sky:SkyWeather;
		private var xml:XML;
		private static var ins:MapEngine;
		private var isInit:Boolean;
		private var newX:Number;
		private var newY:Number;
		private var autoRoad:AutoRoad;
		private var _viewSize:Rectangle;
		private var moveClick:MoveClick;
		private var shakeRef:Shake;
		private var colorFilter:ColorMatrixFilter;
		private var srcLdr:Loader;
		private var bgEffectLayer:BackgroundEffectLayer;
		private var shockMC:MovieClip;
		private var shockBD:BitmapData;
		private var shockFli:DisplacementMapFilter;
		private var bakXY:Array;
		private var shockBDs:Array;
		private var shockIndex:int;
		
		public function MapEngine()
		{
			
			ins = this;
			opaqueBackground = 0x000000;
			ftzip = new FileTxtZiperDecoder();
			ftzip.addEventListener(FileTxtZiperDecoder.DECODE_COMPLETE,initMapData);
			moveClick = new MoveClick();
			background = new Background();
			layer = new DynamicLayer();
			sky = new SkyWeather();
			bgEffectLayer = new BackgroundEffectLayer();
			
			this.mouseEnabled = false;
			
			//顺序
			this.addChild(moveClick);
			this.addChild(background);
			this.addChild(bgEffectLayer);
			this.addChild(layer);
			//this.addChild(sky);
			this.addEventListener(Event.ADDED_TO_STAGE,initStageLis);
			
			
			autoRoad = new AutoRoad();
			
			
			//
			load("maps/map3.tzip");
			viewSize = new Rectangle(0,0,1230,700);
			
			EventCenter.eventRadio.addEventListener(CoreEvent.INIT_ALL_COMPLETE,addToView);
			
			DisplayRefs.swfRootSprite.addChild(new MapTest());
			
		}
		public function earthShock(componentX:Number,componentY:Number):void{
			var fli:DisplacementMapFilter = new DisplacementMapFilter();
			 
			 fli.componentX = BitmapDataChannel.RED;
			 fli.componentY = BitmapDataChannel.RED;
			 fli.scaleX = componentX;
			 fli.scaleY = componentY;
			 fli.mode = DisplacementMapFilterMode.CLAMP;
			 shockFli = fli;
			 bakXY = [this.x,this.y];
			 shockIndex = 0;
			 DisplayRefs.swfRootSprite.mouseChildren = false;
			 this.stage.frameRate = 24;
			 this.addEventListener(Event.ENTER_FRAME,shockFrame);
		 }
		private function initShockBDs(event:Event):void{
			var classRef:Class = getSourceByName("earthshock1") as Class;
			shockMC = new classRef() as MovieClip;
			shockBDs = new Array();
			this.addEventListener(Event.ENTER_FRAME,drawShcokBDFrame);
		}
		private function drawShcokBDFrame(event:Event):void{
			shockBD = new BitmapData(this.stage.stageWidth,this.stage.stageHeight,false,0);
			shockBD.draw(shockMC);
			shockBDs.push(shockBD);
			if(shockMC.currentFrame == shockMC.totalFrames){
				this.removeEventListener(Event.ENTER_FRAME,drawShcokBDFrame);
				shockMC.stop();
				shockMC = null;
			}
		}
		private function shockFrame(event:Event):void{
			shockBD = BitmapData(shockBDs[shockIndex]) ;
			shockFli.mapPoint = new Point(-this.x,-this.y);
			shockFli.mapBitmap = shockBD;
			background.filters =  [ shockFli ];
			shockIndex++
			if(shockIndex == shockBDs.length){
				this.removeEventListener(Event.ENTER_FRAME,shockFrame);
				//this.x = bakXY[0];
				//this.y = bakXY[1];
				background.filters =  null;
				DisplayRefs.swfRootSprite.mouseChildren = true;
				this.stage.frameRate = 30;
			}
		}
		public function getSourceByName(sourceName:String):Object{
			return srcLdr.contentLoaderInfo.applicationDomain.getDefinition(sourceName);
		}
		public function load(mapFileURL:String):void{
			isInit = false;
			ftzip.loadAndDecodeFile(mapFileURL)
		}
		public static function getInstance():MapEngine{
			return ins;
		}
		public function get backgroundLayer():Background{
			return background;
		}
		public function get backgroundEffectLayer():BackgroundEffectLayer{
			return bgEffectLayer;
		}
		public function get mapWidth():Number{
			return Number(xml.@width);
		}
		public function get mapHeight():Number{
			return Number(xml.@height);
		}
		public function get centerX():Number{
			return newX;
		}
		public function get centerY():Number{
			return newY;
		}
		public function set viewSize(value:Rectangle):void{
			_viewSize = value;
		}
		public function get viewSize():Rectangle{
			return _viewSize;
		}
		public function get mapData():XML{
			return xml;
		}
		public function getPoint(type:uint):Point{
			var po:Point = new Point();
			if(type==1){
				po.x = int(newX-_viewSize.width/2);
				po.y = int(newY - _viewSize.height/2);
			}else{
				po.x = newX;
				po.y = newY;
			}
			return po;
		}
		public function shake(time:Number=0.5,range:Number=5,mode:int=1):void{
			if(shakeRef == null) shakeRef = new Shake();
			shakeRef.run(time,range,mode)
		}
		public function move(mx:Number,my:Number):void{
			this.x -= mx;
			this.y -= my;
			if(this.x>0) this.x = 0;
			if(this.y>0) this.y =0;
			if(this.x <  _viewSize.width - mapWidth) this.x = _viewSize.width - mapWidth;
			if(this.y < _viewSize.height - mapHeight) this.y = _viewSize.height - mapHeight;
		}
		public function moveTo(nx:Number,ny:Number):void{
			newX = nx;
			newY = ny;
			checkRectangle();
			//this.scrollRect = new Rectangle(getPoint(1).x,getPoint(1).y,viewSize.width,viewSize.height);
			this.x = int(-getPoint(1).x);
			this.y = int(-getPoint(1).y);
		}
		public function applyPictureHeigher(bright:Number,contrast:Number,saturation:Number,hue:Number):void{
			if(bright == 0 && contrast == 0 && saturation == 0 && hue == 0){
				background.filters = null;
				layer.filters = null;
				return;
			}
			var array:Array =  [
				1,0,0,0,0,
				0,1,0,0,0,
				0,0,1,0,0,
				0,0,0,1,0,
				0,0,0,0,1
			]
			var cm:ColorMatrix = new ColorMatrix(array);
			cm.adjustColor(bright,contrast,saturation,hue);
			colorFilter = new ColorMatrixFilter(cm);
			background.filters =[colorFilter];
			layer.filters = [colorFilter];
		}
		private function checkRectangle():void{
			if(xml == null) return;
			if(newX<int(_viewSize.width/2)) newX=int(_viewSize.width/2);
			if(newY<int(_viewSize.height/2)) newY=int(_viewSize.height/2);
			
			if(newX>int(mapWidth-_viewSize.width/2)) newX=int(mapWidth-_viewSize.width/2);
			if(newY>int(mapHeight-_viewSize.height/2)) newY=int(mapHeight-_viewSize.height/2);
		}
		private function initMapData(event:Event):void{
			xml = new XML(ftzip.data);
			background.init(xml.background[0]);
			layer.initObjects(xml.objects[0]);
			autoRoad.rebulid(xml.grid[0]);
			isInit = true; 
			//resetViewSize(event);
		}
		private function initStageLis(event:Event):void{
			this.stage.addEventListener(KeyboardEvent.KEY_DOWN,checkKeyDown);
			this.stage.addEventListener(KeyboardEvent.KEY_UP,checkKeyUp);
			this.stage.addEventListener(Event.RESIZE,resetViewSize);
			
			
			srcLdr = new Loader();
			//srcLdr.contentLoaderInfo.addEventListener(Event.COMPLETE,initShockBDs);
			srcLdr.load(new URLRequest("map-effect.swf"));
			
			if(xml == null) return;
			resetViewSize(event);
		}
		private function resetViewSize(event:Event):void{
			viewSize = new Rectangle(0,0,this.stage.stageWidth,this.stage.stageHeight);
			moveTo(PlayerSelf.getInstance().x,PlayerSelf.getInstance().y);
		}
		private function checkKeyDown(event:KeyboardEvent):void{
			//trace(event.keyCode);
			switch(event.keyCode)
			{
				case 39:
					keys[2] = true;
					break;
				
				case 37:
					keys[1] = true;
					break;
				
				case 38:
					keys[3] = true;
					break;
				
				case 40:
					keys[4] = true;
					break;
			}
		}
		private function checkKeyUp(event:KeyboardEvent):void{
			//trace(event.keyCode);
			switch(event.keyCode)
			{
				case 39:
					keys[2] = false;
					break;
				
				case 37:
					keys[1] = false;
					break;
				
				case 38:
					keys[3] = false;
					break;
				
				case 40:
					keys[4] = false;
					break;
			}
		}
		private function addToView(event:Event):void{
			DisplayRefs.swfRootSprite.addChildAt(this,0);
		}
	}
}