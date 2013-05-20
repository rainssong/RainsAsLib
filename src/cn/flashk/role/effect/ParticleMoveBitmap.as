package cn.flashk.role.effect
{
	import cn.flashk.map.MapEngine;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.events.Event;

	public class ParticleMoveBitmap extends Bitmap
	{
		private static var bd:BitmapData;
		private static var count:int = 0;
		private static var speedBD:BitmapData;
		private static var indexX:int = 0;
		private static var indexY:int = 0;
		
		private var sx:Number;
		private var sy:Number;
		
		private var px:Number=0;
		private var py:Number = 0;
		
		private var alcount:int=0;
		
		public function ParticleMoveBitmap()
		{
		}
		public static function creat(sourceName:String,ix:int,iy:int):void{
			if(bd == null){
				var footClass:Class = MapEngine.getInstance().getSourceByName(sourceName) as Class;
				var bdtmp:BitmapData = new footClass() as BitmapData;
				bd = bdtmp;
				trace("creat");
			}
			if(speedBD == null){
				speedBD = new BitmapData(500,500,false,0);
				//speedBD.perlinNoise(50,50,3,5,true,true,7,false);
				speedBD.perlinNoise(65, 65, 3, 5, false, true)
			}
			var pmb:ParticleMoveBitmap;
			for(var i:int=0;i<2;i++){
				pmb = new ParticleMoveBitmap();
				pmb.bitmapData = bd;
				pmb.x = ix;
				pmb.y = iy;
				MapEngine.getInstance().backgroundEffectLayer.addChild(pmb);
				pmb.init();
			}
		}
		public function init():void{
			indexX++;
			if(indexX>=speedBD.width){
				indexX = 0;
				indexY++;
				if(indexY >= speedBD.height){
					indexY = 0;
				}
			}
			sx = ((-0.5 + speedBD.getPixel(indexX, indexY) % 255 / 255) * 5+(Math.random()-0.5)*1.3)*1.8;
			sy = ((-0.5 + speedBD.getPixel(indexX, indexY) / 65535 / 255) * 5+(Math.random()-0.5)*1.3)*1.8;
			px = this.x;
			py = this.y;
			//trace(sx,sy);
			this.addEventListener(Event.ENTER_FRAME,move);
		}
		private function move(event:Event):void{
			px += sx;
			py += sy;
			this.x = int(px);
			this.y = int(py);
			alcount++;
			if(alcount >25){
				this.alpha -= 0.1;
				if(this.alpha <0.1){
					this.parent.removeChild(this);
					this.removeEventListener(Event.ENTER_FRAME,move);
				}
			}
		}
	}
}