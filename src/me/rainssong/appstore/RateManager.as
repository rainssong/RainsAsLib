package me.rainssong.appstore 
{
	import com.freshplanet.ane.AirAlert.AirAlert;
	import flash.net.SharedObject;
	import flash.net.URLRequest;
	import flash.net.navigateToURL;
	
	/**
	 * @date 2017/9/26 6:15
	 * @author rainssong
	 * @blog http://blog.sina.com.cn/rainssong
	 * @homepage http://www.rainssong.com
	 * @weibo http://www.weibo.com/rainssong
	 */
	public class RateManager 
	{
		
		public static const APPSTORE_ID:String = "";
		public static const APPSTORE_RATE_URL:String = "itms-apps://itunes.apple.com/app/id" + APPSTORE_ID;
		public static var so:SharedObject;
		
		public function RateManager() 
		{
			
		}
		
		public static function showRate():void
		{
			if (so == null)
				so = SharedObject.getLocal("default");
			
			if (so.data.neveRate == true)
			return;
				
			//AirAlert.instance.showAlert("Rate Me", "", "YES", onYes, "NO", onNo);
		}
		
		private static function onNo():void 
		{
			so.data.neveRate = true;
			//navigateToURL(new URLRequest(APPSTORE_RATE_URL))
		}
		
		private static function onYes():void 
		{
			navigateToURL(new URLRequest(APPSTORE_RATE_URL))
			so.data.neveRate = true;
		}
		
		
	}

}