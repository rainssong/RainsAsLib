package  
{
	/**
	 * ...
	 * @author rainssong
	 */
	public class AstarNode 
	{
		public var g:int = 0;
		public var h:int = 0;
		public var x:int=0;
		public var y:int=0;
		public function AstarNode(x:int=0,y:int=0) 
		{
			this.x = x;
			this.y = y;
		}
		
		public function get f():int
		{
			return g + h;
		}
		
	}

}