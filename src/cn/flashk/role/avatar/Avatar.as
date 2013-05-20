package cn.flashk.role.avatar
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.Event;

	public class Avatar extends Sprite
	{
		private var fileReader:AvatarFileReader;
		private var bp:Bitmap;
		private var loopIndexs:Array;
		private var loopPostion:int;
		private var centerXY:Array;
		private var playSpeed:int=4;
		private var frameCount:int=1;
		
		public function Avatar()
		{
			
			bp = new Bitmap();
			this.addChild(bp);
			fileReader = new AvatarFileReader();
			fileReader.addEventListener(AvatarFileReader.DECODE_ALL_COMPLETE,showFirst);
			fileReader.load("role1.ava");
		}
		private function showFirst(event:Event):void{
			centerXY=[-34,-112];
			trace("fir",centerXY);
			standAt(2);
			//playMove(1);
		}
		public function playLoop(from:uint,to:uint):void{
			loopIndexs=[from,to];
			loopPostion = from;
			frameCount=playSpeed;
			loop();
			this.addEventListener(Event.ENTER_FRAME,loop);
		}
		//循环播放走路动作
		public function playMove(direction:int):void{
			var arr:Array = FrameIndexs.move[direction] as Array;
			//trace(arr);
			if(direction==3 || direction==6 || direction == 9){
				bp.scaleX = -1;
				centerXY=[34,-112];
			}else{
				bp.scaleX = 1;
				centerXY=[-34,-112];
			}
			playLoop(arr[0],arr[1]);
		}
		//在某个方向站立
		public function standAt(direction:int):void{
			this.removeEventListener(Event.ENTER_FRAME,loop);
			var abp:Bitmap= fileReader.getBitmapAt(FrameIndexs.stand[direction]);
			if(direction==3 || direction==6 || direction == 9){
				bp.scaleX = -1;
				centerXY=[34,-112];
				bp.x = centerXY[0]-abp.x;
			}else{
				bp.scaleX = 1;
				centerXY=[-34,-112];
				bp.x = abp.x+centerXY[0];
			}
			bp.bitmapData = abp.bitmapData;
			bp.y = abp.y+centerXY[1];
		}
		private function loop(event:Event=null):void{
			frameCount++;
			if(frameCount>playSpeed){
				frameCount = 1;
				var abp:Bitmap= fileReader.getBitmapAt(loopPostion);
				bp.bitmapData = abp.bitmapData;
				if(bp.scaleX==-1){
					bp.x = centerXY[0]-abp.x;
				}else{
					bp.x = abp.x+centerXY[0];
				}
				bp.y = abp.y+centerXY[1];
				loopPostion++;
				if(loopPostion>loopIndexs[1]) loopPostion=loopIndexs[0];
			}
		}
	}
}