package me.rainssong.math.aStarLike
{
	import me.rainssong.math.base.NetNodesBase;
	import me.rainssong.math.base.Node;
	import me.rainssong.math.base.SearchingDirection;
	
	/**
	 * AStar栅格点数据
	 */
	public class NetNodes extends NetNodesBase
	{
		
		public function NetNodes(rows:uint, cols:uint, delim:String, searchingDirection:SearchingDirection)
		{
			super(rows, cols, delim, searchingDirection);
		}
		
		/**
		 * @inheritDoc
		 */
		override protected function createNodes(rows:uint, cols:uint, delim:String):void
		{
			var node:Node;
			var lastRowIndex:int = rows - 1;
			var lastColIndex:int = cols - 1;
			var push:Function;
			var tRow:int;
			var tColInc:int;
			var tColDec:int;
			
			for(var row:int = 0; row < rows; row++)
			{
				for(var col:int = 0; col < cols; col++)
				{
					node = new Node(row, col, delim);
					_nodes[node] = node;
				}
			}
			
			for (row = 0; row < rows; row++)
			{
				for (col = 0; col < cols; col++)
				{
					node = _nodes[row + delim + col];
					push = node.neighbours.push;
					
					tColInc = col + 1;
					tColDec = col - 1;
					
					if(row != 0)
					{
						tRow = row - 1;
						push(_nodes[tRow + delim + col]);
						
						if(_searchingDirection == SearchingDirection.EIGHT || _searchingDirection == SearchingDirection.ALL)
						{
							if(col != 0)
							{
								push(_nodes[tRow + delim + tColDec]);
							}
							
							if(col != lastColIndex)
							{
								push(_nodes[tRow + delim + tColInc]);
							}
						}
					}
					
					if(row != lastRowIndex)
					{
						tRow = row + 1
						push(_nodes[tRow + delim + col]);
						
						if(_searchingDirection == SearchingDirection.EIGHT || _searchingDirection == SearchingDirection.ALL)
						{
							if(col != 0)
							{
								push(_nodes[tRow + delim + tColDec]);
							}
							
							if(col != lastColIndex)
							{
								push(_nodes[tRow + delim + tColInc]);
							}
						}
					}
					
					if(col != 0)
					{
						push(_nodes[row + delim + tColDec]);
					}
					
					if(col != lastColIndex)
					{
						push(_nodes[row + delim + tColInc]);
					}
				}
			}
		}
	}
}