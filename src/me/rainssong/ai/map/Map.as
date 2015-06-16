package model 
{
	import adobe.utils.CustomActions;
	/**
	 * ...
	 * @author Rainssong
	 */
	public class Map 
	{
		public var width:int = 20;
		public var height:int = 20;
		public var nodes:Vector.<Vector.<Node>> = new Vector.<Vector.<Node>>();
		
		public function Map(width:int,height:int) 
		{
			this.width = width;
			this.height = height;
			for (var i:int = 0; i < height; i++) 
			{
				var line:Vector.<Node> = new Vector.<Node>(100);
				nodes.push(line);
				for (var j:int = 0; j < width; j++) 
				{
					line[j] = new Node(j, i);
				}
			}
		}
		
		public function getNode(x:int, y:int ):Node
		{
			if (x<0 || x>=width)
			return null;
			if (y<0 || y>=height)
			return null;
			return nodes[y][x];
		}
		
	}

}