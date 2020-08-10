package 
{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import me.rainssong.display.BitmapDataCore;
	import me.rainssong.utils.ScaleMode;
	import me.rainui.components.Image;
	import flash.geom.Rectangle;
	
	
	/**
	 * @date 2018-12-21 17:54
	 * @author Rainssong
	 * @blog http://blog.sina.com.cn/rainssong
	 * @homepage http://rainsgameworld.sinaapp.com
	 * @weibo http://www.weibo.com/rainssong
	 */
	

	 
	 
	 //[Embed(source = "../../embed/UI/FullStar.png")]
	//static private const FULL_STAR_SKIN_CLASS:Class
	 
	public class Scale9ImageTest extends Sprite 
	{
			 
		[Embed(source = "../../../embeds/rain_logo.jpg")]
		static private const BMP_CLASS:Class;
			
		public var image:Image;
		public var bmp:Bitmap
		public var sourceBmp:Bitmap
		public function Scale9ImageTest() 
		{
			super();
			
			image = new Image();
			addChild(image);
			image.contentScaleMode=ScaleMode.EXACT_FIT
			image.url = "rain_logo.jpg";
			//image.bitmapData = (new BMP_CLASS()).bitmapData;
			image.scale9Rect = new Rectangle(120, 120, 400, 400);
			//
			stage.addEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
			
			addChild(sourceBmp = new Bitmap())
			sourceBmp.x = 640;
			sourceBmp.y = 640;
			sourceBmp.scaleX = 0.2;
			sourceBmp.scaleY= 0.2;
			//bmp = new BMP_CLASS() as Bitmap;
			//sourceBmp = new Bitmap();
			//sourceBmp.bitmapData = bmp.bitmapData;
			//addChild(bmp);
			//bmp.bitmapData=
			
		}
		
		private function onMouseMove(e:MouseEvent):void 
		{
			image.width = stage.mouseX;
			image.height = stage.mouseY;
			
			
			sourceBmp.bitmapData = image.bitmapData;
			//bmp.bitmapData = BitmapDataCore.scale9Bmd(sourceBmp.bitmapData, new Rectangle(120, 120, 400, 400), stage.mouseX, stage.mouseY);
		}
		
		
		
	}

}