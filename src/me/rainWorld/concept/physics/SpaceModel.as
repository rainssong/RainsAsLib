package  me.rainWorld.concept.physics
{
	import me.rainWorld.ConcreteChaosModel;
	import me.rainWorld.entity.EntityModel;
	
	
	/**
	 * @date 2014/12/17 2:33
	 * @author Rainssong
	 * @blog http://blog.sina.com.cn/rainssong
	 * @homepage http://rainsgameworld.sinaapp.com
	 * @weibo http://www.weibo.com/rainssong
	 */
	public class SpaceModel extends ConcreteChaosModel 
	{
		public var width:Number=100;
		public var height:Number = 100;
		public var length:Number = 100;
		public const contents:Array = [];
		
		public function SpaceModel() 
		{
			super();
		}
		
		public function addContent(content:EntityModel):void
		{
			contents.push(content);
			content.environment = this;
		}
		
		public function removeContent(content:EntityModel):void
		{
			var index:int = contents.indexOf(content);
			contents.splice(index, 1);
			content.environment = null;
		}
	}

}