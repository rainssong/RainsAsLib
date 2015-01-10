package  me.rainWorld.entity.creature.animal
{
	import me.rainWorld.entity.creature.animal.part.HandModel;
	import me.rainWorld.entity.creature.CreatureModel;
	
	
	/**
	 * @date 2014/12/17 2:21
	 * @author Rainssong
	 * @blog http://blog.sina.com.cn/rainssong
	 * @homepage http://rainsgameworld.sinaapp.com
	 * @weibo http://www.weibo.com/rainssong
	 */
	public class HumanModel extends CreatureModel 
	{
		protected var _name:String = "unknown";
		protected var _race:String = "unknown";
		protected var _skinColor:uint = 0xffffff;
		
		protected var _leftHand:HandModel = new HandModel();
		protected var _rightHand:HandModel = new HandModel();
		
		public function HumanModel() 
		{
			super();
			this.mass = 50;
		}
		
	}

}