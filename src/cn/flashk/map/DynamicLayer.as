package cn.flashk.map
{
	import cn.flashk.debug.Debug;
	import cn.flashk.role.player.Player;
	import cn.flashk.role.player.PlayerSelf;
	
	import flash.display.Bitmap;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.utils.getTimer;
	import flash.utils.setTimeout;
	

	public class DynamicLayer extends Sprite
	{
		/**
		 * 告诉地图引擎动态层的人物、建筑关系是否在下一个渲染帧需要重新计算更新
		 */
		public var isDepthNeedChange:Boolean = true;
		private var self:PlayerSelf;
		private var allObjects:Array;
		private var bgIsInitAndDrag:Boolean = false;
		private var frameCount:int=0;
		
		public function DynamicLayer()
		{
			trace("DynamicLayer");
			self = new PlayerSelf();
			allObjects = new Array();
			this.mouseEnabled = false;
			this.addChild(self);
			this.addEventListener(Event.ENTER_FRAME,updateDepth);
			MapEngine.getInstance().backgroundLayer.addEventListener("gridAllLoaded",initToBG);
		}
		public function initObjects(dataXML:XML):void{
			trace("initObjects",dataXML.object.length());
			var objDis:ObjectDisplay;
			var all:Array = new Array();
			bgIsInitAndDrag = false;
			allObjects = new Array();
			for(var i:int=0;i<dataXML.object.length();i++){
				var ox:Number = dataXML.object[i].@x;
				var oy:Number = dataXML.object[i].@y;
				var ra:Number = Math.sqrt(Math.pow(ox-MapEngine.getInstance().centerX,2)+Math.pow(oy-MapEngine.getInstance().centerY,2));
				//trace(i,j,ra);
				all.push({data:dataXML.object[i],range:ra});
			}
			all.sortOn("range",Array.NUMERIC);
			for(i=0;i<all.length;i++){
				objDis = new ObjectDisplay();
				objDis.init(all[i].data);
				this.addChild(objDis);
				allObjects.push(objDis);
			}
		}
		private function updateDepth(event:Event):void{
			//var t:int = getTimer();
			frameCount++;
			if(frameCount>9){
				frameCount =0;
			}else{
				return;
			}
			
				if(isDepthNeedChange == false) return; 
				checkAddRemove();
				var all:Array = new Array();
				var dis:DisplayObject;
				var numCh:int = this.numChildren;
				for(var i:int=0;i<numCh;i++){
					dis = this.getChildAt(i);
					all.push({ref:dis,depth:Object(dis).depthY*MapEngine.getInstance().mapWidth+Object(dis).depthX});
				}
				all.sortOn("depth",Array.NUMERIC);
				var cout:int=0;
				var len:int = all.length;
				for(i=0;i<len;i++){
					if(this.getChildAt(i) != all[i].ref){
						this.setChildIndex(all[i].ref,i);
						cout++;
					}
				}
			
			//trace(getTimer()-t);
			//Debug.infoTxt.text = "深度更新个数："+String(cout) +"\n耗时："+(getTimer()-t)+" 物体："+this.numChildren;
		}
		private function checkAddRemove():void{
			if(bgIsInitAndDrag == false) return;
			var allPlayers:Array = new Array();
			var i:int;
			var j:int;
			var needShows:Array = new Array();
			var showingObjs:Array = new Array();
			var numCh:int = this.numChildren;
			for(i=0;i<numCh;i++){
				var dis:DisplayObject = this.getChildAt(i);
				if(dis is Player){
					allPlayers.push(dis);
				}else{
					showingObjs.push(dis);
				}
			}
			var len:int;
			var len2:int;
			var len3:int;
			len =allObjects.length;
			len2 = allPlayers.length;
			for(j =0 ;j<len;j++){
				for(i=0;i<len2;i++){
					var hitPos:Array = allPlayers[i].getHittestPoints();
					len3 = hitPos.length;
					for(var k:int=0;k<len3;k++){
						if(hitPos[k].x < allObjects[j].x || hitPos[k].x > allObjects[j].x+allObjects[j].width || hitPos[k].y < allObjects[j].y ||  hitPos[k].y > allObjects[j].y+allObjects[j].height){
						}else{
							needShows.push(allObjects[j]);
							break;
						}
					}
				}
			}
			len = showingObjs.length;
			len2 = needShows.length;
			for(i=0;i<len;i++){
				var isIn:Boolean = false;
				for(j=0;j<len2;j++){
					if(needShows[j] == showingObjs[i]){
						isIn = true;
						break;
					}
				}
				if(isIn == false){
					this.removeChild(showingObjs[i]);
				}
			}
			len3 = needShows.length;
			for(i=0;i<len3;i++){
				if(needShows[i].parent != this){
					this.addChild(needShows[i]);
				}
			}
			//allPlayers = null;
		}
		private function initToBG(event:Event):void{
			setTimeout(initToBGLater,1000);
		}
		
		private function initToBGLater():void{
			bgIsInitAndDrag = true;
		}
	}
}