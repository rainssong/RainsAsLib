package cn.flashk.map.effect
{
	import cn.flashk.map.MapEngine;
	
	import flash.events.Event;
	import flash.geom.Point;

	public class Shake
	{
		private var view:MapEngine;
		private var totalFrame:int;
		private var nowFrame:int;
		private var range:Number;
		private var po:Point;
		private var t:Number;
		private var lessNum:Number = 1;
		private var mode:int=1;
		private var move:Number;
		
		public function Shake()
		{
		}
		public function run(time:Number=0.5,range:Number=5,mode:int=1):void{
			view = MapEngine.getInstance();
			nowFrame = 0;
			this.range = range;
			this.mode = mode;
			totalFrame = int(time*view.stage.frameRate);
			//po = new Point(view.x,view.y);
			po = view.getPoint(2);
			//trace(po);
			t = 0;
			view.addEventListener(Event.ENTER_FRAME,shakeFrame);
		}
		private function shakeFrame(event:Event):void{
			//trace("run");
			nowFrame++;
			var ra:Number;
			if(nowFrame<totalFrame){
				//view.x = int(-range/2+po.x+Math.random()*range);
				//view.y = int(-range/2+po.y+Math.random()*range);
				ra = t*Math.PI/180;
				t+=90;
				//trace(Math.sin(ra),Math.cos(ra));
				if(mode == 1){
					move = range;
					view.moveTo(int(-range*lessNum/2+po.x+Math.sin(ra)*move),int(-range*lessNum/2+po.y+Math.cos(ra)*move));
				}else{
					move = range - Math.abs((nowFrame-totalFrame/2)/(totalFrame/2))*range;
					//trace(move,nowFrame);
					view.moveTo(int(po.x+Math.sin(ra)*move),int(po.y+Math.cos(ra)*move));
				}
				
				//
			}else{
				view.removeEventListener(Event.ENTER_FRAME,shakeFrame);
				//view.x = po.x;
				//view.y = po.y;
				view.moveTo(po.x,po.y);
			}
		}
	}
}