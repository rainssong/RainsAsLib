package me.rainssong.utils
{
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.utils.describeType;
	
	/**
	 *
	 * @author Rainssong
	 * 2013-5-9
	 */
	public class Color
	{
		/** * 浅粉红 */
		public static const LightPink:uint = 0xFFB6C1, 浅粉红:uint = LightPink
		/** * 粉红 */
		public static const Pink:uint = 0xFFC0CB, 粉红:uint = Pink
		/** * 深红 */
		public static const Crimson:uint = 0xDC143C, 深红:uint = Crimson
		/** * 淡紫红 */
		public static const LavenderBlush:uint = 0xFFF0F5, 淡紫红:uint = LavenderBlush
		/** * 弱紫罗兰红 */
		public static const PaleVioletRed:uint = 0xDB7093, 弱紫罗兰红:uint = PaleVioletRed
		/** * 热情的粉红 */
		public static const HotPink:uint = 0xFF69B4, 热情的粉红:uint = HotPink
		/** * 深粉红 */
		public static const DeepPink:uint = 0xFF1493, 深粉红:uint = DeepPink
		/** * 中紫罗兰红 */
		public static const MediumVioletRed:uint = 0xC71585, 中紫罗兰红:uint = MediumVioletRed
		/** * 兰花紫 */
		public static const Orchid:uint = 0xDA70D6, 兰花紫:uint = Orchid
		/** * 蓟色 */
		public static const Thistle:uint = 0xD8BFD8, 蓟色:uint = Thistle
		/** * 李子紫 */
		public static const Plum:uint = 0xDDA0DD, 李子紫:uint = Plum
		/** * 紫罗兰 */
		public static const Violet:uint = 0xEE82EE, 紫罗兰:uint = Violet
		/** * 洋红 */
		public static const Magenta:uint = 0xFF00FF, 洋红:uint = Magenta
		/** * 紫红 */
		public static const Fuchsia:uint = 0xFF00FF, 紫红:uint = Fuchsia
		/** * 深洋红 */
		public static const DarkMagenta:uint = 0x8B008B, 深洋红:uint = DarkMagenta
		/** * 紫色 */
		public static const Purple:uint = 0x800080, 紫色:uint = Purple
		/** * 中兰花紫 */
		public static const MediumOrchid:uint = 0xBA55D3, 中兰花紫:uint = MediumOrchid
		/** * 暗紫罗兰 */
		public static const DarkViolet:uint = 0x9400D3, 暗紫罗兰:uint = DarkViolet
		/** * 暗兰花紫 */
		public static const DarkOrchid:uint = 0x9932CC, 暗兰花紫:uint = DarkOrchid
		/** * 靛青 */
		public static const Indigo:uint = 0x4B0082, 靛青:uint = Indigo
		/** * 蓝紫罗兰 */
		public static const BlueViolet:uint = 0x8A2BE2, 蓝紫罗兰:uint = BlueViolet
		/** * 中紫色 */
		public static const MediumPurple:uint = 0x9370DB, 中紫色:uint = MediumPurple
		/** * 中板岩蓝 */
		public static const MediumSlateBlue:uint = 0x7B68EE, 中板岩蓝:uint = MediumSlateBlue
		/** * 板岩蓝 */
		public static const SlateBlue:uint = 0x6A5ACD, 板岩蓝:uint = SlateBlue
		/** * 暗板岩蓝 */
		public static const DarkSlateBlue:uint = 0x483D8B, 暗板岩蓝:uint = DarkSlateBlue
		/** * 熏衣草淡紫 */
		public static const Lavender:uint = 0xE6E6FA, 熏衣草淡紫:uint = Lavender
		/** * 幽灵白 */
		public static const GhostWhite:uint = 0xF8F8FF, 幽灵白:uint = GhostWhite
		/** * 纯蓝 */
		public static const Blue:uint = 0x0000FF, 纯蓝:uint = Blue
		/** * 中蓝色 */
		public static const MediumBlue:uint = 0x0000CD, 中蓝色:uint = MediumBlue
		/** * 午夜蓝 */
		public static const MidnightBlue:uint = 0x191970, 午夜蓝:uint = MidnightBlue
		/** * 暗蓝色 */
		public static const DarkBlue:uint = 0x00008B, 暗蓝色:uint = DarkBlue
		/** * 海军蓝 */
		public static const Navy:uint = 0x000080, 海军蓝:uint = Navy
		/** * 皇家蓝 */
		public static const RoyalBlue:uint = 0x4169E1, 皇家蓝:uint = RoyalBlue
		/** * 矢车菊蓝 */
		public static const CornflowerBlue:uint = 0x6495ED, 矢车菊蓝:uint = CornflowerBlue
		/** * 亮钢蓝 */
		public static const LightSteelBlue:uint = 0xB0C4DE, 亮钢蓝:uint = LightSteelBlue
		/** * 亮石板灰 */
		public static const LightSlateGray:uint = 0x778899, 亮石板灰:uint = LightSlateGray
		/** * 石板灰 */
		public static const SlateGray:uint = 0x708090, 石板灰:uint = SlateGray
		/** * 道奇蓝 */
		public static const DodgerBlue:uint = 0x1E90FF, 道奇蓝:uint = DodgerBlue
		/** * 爱丽丝蓝 */
		public static const AliceBlue:uint = 0xF0F8FF, 爱丽丝蓝:uint = AliceBlue
		/** * 铁青 */
		public static const SteelBlue:uint = 0x4682B4, 铁青:uint = SteelBlue
		/** * 亮天蓝色 */
		public static const LightSkyBlue:uint = 0x87CEFA, 亮天蓝色:uint = LightSkyBlue
		/** * 天蓝色 */
		public static const SkyBlue:uint = 0x87CEEB, 天蓝色:uint = SkyBlue
		/** * 深天蓝 */
		public static const DeepSkyBlue:uint = 0x00BFFF, 深天蓝:uint = DeepSkyBlue
		/** * 亮蓝 */
		public static const LightBlue:uint = 0xADD8E6, 亮蓝:uint = LightBlue
		/** * 粉蓝色 */
		public static const PowderBlue:uint = 0xB0E0E6, 粉蓝色:uint = PowderBlue
		/** * 军兰色 */
		public static const CadetBlue:uint = 0x5F9EA0, 军兰色:uint = CadetBlue
		/** * 蔚蓝色 */
		public static const Azure:uint = 0xF0FFFF, 蔚蓝色:uint = Azure
		/** * 淡青色 */
		public static const LightCyan:uint = 0xE0FFFF, 淡青色:uint = LightCyan
		/** * 弱绿宝石 */
		public static const PaleTurquoise:uint = 0xAFEEEE, 弱绿宝石:uint = PaleTurquoise
		/** * 青色 */
		public static const Cyan:uint = 0x00FFFF, 青色:uint = Cyan
		/** * 水色 */
		public static const Aqua:uint = 0x00FFFF, 水色:uint = Aqua
		/** * 暗绿宝石 */
		public static const DarkTurquoise:uint = 0x00CED1, 暗绿宝石:uint = DarkTurquoise
		/** * 暗石板灰 */
		public static const DarkSlateGray:uint = 0x2F4F4F, 暗石板灰:uint = DarkSlateGray
		/** * 暗青色 */
		public static const DarkCyan:uint = 0x008B8B, 暗青色:uint = DarkCyan
		/** * 水鸭色 */
		public static const Teal:uint = 0x008080, 水鸭色:uint = Teal
		/** * 中绿宝石 */
		public static const MediumTurquoise:uint = 0x48D1CC, 中绿宝石:uint = MediumTurquoise
		/** * 浅海洋绿 */
		public static const LightSeaGreen:uint = 0x20B2AA, 浅海洋绿:uint = LightSeaGreen
		/** * 绿宝石 */
		public static const Turquoise:uint = 0x40E0D0, 绿宝石:uint = Turquoise
		/** * 宝石碧绿 */
		public static const Aquamarine:uint = 0x7FFFD4, 宝石碧绿:uint = Aquamarine
		/** * 中宝石碧绿 */
		public static const MediumAquamarine:uint = 0x66CDAA, 中宝石碧绿:uint = MediumAquamarine
		/** * 中春绿色 */
		public static const MediumSpringGreen:uint = 0x00FA9A, 中春绿色:uint = MediumSpringGreen
		/** * 薄荷奶油 */
		public static const MintCream:uint = 0xF5FFFA, 薄荷奶油:uint = MintCream
		/** * 春绿色 */
		public static const SpringGreen:uint = 0x00FF7F, 春绿色:uint = SpringGreen
		/** * 中海洋绿 */
		public static const MediumSeaGreen:uint = 0x3CB371, 中海洋绿:uint = MediumSeaGreen
		/** * 海洋绿 */
		public static const SeaGreen:uint = 0x2E8B57, 海洋绿:uint = SeaGreen
		/** * 蜜瓜色 */
		public static const Honeydew:uint = 0xF0FFF0, 蜜瓜色:uint = Honeydew
		/** * 淡绿色 */
		public static const LightGreen:uint = 0x90EE90, 淡绿色:uint = LightGreen
		/** * 弱绿色 */
		public static const PaleGreen:uint = 0x98FB98, 弱绿色:uint = PaleGreen
		/** * 暗海洋绿 */
		public static const DarkSeaGreen:uint = 0x8FBC8F, 暗海洋绿:uint = DarkSeaGreen
		/** * 深酸橙绿 */
		public static const LimeGreen:uint = 0x32CD32, 深酸橙绿:uint = LimeGreen
		/** * 酸橙绿 */
		public static const Lime:uint = 0x00FF00, 酸橙绿:uint = Lime
		/** * 森林绿 */
		public static const ForestGreen:uint = 0x228B22, 森林绿:uint = ForestGreen
		/** * 纯绿 */
		public static const Green:uint = 0x008000, 纯绿:uint = Green
		/** * 暗绿色 */
		public static const DarkGreen:uint = 0x006400, 暗绿色:uint = DarkGreen
		/** * 荨麻绿 */
		public static const Chartreuse:uint = 0x7FFF00, 荨麻绿:uint = Chartreuse
		/** * 草绿色 */
		public static const LawnGreen:uint = 0x7CFC00, 草绿色:uint = LawnGreen
		/** * 绿黄色 */
		public static const GreenYellow:uint = 0xADFF2F, 绿黄色:uint = GreenYellow
		/** * 暗橄榄绿 */
		public static const DarkOliveGreen:uint = 0x556B2F, 暗橄榄绿:uint = DarkOliveGreen
		/** * 黄绿色 */
		public static const YellowGreen:uint = 0x9ACD32, 黄绿色:uint = YellowGreen
		/** * 橄榄褐色 */
		public static const OliveDrab:uint = 0x6B8E23, 橄榄褐色:uint = OliveDrab
		/** * 米色 */
		public static const Beige:uint = 0xF5F5DC, 米色:uint = Beige
		/** * 亮菊黄 */
		public static const LightGoldenrodYellow:uint = 0xFAFAD2, 亮菊黄:uint = LightGoldenrodYellow
		/** * 象牙色 */
		public static const Ivory:uint = 0xFFFFF0, 象牙色:uint = Ivory
		/** * 浅黄色 */
		public static const LightYellow:uint = 0xFFFFE0, 浅黄色:uint = LightYellow
		/** * 纯黄 */
		public static const Yellow:uint = 0xFFFF00, 纯黄:uint = Yellow
		/** * 橄榄色 */
		public static const Olive:uint = 0x808000, 橄榄色:uint = Olive
		/** * 暗黄褐色 */
		public static const DarkKhaki:uint = 0xBDB76B, 暗黄褐色:uint = DarkKhaki
		/** * 柠檬绸 */
		public static const LemonChiffon:uint = 0xFFFACD, 柠檬绸:uint = LemonChiffon
		/** * 灰菊黄 */
		public static const PaleGoldenrod:uint = 0xEEE8AA, 灰菊黄:uint = PaleGoldenrod
		/** * 黄褐色 */
		public static const Khaki:uint = 0xF0E68C, 黄褐色:uint = Khaki
		/** * 金色 */
		public static const Gold:uint = 0xFFD700, 金色:uint = Gold
		/** * 玉米丝色 */
		public static const Cornsilk:uint = 0xFFF8DC, 玉米丝色:uint = Cornsilk
		/** * 金菊黄 */
		public static const Goldenrod:uint = 0xDAA520, 金菊黄:uint = Goldenrod
		/** * 暗金菊黄 */
		public static const DarkGoldenrod:uint = 0xB8860B, 暗金菊黄:uint = DarkGoldenrod
		/** * 花白色 */
		public static const FloralWhite:uint = 0xFFFAF0, 花白色:uint = FloralWhite
		/** * 旧蕾丝 */
		public static const OldLace:uint = 0xFDF5E6, 旧蕾丝:uint = OldLace
		/** * 小麦色 */
		public static const Wheat:uint = 0xF5DEB3, 小麦色:uint = Wheat
		/** * 鹿皮色 */
		public static const Moccasin:uint = 0xFFE4B5, 鹿皮色:uint = Moccasin
		/** * 橙色 */
		public static const Orange:uint = 0xFFA500, 橙色:uint = Orange
		/** * 番木色 */
		public static const PapayaWhip:uint = 0xFFEFD5, 番木色:uint = PapayaWhip
		/** * 白杏色 */
		public static const BlanchedAlmond:uint = 0xFFEBCD, 白杏色:uint = BlanchedAlmond
		/** * 土著白 */
		public static const NavajoWhite:uint = 0xFFDEAD, 土著白:uint = NavajoWhite
		/** * 古董白 */
		public static const AntiqueWhite:uint = 0xFAEBD7, 古董白:uint = AntiqueWhite
		/** * 茶色 */
		public static const Tan:uint = 0xD2B48C, 茶色:uint = Tan
		/** * 硬木色 */
		public static const BurlyWood:uint = 0xDEB887, 硬木色:uint = BurlyWood
		/** * 陶坯黄 */
		public static const Bisque:uint = 0xFFE4C4, 陶坯黄:uint = Bisque
		/** * 深橙色 */
		public static const DarkOrange:uint = 0xFF8C00, 深橙色:uint = DarkOrange
		/** * 亚麻布 */
		public static const Linen:uint = 0xFAF0E6, 亚麻布:uint = Linen
		/** * 秘鲁色 */
		public static const Peru:uint = 0xCD853F, 秘鲁色:uint = Peru
		/** * 桃肉色 */
		public static const PeachPuff:uint = 0xFFDAB9, 桃肉色:uint = PeachPuff
		/** * 沙棕色 */
		public static const SandyBrown:uint = 0xF4A460, 沙棕色:uint = SandyBrown
		/** * 巧克力色 */
		public static const Chocolate:uint = 0xD2691E, 巧克力色:uint = Chocolate
		/** * 马鞍棕色 */
		public static const SaddleBrown:uint = 0x8B4513, 马鞍棕色:uint = SaddleBrown
		/** * 海贝壳 */
		public static const Seashell:uint = 0xFFF5EE, 海贝壳:uint = Seashell
		/** * 黄土赭色 */
		public static const Sienna:uint = 0xA0522D, 黄土赭色:uint = Sienna
		/** * 浅鲑鱼色 */
		public static const LightSalmon:uint = 0xFFA07A, 浅鲑鱼色:uint = LightSalmon
		/** * 珊瑚 */
		public static const Coral:uint = 0xFF7F50, 珊瑚:uint = Coral
		/** * 橙红色 */
		public static const OrangeRed:uint = 0xFF4500, 橙红色:uint = OrangeRed
		/** * 深鲑鱼色 */
		public static const DarkSalmon:uint = 0xE9967A, 深鲑鱼色:uint = DarkSalmon
		/** * 番茄红 */
		public static const Tomato:uint = 0xFF6347, 番茄红:uint = Tomato
		/** * 浅玫瑰色 */
		public static const MistyRose:uint = 0xFFE4E1, 浅玫瑰色:uint = MistyRose
		/** * 鲑鱼色 */
		public static const Salmon:uint = 0xFA8072, 鲑鱼色:uint = Salmon
		/** * 雪白色 */
		public static const Snow:uint = 0xFFFAFA, 雪白色:uint = Snow
		/** * 淡珊瑚色 */
		public static const LightCoral:uint = 0xF08080, 淡珊瑚色:uint = LightCoral
		/** * 玫瑰棕色 */
		public static const RosyBrown:uint = 0xBC8F8F, 玫瑰棕色:uint = RosyBrown
		/** * 印度红 */
		public static const IndianRed:uint = 0xCD5C5C, 印度红:uint = IndianRed
		/** * 纯红 */
		public static const Red:uint = 0xFF0000, 纯红:uint = Red
		/** * 棕色 */
		public static const Brown:uint = 0xA52A2A, 棕色:uint = Brown
		/** * 火砖色 */
		public static const FireBrick:uint = 0xB22222, 火砖色:uint = FireBrick
		/** * 深红色 */
		public static const DarkRed:uint = 0x8B0000, 深红色:uint = DarkRed
		/** * 栗色 */
		public static const Maroon:uint = 0x800000, 栗色:uint = Maroon
		/** * 纯白 */
		public static const White:uint = 0xFFFFFF, 纯白:uint = White
		/** * 白烟 */
		public static const WhiteSmoke:uint = 0xF5F5F5, 白烟:uint = WhiteSmoke
		/** * 淡灰色 */
		public static const Gainsboro:uint = 0xDCDCDC, 淡灰色:uint = Gainsboro
		/** * 浅灰色 */
		public static const LightGrey:uint = 0xD3D3D3, 浅灰色:uint = LightGrey
		/** * 银灰色 */
		public static const Silver:uint = 0xC0C0C0, 银灰色:uint = Silver
		/** * 深灰色 */
		public static const DarkGray:uint = 0xA9A9A9, 深灰色:uint = DarkGray
		/** * 灰色 */
		public static const Gray:uint = 0x808080, 灰色:uint = Gray
		/** * 暗淡灰 */
		public static const DimGray:uint = 0x696969, 暗淡灰:uint = DimGray
		/** * 纯黑 */
		public static const Black:uint = 0x000000, 纯黑:uint = Black
		
		public static function getColorListView():Sprite
		{
			var spr:Sprite = new Sprite();
			var arr:Array = [];
			
			const width:int = 80;
			const height:int = 30;
			const row:int = 20;
			
			var xmlList:XMLList = describeType(Color).constant;
			
			for (var i:int = 0; i < xmlList.length(); i++)
			{
				arr.push({name: xmlList[i].@name.toString(), color: Color[xmlList[i].@name], red: Color[xmlList[i].@name] >> 16, green: Color[xmlList[i].@name] >> 8 & 0xff, blue: Color[xmlList[i].@name] & 0xFF});
			}
			
			arr.sort(sortFun);
			
			for (i = 0; i < arr.length; i++)
			{
				//trace(xmlList[i].@name.toString());
				var name:String = arr[i].name;
				spr.graphics.beginFill(Color[name]);
				spr.graphics.drawRect((i % row) * width, 50 * int(i / row), width, height);
				var tf:TextField = new TextField();
				tf.text = name;
				tf.width = width;
				spr.addChild(tf)
				tf.x = (i % row) * width;
				tf.y = 50 * int(i / row) + height;
			}
			
			function sortFun(a:*, b:*):Number
			{
				//选出标准色
				//a = Math.pow(a.red-127,2)+Math.pow(a.blue-127,2)+Math.pow(a.green-127,2)
				//b = Math.pow(b.red-127,2)+Math.pow(b.blue-127,2)+Math.pow(b.green-127,2)
				//return a>b?-1:1;
				
				//高反差排序
				//a = Math.pow(a.red-a.blue,2)+Math.pow(a.blue-a.green,2)+Math.pow(a.green-a.red,2)
				//b = Math.pow(b.red-b.blue,2)+Math.pow(b.blue-b.green,2)+Math.pow(b.green-b.red,2)
				//
				//return a>b?-1:1;
				
				//纯值排序
				if (a.color == b.color)
				{
					return a.name < b.name ? -1 : 1;
				}
				return a.color > b.color ? -1 : 1;
			
			}
			
			return spr;
			
			function isRed(color:*):Boolean
			{
				return getRed(color) > getGreen(color) && getRed(color) > getBlue(color);
			}
			
			function isGreen(color:*):Boolean
			{
				return getGreen(color) > getBlue(color) && getGreen(color) > getRed(color);
			}
			
			function isBlue(color:*):Boolean
			{
				return getBlue(color) > getRed(color) && getBlue(color) > getGreen(color);
			}
		
		}
		
		/** Returns the alpha part of an ARGB color (0 - 255). */
		public static function getAlpha(color:uint):int
		{
			return (color >> 24) & 0xff;
		}
		
		/** Returns the red part of an (A)RGB color (0 - 255). */
		public static function getRed(color:uint):int
		{
			return (color >> 16) & 0xff;
		}
		
		/** Returns the green part of an (A)RGB color (0 - 255). */
		public static function getGreen(color:uint):int
		{
			return (color >> 8) & 0xff;
		}
		
		/** Returns the blue part of an (A)RGB color (0 - 255). */
		public static function getBlue(color:uint):int
		{
			return color & 0xff;
		}
		
		/** Creates an RGB color, stored in an unsigned integer. Channels are expected
		 *  in the range 0 - 255. */
		public static function rgb(red:int, green:int, blue:int):uint
		{
			return (red << 16) | (green << 8) | blue;
		}
		
		/** Creates an ARGB color, stored in an unsigned integer. Channels are expected
		 *  in the range 0 - 255. */
		public static function argb(alpha:int, red:int, green:int, blue:int):uint
		{
			return (alpha << 24) | (red << 16) | (green << 8) | blue;
		}
		
		public static function isSimilar(color1:uint, color2:uint, difference:int):Boolean
		{
			if (Math.abs(Color.getRed(color1) - Color.getRed(color2)) < difference)
				if (Math.abs(Color.getBlue(color1) - Color.getBlue(color2)) < difference)
					if (Math.abs(Color.getGreen(color1) - Color.getGreen(color2)) < difference)
						return true;
			return false;
		}
		
		public static function deviations(color1:uint, color2:uint):Number
		{
			var rd:Number = Math.pow(Color.getRed(color1) - Color.getRed(color2), 2);
			var gd:Number = Math.pow(Color.getGreen(color1) - Color.getGreen(color2), 2);
			var bd:Number = Math.pow(Color.getBlue(color1) - Color.getBlue(color2), 2);
			
			return Math.sqrt((rd+gd+bd)/3);
		}
	
	}

}