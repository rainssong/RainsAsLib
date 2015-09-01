package me.rainssong.ai.pathFinder 
{
	import model.Node;
	/**
	 * ...
	 * @author Rainssong
	 */
	public class FinderNode extends Node 
	{
		public var g:Number = Number.MAX_VALUE;
		public var h:Number = Number.MAX_VALUE;
		public var parentNode:FinderNode
		
		public function FinderNode(x:int=0, y:int=0) 
		{
			super(x, y);
		}
		
		public function get f():Number
		{
			return g+h;
		}
		
		static public function createFromNode(node:Node):FinderNode
		{
			if (!node) return null;
			var fn:FinderNode = new FinderNode(node.x, node.y);
			fn.isOpen = node.isOpen;
			return fn;
		}
		
		public function toString():String
		{
			return x+","+y;
		}
		
	}

}