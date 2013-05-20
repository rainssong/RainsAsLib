package cn.flashk.zipPack
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import flash.utils.ByteArray;
	
	/**
	 * 当文件加载并且解压缩已经完成时调度，此时，你可以访问data属性
	 * @eventType FileTxtZiperDecoder.DECODE_COMPLETE
	 * @see #data
	 **/
	[Event(name="decodeComplete",type="flash.events.Event")]
	
	/**
	 * FileTxtZiperDecoder 类提供了一个在swf运行时访问 FileTxtZiperEncoder 压缩数据的方法。
	 * 
	 * <p>这种格式能将文本、XML、HTML、Json以及所有文本类文件压缩到原来的1/7-1/3左右。此类提供了简单访问这种文件原始数据的方法。</p>
	 * <p>压缩文件是由FileTxtZiperEncoder的AIR生成工具产生的。并部署到网络中，可以参阅关于引擎中提供的AIR压缩工具的内容。</p>
	 * 
	 * @langversion ActionScript 3.0
	 * @playerversion Flash 9.0
	 * 
	 * @see FileTxtZiperEncoder
	 * 
	 * @author flashk
	 */


	public class FileTxtZiperDecoder extends EventDispatcher
	{
		/**
		 * @eventType decodeComplete
		 **/
		public static const DECODE_COMPLETE:String = "decodeComplete";
		
		private var uldr:URLLoader;
		private var req:URLRequest;
		private var _data:String;
		private var byteArray:ByteArray;
		
		/**
		 * 创建一个FileTxtZiperDecoder对象，使用一个单独的进程加载和解压缩文件
		 */ 
		public function FileTxtZiperDecoder()
		{
		}
		/**
		 * 读取压缩包解压缩后的原始数据。必须在decodeComplete事件后访问，否则将返回空值
		 * @see #decodeComplete
		 */ 
		public function get data():String{
			return _data;
		}
		/**
		 * 加载一个压缩文件
		 * @param filePath 压缩文件的相对/绝对地址
		 */ 
		public function loadAndDecodeFile(filePath:String):void{
			uldr = new URLLoader();
			uldr.addEventListener(Event.COMPLETE,decodeFile);
			uldr.dataFormat = URLLoaderDataFormat.BINARY;
			req = new URLRequest(filePath);
			uldr.load(req);
		}
		private function decodeFile(event:Event):void{
			byteArray = new ByteArray();
			byteArray.writeBytes(uldr.data);
			byteArray.uncompress();
			_data = byteArray.readUTFBytes(byteArray.length);
			
			uldr = null;
			req = null;
			//byteArray.clear();
			
			this.dispatchEvent(new Event(DECODE_COMPLETE));
		}
	}
}