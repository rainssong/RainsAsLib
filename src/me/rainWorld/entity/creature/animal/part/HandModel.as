package me.rainWorld.entity.creature.animal.part 
{
	import me.rainWorld.entity.creature.CreatureModel;
	import me.rainWorld.entity.EntityModel;
	
	
	/**
	 * @date 2014/12/17 2:43
	 * @author Rainssong
	 * @blog http://blog.sina.com.cn/rainssong
	 * @homepage http://rainsgameworld.sinaapp.com
	 * @weibo http://www.weibo.com/rainssong
	 */
	public class HandModel extends EntityModel 
	{
		protected var _owner:CreatureModel;
		protected var _items:Array = [];
		
		public function HandModel() 
		{
			super();
		}
		
	}

}