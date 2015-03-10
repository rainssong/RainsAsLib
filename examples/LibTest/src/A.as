package  
{
	
	/**
	 * @date 2015/3/3 10:58
	 * @author Rainssong
	 * @blog http://blog.sina.com.cn/rainssong
	 * @homepage http://rainsgameworld.sinaapp.com
	 * @weibo http://www.weibo.com/rainssong
	 */
	public class A implements IA 
	{
		
		public function A() 
		{
			
		}
		
		/* INTERFACE IA */
		
		public function getA():A
		{
			powerTrace("funny")
			return this;
		}
		
	}

}