package world.entity.creature
{
	import flash.geom.Point;
	import flash.geom.Vector3D;
	import world.entity.EntityModel;
	/**
	 * ...
	 * @author Rainssong
	 */
	public class CreatureModel extends EntityModel 
	{
		private var _isAlive:Boolean = false;
		private var _lifetime:Number=0;
		private var _health:Number = 1;
		private var _food:Number = 1;
		private var _energy:Number = 1;
		
		
		public function CreatureModel() 
		{
			super();
		}
		
		public function born():void
		{
			_isAlive = true;
		}
		
		public function reborn():void
		{
			_isAlive = true;
		}
		
		public function die():void
		{
			_isAlive = false;
		}
		
		public function think():void
		{
			
		}
		
		public function act():void
		{
			
		}
		
		public function feel(information:*):void
		{
			
		}
		
		
		
		public function grow():void
		{
			
		}
		
		public function eat(food:EntityModel):void
		{
			
		}
		
		public function release():EntityModel
		{
			
		}
		
		public function get isAlive():Boolean
		{
			return _isAlive;
		}
		
		
		
		
	}

}