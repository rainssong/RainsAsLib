package cn.flashk.role.player
{
	import cn.flashk.core.DisplayRefs;
	import cn.flashk.events.LoaderManagerEvent;
	import cn.flashk.image.AnimationGridBitmap;
	import cn.flashk.image.BitmapTool;
	import cn.flashk.image.ImageDecode;
	import cn.flashk.map.MapEngine;
	import cn.flashk.net.LoaderManager;
	import cn.flashk.role.avatar.Avatar;
	import cn.flashk.role.effect.ParticleMoveBitmap;
	import cn.flashk.role.effect.RoleShadow;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.filters.DropShadowFilter;
	import flash.filters.GlowFilter;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.text.TextField;
	import flash.text.TextFormat;

	public class Player extends Sprite
	{
		protected var ava:Avatar;
		private var hitTestPoints:Array;
		private var shadow:RoleShadow;
		private var _playerName:String;
		private var nameBD:BitmapData;
		private var nameBP:Bitmap;
		private var nameMaxWidth:Number = 200;
		//private var nameFont:String = "Arial,Microsoft Yahei,华文细黑";
		//Microsoft YaHei";FZYaoTi";,"LiSu";"STKaiti";"YouYuan";"SimHei";SimSun
		private var nameFont:String = "SimSun,Microsoft Yahei,华文细黑,Arial";
		private var nameTextSet:Array = [15,0xFFFFFF,"center"];
		private var nameEffectSet:Array = [2,45,0x000000,1,1.5,2];
		private var _nameAlign:String = "top";
		private var speed:Number = 4;
		private var movePath:Array;
		private var moveIndex:int;
		private var stepCount:int;
		
		private var textAntiAliasing:TextAntiAliasing;
		
		protected var direction:int = 1;
		
		private var lenX:Number;
		private var lenY:Number;
		private var step:Number;
		
		private var footFrame:int = 1;
		private var footCountFrame:int;
		private var footScoureName:String="Flower1";
		private var footIsDirection:Boolean = false;
		

		
		public function Player()
		{
			//this.opaqueBackground = 0xFFFFFF;
			trace("++++++++++++++++");
			
			textAntiAliasing = new TextAntiAliasing();
			
			hitTestPoints = new Array();
			hitTestPoints[0] = new Point();
			hitTestPoints[1] = new Point();
			hitTestPoints[2] = new Point();
			hitTestPoints[3] = new Point();
			

			
			shadow = new RoleShadow();
			shadow.initXY(0,0);
			this.addChildAt(shadow,0);
			
			nameBP = new Bitmap();
			this.addChild(nameBP);
			var r:Number = Math.random();
			if(r<0.3){
				playerName = "※最爱网游☆№";
			}else if(r<0.7){
				playerName = "<font size='17'color='#fffc00'>【神龙帮】</font><font size='15' color='#ffffff'>白虎</font>" ;

			}else{
				playerName = "<font color='#ff6c00'>无</font><font color='#fffc00'>名</font><font color='#0cff00'>战</font><font color='#00d8ff'>士</font>";
			}
			//resetPlayerNameEffect(0x000000,8,3.5,3);
			//playerNameAlign = "b";
			//setPlayerNameStyle(13,null,null);
			
			ava = new Avatar();
			this.addChild(ava);
		}	
		/**
		 * 设置玩家名字，并将Text转化为BitmapData
		 */ 
		public function set playerName(value:String):void{
			_playerName = value;
			var txt:TextField = new TextField();
			txt.width = nameMaxWidth;
			txt.htmlText = _playerName;
			txt.multiline = true;
			txt.wordWrap = true;
			var tf:TextFormat = new TextFormat();
			tf.font = nameFont;
			if(_playerName.indexOf("size=") == -1) tf.size = nameTextSet[0];
			if(_playerName.indexOf("color=") == -1) tf.color = nameTextSet[1];
			tf.align = nameTextSet[2];
			txt.setTextFormat(tf);
			var dropFilter:DropShadowFilter = new DropShadowFilter(nameEffectSet[0],nameEffectSet[1],nameEffectSet[2],1,nameEffectSet[3],nameEffectSet[3],nameEffectSet[4],nameEffectSet[5]);
			var textDrawSP:Sprite = textAntiAliasing.getSpriteByText(txt);
			textDrawSP.filters = [ dropFilter ];
			var bd:BitmapData = new BitmapData(txt.width+nameEffectSet[1]*2,txt.height,true,0x00FFFFFF);
			bd.draw(textDrawSP,new Matrix(1,0,0,1,nameEffectSet[1],nameEffectSet[1]));
			textAntiAliasing.clear();
			var rect:Rectangle = bd.getColorBoundsRect(0xFF000000,0x00000000,false);
			if(nameBD != null) nameBD.dispose();
			nameBD = new BitmapData(rect.width,rect.height,true,0xFFFFFF);
			nameBD.copyPixels(bd,rect,new Point(0,0));
			nameBP.bitmapData = nameBD;
			nameBP.x = int(-nameBP.width/2);
			playerNameAlign = _nameAlign;
			bd.dispose();
		}
		public function get playerName():String{
			return _playerName;
		}
		public function set playerNameAlign(value:String):void{
			if(value == "top"){
				nameBP.y = -90-nameBP.height;
			}else{
				nameBP.y = 10;
			}
		}
		public function setPlayerNameStyle(size:Object,color:Object,align:String):void{
			if(size != null) nameTextSet[0] = size;
			if(color != null) nameTextSet[1] = color;
			if(align != null) nameTextSet[2] = align;
			playerName = _playerName;
		}
		public function resetPlayerNameEffect(glowColor:uint,glowBlur:Number,strength:Number=1,quality:int=2):void{
			nameEffectSet = [glowColor,glowBlur,strength,quality];
			playerName = _playerName;
		}
		public function getHittestPoints():Array{
			hitTestPoints[0].x = this.x;
			hitTestPoints[0].y = this.y;
			
			hitTestPoints[1].x = this.x+this.width/2;
			hitTestPoints[1].y = this.y;
			
			hitTestPoints[2].x = this.x-this.width/2;
			hitTestPoints[2].y = this.y;
			
			hitTestPoints[3].x = this.x;
			hitTestPoints[3].y = this.y-this.height/2;
			
			return hitTestPoints;
		}
		public function get depthX():Number{
			return this.x;
		}
		public function get depthY():Number{
			return this.y;
		}
		public function moveWithPath(path:Array):void{
			movePath = path;
			moveIndex =0;
			stepCount = 0;
			moveCompute();
			footCountFrame = 0;
			this.addEventListener(Event.ENTER_FRAME,moveStep);
			if(this == PlayerSelf.getInstance()){
				this.addEventListener(Event.ENTER_FRAME,centerToMap);
				//DisplayRefs.swfRootSprite.mouseChildren = false;
				//DisplayRefs.swfRootSprite.mouseEnabled = false;
			}
		}
		public function setFootEffect(sourceName:String,gap:int,isDirectionRote:Boolean):void{
			footScoureName = sourceName;
			footFrame = gap;
			footIsDirection = isDirectionRote;
		}
		private function moveCompute():void{
			
			lenX = movePath[moveIndex+1][0]-movePath[moveIndex][0];
			lenY = movePath[moveIndex+1][1]-movePath[moveIndex][1];
			var ar:Number = Math.atan2(lenY,lenX);
			var angle:Number = -ar*180/Math.PI;
			if(angle<22.5 && angle>-22.5){
				direction = 6;
			}else if(angle >= 22.5 && angle <67.5){
				direction = 9;
			}else if(angle>=67.5 && angle < 112.5){
				direction = 8;
			}else if(angle>=112.5 && angle<157.5){
				direction = 7;
			}else if(angle>= 157.5 || angle < -157.5){
				direction = 4;
			}else if(angle<= -22.5 && angle>-67.5){
				direction = 3;
			}else if(angle<= -67.5 && angle > -112.5){
				direction = 2;
			}else{
				direction = 1;
			}
			//trace(angle,direction);
			step = Math.sqrt(Math.pow(lenX,2)+Math.pow(lenY,2))/speed;
			ava.playMove(direction);
		}
		private function moveStep(event:Event):void{
			stepCount++;
			if(stepCount>=step){
				this.x = movePath[moveIndex+1][0];
				this.y = movePath[moveIndex+1][1];
				moveIndex++;
				stepCount=0;
				if(moveIndex==movePath.length-1){
					this.removeEventListener(Event.ENTER_FRAME,moveStep);
					this.removeEventListener(Event.ENTER_FRAME,centerToMap);
					ava.standAt(direction);
					//DisplayRefs.swfRootSprite.mouseChildren = true;
					//DisplayRefs.swfRootSprite.mouseEnabled = true;
				}else{
					moveCompute();
				}
			}else{
				this.x = int(movePath[moveIndex][0]+stepCount/step*lenX);
				this.y = int(movePath[moveIndex][1]+stepCount/step*lenY);
			}
			if(footScoureName != ""){
				if(footScoureName == "Flower1"){
					ParticleMoveBitmap.creat("Flower1BD",this.x,this.y);
					return;
				}
				footCountFrame++;
				if(footCountFrame>footFrame){
					footCountFrame = 0;
					var footClass:Class = MapEngine.getInstance().getSourceByName(footScoureName) as Class;
					var sp:Sprite = new footClass() as Sprite;
					MapEngine.getInstance().backgroundEffectLayer.addChild(sp);
					sp.x = this.x;
					sp.y = this.y;
					var ro:Array = [0,225,270,315,180,0,0,135,90,45];
					if(footIsDirection == true){
						sp.rotation  = -ro[direction];
					}
				}
			}
		}
		private function centerToMap(event:Event=null):void{
			MapEngine.getInstance().moveTo(this.x,this.y);
		}
	}
}