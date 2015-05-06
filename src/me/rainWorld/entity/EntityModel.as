package  me.rainWorld.entity
{
	import flash.geom.Vector3D;
	import me.rainWorld.ChaosModel;
	import me.rainWorld.concept.physics.SpaceModel;
	/**
	 * @author Rainssong
	 * @timeStamp 2013/11/26 18:46
	 * @blog http://blog.sina.com.cn/rainssong
	 */
	
	/**
	 *  狭义实体
	 */
	public class EntityModel extends ChaosModel
	{
		//内部的数据
		public var position:Vector3D = new Vector3D();
		public var speed:Vector3D = new Vector3D();
		public var width:Number=0;
		public var height:Number = 0;
		public var length:Number = 0;
		public var mass:Number = 0;
		public var density:Number = 0;
		//外界的感知
		public var environment:SpaceModel;
		
		
		public function EntityModel() 
		{
			super();
		}
		
		public function update():void
		{
			
		}
		
		
		
	}

}