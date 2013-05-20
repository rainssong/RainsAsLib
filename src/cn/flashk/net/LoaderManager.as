package cn.flashk.net
{
	import cn.flashk.events.LoaderManagerEvent;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.utils.setTimeout;

	public class LoaderManager extends EventDispatcher
	{
		private static var ins:LoaderManager;
		
		public static var max:uint = 10;
		
		private var uldrs:Array;
		private var index:uint = 0;
		private var datas:Array;
		private var isStart:Boolean = false;
		private var loadCout:uint = 0;
		
		public function LoaderManager()
		{
			uldrs = new Array();
			for(var i:int=0;i<max;i++){
				var uldr:URLLoader = new URLLoader();
				uldr.addEventListener(Event.COMPLETE,completeDispath);
				uldrs[i] = uldr;
			}
			datas = new Array();
		}
		public static function getInstance():LoaderManager{
			if(ins == null){
				ins = new LoaderManager();
			}
			return ins;
		}
		public function load(file:String,typeName:String="global",dataFormat:String="binary"):void{
			datas.splice(index+loadCout,0,[file,typeName,dataFormat]);
			//trace(datas.length , index);
			if(isStart == false ){
			//if(isStart == false || datas.length == index+1){
				startLoad(0);
				isStart = true;
			}
			loadCout++;
		}
		public function add(file:String,typeName:String="global",dataFormat:String="binary"):void{
			datas.push([file,typeName,dataFormat]);
			if(index==datas.length-1){
				startLoad(0);
			}
		}
		private function startLoad(tid:uint):void{
			//trace("run-");
			if(index+tid >= datas.length) return;
			var req:URLRequest = new URLRequest(datas[index+tid][0]);
			URLLoader(uldrs[tid]).dataFormat = datas[index+tid][2];
			URLLoader(uldrs[tid]).load(req);
			//trace("run");
		}
		private function completeDispath(event:Event):void{
			
			var tid:uint = getID(event.currentTarget as URLLoader);
			try{
				this.dispatchEvent(new LoaderManagerEvent(LoaderManagerEvent.COMPLETE,datas[index+tid][0],datas[index+tid][1],URLLoader(event.currentTarget)));
			}catch(e:Error){
				//
			}
			index++;
			setTimeout(startLoad,20,0);
			//startLoad(0);
			//trace("completeDispath",index);
		}
		private function getID(uldr:URLLoader):uint{
			var tid:uint = 0;
			for(var i:int=0;i<max;i++){
				if(uldrs[i] == uldr){
					tid = i;
					break;
				}
			}
			return tid;
		}
	}
}