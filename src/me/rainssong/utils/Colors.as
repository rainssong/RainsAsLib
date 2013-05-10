package me.rainssong.utils
{
	
	import fl.motion.Color;
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.utils.describeType;
	
	/**
	 *
	 * @author Rainssong
	 * 2013-5-9
	 */
	public class Colors
	{
		/** * 黑色 */
		public static const BLACK:uint = 0x000000
		/** * 昏灰 */
		public static const DIMGRAY:uint = 0x696969
		/** * 灰色 */
		public static const GRAY:uint = 0x808080
		/** * 暗灰 */
		public static const DARK_GRAY:uint = 0xA9A9A9
		/** * 銀色 */
		public static const SILVER:uint = 0xC0C0C0
		/** * 亮灰色 */
		public static const LIGHT_GRAY:uint = 0xD3D3D3
		/** * 庚斯博羅灰 */
		public static const GAINSBORO:uint = 0xDCDCDC
		/** * 白煙色 */
		public static const WHITE_SMOKE:uint = 0xF5F5F5
		/** * 白色 */
		public static const WHITE:uint = 0xFFFFFF
		/** * 雪色 */
		public static const SNOW:uint = 0xFFFAFA
		/** * 沙棕 */
		public static const SAND_BEIGE:uint = 0xE6C3C3
		/** * 玫瑰褐 */
		public static const ROSY_BROWN:uint = 0xBC8F8F
		/** * 亮珊瑚色 */
		public static const LIGHT_CORAL:uint = 0xF08080
		/** * 印度紅 */
		public static const INDIAN_RED:uint = 0xCD5C5C
		/** * 褐色 */
		public static const BROWN:uint = 0xA52A2A
		/** * 耐火磚紅 */
		public static const FIRE_BRICK:uint = 0xB22222
		/** * 栗色 */
		public static const MAROON:uint = 0x800000
		/** * 暗紅 */
		public static const DARK_RED:uint = 0x8B0000
		/** * 鮮紅 */
		public static const STRONG_RED:uint = 0xE60000
		/** * 紅色 */
		public static const RED:uint = 0xFF0000
		/** * 柿子橙 */
		public static const PERSIMMON:uint = 0xFF4D40
		/** * 霧玫瑰色 */
		public static const MISTY_ROSE:uint = 0xFFE4E1
		/** * 鮭紅 */
		public static const SALMON:uint = 0xFA8072
		/** * 腥紅 */
		public static const SCARLET:uint = 0xFF2400
		/** * 番茄紅 */
		public static const TOMATO:uint = 0xFF6347
		/** * 暗鮭紅 */
		public static const DARK_SALMON:uint = 0xE9967A
		/** * 珊瑚紅 */
		public static const CORAL:uint = 0xFF7F50
		/** * 橙紅 */
		public static const ORANGE_RED:uint = 0xFF4500
		/** * 亮鮭紅 */
		public static const LIGHT_SALMON:uint = 0xFFA07A
		/** * 朱紅 */
		public static const VERMILION:uint = 0xFF4D00
		/** * 黃土赭 */
		public static const SIENNA:uint = 0xA0522D
		/** * 熱帶橙 */
		public static const TROPICAL_ORANGE:uint = 0xFF8033
		/** * 駝色 */
		public static const CAMEL:uint = 0xA16B47
		/** * 杏黃 */
		public static const APRICOT:uint = 0xE69966
		/** * 椰褐 */
		public static const COCONUT_BROWN:uint = 0x4D1F00
		/** * 海貝色 */
		public static const SEASHELL:uint = 0xFFF5EE
		/** * 鞍褐 */
		public static const SADDLE_BROWN:uint = 0x8B4513
		/** * 巧克力色 */
		public static const CHOCOLATE:uint = 0xD2691E
		/** * 燃橙 */
		public static const BURNT_ORANGE:uint = 0xCC5500
		/** * 陽橙 */
		public static const SUN_ORANGE:uint = 0xFF7300
		/** * 粉撲桃色 */
		public static const PEACH_PUFF:uint = 0xFFDAB9
		/** * 沙褐 */
		public static const SAND_BROWN:uint = 0xF4A460
		/** * 古銅色 */
		public static const BRONZE:uint = 0xB87333
		/** * 亞麻色 */
		public static const LINEN:uint = 0xFAF0E6
		/** * 蜜橙 */
		public static const HONEY_ORANGE:uint = 0xFFB366
		/** * 秘魯色 */
		public static const PERU:uint = 0xCD853F
		/** * 烏賊墨色 */
		public static const SEPIA:uint = 0x704214
		/** * 赭色 */
		public static const OCHER:uint = 0xCC7722
		/** * 陶坯黃 */
		public static const BISQUE:uint = 0xFFE4C4
		/** * 橘色 */
		public static const TANGERINE:uint = 0xF28500
		/** * 暗橙 */
		public static const DARK_ORANGE:uint = 0xFF8C00
		/** * 古董白 */
		public static const ANTIQUE_WHITE:uint = 0xFAEBD7
		/** * 日曬色 */
		public static const TAN:uint = 0xD2B48C
		/** * 硬木色 */
		public static const BURLY_WOOD:uint = 0xDEB887
		/** * 杏仁白 */
		public static const BLANCHED_ALMOND:uint = 0xFFEBCD
		/** * 那瓦霍白 */
		public static const NAVAJO_WHITE:uint = 0xFFDEAD
		/** * 萬壽菊黃 */
		public static const MARIGOLD:uint = 0xFF9900
		/** * 番木瓜色 */
		public static const PAPAYA_WHIP:uint = 0xFFEFD5
		/** * 灰土色 */
		public static const PALE_OCRE:uint = 0xCCB38C
		/** * 卡其色 */
		public static const KHAKI:uint = 0x996B1F
		/** * 鹿皮鞋色 */
		public static const MOCCASIN:uint = 0xFFE4B5
		/** * 舊蕾絲色 */
		public static const OLD_LACE:uint = 0xFDF5E6
		/** * 小麥色 */
		public static const WHEAT:uint = 0xF5DEB3
		/** * 桃色 */
		public static const PEACH:uint = 0xFFE5B4
		/** * 橙色 */
		public static const ORANGE:uint = 0xFFA500
		/** * 花卉白 */
		public static const FLORAL_WHITE:uint = 0xFFFAF0
		/** * 金菊色 */
		public static const GOLDENROD:uint = 0xDAA520
		/** * 暗金菊色 */
		public static const DARK_GOLDENROD:uint = 0xB8860B
		/** * 咖啡色 */
		public static const COFFEE:uint = 0x4D3900
		/** * 茉莉黃 */
		public static const JASMINE:uint = 0xE6C35C
		/** * 琥珀色 */
		public static const AMBER:uint = 0xFFBF00
		/** * 玉米絲色 */
		public static const CORNSILK:uint = 0xFFF8DC
		/** * 鉻黃 */
		public static const CHROME_YELLOW:uint = 0xE6B800
		/** * 金色 */
		public static const GOLDEN:uint = 0xFFD700
		/** * 檸檬綢色 */
		public static const LEMON_CHIFFON:uint = 0xFFFACD
		/** * 亮卡其色 */
		public static const LIGHT_KHAKI:uint = 0xF0E68C
		/** * 灰金菊色 */
		public static const PALE_GOLDENROD:uint = 0xEEE8AA
		/** * 暗卡其色 */
		public static const DARK_KHAKI:uint = 0xBDB76B
		/** * 含羞草黃 */
		public static const MIMOSA:uint = 0xE6D933
		/** * 奶油色 */
		public static const CREAM:uint = 0xFFFDD0
		/** * 象牙色 */
		public static const IVORY:uint = 0xFFFFF0
		/** * 棕色 */
		public static const BEIGE:uint = 0xF5F5DC
		/** * 亮黃 */
		public static const LIGHT_YELLOW:uint = 0xFFFFE0
		/** * 亮金菊黃 */
		public static const LIGHT_GOLDENROD_YELLOW:uint = 0xFAFAD2
		/** * 香檳黃 */
		public static const CHAMPAGNE_YELLOW:uint = 0xFFFF99
		/** * 芥末黃 */
		public static const MUSTARD:uint = 0xCCCC4D
		/** * 月黃 */
		public static const MOON_YELLOW:uint = 0xFFFF4D
		/** * 橄欖色 */
		public static const OLIVE:uint = 0x808000
		/** * 鮮黃 */
		public static const CANARY_YELLOW:uint = 0xFFFF00
		/** * 黃色 */
		public static const YELLOW:uint = 0xFFFF00
		/** * 苔蘚綠 */
		public static const MOSS_GREEN:uint = 0x697723
		/** * 亮柠檬绿 */
		public static const LIGHT_LIME:uint = 0xCCFF00
		/** * 橄欖軍服綠 */
		public static const OLIVE_DRAB:uint = 0x6B8E23
		/** * 黃綠 */
		public static const YELLOW_GREEN:uint = 0x9ACD32
		/** * 暗橄欖綠 */
		public static const DARK_OLIVE_GREEN:uint = 0x556B2F
		/** * 蘋果綠 */
		public static const APPLE_GREEN:uint = 0x8CE600
		/** * 綠黃 */
		public static const GREEN_YELLOW:uint = 0xADFF2F
		/** * 草綠 */
		public static const GRASS_GREEN:uint = 0x99E64D
		/** * 草坪綠 */
		public static const LAWN_GREEN:uint = 0x7CFC00
		/** * 查特酒綠 */
		public static const CHARTREUSE:uint = 0x7FFF00
		/** * 葉綠 */
		public static const FOLIAGE_GREEN:uint = 0x73B839
		/** * 嫩綠 */
		public static const FRESH_LEAVES:uint = 0x99FF4D
		/** * 明綠 */
		public static const BRIGHT_GREEN:uint = 0x66FF00
		/** * 鈷綠 */
		public static const COBALT_GREEN:uint = 0x66FF59
		/** * 蜜瓜綠 */
		public static const HONEYDEW:uint = 0xF0FFF0
		/** * 暗海綠 */
		public static const DARK_SEA_GREEN:uint = 0x8FBC8F
		/** * 亮綠 */
		public static const LIGHT_GREEN:uint = 0x90EE90
		/** * 灰綠 */
		public static const PALE_GREEN:uint = 0x98FB98
		/** * 常春藤綠 */
		public static const IVY_GREEN:uint = 0x36BF36
		/** * 森林綠 */
		public static const FOREST_GREEN:uint = 0x228B22
		/** * 柠檬綠 */
		public static const LIME_GREEN:uint = 0x32CD32
		/** * 暗綠 */
		public static const DARK_GREEN:uint = 0x006400
		/** * 綠色 */
		public static const GREEN:uint = 0x008000
		/** * 柠檬绿 */
		public static const LIME:uint = 0x00FF00
		/** * 孔雀石綠 */
		public static const MALACHITE:uint = 0x22C32E
		/** * 薄荷綠 */
		public static const MINT:uint = 0x16982B
		/** * 青瓷綠 */
		public static const CELADON_GREEN:uint = 0x73E68C
		/** * 碧綠 */
		public static const EMERALD:uint = 0x50C878
		/** * 綠松石綠 */
		public static const TURQUOISE_GREEN:uint = 0x4DE680
		/** * 鉻綠 */
		public static const VERIDIAN:uint = 0x127436
		/** * 蒼色 */
		public static const HORIZON_BLUE:uint = 0xA6FFCC
		/** * 海綠 */
		public static const SEA_GREEN:uint = 0x2E8B57
		/** * 中海綠 */
		public static const MEDIUM_SEA_GREEN:uint = 0x3CB371
		/** * 薄荷奶油色 */
		public static const MINT_CREAM:uint = 0xF5FFFA
		/** * 春綠 */
		public static const SPRING_GREEN:uint = 0x00FF80
		/** * 孔雀綠 */
		public static const PEACOCK_GREEN:uint = 0x00A15C
		/** * 中春綠色 */
		public static const MEDIUM_SPRING_GREEN:uint = 0x00FA9A
		/** * 中碧藍色 */
		public static const MEDIUM_AQUAMARINE:uint = 0x66CDAA
		/** * 碧藍色 */
		public static const AQUAMARINE:uint = 0x7FFFD4
		/** * 青藍 */
		public static const CYAN_BLUE:uint = 0x0DBF8C
		/** * 水藍 */
		public static const AQUA_BLUE:uint = 0x66FFE6
		/** * 綠松石藍 */
		public static const TURQUOISE_BLUE:uint = 0x33E6CC
		/** * 綠松石色 */
		public static const TURQUOISE:uint = 0x30D5C8
		/** * 亮海綠 */
		public static const LIGHT_SEA_GREEN:uint = 0x20B2AA
		/** * 中綠松石色 */
		public static const MEDIUM_TURQUOISE:uint = 0x48D1CC
		/** * 亮青 */
		public static const LIGHT_CYAN:uint = 0xE0FFFF
		/** * 淺藍 */
		public static const BABY_BLUE:uint = 0xE0FFFF
		/** * 灰綠松石色 */
		public static const PALE_TURQUOISE:uint = 0xAFEEEE
		/** * 暗岩灰 */
		public static const DARK_SLATE_GRAY:uint = 0x2F4F4F
		/** * 鳧綠 */
		public static const TEAL:uint = 0x008080
		/** * 暗青 */
		public static const DARK_CYAN:uint = 0x008B8B
		/** * 青色 */
		public static const CYAN:uint = 0x00FFFF
		/** * 水色 */
		public static const AQUA:uint = 0x00FFFF
		/** * 暗綠松石色 */
		public static const DARK_TURQUOISE:uint = 0x00CED1
		/** * 軍服藍 */
		public static const CADET_BLUE:uint = 0x5F9EA0
		/** * 孔雀藍 */
		public static const PEACOCK_BLUE:uint = 0x00808C
		/** * 嬰兒粉藍 */
		public static const POWDER_BLUE:uint = 0xB0E0E6
		/** * 濃藍 */
		public static const STRONG_BLUE:uint = 0x006374
		/** * 亮藍 */
		public static const LIGHT_BLUE:uint = 0xADD8E6
		/** * 灰藍 */
		public static const PALE_BLUE:uint = 0x7AB8CC
		/** * 薩克斯藍 */
		public static const SAXE_BLUE:uint = 0x4798B3
		/** * 深天藍 */
		public static const DEEP_SKY_BLUE:uint = 0x00BFFF
		/** * 天藍 */
		public static const SKY_BLUE:uint = 0x87CEEB
		/** * 亮天藍 */
		public static const LIGHT_SKY_BLUE:uint = 0x87CEFA
		/** * 水手藍 */
		public static const MARINE_BLUE:uint = 0x00477D
		/** * 鋼青色 */
		public static const STEEL_BLUE:uint = 0x4682B4
		/** * 愛麗絲藍 */
		public static const ALICE_BLUE:uint = 0xF0F8FF
		/** * 岩灰 */
		public static const SLATE_GRAY:uint = 0x708090
		/** * 亮岩灰 */
		public static const LIGHT_SLATE_GRAY:uint = 0x778899
		/** * 道奇藍 */
		public static const DODGER_BLUE:uint = 0x1E90FF
		/** * 礦藍 */
		public static const MINERAL_BLUE:uint = 0x004D99
		/** * 湛藍 */
		public static const AZURE:uint = 0x007FFF
		/** * 韋奇伍德瓷藍 */
		public static const WEDGWOOD_BLUE:uint = 0x5686BF
		/** * 亮鋼藍 */
		public static const LIGHT_STEEL_BLUE:uint = 0xB0C4DE
		/** * 鈷藍 */
		public static const COBALT_BLUE:uint = 0x0047AB
		/** * 灰丁寧藍 */
		public static const PALE_DENIM:uint = 0x5E86C1
		/** * 矢車菊藍 */
		public static const CORNFLOWER_BLUE:uint = 0x6495ED
		/** * 鼠尾草藍 */
		public static const SALVIA_BLUE:uint = 0x4D80E6
		/** * 暗嬰兒粉藍 */
		public static const DARK_POWDER_BLUE:uint = 0x003399
		/** * 藍寶石色 */
		public static const SAPPHIRE:uint = 0x082567
		/** * 國際奇連藍 */
		public static const INTERNATIONAL_KLEIN_BLUE:uint = 0x002FA7
		/** * 蔚藍 */
		public static const CERULEAN_BLUE:uint = 0x2A52BE
		/** * 品藍 */
		public static const ROYAL_BLUE:uint = 0x4169E1
		/** * 暗礦藍 */
		public static const DARK_MINERAL_BLUE:uint = 0x24367D
		/** * 極濃海藍 */
		public static const ULTRAMARINE:uint = 0x0033FF
		/** * 天青石藍 */
		public static const LAPIS_LAZULI:uint = 0x0D33FF
		/** * 幽靈白 */
		public static const GHOST_WHITE:uint = 0xF8F8FF
		/** * 薰衣草紫 */
		public static const LAVENDER:uint = 0xE6E6FA
		/** * 長春花色 */
		public static const PERIWINKLE:uint = 0xCCCCFF
		/** * 午夜藍 */
		public static const MIDNIGHT_BLUE:uint = 0x191970
		/** * 藏青 */
		public static const NAVY_BLUE:uint = 0x000080
		/** * 暗藍 */
		public static const DARK_BLUE:uint = 0x00008B
		/** * 中藍 */
		public static const MEDIUM_BLUE:uint = 0x0000CD
		/** * 藍色 */
		public static const BLUE:uint = 0x0000FF
		/** * 紫藤色 */
		public static const WISTERIA:uint = 0x5C50E6
		/** * 暗岩藍 */
		public static const DARK_SLATE_BLUE:uint = 0x483D8B
		/** * 岩藍 */
		public static const SLATE_BLUE:uint = 0x6A5ACD
		/** * 中岩藍 */
		public static const MEDIUM_SLATE_BLUE:uint = 0x7B68EE
		/** * 木槿紫 */
		public static const MAUVE:uint = 0x6640FF
		/** * 紫丁香色 */
		public static const LILAC:uint = 0xB399FF
		/** * 中紫紅 */
		public static const MEDIUM_PURPLE:uint = 0x9370DB
		/** * 紫水晶色 */
		public static const AMETHYST:uint = 0x6633CC
		/** * 淺灰紫紅 */
		public static const GRAYISH_PURPLE:uint = 0x8674A1
		/** * 纈草紫 */
		public static const HELIOTROPE:uint = 0x5000B8
		/** * 礦紫 */
		public static const MINERAL_VIOLET:uint = 0xB8A1CF
		/** * 藍紫 */
		public static const BLUE_VIOLET:uint = 0x8A2BE2
		/** * 紫藍色 */
		public static const VIOLET:uint = 0x8B00FF
		/** * 靛色 */
		public static const INDIGO:uint = 0x4B0080
		/** * 暗蘭紫 */
		public static const DARK_ORCHID:uint = 0x9932CC
		/** * 暗紫 */
		public static const DARK_VIOLET:uint = 0x9400D3
		/** * 三色堇紫 */
		public static const PANSY:uint = 0x7400A1
		/** * 錦葵紫 */
		public static const MALLOW:uint = 0xD94DFF
		/** * 優品紫紅 */
		public static const OPERA_MAUVE:uint = 0xE680FF
		/** * 中蘭紫 */
		public static const MEDIUM_ORCHID:uint = 0xBA55D3
		/** * 淡紫丁香色 */
		public static const PAIL_LILAC:uint = 0xE6CFE6
		/** * 薊紫 */
		public static const THISTLE:uint = 0xD8BFD8
		/** * 鐵線蓮紫 */
		public static const CLEMATIS:uint = 0xCCA3CC
		/** * 李紫 */
		public static const PLUM:uint = 0xDDA0DD
		/** * 亮紫 */
		public static const LIGHT_VIOLET:uint = 0xEE82EE
		/** * 紫色 */
		public static const PURPLE:uint = 0x800080
		/** * 暗洋紅 */
		public static const DARK_MAGENTA:uint = 0x8B008B
		/** * 洋紅 */
		public static const MAGENTA:uint = 0xFF00FF
		/** * 品紅 */
		public static const FUCHSIA:uint = 0xF400A1
		/** * 蘭紫 */
		public static const ORCHID:uint = 0xDA70D6
		/** * 淺珍珠紅 */
		public static const PEARL_PINK:uint = 0xFFB3E6
		/** * 陳玫紅 */
		public static const OLD_ROSE:uint = 0xB85798
		/** * 淺玫瑰紅 */
		public static const ROSE_PINK:uint = 0xFF66CC
		/** * 中青紫紅 */
		public static const MEDIUM_VIOLET_RED:uint = 0xC71585
		/** * 玫瑰紅 */
		public static const ROSE_RED:uint = 0xFF0DA6
		/** * 紅寶石色 */
		public static const RUBY:uint = 0xCC0080
		/** * 山茶紅 */
		public static const CAMELLIA:uint = 0xE63995
		/** * 深粉紅 */
		public static const DEEP_PINK:uint = 0xFF1493
		/** * 火鶴紅 */
		public static const FLAMINGO:uint = 0xE68AB8
		/** * 淺珊瑚紅 */
		public static const CORAL_PINK:uint = 0xFF80BF
		/** * 暖粉紅 */
		public static const HOT_PINK:uint = 0xFF69B4
		/** * 勃艮第酒紅 */
		public static const BURGUNDY:uint = 0x470024
		/** * 尖晶石紅 */
		public static const SPINEL_RED:uint = 0xFF73B3
		/** * 胭脂紅 */
		public static const CARMINE:uint = 0xE6005C
		/** * 淺粉紅 */
		public static const BABY_PINK:uint = 0xFFD9E6
		/** * 樞機紅 */
		public static const CARDINAL_RED:uint = 0x990036
		/** * 薰衣草紫紅 */
		public static const LAVENDER_BLUSH:uint = 0xFFF0F5
		/** * 灰紫紅 */
		public static const PALE_VIOLET_RED:uint = 0xDB7093
		/** * 櫻桃紅 */
		public static const CERISE:uint = 0xDE3163
		/** * 淺鮭紅 */
		public static const SALMON_PINK:uint = 0xFF8099
		/** * 緋紅 */
		public static const CRIMSON:uint = 0xDC143C
		/** * 粉紅 */
		public static const PINK:uint = 0xFFC0CB
		/** * 亮粉紅 */
		public static const LIGHT_PINK:uint = 0xFFB6C1
		/** * 殼黃紅 */
		public static const SHELL_PINK:uint = 0xFFB3BF
		/** * 茜紅 */
		public static const ALIZARIN_CRIMSON:uint = 0xE32636
		
		public static function getColorListView():Sprite
		{
			var spr:Sprite = new Sprite();
			var arr:Array = [];
			
			const width:int = 100;
			const height:int = 30;
			const row:int = 15;
			
			var xmlList:XMLList = describeType(Colors).constant;
			
			for (var i:int = 0; i < xmlList.length(); i++)
			{
				arr.push({name: xmlList[i].@name.toString(), color: Colors[xmlList[i].@name], red: Colors[xmlList[i].@name] >> 16, green: Colors[xmlList[i].@name] >> 8 & 0xff, blue: Colors[xmlList[i].@name] & 0xFF});
			}
			
			arr.sort(sortFun);
			
			for (i = 0; i < arr.length; i++)
			{
				//trace(xmlList[i].@name.toString());
				var name:String = arr[i].name;
				spr.graphics.beginFill(Colors[name]);
				spr.graphics.drawRect((i % row) * width, 50 * int(i / row), width, height);
				var tf:TextField = new TextField();
				tf.text = name;
				spr.addChild(tf)
				tf.x = (i % row) * width;
				tf.y = 50 * int(i / row) + height;
			}
			
			function sortFun(a:*, b:*):Number
			{
				//选出标准色
				//a = Math.pow(a.red-128,2)+Math.pow(a.blue-128,2)+Math.pow(a.green-128,2)
				//b = Math.pow(b.red-128,2)+Math.pow(b.blue-128,2)+Math.pow(b.green-128,2)
				//return a>b?-1:1;
				
				//高反差排序
				//a = Math.pow(a.red-a.blue,2)+Math.pow(a.blue-a.green,2)+Math.pow(a.green-a.red,2)
				//b = Math.pow(b.red-b.blue,2)+Math.pow(b.blue-b.green,2)+Math.pow(b.green-b.red,2)
				//
				//return a>b?-1:1;
				
				//纯值排序
				return a.color > b.color ? -1 : 1;
			}
			
			return spr;
		}
	
	}

}