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
package jp.nium.utils {
	import flash.display.FrameLabel;
	import flash.display.MovieClip;
	import flash.display.Scene;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import jp.nium.core.debug.Logger;
	import jp.nium.core.L10N.L10NNiumMsg;
	
	/**
	 * <span lang="ja">MovieClipUtil クラスは、MovieClip 操作のためのユーティリティクラスです。</span>
	 * <span lang="en">The MovieClipUtil class is an utility class for MovieClip operation.</span>
	 */
	public final class MovieClipUtil {
		
		/**
		 * 汎用的な MovieClip インスタンスを取得します。
		 */
		private static var _movieClip:MovieClip = new MovieClip();
		
		
		
		
		
		/**
		 * @private
		 */
		public function MovieClipUtil() {
			throw new Error( Logger.getLog( L10NNiumMsg.getInstance().ERROR_010 ).toString( ClassUtil.getClassName( this ) ) );
		}
		
		
		
		
		
		/**
		 * <span lang="ja">MovieClip インスタンスの指定されたフレームラベルからフレーム番号を保持した配列を取得します。</span>
		 * <span lang="en">Get the array which contains the frame number that specified by frame label of the MovieClip instance.</span>
		 * 
		 * @param movie
		 * <span lang="ja">フレーム番号を取得したい MovieClip インスタンスです。</span>
		 * <span lang="en">The MovieClip instance to get the frame number.</span>
		 * @param labelName
		 * <span lang="ja">フレームラベルです。</span>
		 * <span lang="en">The frame label.</span>
		 * @return
		 * <span lang="ja">フレーム番号です。</span>
		 * <span lang="en">The frame number.</span>
		 * 
		 * @example <listing version="3.0">
		 * </listing>
		 */
		public static function labelToFrames( movie:MovieClip, labelName:String ):Array {
			var list:Array = [];
			
			// FrameLabel を走査する
			var labels:Array = _getFrameLabels( movie );
			for ( var i:int = 0, l:int = labels.length; i < l; i++ ) {
				// 参照を取得する
				var frameLabel:FrameLabel = FrameLabel( labels[i] );
				
				// 条件と一致すれば返す
				if ( labelName == frameLabel.name ) { list.push( frameLabel.frame ); }
			}
			
			return list;
		}
		
		/**
		 * <span lang="ja">MovieClip インスタンスの指定されたフレーム番号からフレームラベルを保持した配列を取得します。</span>
		 * <span lang="en">Get the array which contains the frame label that specified by frame number of the MovieClip instance.</span>
		 * 
		 * @param movie
		 * <span lang="ja">フレームラベルを取得したい MovieClip インスタンスです。</span>
		 * <span lang="en">The MovieClip instance to get the frame number.</span>
		 * @param labelName
		 * <span lang="ja">フレーム番号です。</span>
		 * <span lang="en">The frame number.</span>
		 * @return
		 * <span lang="ja">フレームラベルです。</span>
		 * <span lang="en">The frame label.</span>
		 * 
		 * @example <listing version="3.0">
		 * </listing>
		 */
		public static function frameToLabels( movie:MovieClip, frame:int ):Array {
			var list:Array = [];
			
			// FrameLabel を走査する
			var labels:Array = _getFrameLabels( movie );
			for ( var i:int = 0, l:int = labels.length; i < l; i++ ) {
				// 参照を取得する
				var frameLabel:FrameLabel = FrameLabel( labels[i] );
				
				// 条件と一致すれば返す
				if ( frame == frameLabel.frame ) { list.push( frameLabel.name ); }
			}
			
			return list;
		}
		
		/**
		 * <span lang="ja">指定された 2 点間のフレーム差を取得します。</span>
		 * <span lang="en">Get the frame difference of specified two points.</span>
		 * 
		 * @param movie
		 * <span lang="ja">対象の MovieClip インスタンスです。</span>
		 * <span lang="en">The MovieClip instance to process.</span>
		 * @param frame1
		 * <span lang="ja">最初のフレーム位置です。</span>
		 * <span lang="en">The position of the first frame.</span>
		 * @param frame2
		 * <span lang="ja">2 番目のフレーム位置です。</span>
		 * <span lang="en">The position of the second frame.</span>
		 * @return
		 * <span lang="ja">フレーム差です。</span>
		 * <span lang="en">The frame difference.</span>
		 * 
		 * @example <listing version="3.0">
		 * </listing>
		 */
		public static function getDistanceFrames( movie:MovieClip, frame1:*, frame2:* ):int {
			var s:int = _getFrame( movie, frame1 );
			var e:int = _getFrame( movie, frame2 );
			
			return Math.abs( e - s );
		}
		
		/**
		 * <span lang="ja">指定されて 2 点間に再生ヘッドが存在しているかどうかを取得します。</span>
		 * <span lang="en">Returns if the playback head exists between the specified two points.</span>
		 * 
		 * @param movie
		 * <span lang="ja">対象の MovieClip インスタンスです。</span>
		 * <span lang="en">The MovieClip instance to process.</span>
		 * @param frame1
		 * <span lang="ja">最初のフレーム位置です。</span>
		 * <span lang="en">The position of the first frame.</span>
		 * @param frame2
		 * <span lang="ja">2 番目のフレーム位置です。</span>
		 * <span lang="en">The position of the second frame.</span>
		 * @return
		 * <span lang="ja">存在していれば true 、なければ false です。</span>
		 * <span lang="en">Returns true if exists, otherwise return false.</span>
		 * 
		 * @example <listing version="3.0">
		 * </listing>
		 */
		public static function playheadWithinFrames( movie:MovieClip, frame1:*, frame2:* ):Boolean {
			var s:int = _getFrame( movie, frame1 );
			var e:int = _getFrame( movie, frame2 );
			var c:int = movie.currentFrame;
			
			// s の方が e よりも大きい場合に入れ替える
			if ( s > e ) {
				var temp:int = s;
				s = e;
				e = temp;
			}
			
			return ( s <= c && c <= e );
		}
		
		/**
		 * <span lang="ja">指定したフレームが存在しているかどうかを返します。</span>
		 * <span lang="en">Returns if the specified frame exists.</span>
		 * 
		 * @param movie
		 * <span lang="ja">対象の MovieClip インスタンスです。</span>
		 * <span lang="en">The MovieClip instance to process.</span>
		 * @param labelName
		 * <span lang="ja">存在を確認するフレームです。</span>
		 * <span lang="en">The frame to check if exists.</span>
		 * @return
		 * <span lang="ja">存在していれば true 、なければ false です。</span>
		 * <span lang="en">Returns true if exists, otherwise return false.</span>
		 * 
		 * @example <listing version="3.0">
		 * </listing>
		 */
		public static function hasFrame( movie:MovieClip, frame:* ):Boolean {
			var frameNum:int = _getFrame( movie, frame );
			return ( 0 < frameNum && frameNum <= movie.totalFrames );
		}
		
		/**
		 * 対象の MovieClip インスタンスに存在するフレームラベルを保持した配列を返します。
		 */
		private static function _getFrameLabels( movie:MovieClip ):Array {
			var list:Array = [];
			
			// Scene を取得する
			var scenes:Array = movie.scenes;
			for ( var i:int = 0, l:int = scenes.length; i < l; i++ ) {
				// 参照を取得する
				var scene:Scene = Scene( scenes[i] );
				var labels:Array = scene.labels;
				
				// FrameLabel を取得する
				for ( var ii:int = 0, ll:int = labels.length; ii < ll; ii++ ) {
					list.push( labels[ii] );
				}
			}
			
			return list;
		}
		
		/**
		 * 対象の MovieClip に存在する指定された位置のフレーム番号を返します。
		 */
		private static function _getFrame( movie:MovieClip, frame:* ):int {
			switch ( true ) {
				case frame is String	: { return labelToFrames( movie, frame )[0]; }
				case frame is int		: { return frame; }
			}
			return -1;
		}
		
		/**
		 * <span lang="ja">指定された関数を 1 フレーム経過後に実行します。</span>
		 * <span lang="en">Execute the specified function, 1 frame later.</span>
		 * 
		 * @param scope
		 * <span lang="ja">関数が実行される際のスコープです。</span>
		 * <span lang="en">The scope when the function executes.</span>
		 * @param callBack
		 * <span lang="ja">実行したい関数です。</span>
		 * <span lang="en">The function to execute.</span>
		 * @param args
		 * <span lang="ja">関数の実行時の引数です。</span>
		 * <span lang="en">The argument of the function when executes.</span>
		 * 
		 * @example <listing version="3.0">
		 * </listing>
		 */
		public static function doLater( scope:*, callBack:Function, ... args:Array ):void {
			var timer:Timer = new Timer( 1, 1 );
			timer.addEventListener( TimerEvent.TIMER_COMPLETE, function( e:TimerEvent ):void {
				// イベントリスナーを解除する
				Timer( e.target ).removeEventListener( e.type, arguments.callee );
				
				// コールバック関数を実行する
				callBack.apply( scope, args );
			} );
			timer.start();
		}
		
		/**
		 * <span lang="ja">Event.ENTER_FRAME のイベントに対してリスナーを登録します。</span>
		 * <span lang="en"></span>
		 * 
		 * @param listener
		 * <span lang="ja">イベントを処理するリスナー関数です。この関数は Event インスタンスを唯一のパラメータとして受け取り、何も返さないものである必要があります。関数は任意の名前を持つことができます。</span>
		 * <span lang="en">The listener function that processes the event. This function must accept an Event object as its only parameter and must return nothing. The function can have any name.</span>
		 * @param useCapture
		 * <span lang="ja">リスナーが、キャプチャ段階、またはターゲットおよびバブリング段階で動作するかどうかを判断します。useCapture を true に設定すると、リスナーはキャプチャ段階のみでイベントを処理し、ターゲット段階またはバブリング段階では処理しません。useCapture を false に設定すると、リスナーはターゲット段階またはバブリング段階のみでイベントを処理します。3 つの段階すべてでイベントを受け取るには、addEventListener を 2 回呼び出します。useCapture を true に設定して 1 度呼び出し、useCapture を false に設定してもう一度呼び出します。</span>
		 * <span lang="en">Determines whether the listener works in the capture phase or the target and bubbling phases. If useCapture is set to true, the listener processes the event only during the capture phase and not in the target or bubbling phase. If useCapture is false, the listener processes the event only during the target or bubbling phase. To listen for the event in all three phases, call addEventListener twice, once with useCapture set to true, then again with useCapture set to false.</span>
		 * @param priority
		 * <span lang="ja">イベントリスナーの優先度レベルです。優先度は、符号付き 32 ビット整数で指定します。数値が大きくなるほど優先度が高くなります。優先度が n のすべてのリスナーは、優先度が n -1 のリスナーよりも前に処理されます。複数のリスナーに対して同じ優先度が設定されている場合、それらは追加された順番に処理されます。デフォルトの優先度は 0 です。</span>
		 * <span lang="en">The priority level of the event listener. The priority is designated by a signed 32-bit integer. The higher the number, the higher the priority. All listeners with priority n are processed before listeners of priority n-1. If two or more listeners share the same priority, they are processed in the order in which they were added. The default priority is 0.</span>
		 * @param useWeakReference
		 * <span lang="ja">リスナーへの参照が強参照と弱参照のいずれであるかを判断します。デフォルトである強参照の場合は、リスナーのガベージコレクションが回避されます。弱参照では回避されません。</span>
		 * <span lang="en">Determines whether the reference to the listener is strong or weak. A strong reference (the default) prevents your listener from being garbage-collected. A weak reference does not.</span>
		 * 
		 * @example <listing version="3.0">
		 * </listing>
		 */
		public static function addEnterFrameListener( listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false ):void {
			_movieClip.addEventListener( Event.ENTER_FRAME, listener, useCapture, priority, useWeakReference );
		}
		
		/**
		 * <span lang="ja">Event.ENTER_FRAME のイベントに対して登録したリスナーを解除します。</span>
		 * <span lang="en"></span>
		 * 
		 * @param listener
		 * <span lang="ja">削除するリスナーオブジェクトです。</span>
		 * <span lang="en">The listener object to remove.</span>
		 * @param useCapture
		 * <span lang="ja">リスナーが、キャプチャ段階、またはターゲットおよびバブリング段階に対して登録されたかどうかを示します。リスナーがキャプチャ段階だけでなくターゲット段階とバブリング段階にも登録されている場合は、removeEventListener() を 2 回呼び出して両方のリスナーを削除する必要があります。1 回は useCapture() を true に設定し、もう 1 回は useCapture() を false に設定する必要があります。</span>
		 * <span lang="en">Specifies whether the listener was registered for the capture phase or the target and bubbling phases. If the listener was registered for both the capture phase and the target and bubbling phases, two calls to removeEventListener() are required to remove both, one call with useCapture() set to true, and another call with useCapture() set to false.</span>
		 * 
		 * @example <listing version="3.0">
		 * </listing>
		 */
		public static function removeEnterFrameListener( listener:Function, useCapture:Boolean = false ):void {
			_movieClip.removeEventListener( Event.ENTER_FRAME, listener, useCapture );
		}
	}
}
