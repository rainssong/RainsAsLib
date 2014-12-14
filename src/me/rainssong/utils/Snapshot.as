package me.rainssong.utils
{
	import com.adobe.images.JPGEncoder;
	import com.adobe.images.PNGEncoder;
	import flash.display.BitmapData;
	import flash.display.IBitmapDrawable;
	import flash.display.Stage;
	import flash.filesystem.File;
	import flash.ui.Keyboard;
	import flash.utils.ByteArray;
	import me.rainssong.filesystem.FileCore;
	import me.rainssong.manager.KeyboardManager;
	import me.rainssong.math.MathCore;
	
	/**
	 * ...
	 * @author Rainssong
	 */
	public class Snapshot
	{
		private  static var _target:IBitmapDrawable;
		static public function bind(stage:Stage, keyCode:uint=Keyboard.SPACE):void
		{
			_target = stage;
			KeyboardManager.startListen(stage);
			KeyboardManager.regFunction(shot, keyCode);
		}
		
		static public function shot(target:IBitmapDrawable=null,type:String="jpg"):void
		{
			if (target == null) target = _target;
			var bmd:BitmapData = new BitmapData(target["width"], target["height"], false, 0xFFFFFF);
			bmd.draw(target);
			var content:ByteArray= type == "png"?PNGEncoder.encode(bmd):new JPGEncoder().encode(bmd);
			var file:File=FileCore.createFile(PNGEncoder.encode(bmd), "byteArray", File.desktopDirectory.resolvePath(DateCore.format(new Date(),"%Y%M2%D2%h2%m2%s2") + ".png").nativePath);
			bmd.dispose();
		}
	}

}