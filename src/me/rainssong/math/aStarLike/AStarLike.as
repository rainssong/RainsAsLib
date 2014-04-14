package com.codeTooth.actionscript.algorithm.pathSearching.aStarLike
{
	import com.codeTooth.actionscript.algorithm.pathSearching.base.IPathSearching;
	import com.codeTooth.actionscript.algorithm.pathSearching.base.NetNodesBase;
	import com.codeTooth.actionscript.algorithm.pathSearching.base.Node;
	import com.codeTooth.actionscript.algorithm.pathSearching.base.SearchingDirection;
	import com.codeTooth.actionscript.lang.exceptions.NullPointerException;
	import com.codeTooth.actionscript.lang.utils.Common;
	import com.codeTooth.actionscript.lang.utils.destroy.DestroyUtil;
	
	/**
	 * 类AStar寻路（并非真正的AStar寻路，在简单地型中要比AStar快）
	 */
	public class AStarLike implements IPathSearching
	{
		private var _netNodes:NetNodesBase = null;
		
		private var _fromNode:Node = null;
		
		private var _toNode:Node = null;
		
		private var _queue:Vector.<Node> = null;
		
		private var _excludeNodes:Object = null;
		
		private var _paths:Vector.<Vector.<int>> = null;
		
		private var _path:Vector.<int> = null;
		
		/**
		 * 构造函数
		 * 
		 * @param	rows 栅格行数
		 * @param	cols 栅格列数
		 * @param	searchingDirection 寻路方向
		 * @param	netNodes	栅格网格，如果指定了对象则是用此网格节点来进行寻路，传入默认的null则使用默认的网格节点进行寻路
		 * 
		 * @throws	com.codeTooth.actionscript.lang.exceptions.NullPointerException 
		 * 指定的寻路方向的null
		 */
		public function AStarLike(rows:uint, cols:uint, searchingDirection:SearchingDirection, netNodes:NetNodesBase = null)
		{
			if (searchingDirection == null)
			{
				throw new NullPointerException("Null searchingDirection");
			}
			
			_queue = new Vector.<Node>();
			_netNodes = netNodes == null ? new NetNodes(rows, cols, Common.DELIM, searchingDirection) : netNodes;
			_paths = new Vector.<Vector.<int>>();
			_path = new Vector.<int>();
			_paths[0] = _path;
		}
		
		//-----------------------------------------------------------------------------------------------------------------------------
		// 实现 IPathSearching 接口
		//-----------------------------------------------------------------------------------------------------------------------------
		
		public function addUnwalkable(row:int, col:int):Boolean
		{
			var node:Node = _netNodes.getNode(row, col);
			if (node == null)
			{
				return false;
			}
			
			node.value = int.MAX_VALUE;
			return true;
		}
		
		public function removeUnwalkable(row:int, col:int):Boolean
		{
			var node:Node = _netNodes.getNode(row, col);
			if (node == null)
			{
				return false;
			}
			
			node.value = 1;
			return true;
		}
		
		/**
		 * 获得寻路的结果路径
		 * 
		 * @param	rowFrom
		 * @param	colFrom
		 * @param	rowTo
		 * @param	colTo
		 * 
		 * @return	最多返回一条路径。如果没有找到路径，返回null。路径的结构是[row, col, row, col, row, col]，注意路径从起始到结束，需要反向遍历数组
		 */
		public function search(rowFrom:int, colFrom:int, rowTo:int, colTo:int):Vector.<Vector.<int>>
		{
			if (rowFrom == rowTo && colFrom == colTo)
			{
				// Has not movement
				return null;
			}
			
			_fromNode = _netNodes.getNode(rowFrom, colFrom);
			if (_fromNode == null || _fromNode.value == int.MAX_VALUE)
			{
				// No path
				return null;
			}
			_fromNode.parent = null;
			
			_toNode = _netNodes.getNode(rowTo, colTo);
			if (_toNode == null || _toNode.value == int.MAX_VALUE)
			{
				// No path
				return null;
			}
			_toNode.parent = null;
			
			_queue.length = 0;
			_queue.push(_fromNode);
			
			_excludeNodes = new Object();
			_excludeNodes[_fromNode] = 1;
			
			var neighbour:Node;
			var tailNode:Node;
			var neighbours:Vector.<Node>;
			var minValueNeighbourNode:Node;
			var neighbourMinValue:Number;
			var tValue:Number;
			var queueLength:int;
			var rowSub:int;
			var colSub:int;
			
			while(true)
			{
				queueLength = _queue.length;
				
				if(queueLength == 0)
				{
					break;
				}
				else
				{
					tailNode = _queue[queueLength - 1];
					neighbours = tailNode.neighbours;
					neighbourMinValue = int.MAX_VALUE;
					minValueNeighbourNode = null;
					for each(neighbour in neighbours)
					{	
						if(_excludeNodes[neighbour] == undefined && neighbour.value != int.MAX_VALUE)
						{
							rowSub = _toNode.row - neighbour.row;
							colSub = _toNode.col - neighbour.col;
							tValue = Math.sqrt(rowSub * rowSub + colSub * colSub);
							
							if(tValue < neighbourMinValue)
							{
								neighbourMinValue = tValue;
								minValueNeighbourNode = neighbour;
							}
						}
					}
					
					if(minValueNeighbourNode != null)
					{
						minValueNeighbourNode.parent = tailNode;
						_excludeNodes[minValueNeighbourNode] = 1;
						_queue.push(minValueNeighbourNode);
						
						if(minValueNeighbourNode == _toNode)
						{
							break;
						}
					}
					else
					{
						_queue.pop();
					}
				}
			}
			
			if(_toNode.parent == null)
			{
				// No path
				return null;
			}
			else
			{
				_path.length = 0;
				var tNode:Node = _toNode;
				_path.push(tNode.row, tNode.col);
				
				while(tNode.parent != null)
				{
					tNode = tNode.parent;
					_path.push(tNode.row, tNode.col);
				}
				
				return _paths;
			}
		}
		
		//-----------------------------------------------------------------------------------------------------------------------------
		// 实现 IDestroy 接口
		//-----------------------------------------------------------------------------------------------------------------------------
		
		public function destroy():void
		{
			_fromNode = null;
			_toNode = null;
			DestroyUtil.breakVector(_queue);
			_queue = null;
			_excludeNodes = null;
			
			if (_netNodes != null)
			{
				_netNodes.destroy();
				_netNodes = null;
			}
			
			if (_paths != null)
			{
				_paths.length = 0;
				_paths = null;
			}
			if (_path != null)
			{
				_path.length = 0;
				_path = null;
			}
		}
	}
}