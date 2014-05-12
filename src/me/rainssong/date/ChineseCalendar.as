package me.rainssong.date
{
	
	public class ChineseCalendar
	{
		//*****************************************************************************
		//        本农历日历类代码来源于网络开源代码，作者根据本人习惯略作修改
		//*****************************************************************************
		//===================================私有变量定义================================================
		//数组存入1900年到2100年的大小月及闰月信息，采用16进制记录，据传代码来源台湾林洵贤《农历月历与世界时间》
		//阴历每月只能是29或30天，一年用12（或13）个二进制位表示，对应位为1代表30天，否则为29天
		private var tabCnMonthInfo:Array = new Array(0x4bd8, 0x4ae0, 0xa570, 0x54d5, 0xd260, 0xd950, 0x5554, 0x56af, 0x9ad0, 0x55d2, 0x4ae0, 0xa5b6, 0xa4d0, 0xd250, 0xd255, 0xb54f, 0xd6a0, 0xada2, 0x95b0, 0x4977, 0x497f, 0xa4b0, 0xb4b5, 0x6a50, 0x6d40, 0xab54, 0x2b6f, 0x9570, 0x52f2, 0x4970, 0x6566, 0xd4a0, 0xea50, 0x6a95, 0x5adf, 0x2b60, 0x86e3, 0x92ef, 0xc8d7, 0xc95f, 0xd4a0, 0xd8a6, 0xb55f, 0x56a0, 0xa5b4, 0x25df, 0x92d0, 0xd2b2, 0xa950, 0xb557, 0x6ca0, 0xb550, 0x5355, 0x4daf, 0xa5b0, 0x4573, 0x52bf, 0xa9a8, 0xe950, 0x6aa0, 0xaea6, 0xab50, 0x4b60, 0xaae4, 0xa570, 0x5260, 0xf263, 0xd950, 0x5b57, 0x56a0, 0x96d0, 0x4dd5, 0x4ad0, 0xa4d0, 0xd4d4, 0xd250, 0xd558, 0xb540, 0xb6a0, 0x95a6, 0x95bf, 0x49b0, 0xa974, 0xa4b0, 0xb27a, 0x6a50, 0x6d40, 0xaf46, 0xab60, 0x9570, 0x4af5, 0x4970, 0x64b0, 0x74a3, 0xea50, 0x6b58, 0x5ac0, 0xab60, 0x96d5, 0x92e0, 0xc960, 0xd954, 0xd4a0, 0xda50, 0x7552, 0x56a0, 0xabb7, 0x25d0, 0x92d0, 0xcab5, 0xa950, 0xb4a0, 0xbaa4, 0xad50, 0x55d9, 0x4ba0, 0xa5b0, 0x5176, 0x52bf, 0xa930, 0x7954, 0x6aa0, 0xad50, 0x5b52, 0x4b60, 0xa6e6, 0xa4e0, 0xd260, 0xea65, 0xd530, 0x5aa0, 0x76a3, 0x96d0, 0x4afb, 0x4ad0, 0xa4d0, 0xd0b6, 0xd25f, 0xd520, 0xdd45, 0xb5a0, 0x56d0, 0x55b2, 0x49b0, 0xa577, 0xa4b0, 0xaa50, 0xb255, 0x6d2f, 0xada0, 0x4b63, 0x937f, 0x49f8, 0x4970, 0x64b0, 0x68a6, 0xea5f, 0x6b20, 0xa6c4, 0xaaef, 0x92e0, 0xd2e3, 0xc960, 0xd557, 0xd4a0, 0xda50, 0x5d55, 0x56a0, 0xa6d0, 0x55d4, 0x52d0, 0xa9b8, 0xa950, 0xb4a0, 0xb6a6, 0xad50, 0x55a0, 0xaba4, 0xa5b0, 0x52b0, 0xb273, 0x6930, 0x7337, 0x6aa0, 0xad50, 0x4b55, 0x4b6f, 0xa570, 0x54e4, 0xd260, 0xe968, 0xd520, 0xdaa0, 0x6aa6, 0x56df, 0x4ae0, 0xa9d4, 0xa4d0, 0xd150, 0xf252, 0xd520);
		//每年的正小寒点到各节期正节期点（即十五度倍数点）的分钟数。地球公转每年几乎一样（微小差别忽略不计），由于公转轨道是椭圆，故这个数列并不是准确的等差数列
		private var tabCnSolarTermIntervalInfo:Array = new Array(0, 21208, 42467, 63836, 85337, 107014, 128867, 150921, 173149, 195551, 218072, 240693, 263343, 285989, 308563, 331033, 353350, 375494, 397447, 419210, 440795, 462224, 483532, 504758);
		private var tabGDateInfo:Array = new Array(31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31);
		//定义私有变量干支等信息
		private var tabHeavenlyStemsName:Array = new Array("甲", "乙", "丙", "丁", "戊", "己", "庚", "辛", "壬", "癸");
		private var tabEarthlyBranchesName:Array = new Array("子", "丑", "寅", "卯", "辰", "巳", "午", "未", "申", "酉", "戌", "亥");
		private var tabCnAnimalSignName:Array = new Array("鼠", "牛", "虎", "兔", "龙", "蛇", "马", "羊", "猴", "鸡", "狗", "猪");
		private var tabCnSolarTermName:Array = new Array("小寒", "大寒", "立春", "雨水", "惊蛰", "春分", "清明", "谷雨", "立夏", "小满", "芒种", "夏至", "小暑", "大暑", "立秋", "处暑", "白露", "秋分", "寒露", "霜降", "立冬", "小雪", "大雪", "冬至");
		private var tabCnMonthName:Array = new Array("正", "二", "三", "四", "五", "六", "七", "八", "九", "十", "冬", "腊");
		private var tabCnDigitsName:Array = new Array("零", "一", "二", "三", "四", "五", "六", "七", "八", "九", "十", "廿", "卅", "卌", "百", "千", "万", "兆");
		private var tabCnTensName:Array = new Array("初", "十", "廿", "三");
		private var tabGrMonthName:Array = new Array("JAN", "FEB", "MAR", "APR", "MAY", "JUN", "JUL", "AUG", "SEP", "OCT", "NOV", "DEC");
		private var tabGrDayName:Array = new Array("Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat");
		private var tabGrConstellation:Array = new Array("摩羯", "水瓶", "双鱼", "牧羊", "金牛", "双子", "巨蟹", "狮子", "处女", "天秤", "天蝎", "射手");
		//民俗节日
		private var lFtv:Array = new Array("0101 春节", "0102 大年初二", "0103 大年初三",  "0115 元宵节", "0404 寒食节", "0505 端午节",  "0707 七夕", "0815 中秋节", "0909 重阳节", "1001 祭祖节", "1208 腊八节", "1223 小年", "0100 除夕");
		//公历节日
		private var sFtv:Array = new Array("0101 元旦", "0214 情人节", "0308 妇女节", "0312 植树节","0501 劳动节",  "0601 儿童节",  "0910 教师节",  "1001 国庆节", "1225 圣诞节");
		//某月的第几个星期几; 前两位数字代表月份（m+1）,第三位数字代表第几个（9,8,7,6 表示到数第 1,2,3,4 个），第四位数字代表星期几
		private var wFtv:Array = new Array("0520 母亲节", "0530 全国助残日", "0630 父亲节", "1144 感恩节");
		private var cnYear:String; //农历年中文信息
		private var cnMonth:String; //农历月中文信息
		private var cnDay:String; //农历日中文信息
		private var cnHour:String; //农历时中文信息
		private var cnMoment:String; //农历刻中文信息
		private var cyear:int; //农历年序列号
		private var cmonth:int; //农历月序列号
		private var cday:int; //农历日序列号
		private var isLeap:Boolean; //是否闰月
		private var size:Boolean; //大月为TRUE，小月为FALSE
		private var solarTerm:String;
		private var mydate:Date = new Date();
		private var y:int, m:int, d:int; //公历年月日
		
//=======================ChineseLunisolarCalendar类构造函数=======================================
		public function ChineseCalendar(date:Date)
		{
			//传入日期, 返回农历日期
			var leap:int = 0;
			var temp:int = 0;
			mydate = date;
			y = mydate.getFullYear(); //公历年
			m = mydate.getMonth(); //公历月
			d = mydate.getDate(); //公历日
			var offset:Number = (Date.UTC(y, m, d) - Date.UTC(1900, 0, 31)) / 86400000; //计算1900年1月31日(1900年大年初一)到指定日期经过了多少天为“总日数”
			for (var i:int = 1900; i < 2100 && offset > 0; i++) //从1900年开始依次减去指定年的总天数，直至指定年份，此时总日数为负数或0
			{
				temp = lYearDays(i); //指定年的总天数
				offset -= temp;
			}
			if (offset < 0)
			{
				offset += temp;
				i--;
			}
			cyear = i;
			leap = leapMonth(i); //闰哪个月
			isLeap = false;
			for (var j:int = 1; j < 13 && offset > 0; j++)
			{
				//闰月执行此流程
				if (leap > 0 && j == leap + 1 && isLeap == false)
				{
					--j;
					isLeap = true;
					temp = leapDays(cyear);
				}
				//平月执行此流程
				else
				{
					temp = monthDays(cyear, j);
				}
				//润月后执行此流程，解除闰月
				if (isLeap == true && j == leap + 1)
				{
					isLeap = false;
				}
				offset -= temp;
			}
			if (offset == 0 && leap > 0 && j == leap + 1)
			{
				if (isLeap)
				{
					isLeap = false;
				}
				else
				{
					isLeap = true;
					--j;
				}
			}
			if (offset < 0)
			{
				offset += temp;
				--j;
			}
			cmonth = j;
			cday = offset + 1;
			if (temp == 30)
			{
				size = true;
			}
			else
			{
				size = false;
			}
		}
		
//=================================私有函数定义==========================================
		//返回农历y年的总天数
		private function lYearDays(y:int):int
		{
			var sum:int = 348;
			for (var i:int = 0x8000; i > 0x8; i >>= 1)
			{
				sum += tabCnMonthInfo[y - 1900] & i ? 1 : 0;
			}
			return sum + leapDays(y);
		}
		
		//返回农历 y年闰月的天数
		private function leapDays(y:int):int
		{
			if (leapMonth(y))
			{
				if ((tabCnMonthInfo[y - 1899] & 0xf) == 0xf)
				return 30;
				else
				return 29;
				//return tabCnMonthInfo[y - 1899] & 0xf == 0xf? 30 : 29;
			}
			else
			{
				return 0;
			}
		}
		
		//返回农历 y年闰哪个月 1-12 , 没闰返回 0
		private function leapMonth(y:int):int
		{
			var lm:* = tabCnMonthInfo[y - 1900] & 0xf;
			return lm == 0xf ? 0 : lm;
		}
		
		//返回农历 y年m月的总天数
		private function monthDays(y:int, m:int):int
		{
			return tabCnMonthInfo[y - 1900] & 0x10000 >> m ? 30 : 29;
		}
		
		//某年的第n个节气为几日(从0小寒起算)
		private function sTerm(y:int, n:int):*
		{
			var offDate:* = new Date(31556925974.7 * y - 1900 + tabCnSolarTermIntervalInfo[n] * 60000 + Date.UTC(1900, 0, 6, 2, 5));
			return (offDate.getUTCDate());
		}
		
		//传入 offset 返回干支, 0=甲子
		private function cyclical(num):*
		{
			return tabHeavenlyStemsName[num % 10] + tabEarthlyBranchesName[num % 12];
		}
		
		//返回公历 y年某m+1月的天数
		private function solarDays(y:int, m:int):int
		{
			if (m == 1)
			{
				return y % 4 == 0 && y % 100 != 0 || y % 400 == 0 ? 29 : 28;
			}
			else
			{
				return (tabGDateInfo[m]);
			}
		}
		
		//返回公历y年m+1月第n个星期w的日期
		private function dateNWeek(y:int, m:int, n:int, w:int):int
		{
			var tempDate:Date;
			var resultDate:int;
			if (n < 5)
			{
				//本月第一个星期w的日期
				tempDate = new Date(y, m, 1);
				if (tempDate.day == w)
				{
					resultDate = 1;
				}
				if (tempDate.day < w)
				{
					resultDate = w - tempDate.day + 1;
				}
				if (tempDate.day > w)
				{
					resultDate = 7 - tempDate.day + w + 1;
				}
				resultDate += (n - 1) * 7;
			}
			if (n > 5)
			{
				//本月倒数第一个星期w的日期
				tempDate = new Date(y, m, solarDays(y, m));
				if (tempDate.day == w)
				{
					resultDate = solarDays(y, m);
				}
				if (tempDate.day < w)
				{
					resultDate = 7 - w + tempDate.day;
				}
				if (tempDate.day > w)
				{
					resultDate = solarDays(y, m) - (tempDate.day - w);
				}
				resultDate -= (10 - n - 1) * 7;
			}
			return resultDate;
		}
		
//======================================公有函数定义======================================
		//返回农历年的生肖
		public function getCnAnimalsSign():*
		{
			var a:int = (cyear - 4) % 12;
			return tabCnAnimalSignName[a];
		}
		
		//返回农历年序号
		public function getCnYearNumber():String
		{
			var tempNumber:int = getCYear();
			var resultNumber:String = "";
			for (var i:int = 1000; i > 0; i = i / 10)
			{
				resultNumber += tabCnDigitsName[int(tempNumber / i)];
				tempNumber = tempNumber % i;
			}
			return resultNumber;
		}
		
		//返回农历年干支
		public function getCnYear():String
		{
			//设置农历年份信息，采取大众依春节更新年干支的方法计算
			return cyclical(cyear - 1900 + 36);
		}
		
		public function getCnMonth():String
		{
			//设置农历月份中文信息
			if (isLeap == true)
			{
				cnMonth = "闰";
			}
			else
			{
				cnMonth = "";
			}
			cnMonth += tabCnMonthName[cmonth - 1] + "月";
			//if (size = true)
			//{
				//cnMonth += "大";
			//}
			//else
			//{
				//cnMonth += "小";
			//}
			return cnMonth;
		}
		
		public function getCnDay():String
		{
			//设置农历日期中文信息
			if (cday % 10 == 0)
			{
				if (cday == 10)
					cnDay = "初十";
				else if (cday == 20)
					cnDay = "二十";
				else
					cnDay = "三十";
				
				//cnDay = tabCnTensName[int(cday / 10)] + tabCnDigitsName[10];
			}
			else
			{
				cnDay = tabCnTensName[int(cday / 10)] + tabCnDigitsName[cday % 10];
			}
			return cnDay;
		}
		
		//返回时辰
		public function getCnHours():String
		{
			cnHour = tabEarthlyBranchesName[Math.round(mydate.getHours() % 23 / 2)] + "时";
			cnMoment = tabCnDigitsName[(mydate.getHours() % 2 * 4) + int(mydate.getMinutes() / 15) + 1] + "刻";
			return cnHour + cnMoment;
		}
		
		public function getCYear():int
		{
			return cyear + 2698; //自从夏历纪年开始到公元元年已是第2698个循环年
		}
		
		public function getCMonth():int
		{
			return cmonth;
		}
		
		public function getCDay():int
		{
			return cday;
		}
		
		//返回公历月
		public function getGrMonth():String
		{
			return tabGrMonthName[m];
		}
		
		//返回公历星期
		public function getGrDay():String
		{
			return tabGrDayName[mydate.day];
		}
		
		public function getGYear():int
		{
			return mydate.fullYear;
		}
		
		public function getGMonth():int
		{
			return mydate.month;
		}
		
		public function getGDate():int
		{
			return mydate.date;
		}
		
		//返回节气
		public function getCnSolarTerm():String
		{
			var tmp1:* = sTerm(cyear, m * 2);
			var tmp2:* = sTerm(cyear, m * 2 + 1);
			if (d == tmp1)
			{
				solarTerm = tabCnSolarTermName[m * 2];
			}
			else
			{
				if (d == tmp2)
				{
					solarTerm = tabCnSolarTermName[m * 2 + 1];
				}
				else
				{
					solarTerm = "";
				}
			}
			return solarTerm;
		}
		
		//返回公历历节日
		public function getsFtv():String
		{
			var s:String = "";
			for (var i:String in sFtv)
			{
				if (int(sFtv[i].substring(0, 4)) == 100 * (m + 1) + d)
				{
					s = sFtv[i].substring(5);
				}
			}
			return s;
		}
		
		//返回月周节日
		public function getwFtv():String
		{
			var s:String = "";
			for (var i:String in wFtv)
			{
				if (int(wFtv[i].substring(0, 2)) == (m + 1) && dateNWeek(y, m, int(wFtv[i].substring(2,3)), int(wFtv[i].substring(3,4))) == d)
				{
					s = wFtv[i].substring(5);
				}
			}
			return s;
		}
		
		//返回农历节日
		public function getlFtv():String
		{
			var s:String = "";
			for (var i:String in lFtv) //普通农历节日查询
			{
				if (int(lFtv[i].substring(0, 4)) == 100 * (cmonth) + cday)
				{
					s = lFtv[i].substring(5);
				}
			}
			if (cmonth == 12 && leapMonth(cyear) == 12) //闰腊月年除夕的计算方法，虽极少出现润腊月，但应考虑其可能性
			{
				if (cday == 29 && size == false)
				{
					s = "除夕";
				}
				if (cday == 30 && size == true)
				{
					s = "除夕";
				}
			}
			else if (cmonth == 12) //非闰腊月年除夕的计算方法
			{
				if (cday == 29 && size == false)
				{
					s = "除夕";
				}
				if (cday == 30 && size == true)
				{
					s = "除夕";
				}
			}
			return s;
		}
	}
}