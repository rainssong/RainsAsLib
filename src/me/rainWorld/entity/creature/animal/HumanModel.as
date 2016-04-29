package  me.rainWorld.entity.creature.animal
{
	import me.rainWorld.entity.creature.animal.part.BodyModel;
	import me.rainWorld.entity.creature.animal.part.HandModel;
	import me.rainWorld.entity.creature.CreatureModel;
	import me.rainWorld.entity.creature.animal.part.HeadModel;
	import me.rainWorld.entity.creature.animal.part.LegModel;
	
	
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
		
		protected var _head:HeadModel = new HeadModel();
		protected var _leftHand:HandModel = new HandModel();
		protected var _rightHand:HandModel = new HandModel();
		protected var _body:BodyModel = new BodyModel();
		protected var _leftLeg:LegModel = new LegModel();
		protected var _rightLeg:LegModel = new LegModel();
		
		public function HumanModel() 
		{
			super();
			this.mass = 60;
		}
		
	}

}