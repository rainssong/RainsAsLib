package cn.flashk.map.move
{
	import cn.flashk.core.DisplayRefs;
	import cn.flashk.map.MapEngine;
	import cn.flashk.role.player.PlayerSelf;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.CapsStyle;
	import flash.display.JointStyle;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.display.StageQuality;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;

	/**
	 * 角色自动寻路系统
	 */ 
	public class AutoRoad
	{
		public static var maxCount:int=0;
		private static var ins:AutoRoad;
		private var model:MapTileModel;
		private var aStar:AStar;
		private var viewSP:Sprite;
		private var topX:Number;
		private var topY:Number;
		private var length:uint;
		private var gridWidth:Number;
		private var gridHeight:Number;
		private var dataStr:String;
		private var roadView:Shape;
		private var checkLine:Shape;
		private var blockBD:BitmapData;
		private var bp:Bitmap;
		//判断人物路径可通过的大小
		private var crossSize:Number = 8;
		
		public function AutoRoad()
		{
			ins = this;
			model = new MapTileModel();
			aStar = new AStar(model,2500);
			viewSP = new Sprite();
			viewSP.alpha = 0.5;
			roadView = new Shape();
			checkLine = new Shape();
			bp = new Bitmap();
			bp.alpha = 0.3;
			//MapEngine.getInstance().addChild(bp);
			//MapEngine.getInstance().addChild(roadView);
			roadView.alpha = 1;
			//MapEngine.getInstance().addChild(checkLine);
		}
		public static function getInstance():AutoRoad{
			return ins;
		}
		public function switchShowDebug():void{
			if(roadView.parent == null){
				MapEngine.getInstance().addChild(bp);
				MapEngine.getInstance().addChild(roadView);
			}else{
				MapEngine.getInstance().removeChild(bp);
				MapEngine.getInstance().removeChild(roadView);
			}
		}
		public function rebulid(data:XML):Boolean{
			var newWidth:Number = MapEngine.getInstance().mapWidth;
			var newHeight:Number = MapEngine.getInstance().mapHeight;
			var gridWidth:Number = MapEngine.getInstance().mapData.@gridWidth;
			var gridHeight:Number = MapEngine.getInstance().mapData.@gridHeight;
			var numX:Number = Math.ceil(newWidth/gridWidth);
			topX = numX*gridWidth/2;
			topY = -numX*gridHeight/2;
			var numY:Number = Math.ceil(newHeight/gridHeight);
			length = uint(numX+numY);
			this.gridWidth = gridWidth;
			this.gridHeight = gridHeight;
			dataStr = data.toString();
			trace(gridWidth,gridHeight,topX,topY,numX,numY,length,newWidth,newHeight);
			//trace(dataStr);
			reInit();
			return true;
		}
		/**
		 * 根据地图上的坐标获取网格的坐标
		 **/
		public function getGridXY(px:Number,py:Number):Point{
			var po:Point=new Point();
			po.x = Math.round((py*gridWidth -px*gridHeight )/gridHeight /gridWidth - topY/gridHeight  + topX/gridWidth  - 1/2);
			po.y = Math.round(px / gridWidth + py / gridHeight - topX / gridWidth - topY / gridHeight + 1 / 2);
			return po;
		}
		/**
		 * 根据网格的坐标获取地图上的坐标
		 **/
		public function getMapXY(px:int,py:int):Point{
			var po:Point=new Point();
			var i:int = px;
			var j:int = py;
			po.x = topX+j*gridWidth/2-i*gridWidth/2-gridWidth/2
			po.y = topY+j*gridHeight/2+i*gridHeight/2;
			return po;
		}
		private function reInit():void{
			var px:Number;
			var py:Number;
			var w:Number = MapEngine.getInstance().mapWidth;
			var h:Number =  MapEngine.getInstance().mapHeight;
			
			model.rebuild(dataStr,length);
			var quality:String = DisplayRefs.swfRootSprite.stage.quality;
			DisplayRefs.swfRootSprite.stage.quality = StageQuality.LOW;
			viewSP.graphics.clear();
			viewSP.graphics.beginFill(0xCC0000,1);
			for(var i:int=0;i<length;i++){
				for(var j:int=0;j<length;j++){
					px = topX+j*gridWidth/2-i*gridWidth/2-gridWidth/2
					py = topY+j*gridHeight/2+i*gridHeight/2;
					if(py > h || px > w || px+gridWidth <0 || py+gridHeight<0){
						
					}else{
						if(dataStr.slice(i*length+j-1,i*length+j+1-1)=="0"){
							viewSP.graphics.moveTo(px,py-gridHeight/2);
							viewSP.graphics.lineTo(px+gridWidth/2,py);
							viewSP.graphics.lineTo(px,py+gridHeight/2);
							viewSP.graphics.lineTo(px-gridWidth/2,py);
							viewSP.graphics.lineTo(px,py-gridHeight/2);
							//viewSP.graphics.endFill();
						}else{
							//viewSP.graphics.drawEllipse(px,py,2,2);
						}
					}
				}
			}
			if(blockBD != null) blockBD.dispose();
			blockBD = new BitmapData(w,h,true,0x00FFFFFF);
			blockBD.draw(viewSP);
			bp.bitmapData = blockBD;
			DisplayRefs.swfRootSprite.stage.quality = quality;
		}
		public function moveTo(x:Number,y:Number):Boolean{
			var po:Point = getGridXY(x,y);
			var path:Array = new Array();
			if(model.checkAbleTo(po.x,po.y)== false) {
				findNearPoint(x,y);
				return false;
			}
			roadView.graphics.clear();
			roadView.graphics.lineStyle(1,0,0.5);
			roadView.graphics.beginFill(0,1);
			roadView.graphics.moveTo(PlayerSelf.getInstance().x,PlayerSelf.getInstance().y);
			path[0] = [PlayerSelf.getInstance().x,PlayerSelf.getInstance().y];
			var isSimple:Boolean = false;
			if(checkLineAbleCross(PlayerSelf.getInstance().x,PlayerSelf.getInstance().y,x,y) == true){
				isSimple = true;
			}else{
				var playerPo:Point = getGridXY(PlayerSelf.getInstance().x,PlayerSelf.getInstance().y);
				var pathArr:Array = aStar.find(playerPo.x,playerPo.y,po.x,po.y);
				if(pathArr == null){
					findNearPoint(x,y);
					return false;
				}
				if(pathArr.length ==0) return false;
				var toPo:Point;
				for(var i:int=0;i<pathArr.length;i++){
					toPo = getMapXY(pathArr[i][0],pathArr[i][1]);
					path[i+1] = [toPo.x,toPo.y];
					roadView.graphics.lineTo(toPo.x,toPo.y);
					roadView.graphics.drawCircle(toPo.x,toPo.y,3);
					roadView.graphics.moveTo(toPo.x,toPo.y);
				}
			}
			path.push( [x,y] );
			roadView.graphics.lineTo(x,y);
			//PlayerSelf.getInstance().x = x;
			//PlayerSelf.getInstance().y = y;
			//trace(path);
			if(isSimple == false){
				path = simplePath(path);
			}
			//trace(path,":::");
			roadView.graphics.endFill();
			roadView.graphics.lineStyle(2,0x00DD00,0.5);
			roadView.graphics.beginFill(0x00FF00,1);
			roadView.graphics.drawCircle(path[0][0],path[0][1],5);
			roadView.graphics.moveTo(path[0][0],path[0][1]);
			for(var k:int=1;k<path.length;k++){
				roadView.graphics.lineTo(path[k][0],path[k][1]);
				roadView.graphics.drawCircle(path[k][0]-3,path[k][1],5);
				//roadView.graphics.moveTo(path[k][0],path[k][1]);
			}
			//trace(po,pathArr);
			
			PlayerSelf.getInstance().moveWithPath(path);
			return true;
		}
		/**
		 * 确定一条直线路径能否通过当前地图障碍物
		 */ 
		public function checkLineAbleCross(startX:Number,startY:Number,endX:Number,endY:Number):Boolean{
			checkLine.graphics.clear();
			checkLine.graphics.lineStyle(crossSize,0,1,false,"normal",CapsStyle.ROUND,JointStyle.ROUND,3);
			checkLine.graphics.moveTo(startX,startY);
			checkLine.graphics.lineTo(endX,endY);
			
			var rect:Rectangle = checkLine.getBounds(checkLine);
			var hitBD:BitmapData = new BitmapData(rect.width,rect.height,true,0x00FFFFFF);
			hitBD.draw(checkLine,new Matrix(1,0,0,1,-rect.x,-rect.y));
			var albe:Boolean = blockBD.hitTest(new Point(0,0),125,hitBD,new Point(rect.x,rect.y),1);
			return !albe;
		}
		/**
		 * 按当前地图遮挡简化一条路径
		 */ 
		public function simplePath(path:Array):Array{
			var sim:Array = new Array();
			sim[0] = [ path[0][0],path[0][1] ];
			for(var i:int=0;i<path.length;i++){
				for(var j:int=path.length-1;j>i;j--){
					if(checkLineAbleCross(path[i][0],path[i][1],path[j][0],path[j][1]) == true){
						sim.push([ path[j][0],path[j][1] ]);
						i = j-1;
						break;
						//j =-1;
					}
				}
			}
			return sim;
		}
		/**
		 * 如果目标地点不可到达，寻找最近的点并寻路
		 */ 
		private function findNearPoint(x:Number,y:Number):void{
			maxCount++;
			if(maxCount>5){
				return;
			}
			var po:Point;
			po = getGridXY(x,y);
			var a:int = po.x;
			var b:int = po.y;
			po = getGridXY(PlayerSelf.getInstance().x,PlayerSelf.getInstance().y);
			var c:int = po.x;
			var d:int = po.y;
			var li:Number = (d-b)/(c-a);
			var addX:int = 1;
			var addY:int = 1;
			if(c<a) addX = -1;
			if(d<b) addY = -1;
			var px:int;
			var py:int;
			var i:int;
			if(li<1 && li>-1){
				for(i=0;Math.abs(a+i-c)>1;i+=addX){
					px = a+i;
					py = int(b+i*li);
					if(model.checkAbleTo(px,py) == true){
						po = getMapXY(px,py);
						moveTo(po.x,po.y);
						break;
					}
				}
			}else{
				for(i=0;Math.abs(b+i-d)>1;i+=addY){
					px = int(a+i/li);
					py = b+i;
					if(model.checkAbleTo(px,py) == true){
						po = getMapXY(px,py);
						moveTo(po.x,po.y);
						break;
					}
				}
				
			}
		}
	}
}