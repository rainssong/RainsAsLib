package  world.entity
{
	import flash.geom.Vector3D;
	import world.ChaosModel
	/**
	 * ...
	 * @author Rainssong
	 * @timeStamp 2013/11/26 18:46
	 * @blog http://blog.sina.com.cn/rainssong
	 */
	public class EntityModel extends ChaosModel
	{
		//内部的数据
		public var position:Vector3D = new Vector3D();
		public var speed:Vector3D = new Vector3D();
		public var weight:Number = 0;
		public var width:Number=0;
		public var height:Number = 0;
		public var length:Number = 0;
		public var mass:Number = 0;
		//外界的感知
		public var environment:Object = { };
		
		
		public function EntityModel() 
		{
			super();
			this.name = "entity";
		}
		
		
		
	}

}