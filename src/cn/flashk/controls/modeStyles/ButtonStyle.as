package cn.flashk.controls.modeStyles 
{
	import cn.flashk.controls.Button;
	import cn.flashk.controls.managers.DefaultStyle;
	/**
	 * ...
	 * @author flashk
	 */
	public class ButtonStyle 
	{
		
		public static const TEXT_COLOR:String = "textColor";
		public static const TEXT_OVER_COLOR:String = "textOverColor";
		public static const TEXT_DOWN_COLOR:String = "textDownColor";
		public static const ICON_OVER:String = "iconOver";
		public static const ICON_DOWN:String = "iconDown";
		public static const DEFAULT_SKIN_ELLIPSE_WIDTH:String = "defaultSkinEllipseWidth";
		public static const DEFAULT_SKIN_ELLIPSE_HEIGHT:String = "defaultSkinEllipseHeight";
		public static const DEFAULT_SKIN_ELLIPSE_BOTTOM_WIDTH:String = "defaultSkinEllipseBottomWidth";
		public static const DEFAULT_SKIN_ELLIPSE_BOTTOM_HEIGHT:String = "defaultSkinEllipseBottomHeight";
		public static const TEXT_ALIGN:String = "textAlign";
		public static const TEXT_PADDING:String = "textPadding";
		
		
		public function ButtonStyle(styleSet:Object):void {
			styleSet[ TEXT_COLOR ] = DefaultStyle.buttonOutTextColor;
			styleSet[ TEXT_OVER_COLOR ] = DefaultStyle.buttonOverTextColor;
			styleSet[ TEXT_DOWN_COLOR ] = DefaultStyle.buttonDownTextColor;
			styleSet[ DEFAULT_SKIN_ELLIPSE_WIDTH ] = DefaultStyle.ellipse;
			styleSet[ DEFAULT_SKIN_ELLIPSE_HEIGHT ] = DefaultStyle.ellipse;
			styleSet[ DEFAULT_SKIN_ELLIPSE_BOTTOM_WIDTH ] = DefaultStyle.ellipse;
			styleSet[ DEFAULT_SKIN_ELLIPSE_BOTTOM_HEIGHT ] = DefaultStyle.ellipse;
			styleSet[ ButtonStyle.TEXT_PADDING ] = 5;
			styleSet [ "align" ] = "center";
			styleSet [ "padding" ] = 15;
		}
	}

}