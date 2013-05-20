package cn.flashk.controls.managers 
{
	import flash.filters.DropShadowFilter;
	import flash.filters.GlowFilter;
	/**
	 * <p>DefaultStyle 设置了一些程序组件的默认外观</p>
	 * 
	 */ 
	public class DefaultStyle 
	{
		public static var fontSize:Object = 12;
		public static var titleFontSize:Object = 13;
		public static var buttonOutTextColor:String = "#000000";
		public static var buttonOverTextColor:String = "#111111";
		public static var buttonDownTextColor:String = "#333333";
		public static var checkBoxTextColor:String = "#000000";
		public static var checkBoxTextOverColor:String = "#666666";
		public static var checkBoxLineColor:String = "#009100";
		public static var textColor:String= "#000000";
		public static var menuBackgroundColor:String = "#FFFFFF";
		public static var font:String = "Microsoft Yahei,STXihei,SimSun,Arial,Verdana";
		public static var filters:Array = [];
		//public static var buttonTextFilters:Array = [ new DropShadowFilter(1, 90, 0xFFFFFF, 1, 2, 2, 0.9, 1)];
		public static var buttonTextFilters:Array = [ ];
		public static var buttonTextDropAlpha:Number = 0.5;
		public static var buttonTextDropColor:String = "#FFFFFF";
		public static var windowTitleHeight:Number = 27;
		public static var windowTitleAlpha:Number = 0.7;
		public static var windowButtonOverFilter:Array = [new GlowFilter(0x72d3fc,1,10,10,2.1,2)];
		public static var toolTipEllipse:Number = 3.5;
		//程序全局圆角的大小 推荐的值：0 1 2  2.55  3.7  4.55 6.25 7.5 8.5 9.5 11.5 15
		public static var ellipse:Number = 2;
		public static var scrollBarRound:Number = 2;
		/**
		 * 组件边框线条是否开启像素对齐，如果graphicsDrawOffset值设为0.5，则不开始此选项能获得更好的圆角反锯齿效果。
		 */ 
		public static var pixelHinting:Boolean = false;
		/**
		 * 对于圆角矩形，将此值设为0.5附近的值可以获得更好的反锯齿效果，并且在播放品质为中时边框线条不会模糊，对于直角矩形，在播放品质为低的情况下建议将此值设为0.
		 */ 
		public static var graphicsDrawOffset:Number = 0.5;
	}

}