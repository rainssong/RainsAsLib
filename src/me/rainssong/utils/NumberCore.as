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
	 * <span lang="ja">NumberUtil クラスは、数値操作のためのユーティリティクラスです。</span>
	 * <span lang="en">The NumberUtil class is an utility class for numeric operation.</span>
	 */
	public final class NumberUtil {
		
		
		/**
		 * <span lang="ja">数値を 1000 桁ごとにカンマをつけて返します。</span>
		 * <span lang="en">Returns the numerical value applying the comma every 1000 digits.</span>
		 * 
		 * @param number
		 * <span lang="ja">変換したい数値です。</span>
		 * <span lang="en">The numerical value to convert.</span>
		 * @param radix
		 * <span lang="ja">数値からストリングへの変換に使用する基数（2 ～ 36）を指定します。</span>
		 * <span lang="en">Specifies the numeric base (from 2 to 36) to use for the number-to-string conversion.</span>
		 * @return
		 * <span lang="ja">変換後の数値です。</span>
		 * <span lang="en">The converted numerical value.</span>
		 * 
		 * @example <listing version="3.0">
		 * </listing>
		 */
		public static function format( number:Number, radix:Number = 10 ):String {
			var words:Array = number.toString( radix ).split( "" );
			var minus:Boolean = ( words[0] == "-" );
			
			if ( minus ) {
				words.shift();
			}
			
			words.reverse();
			
			for ( var i:int = 3, l:int = words.length; i < l; i += 3 ) {
				if ( words[i] ) {
					words.splice( i, 0, "," );
					i++;
					l++;
				}
			}
			
			if ( minus ) {
				words.push( "-" );
			}
			
			return words.reverse().join( "" );
		}
		
		/**
		 * <span lang="ja">数値の桁数を 0 で揃えて返します。</span>
		 * <span lang="en">Arrange the digit of numerical value by 0.</span>
		 * 
		 * @param number
		 * <span lang="ja">変換したい数値です。</span>
		 * <span lang="en">The numerical value to convert.</span>
		 * @param figure
		 * <span lang="ja">揃えたい桁数です。</span>
		 * <span lang="en">The number of digit to arrange.</span>
		 * @param radix
		 * <span lang="ja">数値からストリングへの変換に使用する基数（2 ～ 36）を指定します。</span>
		 * <span lang="en">Specifies the numeric base (from 2 to 36) to use for the number-to-string conversion.</span>
		 * @return
		 * <span lang="ja">変換後の数値です。</span>
		 * <span lang="en">The converted numerical value.</span>
		 * 
		 * @example <listing version="3.0">
		 * </listing>
		 */
		public static function digit( number:Number, figure:int, radix:Number = 10 ):String {
			var str:String = number.toString( radix );
			
			for ( var i:int =str.length; i < figure; i++ ) {
				str = "0" + str;
			}
			
			return str.substr( - figure );
		}
	}
}
