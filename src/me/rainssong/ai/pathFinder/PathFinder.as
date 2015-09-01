package me.rainssong.ai.pathFinder 
{
	import flash.geom.Point;
	import flash.utils.Dictionary;
	import me.rainssong.math.MathCore;
	import me.rainssong.utils.DestroyUtil;
	/**
	 * ...
	 * @author Rainssong
	 */
	public class PathFinder 
	{
		private var openList:Array.<FinderNode> = [];
		private var closeList:Array.<FinderNode> = [];
		private var solution:Vector.<FinderNode>= new Vector.<FinderNode>;
		
		private var _startNode:FinderNode = new FinderNode(0, 0);
		private var _endNode:FinderNode = new FinderNode(10, 10);
		
		private var _map:Map;
		
		private var _finderNodeDic:Dictionary = new Dictionary();
		
		public function PathFinder(map:Map) 
		{
			_map = map;
		}
		
		public function clear():void
		{
			DestroyUtil.destroyVector(openList);
			DestroyUtil.destroyVector(closeList);
			DestroyUtil.destroyVector(solution);
			DestroyUtil.destroyMap(_finderNodeDic);
		}
		
		public function setStartNode(x:int, y:int):void
		{
			_startNode=getFinderNode(x, y);
		}
		
		public function setEndNode(x:int, y:int):void
		{
			_endNode=getFinderNode(x, y);
		}
		
		public function startFind():Vector.<FinderNode>
		{
	
			var directions:Array = [[0, -1], [1, 0], [0, 1], [ -1, 0]/*,[1, -1], [1, 1], [-1, 1], [ -1, -1]*/]
			_startNode.g = 0;
			_startNode.h = Math.abs(_endNode.x - _startNode.x) + Math.abs(_endNode.y - _startNode.y);
			openList.push(_startNode);
			
			while (openList.length)
			{
				openList.sortOn("f", Array.DESCENDING );
				var currentNode:FinderNode = openList.pop();
				
				if (currentNode == _endNode)
				{
					solution.push(currentNode);
					while (currentNode.parentNode) 
					{
						solution.push(currentNode.parentNode);
						currentNode=currentNode.parentNode
					}
					return solution;
				}
				
				for (var i:int = 0; i < directions.length; i++) 
				{
					var newNode:FinderNode = getFinderNode(currentNode.x + directions[i][0], currentNode.y + directions[i][1]);
					
					if (!newNode || !newNode.isOpen)
						continue;
					
					var newG:Number = currentNode.g+1;
					var newH:Number = Point.distance(new Point(endNode.x, endNode.y), new Point(newNode.x, newNode.y));
					//var newH:Number = Math.abs(endNode.x - newNode.x) + Math.abs(endNode.y - newNode.y);
					//var newF:Number = newG + newH;
						//
					//powerTrace(newNode.x,newNode.y);
					//powerTrace(closeList.indexOf(newNode));
					
					if (openList.indexOf(newNode) > -1 || closeList.indexOf(newNode)>-1)
					{
						
						if (newG < newNode.g)
						{
							newNode.g = newG;
							newNode.h = newH;
							newNode.parentNode = currentNode;
							
						}
					}
					else
					{
						openList.push(newNode);
						newNode.g = newG;
						newNode.h = newH;
						newNode.parentNode = currentNode;
					}
					
				}
				
				closeList.push(currentNode);
			}
			
			return null;
		}
		
		public function getFinderNode(x:int,y:int):FinderNode
		{
			var node:Node = _map.getNode(x, y);
			
			if (node == null) return null;
			
			if (_finderNodeDic[x+","+y]!=null)
				return _finderNodeDic[x+","+y];
			else
			{
				_finderNodeDic[x+","+y] = FinderNode.createFromNode(node);
				return _finderNodeDic[x+","+y];
			}
		}
		
		public function get startNode():FinderNode 
		{
			return _startNode;
		}
		
		public function get endNode():FinderNode 
		{
			return _endNode;
		}
		
	}

}