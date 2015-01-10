package me.rainWorld.entity.item 
{
	import me.rainWorld.concept.physics.SpaceModel;
	import me.rainWorld.entity.EntityModel;
	
	
	/**
	 * @date 2014/12/22 0:17
	 * @author Rainssong
	 * @blog http://blog.sina.com.cn/rainssong
	 * @homepage http://rainsgameworld.sinaapp.com
	 * @weibo http://www.weibo.com/rainssong
	 */
	public class BuildingModel extends EntityModel 
	{
		protected var _floors:Vector.<SpaceModel>=new Vector.<SpaceModel>;
		public function BuildingModel() 
		{
			super();
			mass = Number.POSITIVE_INFINITY;
			var sm:SpaceModel = new SpaceModel();
			sm.width = 100;
			sm.height = 100;
			sm.length = 100;
			_floors.push(new SpaceModel());
		}
		
	}

}