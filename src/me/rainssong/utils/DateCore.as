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
package me.rainssong.utils {

	
	/**
	 * <span lang="ja">DateUtil クラスは、日付データ操作のためのユーティリティクラスです。</span>
	 * <span lang="en">The DateUtil class is an utility class for date data operation.</span>
	 */
	public final class DateUtil {
		
		/**
		 * <span lang="ja">1 ミリ秒をミリ秒単位で表した定数を取得します。</span>
		 * <span lang="en">Returns the fixed value which express the 1 millisecond by millisecond unit.</span>
		 */
		public static const ONE_MILLISECOND:int = 1;
		
		/**
		 * <span lang="ja">ミリ秒の最大値を表す定数を取得します。</span>
		 * <span lang="en">Returns the maximum value of the millisecond.</span>
		 */
		public static const MAX_MILLISECOND:int = 1000;
		
		/**
		 * <span lang="ja">1 秒をミリ秒単位で表した定数を取得します。</span>
		 * <span lang="en">Returns the fixed value of 1second by millisecond unit.</span>
		 */
		public static const ONE_SECOND:int = ONE_MILLISECOND * MAX_MILLISECOND;
		
		/**
		 * <span lang="ja">秒の最大値を表す定数を取得します。</span>
		 * <span lang="en">Returns the maximum value of the second.</span>
		 */
		public static const MAX_SECOND:int = 60;
		
		/**
		 * <span lang="ja">1 分をミリ秒単位で表した定数を取得します。</span>
		 * <span lang="en">Returns the fixed value of 1minuite by millisecond unit.</span>
		 */
		public static const ONE_MINUTE:int = ONE_SECOND * MAX_SECOND;
		
		/**
		 * <span lang="ja">分の最大値を表す定数を取得します。</span>
		 * <span lang="en">Returns the maximum value of the minuite.</span>
		 */
		public static const MAX_MINUTE:int = 60;
		
		/**
		 * <span lang="ja">1 時間をミリ秒単位で表した定数を取得します。</span>
		 * <span lang="en">Returns the fixed value of 1hour by millisecond unit.</span>
		 */
		public static const ONE_HOUR:int = ONE_MINUTE * MAX_MINUTE;
		
		/**
		 * <span lang="ja">時間の最大値を表す定数を取得します。</span>
		 * <span lang="en">Returns the maximum value of the hour.</span>
		 */
		public static const MAX_HOUR:int = 24;
		
		/**
		 * <span lang="ja">1 日をミリ秒単位で表した定数を取得します。</span>
		 * <span lang="en">Returns the fixed value of 1day by millisecond unit.</span>
		 */
		public static const ONE_DAY:int = ONE_HOUR * MAX_HOUR;
		
		/**
		 * @private
		 */
		static private const _MONTH_NAMES:Array = [ "January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December" ];
		
		/**
		 * @private
		 */
		static private const _DAY_NAMES:Array = [ "Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday" ];
		
		
		
		
	
		
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
		 * <span lang="ja"></span>
		 * <span lang="en"></span>
		 * 
		 * @param date
		 * <span lang="ja"></span>
		 * <span lang="en"></span>
		 * @param format
		 * <span lang="ja"></span>
		 * <span lang="en"></span>
		 * @return
		 * <span lang="ja"></span>
		 * <span lang="en"></span>
		 * 
		 * @example <listing version="3.0">
		 * </listing>
		 */
		public static function format( date:Date, str:String ):String {
			var _fullYear:int = date.getFullYear();
			var _month:int = date.getMonth();
			var _date:int = date.getDate();
			var _day:int = date.getDay();
			var _hour:int = date.getHours();
			var _hhour:int = _hour % 12;
			var _minutes:int = date.getMinutes();
			var _seconds:int = date.getSeconds();
			var _ampm:Boolean = ( _hour < 12 );
			
			str = str.replace( new RegExp( "%a", "g" ), _ampm ? "am" : "pm" );
			str = str.replace( new RegExp( "%A", "g" ), _ampm ? "AM" : "PM" );
			str = str.replace( new RegExp( "%d", "g" ), NumberUtil.digit( _date, 2 ) );
			str = str.replace( new RegExp( "%F", "g" ), _MONTH_NAMES[_month] );
			str = str.replace( new RegExp( "%h", "g" ), NumberUtil.digit( _hhour, 2 ) );
			str = str.replace( new RegExp( "%H", "g" ), NumberUtil.digit( _hour, 2 ) );
			str = str.replace( new RegExp( "%g", "g" ), _hhour.toString() );
			str = str.replace( new RegExp( "%G", "g" ), _hour.toString() );
			str = str.replace( new RegExp( "%i", "g" ), NumberUtil.digit( _minutes, 2 ) );
			str = str.replace( new RegExp( "%j", "g" ), _date.toString() );
			str = str.replace( new RegExp( "%l", "g" ), _DAY_NAMES[_day] );
			str = str.replace( new RegExp( "%m", "g" ), NumberUtil.digit( _month, 2 ) );
			str = str.replace( new RegExp( "%n", "g" ), _month.toString() );
			str = str.replace( new RegExp( "%s", "g" ), NumberUtil.digit( _seconds, 2 ) );
			str = str.replace( new RegExp( "%t", "g" ), getMaxDateLength( date ).toString() );
			str = str.replace( new RegExp( "%w", "g" ), _day.toString() );
			str = str.replace( new RegExp( "%y", "g" ), NumberUtil.digit( _fullYear, 2 ) );
			str = str.replace( new RegExp( "%Y", "g" ), _fullYear.toString() );
			
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
		public static function w3cdtfToDate( time:String ):Date {
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
	}
}
