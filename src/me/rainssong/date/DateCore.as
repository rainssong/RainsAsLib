/**
 * jp.nium Classes
 * 
 * @author Copyright (C) 2007-2010 taka:nium.jp, All Rights Reserved.
 * @version 4.0.22
 * @see http://classes.nium.jp/
 * 
 * jp.nium Classes is released under the MIT License:
 * http://www.opensource.org/licenses/mit-license.php
 */
package me.rainssong.date 
{
	import me.rainssong.utils.NumberCore;

	
	/**
	 * <span lang="ja">DateCore クラスは、日付データ操作のためのユーティリティクラスです。</span>
	 * <span lang="en">The DateCore class is an utility class for date data operation.</span>
	 */
	public final class DateCore {
		
		public static const ONE_MILLISECOND:int = 1;
		
		public static const MAX_MILLISECOND:int = 1000;
		
		public static const ONE_SECOND:int = ONE_MILLISECOND * MAX_MILLISECOND;
		
		public static const MAX_SECOND:int = 60;
		
		public static const ONE_MINUTE:int = ONE_SECOND * MAX_SECOND;
		
		public static const MAX_MINUTE:int = 60;
		
		public static const ONE_HOUR:int = ONE_MINUTE * MAX_MINUTE;
		
		public static const MAX_HOUR:int = 24;
		
		public static const ONE_DAY:int = ONE_HOUR * MAX_HOUR;
		
		
		static private const _MONTH_NAMES:Array = [ "January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December" ];
		
		static private const _DAY_NAMES:Array = [ "Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday" ];
		
		
		public static const DAY_NAMES:Array = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"];
		public static const DAYS_ABBREVIATED_NAMES:Array = ["Sun", "Mon", "Tues", "Wed", "Thurs", "Fri", "Sat"];
  		public static const MONTHS_NAMES:Array = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"];
		public static const MONTHS_ABBREVIATED_NAMES:Array = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"];
  		public static const DAYSINMONTH:Array = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];
		
	
		
		/**
		 * <span lang="ja">対象の月の最大日数を返します。</span>
		 * <span lang="en">Returns the maximum day of the month.</span>
		 * 
		 * @param date
		 * <span lang="ja">最大日数を取得したい Date インスタンスです。</span>
		 * <span lang="en">The date istance to get the maximum day.</span>
		 * @return
		 * <span lang="ja">最大日数です。</span>
		 * <span lang="en">The maximum day.</span>
		 * 
		 * @example <listing version="3.0">
		 * </listing>
		 */
		public static function getMaxDateLength( date:Date ):int {
			var newDate:Date = new Date( date );
			newDate.setMonth( date.getMonth() + 1 );
			newDate.setDate( 0 );
			return newDate.getDate();
		}
		
		/**
		 * @param date
		 * @param format
		 * @return
		 * @example <listing version="3.0">
		 */
		public static function format( date:Date, str:String="%Y-%M2-%D2 %h2:%m2:%s2" ):String {
			var _fullYear:int = date.getFullYear();
			var _month:int = date.getMonth();
			var _date:int = date.getDate();
			var _day:int = date.getDay();
			var _hour:int = date.getHours();
			var _hhour:int = _hour % 12;
			var _minutes:int = date.getMinutes();
			var _seconds:int = date.getSeconds();
			var _ampm:Boolean = ( _hour < 12 );
			
			str = str.replace( new RegExp( "%ampm", "g" ), _ampm ? "am" : "pm" );
			str = str.replace( new RegExp( "%AMPM", "g" ), _ampm ? "AM" : "PM" );
			str = str.replace( new RegExp( "%D2", "g" ), NumberCore.digit( _date, 2 ) );
			str = str.replace( new RegExp( "%D", "g" ), _date.toString() );
			str = str.replace( new RegExp( "%Mn", "g" ), _MONTH_NAMES[_month] );
			str = str.replace( new RegExp( "%M2", "g" ), NumberCore.digit( _month+1, 2 ) );
			str = str.replace( new RegExp( "%M", "g" ), _month.toString() );
			str = str.replace( new RegExp( "%Y2", "g" ), NumberCore.digit( _fullYear, 2 ) );
			str = str.replace( new RegExp( "%Y", "g" ), _fullYear.toString() );
			str = str.replace( new RegExp( "%hh2", "g" ), NumberCore.digit( _hhour, 2 ) );
			str = str.replace( new RegExp( "%h2", "g" ), NumberCore.digit( _hour, 2 ) );
			str = str.replace( new RegExp( "%hh", "g" ), _hhour.toString() );
			str = str.replace( new RegExp( "%h", "g" ), _hour.toString() );
			str = str.replace( new RegExp( "%m2", "g" ), NumberCore.digit( _minutes, 2 ) );
			str = str.replace( new RegExp( "%m", "g" ), _minutes.toString() );
			
			str = str.replace( new RegExp( "%s2", "g" ), NumberCore.digit( _seconds, 2 ) );
			str = str.replace( new RegExp( "%s", "g" ), _seconds.toString());
			
			str = str.replace( new RegExp( "%md", "g" ), getMaxDateLength( date ).toString() );
			str = str.replace( new RegExp( "%day", "g" ), _day.toString() );
			str = str.replace( new RegExp( "%DN", "g" ), _DAY_NAMES[_day] );
			
			return str;
		}
		
		/**
		 * <span lang="ja">W3CDTF 形式のストリングから Date インスタンスを生成して返します。</span>
		 * <span lang="en"></span>
		 * 
		 * @param date
		 * <span lang="en">W3CDTF 形式のストリングです。</span>
		 * <span lang="en"></span>
		 * @return
		 * <span lang="ja">生成された Date インスタンスです。</span>
		 * <span lang="en"></span>
		 * 
		 * @example <listing version="3.0">
		 * </listing>
		 */
		public static function praseW3CDTF( time:String ):Date 
		{
			var results:Array = new RegExp( "^(\\d{4})-(\\d{2})-(\\d{2})T(\\d{2}):(\\d{2}):(\\d{2})Z$", "g" ).exec( time ) || [];
			
			var date:Date = new Date();
			date.fullYear = parseInt( results[1] );
			date.month = parseInt( results[2] ) - 1;
			date.date = parseInt( results[3] );
			date.hours = parseInt( results[4] );
			date.minutes = parseInt( results[5] );
			date.seconds = parseInt( results[6] );
			
			return date;
		}
		
		public static function toW3CDTF(d:Date,includeMilliseconds:Boolean=false):String
		{
			var date:Number = d.getUTCDate();
			var month:Number = d.getUTCMonth();
			var hours:Number = d.getUTCHours();
			var minutes:Number = d.getUTCMinutes();
			var seconds:Number = d.getUTCSeconds();
			var milliseconds:Number = d.getUTCMilliseconds();
			var sb:String = new String();
			
			sb += d.getUTCFullYear();
			sb += "-";
			
			//thanks to "dom" who sent in a fix for the line below
			if (month + 1 < 10)
			{
				sb += "0";
			}
			sb += month + 1;
			sb += "-";
			if (date < 10)
			{
				sb += "0";
			}
			sb += date;
			sb += "T";
			if (hours < 10)
			{
				sb += "0";
			}
			sb += hours;
			sb += ":";
			if (minutes < 10)
			{
				sb += "0";
			}
			sb += minutes;
			sb += ":";
			if (seconds < 10)
			{
				sb += "0";
			}
			sb += seconds;
			if (includeMilliseconds && milliseconds > 0)
			{
				sb += ".";
				sb += milliseconds;
			}
			sb += "-00:00";
			return sb;
		}
	}
}
