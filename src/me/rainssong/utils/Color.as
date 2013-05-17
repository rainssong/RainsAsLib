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
	public class Color
	{
		/** * 黑色 */
		public static const BLACK:uint = 0x000000, 黑色:uint = BLACK
		/** * 昏灰 */
		public static const DIMGRAY:uint = 0x696969, 昏灰:uint = DIMGRAY
		/** * 灰色 */
		public static const GRAY:uint = 0x808080, 灰色:uint = GRAY
		/** * 暗灰 */
		public static const DARK_GRAY:uint = 0xA9A9A9, 暗灰:uint = DARK_GRAY
		/** * 銀色 */
		public static const SILVER:uint = 0xC0C0C0, 銀色:uint = SILVER
		/** * 亮灰色 */
		public static const LIGHT_GRAY:uint = 0xD3D3D3, 亮灰色:uint = LIGHT_GRAY
		/** * 庚斯博羅灰 */
		public static const GAINSBORO:uint = 0xDCDCDC, 庚斯博羅灰:uint = GAINSBORO
		/** * 白煙色 */
		public static const WHITE_SMOKE:uint = 0xF5F5F5, 白煙色:uint = WHITE_SMOKE
		/** * 白色 */
		public static const WHITE:uint = 0xFFFFFF, 白色:uint = WHITE
		/** * 雪色 */
		public static const SNOW:uint = 0xFFFAFA, 雪色:uint = SNOW
		/** * 沙棕 */
		public static const SAND_BEIGE:uint = 0xE6C3C3, 沙棕:uint = SAND_BEIGE
		/** * 玫瑰褐 */
		public static const ROSY_BROWN:uint = 0xBC8F8F, 玫瑰褐:uint = ROSY_BROWN
		/** * 亮珊瑚色 */
		public static const LIGHT_CORAL:uint = 0xF08080, 亮珊瑚色:uint = LIGHT_CORAL
		/** * 印度紅 */
		public static const INDIAN_RED:uint = 0xCD5C5C, 印度紅:uint = INDIAN_RED
		/** * 褐色 */
		public static const BROWN:uint = 0xA52A2A, 褐色:uint = BROWN
		/** * 耐火磚紅 */
		public static const FIRE_BRICK:uint = 0xB22222, 耐火磚紅:uint = FIRE_BRICK
		/** * 栗色 */
		public static const MAROON:uint = 0x800000, 栗色:uint = MAROON
		/** * 暗紅 */
		public static const DARK_RED:uint = 0x8B0000, 暗紅:uint = DARK_RED
		/** * 鮮紅 */
		public static const STRONG_RED:uint = 0xE60000, 鮮紅:uint = STRONG_RED
		/** * 紅色 */
		public static const RED:uint = 0xFF0000, 紅色:uint = RED
		/** * 柿子橙 */
		public static const PERSIMMON:uint = 0xFF4D40, 柿子橙:uint = PERSIMMON
		/** * 霧玫瑰色 */
		public static const MISTY_ROSE:uint = 0xFFE4E1, 霧玫瑰色:uint = MISTY_ROSE
		/** * 鮭紅 */
		public static const SALMON:uint = 0xFA8072, 鮭紅:uint = SALMON
		/** * 腥紅 */
		public static const SCARLET:uint = 0xFF2400, 腥紅:uint = SCARLET
		/** * 番茄紅 */
		public static const TOMATO:uint = 0xFF6347, 番茄紅:uint = TOMATO
		/** * 暗鮭紅 */
		public static const DARK_SALMON:uint = 0xE9967A, 暗鮭紅:uint = DARK_SALMON
		/** * 珊瑚紅 */
		public static const CORAL:uint = 0xFF7F50, 珊瑚紅:uint = CORAL
		/** * 橙紅 */
		public static const ORANGE_RED:uint = 0xFF4500, 橙紅:uint = ORANGE_RED
		/** * 亮鮭紅 */
		public static const LIGHT_SALMON:uint = 0xFFA07A, 亮鮭紅:uint = LIGHT_SALMON
		/** * 朱紅 */
		public static const VERMILION:uint = 0xFF4D00, 朱紅:uint = VERMILION
		/** * 黃土赭 */
		public static const SIENNA:uint = 0xA0522D, 黃土赭:uint = SIENNA
		/** * 熱帶橙 */
		public static const TROPICAL_ORANGE:uint = 0xFF8033, 熱帶橙:uint = TROPICAL_ORANGE
		/** * 駝色 */
		public static const CAMEL:uint = 0xA16B47, 駝色:uint = CAMEL
		/** * 杏黃 */
		public static const APRICOT:uint = 0xE69966, 杏黃:uint = APRICOT
		/** * 椰褐 */
		public static const COCONUT_BROWN:uint = 0x4D1F00, 椰褐:uint = COCONUT_BROWN
		/** * 海貝色 */
		public static const SEASHELL:uint = 0xFFF5EE, 海貝色:uint = SEASHELL
		/** * 鞍褐 */
		public static const SADDLE_BROWN:uint = 0x8B4513, 鞍褐:uint = SADDLE_BROWN
		/** * 巧克力色 */
		public static const CHOCOLATE:uint = 0xD2691E, 巧克力色:uint = CHOCOLATE
		/** * 燃橙 */
		public static const BURNT_ORANGE:uint = 0xCC5500, 燃橙:uint = BURNT_ORANGE
		/** * 陽橙 */
		public static const SUN_ORANGE:uint = 0xFF7300, 陽橙:uint = SUN_ORANGE
		/** * 粉撲桃色 */
		public static const PEACH_PUFF:uint = 0xFFDAB9, 粉撲桃色:uint = PEACH_PUFF
		/** * 沙褐 */
		public static const SAND_BROWN:uint = 0xF4A460, 沙褐:uint = SAND_BROWN
		/** * 古銅色 */
		public static const BRONZE:uint = 0xB87333, 古銅色:uint = BRONZE
		/** * 亞麻色 */
		public static const LINEN:uint = 0xFAF0E6, 亞麻色:uint = LINEN
		/** * 蜜橙 */
		public static const HONEY_ORANGE:uint = 0xFFB366, 蜜橙:uint = HONEY_ORANGE
		/** * 秘魯色 */
		public static const PERU:uint = 0xCD853F, 秘魯色:uint = PERU
		/** * 烏賊墨色 */
		public static const SEPIA:uint = 0x704214, 烏賊墨色:uint = SEPIA
		/** * 赭色 */
		public static const OCHER:uint = 0xCC7722, 赭色:uint = OCHER
		/** * 陶坯黃 */
		public static const BISQUE:uint = 0xFFE4C4, 陶坯黃:uint = BISQUE
		/** * 橘色 */
		public static const TANGERINE:uint = 0xF28500, 橘色:uint = TANGERINE
		/** * 暗橙 */
		public static const DARK_ORANGE:uint = 0xFF8C00, 暗橙:uint = DARK_ORANGE
		/** * 古董白 */
		public static const ANTIQUE_WHITE:uint = 0xFAEBD7, 古董白:uint = ANTIQUE_WHITE
		/** * 日曬色 */
		public static const TAN:uint = 0xD2B48C, 日曬色:uint = TAN
		/** * 硬木色 */
		public static const BURLY_WOOD:uint = 0xDEB887, 硬木色:uint = BURLY_WOOD
		/** * 杏仁白 */
		public static const BLANCHED_ALMOND:uint = 0xFFEBCD, 杏仁白:uint = BLANCHED_ALMOND
		/** * 那瓦霍白 */
		public static const NAVAJO_WHITE:uint = 0xFFDEAD, 那瓦霍白:uint = NAVAJO_WHITE
		/** * 萬壽菊黃 */
		public static const MARIGOLD:uint = 0xFF9900, 萬壽菊黃:uint = MARIGOLD
		/** * 番木瓜色 */
		public static const PAPAYA_WHIP:uint = 0xFFEFD5, 番木瓜色:uint = PAPAYA_WHIP
		/** * 灰土色 */
		public static const PALE_OCRE:uint = 0xCCB38C, 灰土色:uint = PALE_OCRE
		/** * 卡其色 */
		public static const KHAKI:uint = 0x996B1F, 卡其色:uint = KHAKI
		/** * 鹿皮鞋色 */
		public static const MOCCASIN:uint = 0xFFE4B5, 鹿皮鞋色:uint = MOCCASIN
		/** * 舊蕾絲色 */
		public static const OLD_LACE:uint = 0xFDF5E6, 舊蕾絲色:uint = OLD_LACE
		/** * 小麥色 */
		public static const WHEAT:uint = 0xF5DEB3, 小麥色:uint = WHEAT
		/** * 桃色 */
		public static const PEACH:uint = 0xFFE5B4, 桃色:uint = PEACH
		/** * 橙色 */
		public static const ORANGE:uint = 0xFFA500, 橙色:uint = ORANGE
		/** * 花卉白 */
		public static const FLORAL_WHITE:uint = 0xFFFAF0, 花卉白:uint = FLORAL_WHITE
		/** * 金菊色 */
		public static const GOLDENROD:uint = 0xDAA520, 金菊色:uint = GOLDENROD
		/** * 暗金菊色 */
		public static const DARK_GOLDENROD:uint = 0xB8860B, 暗金菊色:uint = DARK_GOLDENROD
		/** * 咖啡色 */
		public static const COFFEE:uint = 0x4D3900, 咖啡色:uint = COFFEE
		/** * 茉莉黃 */
		public static const JASMINE:uint = 0xE6C35C, 茉莉黃:uint = JASMINE
		/** * 琥珀色 */
		public static const AMBER:uint = 0xFFBF00, 琥珀色:uint = AMBER
		/** * 玉米絲色 */
		public static const CORNSILK:uint = 0xFFF8DC, 玉米絲色:uint = CORNSILK
		/** * 鉻黃 */
		public static const CHROME_YELLOW:uint = 0xE6B800, 鉻黃:uint = CHROME_YELLOW
		/** * 金色 */
		public static const GOLDEN:uint = 0xFFD700, 金色:uint = GOLDEN
		/** * 檸檬綢色 */
		public static const LEMON_CHIFFON:uint = 0xFFFACD, 檸檬綢色:uint = LEMON_CHIFFON
		/** * 亮卡其色 */
		public static const LIGHT_KHAKI:uint = 0xF0E68C, 亮卡其色:uint = LIGHT_KHAKI
		/** * 灰金菊色 */
		public static const PALE_GOLDENROD:uint = 0xEEE8AA, 灰金菊色:uint = PALE_GOLDENROD
		/** * 暗卡其色 */
		public static const DARK_KHAKI:uint = 0xBDB76B, 暗卡其色:uint = DARK_KHAKI
		/** * 含羞草黃 */
		public static const MIMOSA:uint = 0xE6D933, 含羞草黃:uint = MIMOSA
		/** * 奶油色 */
		public static const CREAM:uint = 0xFFFDD0, 奶油色:uint = CREAM
		/** * 象牙色 */
		public static const IVORY:uint = 0xFFFFF0, 象牙色:uint = IVORY
		/** * 棕色 */
		public static const BEIGE:uint = 0xF5F5DC, 棕色:uint = BEIGE
		/** * 亮黃 */
		public static const LIGHT_YELLOW:uint = 0xFFFFE0, 亮黃:uint = LIGHT_YELLOW
		/** * 亮金菊黃 */
		public static const LIGHT_GOLDENROD_YELLOW:uint = 0xFAFAD2, 亮金菊黃:uint = LIGHT_GOLDENROD_YELLOW
		/** * 香檳黃 */
		public static const CHAMPAGNE_YELLOW:uint = 0xFFFF99, 香檳黃:uint = CHAMPAGNE_YELLOW
		/** * 芥末黃 */
		public static const MUSTARD:uint = 0xCCCC4D, 芥末黃:uint = MUSTARD
		/** * 月黃 */
		public static const MOON_YELLOW:uint = 0xFFFF4D, 月黃:uint = MOON_YELLOW
		/** * 橄欖色 */
		public static const OLIVE:uint = 0x808000, 橄欖色:uint = OLIVE
		/** * 鮮黃 */
		public static const CANARY_YELLOW:uint = 0xFFFF00, 鮮黃:uint = CANARY_YELLOW
		/** * 黃色 */
		public static const YELLOW:uint = 0xFFFF00, 黃色:uint = YELLOW
		/** * 苔蘚綠 */
		public static const MOSS_GREEN:uint = 0x697723, 苔蘚綠:uint = MOSS_GREEN
		/** * 亮柠檬绿 */
		public static const LIGHT_LIME:uint = 0xCCFF00, 亮柠檬绿:uint = LIGHT_LIME
		/** * 橄欖軍服綠 */
		public static const OLIVE_DRAB:uint = 0x6B8E23, 橄欖軍服綠:uint = OLIVE_DRAB
		/** * 黃綠 */
		public static const YELLOW_GREEN:uint = 0x9ACD32, 黃綠:uint = YELLOW_GREEN
		/** * 暗橄欖綠 */
		public static const DARK_OLIVE_GREEN:uint = 0x556B2F, 暗橄欖綠:uint = DARK_OLIVE_GREEN
		/** * 蘋果綠 */
		public static const APPLE_GREEN:uint = 0x8CE600, 蘋果綠:uint = APPLE_GREEN
		/** * 綠黃 */
		public static const GREEN_YELLOW:uint = 0xADFF2F, 綠黃:uint = GREEN_YELLOW
		/** * 草綠 */
		public static const GRASS_GREEN:uint = 0x99E64D, 草綠:uint = GRASS_GREEN
		/** * 草坪綠 */
		public static const LAWN_GREEN:uint = 0x7CFC00, 草坪綠:uint = LAWN_GREEN
		/** * 查特酒綠 */
		public static const CHARTREUSE:uint = 0x7FFF00, 查特酒綠:uint = CHARTREUSE
		/** * 葉綠 */
		public static const FOLIAGE_GREEN:uint = 0x73B839, 葉綠:uint = FOLIAGE_GREEN
		/** * 嫩綠 */
		public static const FRESH_LEAVES:uint = 0x99FF4D, 嫩綠:uint = FRESH_LEAVES
		/** * 明綠 */
		public static const BRIGHT_GREEN:uint = 0x66FF00, 明綠:uint = BRIGHT_GREEN
		/** * 鈷綠 */
		public static const COBALT_GREEN:uint = 0x66FF59, 鈷綠:uint = COBALT_GREEN
		/** * 蜜瓜綠 */
		public static const HONEYDEW:uint = 0xF0FFF0, 蜜瓜綠:uint = HONEYDEW
		/** * 暗海綠 */
		public static const DARK_SEA_GREEN:uint = 0x8FBC8F, 暗海綠:uint = DARK_SEA_GREEN
		/** * 亮綠 */
		public static const LIGHT_GREEN:uint = 0x90EE90, 亮綠:uint = LIGHT_GREEN
		/** * 灰綠 */
		public static const PALE_GREEN:uint = 0x98FB98, 灰綠:uint = PALE_GREEN
		/** * 常春藤綠 */
		public static const IVY_GREEN:uint = 0x36BF36, 常春藤綠:uint = IVY_GREEN
		/** * 森林綠 */
		public static const FOREST_GREEN:uint = 0x228B22, 森林綠:uint = FOREST_GREEN
		/** * 柠檬綠 */
		public static const LIME_GREEN:uint = 0x32CD32, 柠檬綠:uint = LIME_GREEN
		/** * 暗綠 */
		public static const DARK_GREEN:uint = 0x006400, 暗綠:uint = DARK_GREEN
		/** * 綠色 */
		public static const GREEN:uint = 0x008000, 綠色:uint = GREEN
		/** * 柠檬绿 */
		public static const LIME:uint = 0x00FF00, 柠檬绿:uint = LIME
		/** * 孔雀石綠 */
		public static const MALACHITE:uint = 0x22C32E, 孔雀石綠:uint = MALACHITE
		/** * 薄荷綠 */
		public static const MINT:uint = 0x16982B, 薄荷綠:uint = MINT
		/** * 青瓷綠 */
		public static const CELADON_GREEN:uint = 0x73E68C, 青瓷綠:uint = CELADON_GREEN
		/** * 碧綠 */
		public static const EMERALD:uint = 0x50C878, 碧綠:uint = EMERALD
		/** * 綠松石綠 */
		public static const TURQUOISE_GREEN:uint = 0x4DE680, 綠松石綠:uint = TURQUOISE_GREEN
		/** * 鉻綠 */
		public static const VERIDIAN:uint = 0x127436, 鉻綠:uint = VERIDIAN
		/** * 蒼色 */
		public static const HORIZON_BLUE:uint = 0xA6FFCC, 蒼色:uint = HORIZON_BLUE
		/** * 海綠 */
		public static const SEA_GREEN:uint = 0x2E8B57, 海綠:uint = SEA_GREEN
		/** * 中海綠 */
		public static const MEDIUM_SEA_GREEN:uint = 0x3CB371, 中海綠:uint = MEDIUM_SEA_GREEN
		/** * 薄荷奶油色 */
		public static const MINT_CREAM:uint = 0xF5FFFA, 薄荷奶油色:uint = MINT_CREAM
		/** * 春綠 */
		public static const SPRING_GREEN:uint = 0x00FF80, 春綠:uint = SPRING_GREEN
		/** * 孔雀綠 */
		public static const PEACOCK_GREEN:uint = 0x00A15C, 孔雀綠:uint = PEACOCK_GREEN
		/** * 中春綠色 */
		public static const MEDIUM_SPRING_GREEN:uint = 0x00FA9A, 中春綠色:uint = MEDIUM_SPRING_GREEN
		/** * 中碧藍色 */
		public static const MEDIUM_AQUAMARINE:uint = 0x66CDAA, 中碧藍色:uint = MEDIUM_AQUAMARINE
		/** * 碧藍色 */
		public static const AQUAMARINE:uint = 0x7FFFD4, 碧藍色:uint = AQUAMARINE
		/** * 青藍 */
		public static const CYAN_BLUE:uint = 0x0DBF8C, 青藍:uint = CYAN_BLUE
		/** * 水藍 */
		public static const AQUA_BLUE:uint = 0x66FFE6, 水藍:uint = AQUA_BLUE
		/** * 綠松石藍 */
		public static const TURQUOISE_BLUE:uint = 0x33E6CC, 綠松石藍:uint = TURQUOISE_BLUE
		/** * 綠松石色 */
		public static const TURQUOISE:uint = 0x30D5C8, 綠松石色:uint = TURQUOISE
		/** * 亮海綠 */
		public static const LIGHT_SEA_GREEN:uint = 0x20B2AA, 亮海綠:uint = LIGHT_SEA_GREEN
		/** * 中綠松石色 */
		public static const MEDIUM_TURQUOISE:uint = 0x48D1CC, 中綠松石色:uint = MEDIUM_TURQUOISE
		/** * 亮青 */
		public static const LIGHT_CYAN:uint = 0xE0FFFF, 亮青:uint = LIGHT_CYAN
		/** * 淺藍 */
		public static const BABY_BLUE:uint = 0xE0FFFF, 淺藍:uint = BABY_BLUE
		/** * 灰綠松石色 */
		public static const PALE_TURQUOISE:uint = 0xAFEEEE, 灰綠松石色:uint = PALE_TURQUOISE
		/** * 暗岩灰 */
		public static const DARK_SLATE_GRAY:uint = 0x2F4F4F, 暗岩灰:uint = DARK_SLATE_GRAY
		/** * 鳧綠 */
		public static const TEAL:uint = 0x008080, 鳧綠:uint = TEAL
		/** * 暗青 */
		public static const DARK_CYAN:uint = 0x008B8B, 暗青:uint = DARK_CYAN
		/** * 青色 */
		public static const CYAN:uint = 0x00FFFF, 青色:uint = CYAN
		/** * 水色 */
		public static const AQUA:uint = 0x00FFFF, 水色:uint = AQUA
		/** * 暗綠松石色 */
		public static const DARK_TURQUOISE:uint = 0x00CED1, 暗綠松石色:uint = DARK_TURQUOISE
		/** * 軍服藍 */
		public static const CADET_BLUE:uint = 0x5F9EA0, 軍服藍:uint = CADET_BLUE
		/** * 孔雀藍 */
		public static const PEACOCK_BLUE:uint = 0x00808C, 孔雀藍:uint = PEACOCK_BLUE
		/** * 嬰兒粉藍 */
		public static const POWDER_BLUE:uint = 0xB0E0E6, 嬰兒粉藍:uint = POWDER_BLUE
		/** * 濃藍 */
		public static const STRONG_BLUE:uint = 0x006374, 濃藍:uint = STRONG_BLUE
		/** * 亮藍 */
		public static const LIGHT_BLUE:uint = 0xADD8E6, 亮藍:uint = LIGHT_BLUE
		/** * 灰藍 */
		public static const PALE_BLUE:uint = 0x7AB8CC, 灰藍:uint = PALE_BLUE
		/** * 薩克斯藍 */
		public static const SAXE_BLUE:uint = 0x4798B3, 薩克斯藍:uint = SAXE_BLUE
		/** * 深天藍 */
		public static const DEEP_SKY_BLUE:uint = 0x00BFFF, 深天藍:uint = DEEP_SKY_BLUE
		/** * 天藍 */
		public static const SKY_BLUE:uint = 0x87CEEB, 天藍:uint = SKY_BLUE
		/** * 亮天藍 */
		public static const LIGHT_SKY_BLUE:uint = 0x87CEFA, 亮天藍:uint = LIGHT_SKY_BLUE
		/** * 水手藍 */
		public static const MARINE_BLUE:uint = 0x00477D, 水手藍:uint = MARINE_BLUE
		/** * 鋼青色 */
		public static const STEEL_BLUE:uint = 0x4682B4, 鋼青色:uint = STEEL_BLUE
		/** * 愛麗絲藍 */
		public static const ALICE_BLUE:uint = 0xF0F8FF, 愛麗絲藍:uint = ALICE_BLUE
		/** * 岩灰 */
		public static const SLATE_GRAY:uint = 0x708090, 岩灰:uint = SLATE_GRAY
		/** * 亮岩灰 */
		public static const LIGHT_SLATE_GRAY:uint = 0x778899, 亮岩灰:uint = LIGHT_SLATE_GRAY
		/** * 道奇藍 */
		public static const DODGER_BLUE:uint = 0x1E90FF, 道奇藍:uint = DODGER_BLUE
		/** * 礦藍 */
		public static const MINERAL_BLUE:uint = 0x004D99, 礦藍:uint = MINERAL_BLUE
		/** * 湛藍 */
		public static const AZURE:uint = 0x007FFF, 湛藍:uint = AZURE
		/** * 韋奇伍德瓷藍 */
		public static const WEDGWOOD_BLUE:uint = 0x5686BF, 韋奇伍德瓷藍:uint = WEDGWOOD_BLUE
		/** * 亮鋼藍 */
		public static const LIGHT_STEEL_BLUE:uint = 0xB0C4DE, 亮鋼藍:uint = LIGHT_STEEL_BLUE
		/** * 鈷藍 */
		public static const COBALT_BLUE:uint = 0x0047AB, 鈷藍:uint = COBALT_BLUE
		/** * 灰丁寧藍 */
		public static const PALE_DENIM:uint = 0x5E86C1, 灰丁寧藍:uint = PALE_DENIM
		/** * 矢車菊藍 */
		public static const CORNFLOWER_BLUE:uint = 0x6495ED, 矢車菊藍:uint = CORNFLOWER_BLUE
		/** * 鼠尾草藍 */
		public static const SALVIA_BLUE:uint = 0x4D80E6, 鼠尾草藍:uint = SALVIA_BLUE
		/** * 暗嬰兒粉藍 */
		public static const DARK_POWDER_BLUE:uint = 0x003399, 暗嬰兒粉藍:uint = DARK_POWDER_BLUE
		/** * 藍寶石色 */
		public static const SAPPHIRE:uint = 0x082567, 藍寶石色:uint = SAPPHIRE
		/** * 國際奇連藍 */
		public static const INTERNATIONAL_KLEIN_BLUE:uint = 0x002FA7, 國際奇連藍:uint = INTERNATIONAL_KLEIN_BLUE
		/** * 蔚藍 */
		public static const CERULEAN_BLUE:uint = 0x2A52BE, 蔚藍:uint = CERULEAN_BLUE
		/** * 品藍 */
		public static const ROYAL_BLUE:uint = 0x4169E1, 品藍:uint = ROYAL_BLUE
		/** * 暗礦藍 */
		public static const DARK_MINERAL_BLUE:uint = 0x24367D, 暗礦藍:uint = DARK_MINERAL_BLUE
		/** * 極濃海藍 */
		public static const ULTRAMARINE:uint = 0x0033FF, 極濃海藍:uint = ULTRAMARINE
		/** * 天青石藍 */
		public static const LAPIS_LAZULI:uint = 0x0D33FF, 天青石藍:uint = LAPIS_LAZULI
		/** * 幽靈白 */
		public static const GHOST_WHITE:uint = 0xF8F8FF, 幽靈白:uint = GHOST_WHITE
		/** * 薰衣草紫 */
		public static const LAVENDER:uint = 0xE6E6FA, 薰衣草紫:uint = LAVENDER
		/** * 長春花色 */
		public static const PERIWINKLE:uint = 0xCCCCFF, 長春花色:uint = PERIWINKLE
		/** * 午夜藍 */
		public static const MIDNIGHT_BLUE:uint = 0x191970, 午夜藍:uint = MIDNIGHT_BLUE
		/** * 藏青 */
		public static const NAVY_BLUE:uint = 0x000080, 藏青:uint = NAVY_BLUE
		/** * 暗藍 */
		public static const DARK_BLUE:uint = 0x00008B, 暗藍:uint = DARK_BLUE
		/** * 中藍 */
		public static const MEDIUM_BLUE:uint = 0x0000CD, 中藍:uint = MEDIUM_BLUE
		/** * 藍色 */
		public static const BLUE:uint = 0x0000FF, 藍色:uint = BLUE
		/** * 紫藤色 */
		public static const WISTERIA:uint = 0x5C50E6, 紫藤色:uint = WISTERIA
		/** * 暗岩藍 */
		public static const DARK_SLATE_BLUE:uint = 0x483D8B, 暗岩藍:uint = DARK_SLATE_BLUE
		/** * 岩藍 */
		public static const SLATE_BLUE:uint = 0x6A5ACD, 岩藍:uint = SLATE_BLUE
		/** * 中岩藍 */
		public static const MEDIUM_SLATE_BLUE:uint = 0x7B68EE, 中岩藍:uint = MEDIUM_SLATE_BLUE
		/** * 木槿紫 */
		public static const MAUVE:uint = 0x6640FF, 木槿紫:uint = MAUVE
		/** * 紫丁香色 */
		public static const LILAC:uint = 0xB399FF, 紫丁香色:uint = LILAC
		/** * 中紫紅 */
		public static const MEDIUM_PURPLE:uint = 0x9370DB, 中紫紅:uint = MEDIUM_PURPLE
		/** * 紫水晶色 */
		public static const AMETHYST:uint = 0x6633CC, 紫水晶色:uint = AMETHYST
		/** * 淺灰紫紅 */
		public static const GRAYISH_PURPLE:uint = 0x8674A1, 淺灰紫紅:uint = GRAYISH_PURPLE
		/** * 纈草紫 */
		public static const HELIOTROPE:uint = 0x5000B8, 纈草紫:uint = HELIOTROPE
		/** * 礦紫 */
		public static const MINERAL_VIOLET:uint = 0xB8A1CF, 礦紫:uint = MINERAL_VIOLET
		/** * 藍紫 */
		public static const BLUE_VIOLET:uint = 0x8A2BE2, 藍紫:uint = BLUE_VIOLET
		/** * 紫藍色 */
		public static const VIOLET:uint = 0x8B00FF, 紫藍色:uint = VIOLET
		/** * 靛色 */
		public static const INDIGO:uint = 0x4B0080, 靛色:uint = INDIGO
		/** * 暗蘭紫 */
		public static const DARK_ORCHID:uint = 0x9932CC, 暗蘭紫:uint = DARK_ORCHID
		/** * 暗紫 */
		public static const DARK_VIOLET:uint = 0x9400D3, 暗紫:uint = DARK_VIOLET
		/** * 三色堇紫 */
		public static const PANSY:uint = 0x7400A1, 三色堇紫:uint = PANSY
		/** * 錦葵紫 */
		public static const MALLOW:uint = 0xD94DFF, 錦葵紫:uint = MALLOW
		/** * 優品紫紅 */
		public static const OPERA_MAUVE:uint = 0xE680FF, 優品紫紅:uint = OPERA_MAUVE
		/** * 中蘭紫 */
		public static const MEDIUM_ORCHID:uint = 0xBA55D3, 中蘭紫:uint = MEDIUM_ORCHID
		/** * 淡紫丁香色 */
		public static const PAIL_LILAC:uint = 0xE6CFE6, 淡紫丁香色:uint = PAIL_LILAC
		/** * 薊紫 */
		public static const THISTLE:uint = 0xD8BFD8, 薊紫:uint = THISTLE
		/** * 鐵線蓮紫 */
		public static const CLEMATIS:uint = 0xCCA3CC, 鐵線蓮紫:uint = CLEMATIS
		/** * 李紫 */
		public static const PLUM:uint = 0xDDA0DD, 李紫:uint = PLUM
		/** * 亮紫 */
		public static const LIGHT_VIOLET:uint = 0xEE82EE, 亮紫:uint = LIGHT_VIOLET
		/** * 紫色 */
		public static const PURPLE:uint = 0x800080, 紫色:uint = PURPLE
		/** * 暗洋紅 */
		public static const DARK_MAGENTA:uint = 0x8B008B, 暗洋紅:uint = DARK_MAGENTA
		/** * 洋紅 */
		public static const MAGENTA:uint = 0xFF00FF, 洋紅:uint = MAGENTA
		/** * 品紅 */
		public static const FUCHSIA:uint = 0xF400A1, 品紅:uint = FUCHSIA
		/** * 蘭紫 */
		public static const ORCHID:uint = 0xDA70D6, 蘭紫:uint = ORCHID
		/** * 淺珍珠紅 */
		public static const PEARL_PINK:uint = 0xFFB3E6, 淺珍珠紅:uint = PEARL_PINK
		/** * 陳玫紅 */
		public static const OLD_ROSE:uint = 0xB85798, 陳玫紅:uint = OLD_ROSE
		/** * 淺玫瑰紅 */
		public static const ROSE_PINK:uint = 0xFF66CC, 淺玫瑰紅:uint = ROSE_PINK
		/** * 中青紫紅 */
		public static const MEDIUM_VIOLET_RED:uint = 0xC71585, 中青紫紅:uint = MEDIUM_VIOLET_RED
		/** * 玫瑰紅 */
		public static const ROSE_RED:uint = 0xFF0DA6, 玫瑰紅:uint = ROSE_RED
		/** * 紅寶石色 */
		public static const RUBY:uint = 0xCC0080, 紅寶石色:uint = RUBY
		/** * 山茶紅 */
		public static const CAMELLIA:uint = 0xE63995, 山茶紅:uint = CAMELLIA
		/** * 深粉紅 */
		public static const DEEP_PINK:uint = 0xFF1493, 深粉紅:uint = DEEP_PINK
		/** * 火鶴紅 */
		public static const FLAMINGO:uint = 0xE68AB8, 火鶴紅:uint = FLAMINGO
		/** * 淺珊瑚紅 */
		public static const CORAL_PINK:uint = 0xFF80BF, 淺珊瑚紅:uint = CORAL_PINK
		/** * 暖粉紅 */
		public static const HOT_PINK:uint = 0xFF69B4, 暖粉紅:uint = HOT_PINK
		/** * 勃艮第酒紅 */
		public static const BURGUNDY:uint = 0x470024, 勃艮第酒紅:uint = BURGUNDY
		/** * 尖晶石紅 */
		public static const SPINEL_RED:uint = 0xFF73B3, 尖晶石紅:uint = SPINEL_RED
		/** * 胭脂紅 */
		public static const CARMINE:uint = 0xE6005C, 胭脂紅:uint = CARMINE
		/** * 淺粉紅 */
		public static const BABY_PINK:uint = 0xFFD9E6, 淺粉紅:uint = BABY_PINK
		/** * 樞機紅 */
		public static const CARDINAL_RED:uint = 0x990036, 樞機紅:uint = CARDINAL_RED
		/** * 薰衣草紫紅 */
		public static const LAVENDER_BLUSH:uint = 0xFFF0F5, 薰衣草紫紅:uint = LAVENDER_BLUSH
		/** * 灰紫紅 */
		public static const PALE_VIOLET_RED:uint = 0xDB7093, 灰紫紅:uint = PALE_VIOLET_RED
		/** * 櫻桃紅 */
		public static const CERISE:uint = 0xDE3163, 櫻桃紅:uint = CERISE
		/** * 淺鮭紅 */
		public static const SALMON_PINK:uint = 0xFF8099, 淺鮭紅:uint = SALMON_PINK
		/** * 緋紅 */
		public static const CRIMSON:uint = 0xDC143C, 緋紅:uint = CRIMSON
		/** * 粉紅 */
		public static const PINK:uint = 0xFFC0CB, 粉紅:uint = PINK
		/** * 亮粉紅 */
		public static const LIGHT_PINK:uint = 0xFFB6C1, 亮粉紅:uint = LIGHT_PINK
		/** * 殼黃紅 */
		public static const SHELL_PINK:uint = 0xFFB3BF, 殼黃紅:uint = SHELL_PINK
		/** * 茜紅 */
		public static const ALIZARIN_CRIMSON:uint = 0xE32636, 茜紅:uint = ALIZARIN_CRIMSON
		
		public static function getColorListView():Sprite
		{
			var spr:Sprite = new Sprite();
			var arr:Array = [];
			
			const width:int = 100;
			const height:int = 30;
			const row:int = 15;
			
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
				if (a.color == b.color)
				{
					return a.name > b.name ? -1 : 1;
				}
				return a.color > b.color ? -1 : 1;
			}
			
			return spr;
		}
	
	}

}