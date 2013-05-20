package cn.flashk.conversion 
{
	
	/**
	 * ColorConversion 类转换各种颜色值。
	 * 
	 * @langversion ActionScript 3.0
	 * @playerversion Flash 9.0
	 * 
	 * @see cn.flashk.controls.support.UIComponent
	 * @see UIComponent.setStyle()
	 * 
	 * @author flashk
	 */
	public class ColorConversion 
	{
		
		public function ColorConversion() 
		{
			
		}
		/**将一个十六进制的字符串（#FF3300)转换成为一个uint数字
		 * 
		 * @return 转换后的uint数字
		 */ 
		public static function transformWebColor(value:String):uint {
			if (value == "" || value == null) {
				return 0x000000;
			}
			return uint(parseInt(value.slice(1), 16));
		}
		/**将一个uint数字转换成为一个十六进制的字符串（#FF3300)
		 * 
		 * @return 转换后的带#的字符串文本
		 */ 
		public static function transUintToWeb(value:uint):String {
			return "#"+value.toString(16);
		}
		/**
		 * 提取从BitmapData.getPixel32()方法32位色彩中的透明度值
		 * 
		 * @return 32位色彩值中的Alpha透明度值，为0（全透明）-255（不透明）
		 */ 
		public static function getAlphaFromeARGB(value:uint):uint {
			var pixelValue:uint = value;
			var alphaValue:uint = pixelValue >> 24 & 0xFF;
			var red:uint = pixelValue >> 16 & 0xFF;
			var green:uint = pixelValue >> 8 & 0xFF;
			var blue:uint = pixelValue & 0xFF;

			return alphaValue;
			trace(alphaValue.toString(16)); // ff
			trace(red.toString(16)); // 44
			trace(green.toString(16)); // aa
			trace(blue.toString(16)); // cc
		}
	}

}