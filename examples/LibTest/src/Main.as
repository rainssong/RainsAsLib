package 
{
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.text.TextField;
	import me.rainssong.utils.Color;
	import me.rainssong.utils.Draw;
	import utils.GamePad;
	import utils.Logitech;
	
	/**
	 * ...
	 * @author Mike
	 */
	public class Main extends Sprite 
	{
		
		private var ball:Sprite;
		private var frameTime:TextField;
		private var lastFrameTime:Number;
		private var ySpeed:Number = 0;
		private var xSpeed:Number = 0;
		private var energy:Number = 100;
		
		private const speed:Number = 8;
		private const jumpSpeed:Number = 14;
		
		private var energyBar:Sprite;
		
		public function Main():void 
		{
			var j:JoyStick = new JoyStick(this);
			j.setBallTexture(new BitmapData(100, 100, false, Color.BlanchedAlmond));
			j.setDockTexture(new BitmapData(100, 100, false, Color.Tomato));
			j.setStickTexture(new BitmapData(100, 100, false, Color.ForestGreen));
			
		}
		
	}
	
}