package com.codeTooth.actionscript.algorithm.pathSearching.base
{
	import com.codeTooth.actionscript.lang.utils.Common;
	import com.codeTooth.actionscript.lang.utils.destroy.DestroyUtil;
	import com.codeTooth.actionscript.lang.utils.destroy.IDestroy;
	/**
	 * 路径节点
	 */
	public class Node implements IDestroy
	{
		public var G:Number = 0;
		public var F:Number = 0;
		public var H:Number = 0;
		
		/**
		 * 行编号
		 */
		public var row:int;
		
		/**
		 * 列编号
		 */
		public var col:int;
		
		/**
		 * 邻节点的id
		 */
		public var neighbours:Vector.<Node>;
		
		/**
		 * 父节点的id
		 */
		public var parent:Node;
		
		/**
		 * 节点的值
		 */
		public var value:Number;
		
		// id号
		private var _toString:String;
		
		/**
		 * 构造函数
		 * 
		 * @param	row 行编号
		 * @param	col 列编号
		 * @param	delim 分隔符
		 */
		public function Node(row:int, col:int, delim:String)
		{
			this.row = row;
			this.col = col;
			_toString = row + delim + col;
			neighbours = new Vector.<Node>();
		}	
		
		public function set pass(bool:Boolean):void
		{
			value = bool ? 1 : int.MAX_VALUE;
		}
		
		public function get pass():Boolean
		{
			return value != int.MAX_VALUE;
		}
		
		/**
		 * 返回id
		 * 
		 * @return
		 */
		public function toString():String
		{
			return _toString;
		}
		
		//------------------------------------------------------------------------------------------------------------------------------------
		// 实现 IDestroy 接口
		//------------------------------------------------------------------------------------------------------------------------------------
		
		public function destroy():void
		{
			parent = null;
			DestroyUtil.breakVector(neighbours);
			neighbours = null;
		}
	}
}