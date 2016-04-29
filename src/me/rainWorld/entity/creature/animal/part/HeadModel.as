package me.rainWorld.entity.creature.animal.part 
{
	import me.rainWorld.entity.EntityModel;
	import me.rainWorld.entity.creature.CreatureModel;
	
	
	/**
	 * @date 2016/3/1 2:54
	 * @author rainssong
	 * @blog http://blog.sina.com.cn/rainssong
	 * @homepage http://rainsgameworld.sinaapp.com
	 * @weibo http://www.weibo.com/rainssong
	 */
	public class HeadModel extends EntityModel 
	{
		protected  var _brain:BrainModel
		
		
		public function HeadModel() 
		{
			super();
			_brain = new BrainModel();
		}
		
		
		
	}

}