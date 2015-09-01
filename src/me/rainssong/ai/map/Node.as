package me.rainssong.ai.map 
{
	/**
	 * ...
	 * @author Rainssong
	 */
	public class Node 
	{
		public var x:int = 0;
		public var y:int = 0;
		public var isOpen:Boolean = true;
		
		public function Node(x:int=0,y:int=0)
		{
			this.x = x;
			this.y = y;
		}
		
		public function equal(node:Node):Boolean
		{
			if (x == node.x && y == node.y)
			return true;
			else
			return false;
		}
		
		public function clone():Node
		{
			return new Node(x, y);
		}
	}

}