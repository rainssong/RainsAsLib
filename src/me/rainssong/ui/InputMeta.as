package me.rainssong.ui 
{
	/**
	 * ...
	 * @author Rainssong
	 */
	public class InputMeta extends Object 
	{
		/**
		 * 按键是否生效
		 */
		public var isActive:Boolean = false;
		public var x:Number=0;
		public var y:Number=0;
		public var power:Number = 0;
		
		public function InputMeta() 
		{
			super();
		}
		
		public function get radians():Number
		{
			if (y == 0) return Math.PI / 2;
			return Math.atan2(y, x);
		}
		
		public function get length():Number
		{
			return Math.sqrt(x * x, y * y, z * z);
		}
		
	}

}