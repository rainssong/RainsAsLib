package  org.superkaka.kakalib.struct 
{
	import flash.display.BitmapData;
	/**
	 * ...
	 * @author ｋａｋａ
	 * 位图帧信息
	 */
	public class BitmapFrameInfo
	{
		/**
		 * x轴偏移
		 */
		public var x:Number;
		
		/**
		 * y轴偏移
		 */
		public var y:Number;
		
		/**
		 * 位图数据
		 */
		public var bitmapData:BitmapData;
		
		
		//=================静态管理===============
		
		
		static private const map_data:Object = { };
		
		/**
		 * 存储位图帧信息序列
		 * @param	id
		 * @param	data
		 */
		static public function storeBitmapFrameInfo(id:String, data:Vector.<BitmapFrameInfo>):void
		{
			map_data[id] = data;
		}
		
		
		/**
		 * 获取位图帧信息序列
		 * @param	id
		 * @return
		 */
		static public function getBitmapFrameInfo(id:String):Vector.<BitmapFrameInfo>
		{
			return map_data[id];
		}
		
	}

}