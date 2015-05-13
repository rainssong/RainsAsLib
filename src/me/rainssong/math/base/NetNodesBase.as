package me.rainssong.math.base
{
	import me.rainssong.utils.IDestroy;
	
	/**
	 * 网格节点基类
	 */
	public class NetNodesBase implements IDestroy
	{
		/**
		 * 保存所有节点
		 */
		protected var _nodes:Object = null;
		
		/**
		 * 寻路方向。是八方向寻路还是四方向
		 */
		protected var _searchingDirection:SearchingDirection = SearchingDirection.EIGHT;
		
		private var _delim:String = null;
		
		private var _rows:uint = 0;
		
		private var _cols:uint = 0;
		
		/**
		 * 构造函数
		 * 
		 * @param	rows	总行数
		 * @param	cols	总列数
		 * @param	delim 分隔符
		 * @param	searchingDirection 寻路的方向
		 */
		public function NetNodesBase(rows:uint, cols:uint, delim:String, searchingDirection:SearchingDirection)
		{
			_rows = rows;
			_cols = cols;
			_delim = delim;
			_nodes = new Object();
			_searchingDirection = searchingDirection;
			createNodes(rows, cols, delim);
		}
		
		public function get rows():uint
		{
			return _rows;
		}
		
		public function get cols():uint
		{
			return _cols;
		}
		
		/**
		 * 获得指定的节点对象
		 * 
		 * @param	row
		 * @param	col
		 * 
		 * @return
		 */
		public function getNode(row:int, col:int):Node
		{
			return _nodes[row + _delim + col];
		}
		
		/**
		 * 子类覆盖这个方法，开始创建所有的节点对象
		 * 
		 * @param	rows	总函数
		 * @param	cols	总列数
		 * @param	delim
		 */
		protected function createNodes(rows:uint, cols:uint, delim:String):void
		{
			throw new AbstractError();
		}
		
		//----------------------------------------------------------------------------------------------------------------------
		// 实现 IDestroy 接口
		//----------------------------------------------------------------------------------------------------------------------
		
		public function destroy():void
		{
			DestroyUtil.destroyMap(_nodes);
			_nodes = null;
		}
	}
}