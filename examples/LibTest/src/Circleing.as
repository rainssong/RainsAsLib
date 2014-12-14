package
{
	import avmplus.getQualifiedClassName;
	import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.filesystem.File;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.system.ApplicationDomain;
	import flash.system.LoaderContext;
	import flash.utils.ByteArray;
	import flash.utils.getDefinitionByName;
	import me.rainssong.filesystem.FileCore;
	import me.rainssong.utils.Draw;
	import mx.core.ByteArrayAsset;
	
	public class Main extends Sprite
	{
		
		//public const mathSin:Function = Math.sin;
		//[Embed(source="cha", mimeType="application/octet-stream")]
		//public static var Data:Class
		private var circle1:Sprite = new Sprite();
		private var circle2:Sprite = new Sprite();
		private var circle3:Sprite = new Sprite();
		
		private var radian:Number = 0.01
		private var dis:Number = circle1.width / 2
		private var cos:Number = Math.cos(radian)
		private var sin:Number = Math.sin(radian)
		
		public function Main():void
		{
			addChild(circle1);
			circle1.addChild(circle2);
			circle1.addChild(circle3);
			Draw.cirlce(circle1.graphics, 0, 0, 80, 0xFF0000);
			Draw.cirlce(circle2.graphics, 0, 0, 10, 0x00FF00);
			Draw.cirlce(circle3.graphics, 0, 0, 10, 0x00FF00);
			circle1.x = 100;
			circle1.y = 100;
			circle2.x = 125;
			circle2.y = 110;
			//stage.addEventListener(Event.ENTER_FRAME, onEnterFrame);
			
			circle2.addEventListener(Event.REMOVED, onRemove);
			circle2.addEventListener(Event.REMOVED_FROM_STAGE, onRemove);
			circle3.addEventListener(Event.REMOVED, onRemove);
			circle3.addEventListener(Event.REMOVED_FROM_STAGE, onRemove);
			
			circle1.removeChild(circle2);
			this.removeChild(circle1);
		}
		
		private function onRemove(e:Event):void 
		{
			powerTrace(e.type, e.target);
		}
		
		private function onEnterFrame(e:Event):void
		{
			var tx:Number = circle2.x - circle1.x
			var ty:Number = circle2.y - circle1.y
			//转换坐标
			var x1:Number = cos * tx - sin * ty
			var y1:Number = cos * ty + sin * tx
			//重新设置物体在圆上的坐标
			circle2.x = x1 + circle1.x
			circle2.y = y1 + circle1.y
		}
		
	
	
	}

}