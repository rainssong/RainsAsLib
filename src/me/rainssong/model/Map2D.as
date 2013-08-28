package  me.rainssong.model
{
	/**
	 * ...
	 * @author Rainssong
	 */
	public dynamic class Map2D extends Array 
	{
		public function Map2D(w:uint,h:uint,defaultValue:*=null) 
		{
			super();
			for (var i:int = 0; i < h; i++ )
			{
				this[i] = [];
				for (var ii:int = 0; ii < w; ii++ )
					this[i][ii] = defaultValue;
			}
		
		}
		
		
		public function get width():int
		{
			return this[0].length;
		}
		
		public function get height():int
		{
			return this.length;
		}
	}

}