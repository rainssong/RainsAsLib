package me.rainssong.application 
{
	import me.rainssong.manager.EnterFrameManager;
	import me.rainui.components.Container;
	
	/**
	 * @date 2014/12/23 21:12
	 * @author Rainssong
	 * @blog http://blog.sina.com.cn/rainssong
	 * @homepage http://rainsgameworld.sinaapp.com
	 * @weibo http://www.weibo.com/rainssong
	 */
	public class GameBase extends Container implements IGame 
	{
		
		public function GameBase() 
		{
			super();
		}
		
		/* INTERFACE me.rainssong.application.IGame */
		
		public function reset():void 
		{
			
		}
		
		public function pause():void 
		{
			
		}
		
		public function resume():void 
		{
			
		}
		
		public function gameOver():void 
		{
			
		}
		
		public function gameStart():void 
		{
			
		}
		
		public function save(index:uint = 0):void 
		{
			
		}
		
		public function load(index:uint = 0):void 
		{
			
		}
		
	}

}