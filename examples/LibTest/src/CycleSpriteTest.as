package 
{
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.Event;
	import me.rainssong.display.CycleSprite
	import me.rainssong.display.CycleSprite;
	import me.rainssong.utils.Color;
	import net.hires.debug.Stats;
	
	/**
	 * @date 2015/7/2 22:44
	 * @author rainssong
	 * @blog http://blog.sina.com.cn/rainssong
	 * @homepage http://rainsgameworld.sinaapp.com
	 * @weibo http://www.weibo.com/rainssong
	 */
	[SWF(width="600",height="600",backgroundColor="#000000",frameRate="60")]
	public class CycleSpriteTest extends Sprite 
	{
		private var arr:Array.<CycleSprite> = [];
		private var bmd:BitmapData;
		public function CycleSpriteTest() 
		{
			super();
			bmd = new BitmapData(800, 600,false,0xff);
			bmd.draw(Color.getColorListView());
			
			for (var i:int = 0; i < 100; i++) 
			{
				var cs:CycleSprite = new CycleSprite(bmd, 60, 60);
				arr.push(cs);
				addChild(cs);
				cs.x = 60 * (i % 10);
				cs.y = 60 * Math.floor(i / 10);
			}
			
			stage.addEventListener(Event.ENTER_FRAME, oef);
			
			stage.addChild(new Stats)
		}
		
		
		private function oef(e:Event):void 
		{
			
			for each (var item:CycleSprite in  arr) 
			{
				item.scrollX++;
				item.scrollY++;
			}
			
		}
		
	}

}