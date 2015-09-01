package me.rainssong.ai.map 
{
	import me.rainssong.rainMVC.model.Model;
	/**
	 * ...
	 * @author Rainssong
	 */
	public class Map extends Model
	{
		private var _width:int = 20;
		private var _height:int = 20;
		private var _nodes:Vector.<Vector.<Node>> = new Vector.<Vector.<Node>>();
		
		public function Map(width:int,height:int) 
		{
			_width = width;
			_height = height;
			for (var i:int = 0; i < _height; i++) 
			{
				var line:Vector.<Node> = new Vector.<Node>(width);
				_nodes.push(line);
				for (var j:int = 0; j < _width; j++) 
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
			return _nodes[y][x];
		}
		
		public function get height():int 
		{
			return _height;
		}
		
		public function get width():int 
		{
			return _width;
		}
		
	}

}