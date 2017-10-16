package me.rainssong.utils
{
	import com.adobe.images.JPGEncoder;
	import com.adobe.images.PNGEncoder;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.IBitmapDrawable;
	import flash.display.Stage;
	import flash.filesystem.File;
	import flash.geom.Rectangle;
	import flash.ui.Keyboard;
	import flash.utils.ByteArray;
	import me.rainssong.date.DateCore;
	import me.rainssong.filesystem.FileCore;
	import me.rainssong.manager.KeyboardManager;
	import me.rainssong.math.MathCore;
	
	/**
	 * ...
	 * @author Rainssong
	 */
	public class Snapshot
	{
		private  static var _target:DisplayObject;
		public static var type:String="jpg";
		static public function bind(target:DisplayObject, keyCode:uint=Keyboard.SPACE,type:String="jpg"):void
		{
			_target = target;
			if (_target["stage"])
				KeyboardManager.startListen(_target["stage"]);
			else
				KeyboardManager.startListen(_target);
				
			Snapshot.type = type;
				
			KeyboardManager.regFunction(shot, keyCode);
		}
		
		static public function shot(target:IBitmapDrawable=null,type:String=null,rect:Rectangle=null):void
		{
			if (target == null) target = _target;
			if (type == null) type = Snapshot.type;
			if (rect == null)
			{
				if (target is Stage)
				{
					rect = new Rectangle(0, 0, target["stageWidth"], target["stageHeight"]);
				}
				else
				{
					rect = new Rectangle(0, 0, target["width"], target["height"]);
				}
			}
			
			var bmd:BitmapData = new BitmapData(rect.width,rect.height, true, 0xFFFFFF);
			bmd.draw(target,null,null,null,rect);
			var content:ByteArray= type == "png"?PNGEncoder.encode(bmd):new JPGEncoder(80).encode(bmd);
			var file:File=FileCore.createFile(content, "byteArray", File.desktopDirectory.resolvePath(DateCore.format(new Date(),"%Y%M2%D2%h2%m2%s2") + "."+type).nativePath);
			bmd.dispose();
		}
		
	}

}