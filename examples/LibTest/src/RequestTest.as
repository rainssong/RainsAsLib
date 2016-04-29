package 
{
	import flash.display.Sprite;
	import flash.net.URLRequestMethod;
	import me.rainssong.events.RequestEvent;
	import me.rainssong.manager.RequestManager;
	
	
	/**
	 * @date 2016/4/7 2:04
	 * @author rainssong
	 * @blog http://blog.sina.com.cn/rainssong
	 * @homepage http://rainsgameworld.sinaapp.com
	 * @weibo http://www.weibo.com/rainssong
	 */
	public class RequestTest extends Sprite 
	{
		private var rm:RequestManager;
		
		public function RequestTest() 
		{
			super();
			rm = new RequestManager();
			rm.addEventListener(RequestEvent.COMPLETE, onComplete);
			rm.sendRequest({userid:"410008"},"http://139.196.172.125:8080/baxter/getUser.asp",URLRequestMethod.GET);
			
			
		}
		
		private function onComplete(e:RequestEvent):void 
		{
			powerTrace(e.data);
			
		}
		
	}

}