package cn.flashk.role.player
{
	import cn.flashk.map.MapEngine;
	
	import flash.display.BitmapData;
	import flash.events.Event;
	import flash.filters.BlurFilter;
	import flash.geom.Point;
	import flash.geom.Rectangle;

	public class PlayerSelf extends Player
	{
		private static var ins:PlayerSelf;
		
		public function PlayerSelf()
		{
			ins = this;
			this.x = 750;
			this.y = 500;
			this.addEventListener(Event.ENTER_FRAME,checkKeyMove);
		}
		public static function getInstance():PlayerSelf{
			return ins;
		}
		public function move(mx:Number,my:Number):void{
			this.x += mx;
			this.y += my;
			if(this.x < 20 ) this.x =20;
			if(this.x > MapEngine.getInstance().mapWidth - 26)  this.x = MapEngine.getInstance().mapWidth - 26;
			if(this.y <0)  this.y = 0;
			if(this.y >MapEngine.getInstance().mapHeight -63 ) this.y = MapEngine.getInstance().mapHeight -63 ;
			this.x = int(this.x);
			this.y = int(this.y);
			MapEngine.getInstance().moveTo(this.x,this.y);
		}
		public function moveTo(nx:Number,ny:Number):void{
			MapEngine.getInstance().moveTo(nx,ny);
			this.x = nx;
			this.y = ny;
		}
		private function checkKeyMove(event:Event):void{
			if(MapEngine.getInstance().keys[1] == true){
				move(-3,0);
			}
			if(MapEngine.getInstance().keys[2] == true){
				move(3,0);
			}
			if(MapEngine.getInstance().keys[3] == true){
				move(0,-3);
			}
			if(MapEngine.getInstance().keys[4] == true){
				move(0,3);
			}
		}
	}
}