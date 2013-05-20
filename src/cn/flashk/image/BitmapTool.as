package cn.flashk.image
{
	import flash.display.BitmapData;
	import flash.geom.Rectangle;
	/**
	 * BitmapTool 是一些参数化处理bitmapData/bitmap的方法集合，用来处理图片或者获得图片数据信息。
	 * 
	 * BitmapTool所有的方法都是静态方法 
	 * 
	 * @langversion ActionScript 3.0
	 * @playerversion Flash 9.0
	 * 
	 * @see cn.flashk.controls.support.UIComponent
	 * 
	 * @author flashk
	 */

	public class BitmapTool
	{
		/**
		 * 返回透明BitmapData图像的不透明区域矩形/透明区域矩形
		 * 
		 * @param isNoAlpha 是否是不透明区域,传递true返回图像不透明区域的矩形
		 */ 
		public static function getNoAlphaArea(checkBitmapData:BitmapData,isNoAlpha:Boolean = true):Rectangle{
			return checkBitmapData.getColorBoundsRect(0xFF000000,0x00000000,!isNoAlpha);
		}
		
		/**
		 * 查找BitmapData图像中相关颜色的范围
		 */ 
		public static function getColorArea(checkBitmapData:BitmapData,color:uint):Rectangle{
			return checkBitmapData.getColorBoundsRect(0xFFFFFFFF,color,true);
		}
		/**
		 * 查找BitmapData图像周围的空白区域
		 */
		public static function getEmptyArea(checkBitmapData:BitmapData,isEmpty:Boolean=true):Rectangle{
			return checkBitmapData.getColorBoundsRect(0xFFFFFFFF,0xFFFFFFFF);
		}
	}
}