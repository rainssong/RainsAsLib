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
	 * <span lang="ja">URLCore クラスは、URL 操作のためのユーティリティクラスです。</span>
	 * <span lang="en">The URLCore class is an utility class for URL operation.</span>
	 */
	public final class URLCore {
		
		/**
		 * ウィンドウズ上のかどうかを判別する正規表現を取得します。
		 */
		private static const _WINDOWS_LOCAL_REGEXP:String = "^file://([a-z]):\\\\";
		
		/**
		 * 絶対パスかどうかを判別する正規表現を取得します。
		 */
		private static const _ABSOLUTE_PATH_REGEXP:String = "^(http://|https://|file://)";
		
		

		
		/**
		 * <span lang="ja">指定された URL を file プロトコルを使用した書式に整形します。</span>
		 * <span lang="en"></span>
		 * 
		 * @param url
		 * <span lang="ja">整形したい URL です。</span>
		 * <span lang="en"></span>
		 * @return
		 * <span lang="ja">整形後の URL です。</span>
		 * <span lang="en"></span>
		 * 
		 * @example <listing version="3.0">
		 * </listing>
		 */
		public static function normalize( url:String ):String {
			if ( new RegExp( _WINDOWS_LOCAL_REGEXP, "gi" ).test( url ) ) {
				url = url.replace( new RegExp( _WINDOWS_LOCAL_REGEXP, "gi" ), "file:///$1:/" );
				url = url.split( "\\" ).join( "/" );
			}
			
			return url;
		}
		
		/**
		 * <span lang="ja">URL からファイル名を抽出して返します。</span>
		 * <span lang="en"></span>
		 * 
		 * @param url
		 * <span lang="ja">ファイル名を抽出したい URL を示すストリングです。</span>
		 * <span lang="en"></span>
		 * @return
		 * <span lang="ja">抽出されたストリングです。</span>
		 * <span lang="en"></span>
		 * 
		 * @example <listing version="3.0">
		 * </listing>
		 */
		public static function getFileName( url:String ):String {
			var fileName:String = normalize( url ).split( "/" ).pop();
			
			if ( !fileName ) { return ""; }
			
			var segments:Array = fileName.split( "." );
			
			return segments.slice( 0, Math.max( 1, segments.length - 1 ) ).join( "." );
		}
		
		/**
		 * <span lang="ja">URL からファイルの拡張子名を抽出して返します。</span>
		 * <span lang="en"></span>
		 * 
		 * @param url
		 * <span lang="ja">ファイルの拡張子名を抽出したい URL を示すストリングです。</span>
		 * <span lang="en"></span>
		 * @return
		 * <span lang="ja">抽出されたストリングです。</span>
		 * <span lang="en"></span>
		 * 
		 * @example <listing version="3.0">
		 * </listing>
		 */
		public static function getExtension( url:String ):String {
			var fileName:String = normalize( url ).split( "/" ).pop();
			
			if ( !fileName ) { return ""; }
			
			var segments:Array = fileName.split( "." );
			
			if ( segments.length < 2 ) { return ""; }
			
			return segments.reverse()[0];
		}
		
		/**
		 * <span lang="ja">URL からフォルダまでのパスのみを抽出して返します。</span>
		 * <span lang="en"></span>
		 * 
		 * @param url
		 * <span lang="ja">パスを抽出したい URL を示すストリングです。</span>
		 * <span lang="en"></span>
		 * @return
		 * <span lang="ja">抽出されたストリングです。</span>
		 * <span lang="en"></span>
		 * 
		 * @example <listing version="3.0">
		 * </listing>
		 */
		public static function getFolderPath( url:String ):String {
			// パスを分解する
			var path:Array = normalize( url ).split( "/" );
			
			// すでにフォルダを指していればそのまま返す
			if ( path[path.length -1] == "" ) { return url; }
			
			return path.slice( 0, -1 ).join( "/" ) + "/";
		}
		
		/**
		 * <span lang="ja">URL を絶対パスに変換します。</span>
		 * <span lang="en"></span>
		 * 
		 * @param url
		 * <span lang="ja">変換したい URL を示すストリングです。</span>
		 * <span lang="en"></span>
		 * @param baseUrl
		 * <span lang="ja">基準として使用する URL を示すストリングです。</span>
		 * <span lang="en"></span>
		 * @return
		 * <span lang="ja">変換後の URL を示すストリングです。</span>
		 * <span lang="en"></span>
		 * 
		 * @example <listing version="3.0">
		 * </listing>
		 */
		public static function getAbsolutePath( url:String, baseUrl:String ):String {
			// すでに絶対パスであればそのまま返す
			if ( new RegExp( _ABSOLUTE_PATH_REGEXP, "gi" ).test( url ) ) { return url; }
			return getFolderPath( baseUrl ) + url;
		}
	}
}
