package model 
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
		
	}

}