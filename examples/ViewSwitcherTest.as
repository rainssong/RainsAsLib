package 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.ui.Keyboard;
	import me.rainssong.manager.KeyboardManager;
	import me.rainssong.tween.AnimationCore;
	import me.rainssong.tween.ViewSwitcher;
	
	
	/**
	 * @date 2015/11/12 5:07
	 * @author ...
	 * @blog http://blog.sina.com.cn/rainssong
	 * @homepage http://rainsgameworld.sinaapp.com
	 * @weibo http://www.weibo.com/rainssong
	 */
	public class ViewSwitcherTest extends Sprite 
	{
		private var bmp1:Bitmap = new Bitmap(new BitmapData(400, 400, false, 0xff0000));
		private var bmp2:Bitmap = new Bitmap(new BitmapData(400, 400, false, 0x00ff00));
		public function ViewSwitcherTest() 
		{
			super();
			
			KeyboardManager.startListen(stage);
			KeyboardManager.regFunction(onA, Keyboard.A);
			KeyboardManager.regFunction(onS, Keyboard.S);
			KeyboardManager.regFunction(onD, Keyboard.D);
			KeyboardManager.regFunction(onR, Keyboard.R);
			addChild(bmp1);
		}
		
		private function onA():void 
		{
			ViewSwitcher.switchView(bmp1,bmp2,"fadeBlack",{delay:0.5,duration:1});
		}
		
		private function onS():void 
		{
			ViewSwitcher.switchView(bmp1,bmp2,"fadeOut",{delay:0.5,duration:1});
		}
		private function onD():void 
		{
			ViewSwitcher.switchView(bmp1,bmp2,"fadeOutIn",{delay:0.5,duration:1});
		}
		
		private function onR():void 
		{
			ViewSwitcher.switchView(bmp2,bmp1,"none",{duration:0});
		}
	}
	
	

}