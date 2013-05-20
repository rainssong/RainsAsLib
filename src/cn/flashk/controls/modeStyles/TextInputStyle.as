package cn.flashk.controls.modeStyles 
{
	import cn.flashk.controls.managers.DefaultStyle;

	/**
	 * ...
	 * @author flashk
	 */
	public class TextInputStyle 
	{
		
		public static const TEXT_COLOR:String = "textColor";
		public static const TEXT_OVER_COLOR:String = "textOverColor";
		public static const TEXT_DOWN_COLOR:String = "textDownColor";
		public static const TIP_TEXT_COLOR:String = "tipTextColor";
		public static const ICON_OVER:String = "iconOver";
		public static const ICON_DOWN:String = "iconDown";
		public static const DEFAULT_SKIN_ELLIPSE_WIDTH:String = "defaultSkinEllipseWidth";
		public static const DEFAULT_SKIN_ELLIPSE_HEIGHT:String = "defaultSkinEllipseHeight";
		
		public function TextInputStyle(styleSet:Object):void
		{
			
			styleSet[ TEXT_COLOR ] = 0x000000;
			styleSet[ TIP_TEXT_COLOR ] = 0x666666;
			styleSet[ TEXT_OVER_COLOR ] = 0x333333;
			styleSet[ TEXT_DOWN_COLOR ] = 0x000000;
			styleSet[ DEFAULT_SKIN_ELLIPSE_WIDTH ] = DefaultStyle.ellipse;
			styleSet[ DEFAULT_SKIN_ELLIPSE_HEIGHT ] = DefaultStyle.ellipse;
		}
		
	}

}