package me.rainssong.components 
{
	import me.rainssong.display.LiquidSprite;
	
	/**
	 * ...
	 * @author Rainssong
	 * @timeStamp 2013/12/10 15:45
	 * @blog http://blog.sina.com.cn/rainssong
	 */
	public class Component extends LiquidSprite 
	{
		private var _activeted:Boolean = true;
		
		public function Component() 
		{
			super();
		}
		
		protected function refreash():void
		{
			
		}
		
		public function get activeted():Boolean 
		{
			return _activeted;
		}
		
		public function active():void
		{
			_activeted = true;
		}
		
		public function deactive():void
		{
			_activeted = false;
		}
		
	}

}