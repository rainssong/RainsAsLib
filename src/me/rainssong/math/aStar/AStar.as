package com.codeTooth.actionscript.algorithm.pathSearching.aStar
{
	import com.codeTooth.actionscript.algorithm.pathSearching.aStarLike.NetNodes;
	import com.codeTooth.actionscript.algorithm.pathSearching.base.IPathSearching;
	import com.codeTooth.actionscript.algorithm.pathSearching.base.NetNodesBase;
	import com.codeTooth.actionscript.algorithm.pathSearching.base.Node;
	import com.codeTooth.actionscript.algorithm.pathSearching.base.SearchingDirection;
	import com.codeTooth.actionscript.lang.utils.Common;
	import com.codeTooth.actionscript.lang.utils.destroy.DestroyUtil;
	
	public class AStar implements IPathSearching
	{
		private var _netNodes:NetNodesBase = null;
		
		private var _startPoint:Node = null;
		
		private var _endPoint:Node = null;
		
		private var _openList:Vector.<Node> = null;
		
		private var _openListLength:int = 0;
		
		private var _closelist:Vector.<Node> = null;
		
		private var _roadsList:Vector.<Vector.<int>> = null;
		
		private var _road:Vector.<int> = null;
		
		public function AStar(rows:uint, cols:uint, netNodes:NetNodesBase = null)
		{
			_netNodes = netNodes == null ? new NetNodes(rows, cols, Common.DELIM, SearchingDirection.EIGHT) : netNodes;
			_openList = new Vector.<Node>();
			_closelist = new Vector.<Node>();
			_roadsList = new Vector.<Vector.<int>>();
			_road = new Vector.<int>();
			_roadsList[0] = _road;
			_startPoint = new Node(0, 0, Common.DELIM);;
			_endPoint = new Node(0, 0, Common.DELIM);
		}
		
		public function addUnwalkable(row:int, col:int):Boolean
		{
			var node:Node = _netNodes.getNode(row, col);
			if (node == null)
			{
				return false;
			}
			
			node.pass = false;
			return true;
		}
		
		public function removeUnwalkable(row:int, col:int):Boolean
		{
			var node:Node = _netNodes.getNode(row, col);
			if (node == null)
			{
				return false;
			}
			
			node.pass = true;
			return true;
		}
		
		public function search(rowFrom:int, colFrom:int, rowTo:int, colTo:int):Vector.<Vector.<int>>
		{
			DestroyUtil.breakVector(_openList);
			DestroyUtil.breakVector(_closelist);
			_road.length = 0;
			_openListLength = 0;
			
			_startPoint.col = colFrom;
			_startPoint.row = rowFrom;
			_endPoint.col = colTo;
			_endPoint.row = rowTo;
			
			_openList.push(_startPoint);
			_openListLength++;
			
			if(!_startPoint.pass || !_endPoint.pass || (_startPoint.row == _endPoint.row && _startPoint.col == _endPoint.col))
			{
				return null;
			}
			
			while(true)
			{
				if(_openListLength < 1)
				{
					// Cannot goto
					return null;
					break;
				}
				
				var currPoint:Node = popMinFAPointFromOpenList();
				if(currPoint == null)
				{
					// Cannot goto
					return null;
				}
				
				if(currPoint.col == _endPoint.col && currPoint.row == _endPoint.row)
				{
					// Find the path
					while(currPoint.parent != _startPoint.parent)
					{
						_road.push(currPoint.row, currPoint.col);
						currPoint = currPoint.parent;
					}
					return _roadsList;
				}
				
				_closelist.push(currPoint);
				addAroundPoint(currPoint);
			}
			
			return null;
		}
		
		private function addAroundPoint(currNode:Node):void
		{
			var currNodeCol:uint=currNode.col;
			var currNodeRow:uint=currNode.row;
			
			var tempNode:Node = null;
			
			tempNode = _netNodes.getNode(currNodeRow, currNodeCol - 1)
			if (currNodeCol > 0 && tempNode.pass)
			{
				if(!nodeInCloseList(tempNode))
				{
					if(!nodeInOpenList(tempNode))
					{
						setNodeGHF(tempNode, currNode, 10);
						_openList.push(tempNode);
					}
					else
					{
						checkNodeG(tempNode, currNode);
					}
				}
				
				tempNode = _netNodes.getNode(currNodeRow - 1, currNodeCol - 1);
				if(currNodeRow > 0 && tempNode.pass && _netNodes.getNode(currNodeRow - 1, currNodeCol).pass)
				{
					if(!nodeInCloseList(tempNode) && !nodeInOpenList(tempNode))
					{
						setNodeGHF(tempNode, currNode, 14);
						_openList.push(tempNode);
					}
				}
				
				tempNode = _netNodes.getNode(currNodeRow + 1, currNodeCol - 1);
				if(currNodeRow < _netNodes.rows - 1 && tempNode.pass && _netNodes.getNode(currNodeRow + 1, currNodeCol).pass)
				{
					if(!nodeInCloseList(tempNode) && !nodeInOpenList(tempNode))
					{
						setNodeGHF(tempNode, currNode, 14);
						_openList.push(tempNode);
					}
				}
			}
			
			tempNode = _netNodes.getNode(currNodeRow, currNodeCol + 1);
			if (currNodeCol < _netNodes.cols - 1 && tempNode.pass) 
			{
				if(!nodeInCloseList(tempNode))
				{
					if(!nodeInOpenList(tempNode))
					{
						setNodeGHF(tempNode, currNode, 10);
						_openList.push(tempNode);
					}
					else
					{
						checkNodeG(tempNode, currNode);
					}
				}
				
				tempNode = _netNodes.getNode(currNodeRow - 1, currNodeCol + 1);
				if(currNodeRow > 0 && tempNode.pass && _netNodes.getNode(currNodeRow - 1, currNodeCol).pass)
				{
					if(!nodeInCloseList(tempNode) && !nodeInOpenList(tempNode))
					{
						setNodeGHF(tempNode, currNode, 14);
						_openList.push(tempNode);
					}
				}
				
 				tempNode = _netNodes.getNode(currNodeRow + 1, currNodeCol + 1);
				if(currNodeRow < _netNodes.rows - 1 && tempNode.pass && _netNodes.getNode(currNodeRow + 1, currNodeCol).pass)
				{
					if(!nodeInCloseList(tempNode) && !nodeInOpenList(tempNode))
					{
						setNodeGHF(tempNode, currNode, 14);
						_openList.push(tempNode);
					}
				}
			}
			
			tempNode = _netNodes.getNode(currNodeRow - 1, currNodeCol);
			if(currNodeRow > 0 && tempNode.pass)
			{
				if(!nodeInCloseList(tempNode))
				{
					if(!nodeInOpenList(tempNode))
					{
						setNodeGHF(tempNode, currNode, 10);
						_openList.push(tempNode);
					}
					else
					{
						checkNodeG(tempNode, currNode);
					}
				}
			}
			
			tempNode = _netNodes.getNode(currNodeRow + 1, currNodeCol);
			if(currNodeRow < _netNodes.rows - 1 && tempNode.pass)
			{
				if(!nodeInCloseList(tempNode))
				{
					if(!nodeInOpenList(tempNode))
					{
						setNodeGHF(tempNode, currNode, 10);
						_openList.push(tempNode);
					}
					else
					{
						checkNodeG(tempNode, currNode);
					}
				}
			}
		}
		
		private function setNodeGHF(node:Node, parentNode:Node, G:Number):void
		{
			node.G=parentNode.G+G;
			node.H=(Math.abs(node.col - _endPoint.col) + Math.abs(node.row - _endPoint.row))*10;
			node.F=node.H + node.G;
			node.parent=parentNode;
		}
		
		private function checkNodeG(checkNode:Node, parenNode:Node):void
		{
			var newG:Number=parenNode.G + 10;
			if (newG <= checkNode.G)
			{
				checkNode.G=newG;
				checkNode.F=checkNode.H+newG;
				checkNode.parent=parenNode;
			}
		}
		
		private function nodeInOpenList(node:Node):Boolean
		{
			return _openList.indexOf(node) != -1;
		}
		
		private function nodeInCloseList(node:Node):Boolean
		{
			return _closelist.indexOf(node) != -1;
		}
		
		private function popMinFAPointFromOpenList():Node
		{
			sortOpenListByF();
			return _openList.pop();
		}
		
		private function sortOpenListByF():void
		{
			_openList.sort(openListSortFunc);
		}
		
		private function openListSortFunc(aPoint1:Node, aPoint2:Node):int
		{
			return aPoint1.F > aPoint2.F ? -1 : 1;
		}
		
		public function destroy():void
		{
			if(_netNodes != null)
			{
				_netNodes.destroy();
				_netNodes = null;
			}
			
			DestroyUtil.breakVector(_openList);
			_openList = null;
			
			DestroyUtil.breakVector(_closelist);
			_closelist = null;
			
			if(_roadsList != null)
			{
				_roadsList.length = 0;
				_roadsList = null;
			}
			
			if(_road != null)
			{
				_road.length = 0;
				_road = null;
			}
			
			_startPoint = null;
			_endPoint = null;
		}
	}
}