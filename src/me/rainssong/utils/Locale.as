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
package me.rainssong.utils
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.system.Capabilities;
	import flash.utils.Dictionary;
	
	/**
	 * @private
	 */
	public final class Locale extends EventDispatcher
	{
		
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
		public static const CHINESE_TRADITIONAL:String = "zh-TW";
		
		/**
		 * <span lang="ja">登録されたメッセージが存在しない場合のデフォルトメッセージを取得します。</span>
		 * <span lang="en"></span>
		 */
		public static const NONE:String = "MESSAGE IS NOT REGISTERED.";
		
		public function get language():String
		{
			if (_language == null)
				return Capabilities.language;
			
			return _language;
		
		}
		
		public function set language(value:String):void
		{
			if (value != _language)
			{
				_language = value;
				dispatchEvent(new Event(Event.CHANGE));
			}
			
		}
		
		private static var _language:String = null;
		
		/**
		 * <span lang="ja">指定された言語に対応したストリングが存在しなかった場合に、代替言語として使用される言語を取得します。</span>
		 * <span lang="en"></span>
		 */
		public static function get defaultLanguage():String
		{
			return _defaultLanguage;
		}
		
		private static var _defaultLanguage:String = ENGLISH;
		
		/**
		 * ローカライズ用の文字列を保持した Dictionary インスタンスを取得します。
		 */
		private var _messages:Object = new Object();
		
		public function getString(id:String):String
		{
			if (_messages[id] != null)
				return _messages[id];
			else
				return id;
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
		//public static function getStringByLang( id:String, language:String = ""):String 
		//{
		//if (language == "") language = _language;
		//var messages1:Dictionary = _messages[language];
		//var messages2:Dictionary = _messages[_defaultLanguage];
		//
		//if ( !messages1 ) { return messages2[id] || NONE; }
		//
		//return messages1[id] || messages2[id] || NONE;
		//}
		
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
		//public static function setString( id:String, language:String, value:String ):void {
		//// 初期化されていなければ初期化する
		//_messages[language] ||= new Dictionary();
		//
		//// 設定する
		//_messages[language][id] = value;
		//}
		
		public function get messages():Object
		{
			return _messages;
		}
		
		public function set messages(value:Object):void
		{
			_messages = value;
		}
	}
}
