package world.model.creature 
{
	import flash.geom.Point;
	import flash.geom.Vector3D;
	/**
	 * ...
	 * @author Rainssong
	 */
	public class CreatureModel extends Object 
	{
		
		private var _isAlive:Boolean = false;
		private var _location:Vector3D;
		private var _lifetime:Number=0;
		private var _hp:Number;
		
		
		
		public function CreatureModel() 
		{
			super();
		}
		
		public function born():void
		{
			_isAlive = true;
		}
		
		public function death():void
		{
			_isAlive = false;
		}
		
		public function think():void
		{
			
		}
		
		public function move():void
		{
			
		}
		
		public function grow():void
		{
			
		}
		
		public function eat(food:*):void
		{
			
		}
		
		public function get isAlive():Boolean
		{
			return _isAlive;
		}
		
		
		
		
	}

}