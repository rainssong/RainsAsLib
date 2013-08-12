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
package jp.nium.display {
	import flash.display.BitmapData;
	import flash.display.Graphics;
	import flash.display.Shape;
	import flash.geom.Matrix;
	
	/**
	 * <span lang="ja"></span>
	 * <span lang="en"></span>
	 * 
	 * @example <listing version="3.0">
	 * </listing>
	 */
	public class BitmapFill extends Shape {
		
		/**
		 * <span lang="ja"></span>
		 * <span lang="en"></span>
		 */
		override public function get width():Number { return super.width; }
		override public function set width( value:Number ):void {
			_width = int( value );
			
			_resize();
		}
		private var _width:Number = 0;
		
		/**
		 * <span lang="ja"></span>
		 * <span lang="en"></span>
		 */
		override public function get height():Number { return super.height; }
		override public function set height( value:Number ):void {
			_height = int( value );
			
			_resize();
		}
		private var _height:Number = 0;
		
		/**
		 * @private
		 */
		override public function get graphics():Graphics { return null; }
		
		/**
		 * <span lang="ja"></span>
		 * <span lang="en"></span>
		 */
		public function get matrix():Matrix { return _matrix; }
		public function set matrix( value:Matrix ):void {
			_matrix = value;
			
			_resize();
		}
		private var _matrix:Matrix;
		
		/**
		 * <span lang="ja"></span>
		 * <span lang="en"></span>
		 */
		public function get bitmapData():BitmapData { return _bitmapData; }
		public function set bitmapData( value:BitmapData ):void {
			_bitmapData = value;
			
			_resize();
		}
		private var _bitmapData:BitmapData;
		
		
		
		
		
		/**
		 * <span lang="ja">新しい BitmapFill インスタンスを作成します。</span>
		 * <span lang="en">Creates a new BitmapFill object.</span>
		 * 
		 * @param bitmapData
		 * <span lang="ja"></span>
		 * <span lang="en"></span>
		 */
		public function BitmapFill( bitmapData:BitmapData = null ) {
			_bitmapData = bitmapData;
		}
		
		
		
		
		
		/**
		 * <span lang="ja"></span>
		 * <span lang="en"></span>
		 * 
		 * @param width
		 * <span lang="ja"></span>
		 * <span lang="en"></span>
		 * @param height
		 * <span lang="ja"></span>
		 * <span lang="en"></span>
		 * @param matrix
		 * <span lang="ja"></span>
		 * <span lang="en"></span>
		 */
		public function setSize( width:Number, height:Number, matrix:Matrix = null ):void {
			_width = int( width );
			_height = int( height );
			_matrix = matrix;
			
			_resize();
		}
		
		/**
		 * 
		 */
		private function _resize():void {
			super.graphics.clear();
			
			if ( _bitmapData ) {
				super.graphics.beginBitmapFill( _bitmapData, _matrix, true, true );
				super.graphics.drawRect( 0, 0, _width, _height );
				super.graphics.endFill();
			}
		}
	}
}
