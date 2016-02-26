package 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import me.rainssong.date.DateCore;
	import me.rainssong.events.ObjectEvent;
	import me.rainssong.service.NTPServers;
	
	/**
	 * @date 2015/12/21 1:22
	 * @author rainssong
	 * @blog http://blog.sina.com.cn/rainssong
	 * @homepage http://rainsgameworld.sinaapp.com
	 * @weibo http://www.weibo.com/rainssong
	 */
	public class NTPTest extends Sprite
	{
		
		private var ntpServers:NTPServers
		
		public function NTPTest()
		{
			ntpServers = new NTPServers();
			ntpServers.addEventListener(Event.COMPLETE, onComplete);
			ntpServers.loadDate(3);
		}
		
		private function onComplete(e:ObjectEvent):void 
		{
			trace(e.data)
		}
		
	}

}