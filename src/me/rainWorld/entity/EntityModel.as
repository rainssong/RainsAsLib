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
	dynamic public class EntityModel extends ChaosModel
	{
		protected var _name:String = "unknown";
		//内部的数据
		public var position:Vector3D = new Vector3D();
		public var speed:Vector3D = new Vector3D();
		public var velocity:Vector3D = new Vector3D();
		public var angSpeed:Number = 0;
		public var rotation:Number = 0;
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

		public function get name():String
		{
			return _name;
		}

		public function set name(value:String):void
		{
			_name = value;
		}
		
		
		
	}

}