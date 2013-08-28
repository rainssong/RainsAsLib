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
package me.rainssong.model {
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.utils.describeType;
	import flash.utils.Dictionary;
	import flash.utils.flash_proxy;
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;
	import flash.utils.Proxy;
	import jp.nium.core.debug.Logger;
	import jp.nium.core.L10N.L10NNiumMsg;
	import jp.nium.core.ns.nium_internal;
	import jp.nium.core.primitives.StringObject;
	import jp.nium.events.ModelEvent;
	import jp.nium.utils.ArrayUtil;
	import jp.nium.utils.ClassUtil;
	import jp.nium.utils.ObjectUtil;
	import jp.nium.utils.StringUtil;
	/**
	 * <span lang="ja">モデルオブジェクトがモデルリストに追加されたときに送出されます。</span>
	 * <span lang="en"></span>
	 * 
	 * @eventType jp.nium.events.ModelEvent.MODEL_ADDED
	 */
	[Event( name="modelAdded", type="jp.nium.events.ModelEvent" )]
	
	/**
	 * <span lang="ja">モデルオブジェクトがモデルリストから削除されようとしているときに送出されます。</span>
	 * <span lang="en"></span>
	 * 
	 * @eventType jp.nium.events.ModelEvent.MODEL_REMOVED
	 */
	[Event( name="modelRemoved", type="jp.nium.events.ModelEvent" )]
	
	/**
	 * <span lang="ja">モデルオブジェクトが管理する値が更新される直前に送出されます。</span>
	 * <span lang="en"></span>
	 * 
	 * @eventType jp.nium.events.ModelEvent.MODEL_UPDATE_BEFORE
	 */
	[Event( name="modelUpdateBefore", type="jp.nium.events.ModelEvent" )]
	
	/**
	 * <span lang="ja">モデルオブジェクトが管理する値の更新に成功した場合に送出されます。</span>
	 * <span lang="en"></span>
	 * 
	 * @eventType jp.nium.events.ModelEvent.MODEL_UPDATE_SUCCESS
	 */
	[Event( name="modelUpdateSuccess", type="jp.nium.events.ModelEvent" )]
	
	/**
	 * <span lang="ja">モデルオブジェクトが管理する値の更新に失敗した場合に送出されます。</span>
	 * <span lang="en"></span>
	 * 
	 * @eventType jp.nium.events.ModelEvent.MODEL_UPDATE_FAILURE
	 */
	[Event( name="modelUpdateFailure", type="jp.nium.events.ModelEvent" )]
	
	/**
	 * <span lang="ja">Model クラスは、データの状態を管理し、データ構造の入出力をサポートするモデルクラスです。</span>
	 * <span lang="en"></span>
	 * 
	 * @example <listing version="3.0">
	 * </listing>
	 */
	public dynamic class Model extends Proxy implements IEventDispatcher {
		
		/**
		 * 
		 */
		public static const TYPE_NODE:String = "node";
		
		/**
		 * 
		 */
		public static const TYPE_ATTRIBUTE:String = "attribute";
		
		
		
		
		
		/**
		 * インスタンスのクラス名を含む StringObject インスタンスを取得します。
		 */
		private var _classNameObj:StringObject;
		
		/**
		 * モデル名を取得します。
		 */
		private var _name:String;
		
		/**
		 * モデルが保持するデータを保持するオブジェクトを取得します。
		 */
		private var _data:Object;
		
		/**
		 * データ名毎のフォーマットを保持するオブジェクトを取得します。
		 */
		private var _dataTypes:Object;
		
		/**
		 * 
		 */
		private var _defaultDataType:String = Model.TYPE_ATTRIBUTE;
		
		/**
		 * 列挙しないデータ名を保持するオブジェクトを取得します。
		 */
		private var _preventEnumeratables:Object;
		
		/**
		 * EventDispatcher インスタンスを取得します。
		 */
		private var _dispatcher:EventDispatcher;
		
		/**
		 * 親モデルの参照を取得します。
		 */
		private var _parent:Model;
		
		
		
		
		
		/**
		 * <span lang="ja">新しい Model インスタンスを作成します。</span>
		 * <span lang="en">Creates a new Model object.</span>
		 * 
		 * @param name
		 * <span lang="ja">モデル名です。</span>
		 * <span lang="en"></span>
		 * @param xml
		 * <span lang="ja">モデルデータとなる XML インスタンスです。</span>
		 * <span lang="en"></span>
		 */
		public function Model( name:String, xml:XML = null ) {
			// クラスをコンパイルに含める
			nium_internal;
			
			// クラス名を取得する
			_classNameObj = ClassUtil.nium_internal::$getClassString( this );
			
			// 引数を設定する
			_name = name;
			xml ||= new XML();
			
			// 初期化する
			_data = {};
			_dataTypes = {};
			_preventEnumeratables = {};
			
			// EventDispatcher を作成する
			_dispatcher = new EventDispatcher( this );
			
			// 親クラスを初期化する
			super();
			
			// 継承せずにインスタンスを生成しようとしたら例外をスローする
			if ( Object( this ).constructor == Model ) { throw new Error( Logger.getLog( L10NNiumMsg.getInstance().ERROR_010 ).toString( _classNameObj.toString() ) ); }
			
			// フィールドを取得する
			var describe:XML = describeType( this );
			for each ( var accessor:XML in describe.accessor ) {
				var accName:String = String( accessor.@name );
				var accAccess:String = String( accessor.@access );
				
				switch ( accAccess ) {
					case "readonly"		:
					case "readwrite"	: { _data[accName] = undefined; break; }
					case "writeonly"	: { break; }
				}
			}
			
			// データをパースする
			parse( xml );
		}
		
		
		
		
		
		/**
		 * <span lang="ja">渡された XML インスタンスに設定されているデータをモデルに対して割り当てます。</span>
		 * <span lang="en"></span>
		 * 
		 * @param xml
		 * <span lang="ja">パースしたい XML インスタンスです。</span>
		 * <span lang="en"></span>
		 */
		public function parse( xml:XML ):void {
			if ( xml ) {
				if ( xml.name() != _name ) { return; }
				
				for each ( var attribute:XML in xml.attributes() ) {
					var name:String = attribute.name();
					var dataType:String = _dataTypes[name] || _defaultDataType;
					
					switch ( dataType ) {
						case TYPE_NODE			: { break; }
						case TYPE_ATTRIBUTE		:
						default					: { flash_proxy::setProperty( name, StringUtil.toProperType( attribute ) ); }
					}
				}
				
				for each ( var node:XML in xml.* ) {
					name = node.name();
					dataType = _dataTypes[name] || _defaultDataType;
					
					switch ( dataType ) {
						case TYPE_NODE			: { flash_proxy::setProperty( name, StringUtil.toProperType( node.*.toXMLString() ) ); break; }
						case TYPE_ATTRIBUTE		:
						default					: {}
					}
				}
			}
		}
		
		/**
		 * <span lang="ja">Model インスタンスのコピーを作成して、各プロパティの値を元のプロパティの値と一致するように設定します。</span>
		 * <span lang="en">Duplicates an instance of an Model subclass.</span>
		 * 
		 * @return
		 * <span lang="ja">元のオブジェクトと同じプロパティ値を含む新しい Model インスタンスです。</span>
		 * <span lang="en">A new Model object that is identical to the original.</span>
		 */
		public function clone():Model {
			var cls:Class = getDefinitionByName( getQualifiedClassName( this ) ) as Class;
			
			try {
				var model:Model = new cls() as Model;
				
				model._name = _name;
				
				for ( var p:String in _data ) {
					model._data[p] = _data[p];
				}
				
				for ( p in _dataTypes ) {
					model._dataTypes[p] = _dataTypes[p];
				}
				
				for ( p in _preventEnumeratables ) {
					model._preventEnumeratables[p] = _preventEnumeratables[p];
				}
				
				return model;
			}
			catch ( err:Error ) {}
			
			return new Model( _name, toXML() );
		}
		
		/**
		 * <span lang="ja">指定されたオブジェクトの XML 表現を返します。</span>
		 * <span lang="en">Returns the XML representation of the specified object.</span>
		 * 
		 * @return
		 * <span lang="ja">オブジェクトの XML 表現です。</span>
		 * <span lang="en">A XML representation of the object.</span>
		 */
		public function toXML():XML {
			var xml:XML = <{ _name } />;
			
			for ( var p:String in _data ) {
				if ( _preventEnumeratables[p] ) { continue; }
				
				var value:* = _data[p];
				
				switch ( true ) {
					case value is Array			: {
						for ( var i:int = 0, l:int = value.length; i < l; i++ ) {
							var item:* = value[i];
							
							if ( item is Model ) {
								xml.appendChild( item.toXML() );
							}
							else if ( item ) {
								xml.appendChild( <{ p }>{ item }</{ p }> );
							}
							else {
								xml.appendChild( <{ p } /> );
							}
						}
						break;
					}
					case value is Dictionary	: {
						for ( var pp:String in value ) {
							item = value[pp];
							
							if ( item is Model ) {
								xml.prependChild( item.toXML() );
							}
							else if ( item ) {
								xml.prependChild( <{ pp }>{ item }</{ pp }> );
							}
							else {
								xml.prependChild( <{ pp } /> );
							}
						}
						break;
					}
					case value is Model			: { xml.appendChild( value.toXML() ); break; }
					default						: {
						var dataType:String = _dataTypes[p] || _defaultDataType;
						switch ( dataType ) {
							case TYPE_NODE			: {
								if ( value ) {
									xml.appendChild( <{ p }>{ value }</{ p }> );
								}
								else {
									xml.appendChild( <{ p } /> );
								}
								break;
							}
							case TYPE_ATTRIBUTE		:
							default					: { xml.@[p] = value; }
						}
					}
				}
			}
			
			return xml;
		}
		
		/**
		 * <span lang="ja">指定されたオブジェクトの XML ストリング表現を返します。</span>
		 * <span lang="en">Returns the XML string representation of the specified object.</span>
		 * 
		 * @return
		 * <span lang="ja">オブジェクトの XML ストリング表現です。</span>
		 * <span lang="en">A XML string representation of the object.</span>
		 */
		public function toXMLString():String {
			return toXML().toXMLString();
		}
		
		/**
		 * <span lang="ja">指定されたオブジェクトのストリング表現を返します。</span>
		 * <span lang="en">Returns the string representation of the specified object.</span>
		 * 
		 * @return
		 * <span lang="ja">オブジェクトのストリング表現です。</span>
		 * <span lang="en">A string representation of the object.</span>
		 */
		public function toString():String {
			var args:Array = [ this, _classNameObj.toString() ];
			
			for ( var p:String in _data ) {
				if ( _preventEnumeratables[p] ) { continue; }
				
				var value:* = _data[p];
				
				switch ( true ) {
					case value is Array			:
					case value is Dictionary	:
					case value is Model			: { break; }
					default						: { args.push( p ); }
				}
			}
			
			return ObjectUtil.formatToString.apply( null, args );
		}
		
		/**
		 * <span lang="ja">イベントリスナーオブジェクトを EventIntegrator インスタンスに登録し、リスナーがイベントの通知を受け取るようにします。
		 * このメソッドを使用して登録されたリスナーを removeEventListener() メソッドで削除した場合には、restoreRemovedListeners() メソッドで再登録させることができます。</span>
		 * <span lang="en">Register the event listener object into the EventIntegrator instance to get the event notification.
		 * If the registered listener by this method removed by using removeEventListener() method, it can re-register using restoreRemovedListeners() method.</span>
		 * 
		 * @param type
		 * <span lang="ja">イベントのタイプです。</span>
		 * <span lang="en">The type of event.</span>
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
		 */
		public function addEventListener( type:String, listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false ):void {
			_dispatcher.addEventListener( type, listener, useCapture, priority );
		}
		
		/**
		 * <span lang="ja">EventIntegrator インスタンスからリスナーを削除します。
		 * このメソッドを使用して削除されたリスナーは、restoreRemovedListeners() メソッドで再登録させることができます。</span>
		 * <span lang="en">Remove the listener from EventIntegrator instance.
		 * The listener removed by using this method can re-register by restoreRemovedListeners() method.</span>
		 * 
		 * @param type
		 * <span lang="ja">イベントのタイプです。</span>
		 * <span lang="en">The type of event.</span>
		 * @param listener
		 * <span lang="ja">削除するリスナーオブジェクトです。</span>
		 * <span lang="en">The listener object to remove.</span>
		 * @param useCapture
		 * <span lang="ja">リスナーが、キャプチャ段階、またはターゲットおよびバブリング段階に対して登録されたかどうかを示します。リスナーがキャプチャ段階だけでなくターゲット段階とバブリング段階にも登録されている場合は、removeEventListener() を 2 回呼び出して両方のリスナーを削除する必要があります。1 回は useCapture() を true に設定し、もう 1 回は useCapture() を false に設定する必要があります。</span>
		 * <span lang="en">Specifies whether the listener was registered for the capture phase or the target and bubbling phases. If the listener was registered for both the capture phase and the target and bubbling phases, two calls to removeEventListener() are required to remove both, one call with useCapture() set to true, and another call with useCapture() set to false.</span>
		 */
		public function removeEventListener( type:String, listener:Function, useCapture:Boolean = false ):void {
			_dispatcher.removeEventListener( type, listener, useCapture );
		}
		
		/**
		 * <span lang="ja">イベントをイベントフローに送出します。</span>
		 * <span lang="en">Dispatches an event into the event flow.</span>
		 * 
		 * @param event
		 * <span lang="ja">イベントフローに送出されるイベントオブジェクトです。イベントが再度送出されると、イベントのクローンが自動的に作成されます。イベントが送出された後にそのイベントの target プロパティは変更できないため、再送出処理のためにはイベントの新しいコピーを作成する必要があります。</span>
		 * <span lang="en">The Event object that is dispatched into the event flow. If the event is being redispatched, a clone of the event is created automatically. After an event is dispatched, its target property cannot be changed, so you must create a new copy of the event for redispatching to work.</span>
		 * @return
		 * <span lang="ja">値が true の場合、イベントは正常に送出されました。値が false の場合、イベントの送出に失敗したか、イベントで preventDefault() が呼び出されたことを示しています。</span>
		 * <span lang="en">A value of true if the event was successfully dispatched. A value of false indicates failure or that preventDefault() was called on the event.</span>
		 */
		public function dispatchEvent( event:Event ):Boolean {
			return _dispatcher.dispatchEvent( event );
		}
		
		/**
		 * <span lang="ja">EventIntegrator インスタンスに、特定のイベントタイプに対して登録されたリスナーがあるかどうかを確認します。</span>
		 * <span lang="en">Checks whether the EventDispatcher object has any listeners registered for a specific type of event.</span>
		 * 
		 * @param event
		 * <span lang="ja">イベントのタイプです。</span>
		 * <span lang="en">The type of event.</span>
		 * @return
		 * <span lang="ja">指定したタイプのリスナーが登録されている場合は true に、それ以外の場合は false になります。</span>
		 * <span lang="en">A value of true if a listener of the specified type is registered; false otherwise.</span>
		 */
		public function hasEventListener( type:String ):Boolean {
			return _dispatcher.hasEventListener( type );
		}
		
		/**
		 * <span lang="ja">指定されたイベントタイプについて、この EventIntegrator インスタンスまたはその祖先にイベントリスナーが登録されているかどうかを確認します。</span>
		 * <span lang="en">Checks whether an event listener is registered with this EventDispatcher object or any of its ancestors for the specified event type.</span>
		 * 
		 * @param event
		 * <span lang="ja">イベントのタイプです。</span>
		 * <span lang="en">The type of event.</span>
		 * @return
		 * <span lang="ja">指定したタイプのリスナーがトリガされた場合は true に、それ以外の場合は false になります。</span>
		 * <span lang="en">A value of true if a listener of the specified type will be triggered; false otherwise.</span>
		 */
		public function willTrigger( type:String ):Boolean {
			return _dispatcher.willTrigger( type );
		}
		
		/**
		 * <span lang="ja">指定された名前と関連付けられたデータを取得します。</span>
		 * <span lang="en"></span>
		 * 
		 * @param name
		 * <span lang="ja">取得したいプロパティ名です。</span>
		 * <span lang="en"></span>
		 * @return
		 * <span lang="ja">対応するデータです。</span>
		 * <span lang="en"></span>
		 */
		protected function getProperty( name:String ):* {
			return flash_proxy::getProperty( name );
		}
		
		/**
		 * <span lang="ja">データに対して名前を付けて登録します。</span>
		 * <span lang="en"></span>
		 * 
		 * @param name
		 * <span lang="ja">登録したいプロパティ名です。</span>
		 * <span lang="en"></span>
		 * @param value
		 * <span lang="ja">登録したいデータです。</span>
		 * <span lang="en"></span>
		 */
		protected function setProperty( name:String, value:* ):void {
			flash_proxy::setProperty( name, value );
		}
		
		/**
		 * <span lang="ja">指定されたフィールドの構造種別を設定します。</span>
		 * <span lang="en"></span>
		 * 
		 * @param name
		 * <span lang="ja">構造種別を設定したいフィールド名です。</span>
		 * <span lang="en"></span>
		 * @param dataType
		 * <span lang="ja">設定される構造種別です。</span>
		 * <span lang="en"></span>
		 */
		protected function setFormat( name:String, dataType:String ):void {
			_dataTypes[name] = dataType;
		}
		
		/**
		 * <span lang="ja">標準の構造種別を設定します。</span>
		 * <span lang="en"></span>
		 * 
		 * @param dataType
		 * <span lang="ja">設定される構造種別です。</span>
		 * <span lang="en"></span>
		 */
		protected function setDefaultFormat( dataType:String ):void {
			_defaultDataType = dataType;
		}
		
		/**
		 * <span lang="ja">指定されたプロパティが列挙されないように指定します。</span>
		 * <span lang="en"></span>
		 * 
		 * @param name
		 * <span lang="ja">列挙したくないプロパティ名です。</span>
		 * <span lang="en"></span>
		 */
		protected function preventEnumeratable( name:String ):void {
			_preventEnumeratables[name] = true;
		}
		
		/**
		 * <span lang="ja">親のモデルを取得します。</span>
		 * <span lang="en"></span>
		 * 
		 * @return
		 * <span lang="ja">親のモデルです。</span>
		 * <span lang="en"></span>
		 */
		public function getParent():Model {
			return _parent;
		}
		
		/**
		 * @private
		 */
		override flash_proxy function callProperty( methodName:*, ... args:Array ):* {
			methodName, args;
			return null;
		}
		
		/**
		 * @private
		 */
		override flash_proxy function getProperty( name:* ):* {
			if ( !( name in _data ) ) { return null; }
			
			var value:* = _data[name];
			
			if ( value is Array ) { return value.slice(); }
			
			return value;
		}
		
		/**
		 * @private
		 */
		override flash_proxy function setProperty( name:*, value:* ):void {
			// フィールドが存在しなければ例外をスローする
			if ( !( name in _data ) ) { throw new Error( Logger.getLog( L10NNiumMsg.getInstance().ERROR_001 ).toString( name ) ); }
			
			// データを取得する
			var oldData:* = _data[name];
			var newData:* = value;
			
			// 更新されていなければ終了する
			if ( oldData == newData ) { return; }
			
			// 同一の中身を持つ Array であれば終了する
			if ( oldData is Array && newData is Array && ArrayUtil.equals( oldData, newData ) ) { return; }
			
			// イベントを作成する
			var event:ModelEvent = new ModelEvent( ModelEvent.MODEL_REMOVED );
			
			switch ( true ) {
				case oldData is Array		: {
					for ( var i:int = 0, l:int = oldData.length; i < l; i++ ) {
						var model:Model = oldData[i] as Model;
						
						if ( !model ) { continue; }
						
						// イベントを送出する
						model._dispatcher.dispatchEvent( event );
						
						// 親を設定する
						model._parent = null;
						
						// イベントリスナーを解除する
						model.removeEventListener( ModelEvent.MODEL_ADDED, _dispatcher.dispatchEvent );
						model.removeEventListener( ModelEvent.MODEL_REMOVED, _dispatcher.dispatchEvent );
						model.removeEventListener( ModelEvent.MODEL_UPDATE_BEFORE, _dispatcher.dispatchEvent );
						model.removeEventListener( ModelEvent.MODEL_UPDATE_SUCCESS, _dispatcher.dispatchEvent );
						model.removeEventListener( ModelEvent.MODEL_UPDATE_FAILURE, _dispatcher.dispatchEvent );
					}
					break;
				}
				case oldData is Dictionary	: {
					for ( var p:String in oldData ) {
						model = oldData[p] as Model;
						
						if ( !model ) { continue; }
						
						// イベントを送出する
						model._dispatcher.dispatchEvent( event );
						
						// 親を設定する
						model._parent = null;
						
						// イベントリスナーを解除する
						model.removeEventListener( ModelEvent.MODEL_ADDED, _dispatcher.dispatchEvent );
						model.removeEventListener( ModelEvent.MODEL_REMOVED, _dispatcher.dispatchEvent );
						model.removeEventListener( ModelEvent.MODEL_UPDATE_BEFORE, _dispatcher.dispatchEvent );
						model.removeEventListener( ModelEvent.MODEL_UPDATE_SUCCESS, _dispatcher.dispatchEvent );
						model.removeEventListener( ModelEvent.MODEL_UPDATE_FAILURE, _dispatcher.dispatchEvent );
					}
					break;
				}
				case oldData is Model		: {
					// イベントを送出する
					oldData._dispatcher.dispatchEvent( event );
					
					// 親を設定する
					oldData._parent = null;
					
					// イベントリスナーを解除する
					oldData.removeEventListener( ModelEvent.MODEL_ADDED, _dispatcher.dispatchEvent );
					oldData.removeEventListener( ModelEvent.MODEL_REMOVED, _dispatcher.dispatchEvent );
					oldData.removeEventListener( ModelEvent.MODEL_UPDATE_BEFORE, _dispatcher.dispatchEvent );
					oldData.removeEventListener( ModelEvent.MODEL_UPDATE_SUCCESS, _dispatcher.dispatchEvent );
					oldData.removeEventListener( ModelEvent.MODEL_UPDATE_FAILURE, _dispatcher.dispatchEvent );
					break;
				}
			}
			
			// イベントを送出して、キャンセルされなければ
			if ( _dispatcher.dispatchEvent( new ModelEvent( ModelEvent.MODEL_UPDATE_BEFORE, false, true, this, name, oldData, newData ) ) ) {
				// イベントを作成する
				event = new ModelEvent( ModelEvent.MODEL_ADDED );
				
				switch ( true ) {
					case newData is Array		: {
						for ( i = 0, l = newData.length; i < l; i++ ) {
							model = newData[i] as Model;
							
							if ( !model ) { continue; }
							
							// イベントリスナーを登録する
							model.addEventListener( ModelEvent.MODEL_ADDED, _dispatcher.dispatchEvent );
							model.addEventListener( ModelEvent.MODEL_REMOVED, _dispatcher.dispatchEvent );
							model.addEventListener( ModelEvent.MODEL_UPDATE_BEFORE, _dispatcher.dispatchEvent );
							model.addEventListener( ModelEvent.MODEL_UPDATE_SUCCESS, _dispatcher.dispatchEvent );
							model.addEventListener( ModelEvent.MODEL_UPDATE_FAILURE, _dispatcher.dispatchEvent );
							
							// 親を設定する
							model._parent = this;
							
							// イベントを送出する
							model._dispatcher.dispatchEvent( event );
						}
						break;
					}
					case newData is Dictionary	: {
						for ( var pp:String in oldData ) {
							model = oldData[pp] as Model;
							
							if ( !model ) { continue; }
							
							// イベントリスナーを登録する
							model.addEventListener( ModelEvent.MODEL_ADDED, _dispatcher.dispatchEvent );
							model.addEventListener( ModelEvent.MODEL_REMOVED, _dispatcher.dispatchEvent );
							model.addEventListener( ModelEvent.MODEL_UPDATE_BEFORE, _dispatcher.dispatchEvent );
							model.addEventListener( ModelEvent.MODEL_UPDATE_SUCCESS, _dispatcher.dispatchEvent );
							model.addEventListener( ModelEvent.MODEL_UPDATE_FAILURE, _dispatcher.dispatchEvent );
							
							// 親を設定する
							model._parent = this;
							
							// イベントを送出する
							model._dispatcher.dispatchEvent( event );
						}
						break;
					}
					case newData is Model		: {
						// イベントリスナーを登録する
						newData.addEventListener( ModelEvent.MODEL_ADDED, _dispatcher.dispatchEvent );
						newData.addEventListener( ModelEvent.MODEL_REMOVED, _dispatcher.dispatchEvent );
						newData.addEventListener( ModelEvent.MODEL_UPDATE_BEFORE, _dispatcher.dispatchEvent );
						newData.addEventListener( ModelEvent.MODEL_UPDATE_SUCCESS, _dispatcher.dispatchEvent );
						newData.addEventListener( ModelEvent.MODEL_UPDATE_FAILURE, _dispatcher.dispatchEvent );
						
						// 親を設定する
						newData._parent = this;
						
						// イベントを送出する
						newData._dispatcher.dispatchEvent( event );
						break;
					}
				}
				
				// 値を更新する
				if ( newData is Array ) {
					_data[name] = newData.slice();
				}
				else {
					_data[name] = newData;
				}
				
				// イベントを送出する
				_dispatcher.dispatchEvent( new ModelEvent( ModelEvent.MODEL_UPDATE_SUCCESS, false, true, this, name, oldData, newData ) );
			}
			else {
				// イベントを送出する
				_dispatcher.dispatchEvent( new ModelEvent( ModelEvent.MODEL_UPDATE_FAILURE, false, true, this, name, oldData, newData ) );
			}
		}
		
		/**
		 * @private
		 */
		override flash_proxy function deleteProperty( name:* ):Boolean {
			name;
			return false;
		}
		
		/**
		 * @private
		 */
		override flash_proxy function hasProperty( name:* ):Boolean {
			return ( name in _data );
		}
		
		/**
		 * @private
		 */
		override flash_proxy function nextNameIndex( index:int ):int {
			index;
			return -1;
		}
		
		/**
		 * @private
		 */
		override flash_proxy function nextName( index:int ):String {
			index;
			return null;
		}
		
		/**
		 * @private
		 */
		override flash_proxy function nextValue( index:int ):* {
			index;
			return null;
		}
	}
}
