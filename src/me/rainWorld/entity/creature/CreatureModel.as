package me.rainWorld.entity.creature
{
	import flash.geom.Point;
	import flash.geom.Vector3D;
	import me.rainWorld.entity.EntityModel;
	/**
	 * ...
	 * @author Rainssong
	 */
	public class CreatureModel extends EntityModel 
	{
		private var _isAlive:Boolean = false;
		private var _lifetime:Number=0;
		private var _health:Number = 1;
		private var _hungry:Number = 0;
		private var _energy:Number = 1;
		
		protected var _posture:String = "stand";
		protected var _emotion:String = "normal";
		
		protected var _items:Array = [];
		
		
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
			return new EntityModel();
		}
		
		public function getItem(item:EntityModel):void
		{
			_items.push(item);
		}
		
		public function thowItem(item:EntityModel):void
		{
			var index:int = _items.indexOf(item);
			if (index < 0)
				powerTrace("It's not my item");
			else
			{
				_items.splice(index, 1);
			}
		}
		
		public function get isAlive():Boolean
		{
			return _isAlive;
		}
		
		
		
		
	}

}