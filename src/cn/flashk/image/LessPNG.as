package cn.flashk.image 
{
	import cn.flashk.eventManager.EventCenter;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.BitmapDataChannel;
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.net.URLRequest;
	
	/**
	 * 图像合并完成时调度
	 * @eventType loadedComplete
	 **/
	[Event(name="complete",type="flash.events.Event")]
	/**
	 * 当两个图像文件都加载完时调度
	 * @eventType loadedComplete
	 **/
	[Event(name="loadedComplete",type="flash.events.Event")]
	
	/**
	 * LessPNG 类将一个jpeg和png8/gif/jpg蒙板直接合成为一个透明的png图片。可以使用外部的文件或者库链接。
	 * 
	 * <p>这种类型的图片能将原来的图片压缩到30%-70%大小，并且人眼几乎分辨率不出分别，原始png的透明通道也给以保留。</p>
	 * <p>关于如何使用工具生成压缩图和通道蒙板，请参考引擎关于压缩LessPNG AIR工具包的内容。</p>
	 * 
	 * @langversion ActionScript 3.0
	 * @playerversion Flash 9.0
	 * 
	 * @see LessPNG.mxml
	 * @see flash.display.Bitmap
	 * 
	 * @author flashk
	 */
	public class LessPNG extends Bitmap
	{
		private var ldr:Loader;
		private var ldr2:Loader;
		
		private var bd:BitmapData;
		private var bd2:BitmapData;
		
		private var showBD:BitmapData;
		
		private var loadedCount:uint;
		
		/**
		 * 创建一个LessPNG对象，如果urlOrLinkName参数不为空，将自动调用load加载。
		 * @see #load()
		 */
		public function LessPNG(urlOrLinkName:String="", type:String=".gif",isUseAssetLibrary:Boolean=false,maskURLOrLinkName:String="") 
		{
			if(urlOrLinkName != ""){
				load(urlOrLinkName, type,isUseAssetLibrary, maskURLOrLinkName);
			}
		}
		/**
		 * 加载一个压缩图片和蒙板图片，并自动合成png透明图片
		 * @param urlOrLinkName压缩图片的地址/库连接名
		 * @param type 蒙板图片的后缀名，默认为 .gif
		 * @param isUseAssetLibrary 指示urlOrLinkName的值是一个文件地址还是库中的链接名，如果使用的是库链接，可以在load之后立即访问bitmapData属性，不比等待loadedComplete事件
		 * @param maskURLOrLinkName 蒙板文件的文件名/库名。如果此参数为路径并且非空，将忽略type参数，默认不填此参数的情况下自动使用urlOrLinkName+"-mask"的文件名/库名作为蒙板
		 * 
		 * @see #complete
		 */
		public function load(urlOrLinkName:String, 
							 type:String=".gif",
							 isUseAssetLibrary:Boolean = false, 
							 maskURLOrLinkName:String = ""):void 
		{
			ldr = new Loader();
			ldr2 = new Loader();
			ldr.contentLoaderInfo.addEventListener(Event.COMPLETE, checkDrawAble);
			ldr2.contentLoaderInfo.addEventListener(Event.COMPLETE, checkDrawAble);
			if (maskURLOrLinkName == "") {
				var index:int = urlOrLinkName.lastIndexOf(".");
				maskURLOrLinkName = urlOrLinkName.slice(0, index) + "-mask" + type;
			}
			loadedCount = 0;
			ldr.load(new URLRequest(urlOrLinkName));
			ldr2.load(new URLRequest(maskURLOrLinkName));
		}
		private function checkDrawAble(event:Event):void {
			loadedCount++;
			trace(loadedCount);
			if (loadedCount == 2) {
				bd = (ldr.content as Bitmap).bitmapData;
				bd2 = (ldr2.content as Bitmap).bitmapData;
				trace(bd.width);
				this.dispatchEvent(new Event("loadedComplete"));
				synthesisShowBD();
			}
		}
		private function synthesisShowBD():void {
			showBD = new BitmapData(bd.width, bd.height, true, 0x00FFFFFF);
			showBD.copyPixels(bd,new Rectangle(0,0,bd.width,bd.height),new Point(0,0),null,null,false);
			showBD.copyChannel(bd2, new Rectangle(0, 0, showBD.width, showBD.height), new Point(0, 0), BitmapDataChannel.RED, BitmapDataChannel.ALPHA);
			this.bitmapData = showBD;
			
			bd.dispose();
			bd2.dispose();
			ldr = null;
			ldr2 = null;
			this.dispatchEvent(new Event(Event.COMPLETE));
		}
	}

}