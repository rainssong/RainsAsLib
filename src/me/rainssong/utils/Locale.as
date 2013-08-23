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
	import flash.system.Capabilities;
	import flash.utils.Dictionary;

	
	/**
	 * @private
	 */
	public final class Locale {
		
		/**
		 * <span lang="ja">日本語を示すストリングを取得します。</span>
		 * <span lang="en"></span>
		 */
		public static const JAPANESE:String = "ja";
		
		/**
		 * <span lang="ja">英語を示すストリングを取得します。</span>
		 * <span lang="en"></span>
		 */
		public static const ENGLISH:String = "en";
		
		/**
		 * <span lang="ja">フランス語を示すストリングを取得します。</span>
		 * <span lang="en"></span>
		 */
		public static const FRENCH:String = "fr";
		
		/**
		 * <span lang="ja">中国語を示すストリングを取得します。</span>
		 * <span lang="en"></span>
		 */
		public static const CHINESE:String = "zh-CN";
		
		/**
		 * <span lang="ja">登録されたメッセージが存在しない場合のデフォルトメッセージを取得します。</span>
		 * <span lang="en"></span>
		 */
		public static const NONE:String = "MESSAGE IS NOT REGISTERED.";
		
		
		
		
		
		/**
		 * <span lang="ja">現在設定されている言語を取得または設定します。
		 * デフォルト設定は、Flash Player が実行されているシステムの言語コードになります。</span>
		 * <span lang="en">Get or set the current language.
		 * The default setting will be same as System language code which executing the Flash Player.</span>
		 */
		public static function get language():String { return _language; }
		public static function set language( value:String ):void {
			switch ( value ) {
				case JAPANESE	:
				case ENGLISH	:
				case FRENCH		:
				case CHINESE	: { _language = value; break; }
				default			: { _language = ENGLISH; }
			}
		}
		private static var _language:String = ENGLISH;
		
		/**
		 * <span lang="ja">指定された言語に対応したストリングが存在しなかった場合に、代替言語として使用される言語を取得します。</span>
		 * <span lang="en"></span>
		 */
		public static function get defaultLanguage():String { return _defaultLanguage; }
		private static var _defaultLanguage:String = ENGLISH;
		
		/**
		 * ローカライズ用の文字列を保持した Dictionary インスタンスを取得します。
		 */
		private static var _messages:Dictionary = new Dictionary();
		
		
		
		
		
		/**
		 * 初期化する
		 */
		( function():void {
			// 初期言語を設定する
			language = Capabilities.language;
		} )();
		
		
		
		/**
		 * <span lang="ja">指定した id に関連付けられたストリングを現在設定されている言語表現で返します。</span>
		 * <span lang="en">Returns the string which relate to the specified id by the current language expression.</span>
		 * 
		 * @param id
		 * <span lang="ja">ストリングに関連付けられた識別子です。</span>
		 * <span lang="en">The identifier relates to the string.</span>
		 * @return
		 * <span lang="ja">関連付けられたストリングです。</span>
		 * <span lang="en">Related string.</span>
		 * 
		 * @see #getStringByLang()
		 * @see #setString()
		 * 
		 * @example <listing version="3.0">
		 * </listing>
		 */
		public static function getString( id:String ):String {
			return getStringByLang( id, _language );
		}
		
		/**
		 * <span lang="ja">指定した id と言語に関連付けられたストリングを返します。</span>
		 * <span lang="en">Returns the string which relates to the specified id and language.</span>
		 * 
		 * @param id
		 * <span lang="ja">ストリングに関連付けられた識別子です。</span>
		 * <span lang="en">The identifier relates to the string.</span>
		 * @param language
		 * <span lang="ja">ストリングに関連付けられた言語です。</span>
		 * <span lang="en">The language relates to the string.</span>
		 * @return
		 * <span lang="ja">関連付けられたストリングです。</span>
		 * <span lang="en">Related string.</span>
		 * 
		 * @see #getString()
		 * @see #setString()
		 * 
		 * @example <listing version="3.0">
		 * </listing>
		 */
		public static function getStringByLang( id:String, language:String = ""):String 
		{
			if (language == "") language = _language;
			var messages1:Dictionary = _messages[language];
			var messages2:Dictionary = _messages[_defaultLanguage];
			
			if ( !messages1 ) { return messages2[id] || NONE; }
			
			return messages1[id] || messages2[id] || NONE;
		}
		
		/**
		 * <span lang="ja">ストリングを指定した id と言語に関連付けます。</span>
		 * <span lang="en">Relate the specified string to the language.</span>
		 * 
		 * @param id
		 * <span lang="ja">ストリングに関連付ける識別子です。</span>
		 * <span lang="en">The identifier relates to the string.</span>
		 * @param language
		 * <span lang="ja">ストリングに関連付ける言語です。</span>
		 * <span lang="en">The language relates to the string.</span>
		 * @param value
		 * <span lang="ja">関連付けるストリングです。</span>
		 * <span lang="en">Related string.</span>
		 * 
		 * @see #getString()
		 * @see #getStringByLang()
		 * 
		 * @example <listing version="3.0">
		 * </listing>
		 */
		public static function setString( id:String, language:String, value:String ):void {
			// 初期化されていなければ初期化する
			_messages[language] ||= new Dictionary();
			
			// 設定する
			_messages[language][id] = value;
		}
	}
}
