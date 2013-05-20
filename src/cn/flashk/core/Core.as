package cn.flashk.core
{
	import cn.flashk.asset.AssetFactory;
	import cn.flashk.asset.LoadingAsset;
	import cn.flashk.eventManager.EventCenter;
	import cn.flashk.events.CoreEvent;
	import cn.flashk.net.StartFilesLoader;
	
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.utils.ByteArray;

	public class Core extends Sprite
	{
		private static var ins:Core;
		private var loadingMC:MovieClip;
		private var sfloader:StartFilesLoader;
		private var ldrs:Array;
		private var initIndex:int;
		private var initDatas:Array;
		
		public function Core()
		{
			ins = this;
			start();
		}
		public static function getInstance():Core{
			return ins;
		}
		/**
		 * 开始游戏必需的文件下载
		 */ 
		public function start():void{
			loadingMC = AssetFactory.getMovieClipByRef(LoadingAsset.startMovieClip);
			DisplayRefs.swfRootSprite.addChild(loadingMC);
			sfloader = new StartFilesLoader();
			sfloader.init(loadingMC,Config.getInstance().startLoad,Config.getInstance().startLoadScreen,Config.getAttributeByChild("startLoadScreen","scaleMode"),Config.getAttributeByChild("startLoadScreen","loadBarAlgin"));
		}
		/**
		 * 初始化游戏
		 * 对于被预加载的数据，将按文件顺序前一个初始化完成再初始化后面一个，直到最后一个初始化完毕。将播发CoreEvent.INIT_ALL_COMPLETE事件。
		 * 
		 *  @param datas 此数组为需要初始化的原始文件数据列表（默认为下载器里的数据），请注意：初始化完成后，此数组将被清空以释放内存
		 * 
		 */ 
		public function initGame(datas:Array):void{
			ldrs = new Array();
			initIndex = 0;
			initDatas = datas;
			initNext();
		}
		private function initNext(event:Event=null):void{
			var ldr:Loader;
			if(initIndex<initDatas.length){
				ldr = new Loader();
				ldrs[initIndex] = ldrs;
				ldr.loadBytes(initDatas[initIndex]);
				ldr.contentLoaderInfo.addEventListener(Event.INIT,initNext);
				initIndex++;
			}else{
				initComplete();
			};
		}
		private function initComplete():void{
			initDatas.splice(0);
			EventCenter.eventRadio.dispatchEvent(new Event(CoreEvent.LOAD_SCREEN_REMOVE));
			DisplayRefs.swfRootSprite.removeChild(loadingMC);
			loadingMC = null;
			EventCenter.eventRadio.dispatchEvent(new Event(CoreEvent.INIT_ALL_COMPLETE));
			trace("init all complete");
		}
	}
}