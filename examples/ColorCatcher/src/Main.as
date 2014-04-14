package
{
	//import flash.desktop.NativeApplication;
	import com.bit101.components.ScrollBar;
	import com.bit101.components.Slider;
	import flash.display.Shape;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import me.rainssong.tools.SimpleGUI;
	import me.rainssong.utils.Draw;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.BlendMode;
	import flash.events.Event;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.filters.BlurFilter;
	import flash.geom.ColorTransform;
	import flash.geom.Rectangle;
	import flash.media.Camera;
	import flash.media.Video;
	import flash.net.FileFilter;
	import flash.ui.Multitouch;
	import flash.ui.MultitouchInputMode;
	import me.rainssong.math.ArrayCore;
	
	/**
	 * ...
	 * @author Rainssong
	 */
	public class Main extends Sprite
	{
		
		public var video:Video;
		private var camera:Camera;
		
		private var bmd:BitmapData
		private var bmd2:BitmapData
		private var bmp:Bitmap;
		private var bmp2:Bitmap;
		private var redSlider:Slider;
		private var greenSlider:Slider;
		private var blueSlider:Slider;
		private var _gui:SimpleGUI
		public var redOffset:Number = 0;
		public var greenOffset:Number = 0;
		public var blueOffset:Number = 0;
		public var blurFilter:BlurFilter = new BlurFilter();
		public var showBlurFilter:Boolean = false;
		
		public var operation:String = ">"
		public var threshold:uint = 0x00800000;
		public var color:uint = 0xFF0000
		public var masker:uint = 0x00ff0000
		public var copySource:Boolean = true
		public var operation2:String = ">"
		public var threshold2:uint = 0x00890000;
		public var color2:uint = 0xffff00ff
		public var masker2:uint = 0x00ff0000
		public var copySource2:Boolean = true
		
		public var operation3:String = ">"
		public var threshold3:uint = 0x00890000;
		public var color3:uint = 0xffff00ff
		public var masker3:uint = 0x00ff0000
		public var copySource3:Boolean = true
		
		public var active:Boolean = true
		public var active2:Boolean = true
		public var active3:Boolean = true
		
		public var shape:Sprite = Draw.getBoxSp(100, 100, 0xDDDD00);
		
		
		public var mask4:uint = 0;
		public var color4:uint = 0;
		
		
		public function Main():void
		{
			
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT
			// touch or gesture?
			Multitouch.inputMode = MultitouchInputMode.TOUCH_POINT;
			
			// entry point
			
			camera = Camera.getCamera();
			camera.setMode(stage.stageWidth * 0.5, stage.stageWidth / 4 * 3 * 0.5, 25);
			
			bmd = new BitmapData(camera.width, camera.height);
			bmd2 = new BitmapData(camera.width, camera.height);
			addChild(bmp = new Bitmap(bmd));
			addChild(bmp2 = new Bitmap(bmd2));
			bmp2.x = bmp.width;
			threshold = 8388608;
			color = 16711680;
			masker = 16711680;
			copySource = true;
			active2 = true;
			
			threshold2 = 32768;
			color2 = 65280;
			masker2 = 65280;
			copySource2 = true;
			active3 = true;
			
			threshold3 = 128;
			color3 = 255;
			masker3 = 255;
			copySource3 = true;
			
			video = new Video(camera.width, camera.height);
			video.attachCamera(camera);
			//addChild(video);
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
			
			_gui = new SimpleGUI(this, "Example GUI");
			_gui.message = "fuck"
			_gui.addGroup("General Settings");
			_gui.addSlider("redOffset", -255, 255, {callback: change});
			_gui.addSlider("greenOffset", -255, 255, {callback: change});
			_gui.addSlider("blueOffset", -255, 255, {callback: change});
			_gui.addColumn("filters");
			_gui.addToggle("showBlurFilter", {callback: change})
			_gui.addColumn("threshold");
			var arr:Array = [{label: "<", data: "<"}, {label: "<=", data: "<="}, {label: ">", data: ">"}, {label: ">=", data: ">="}, {label: "==", data: "=="}, {label: "!=", data: "!="}];
			_gui.addToggle("active")
			_gui.addComboBox("operation", arr);
			_gui.addColour("threshold");
			_gui.addColour("color");
			_gui.addColour("masker");
			_gui.addToggle("copySource")
			_gui.addColumn("threshold2");
			_gui.addToggle("active2")
			_gui.addComboBox("operation2", arr);
			_gui.addColour("threshold2");
			_gui.addColour("color2");
			_gui.addColour("masker2");
			_gui.addToggle("copySource2")
			_gui.addColumn("threshold3");
			_gui.addToggle("active3")
			_gui.addComboBox("operation3", arr);
			_gui.addColour("threshold3");
			_gui.addColour("color3");
			_gui.addColour("masker3");
			_gui.addToggle("copySource3")
			_gui.addColumn("colorRect");
			_gui.addColour("mask4")
			_gui.addColour("color4")
			
			_gui.show();
			
			addChild(shape);
			//redSlider = new Slider(Slider.HORIZONTAL, this,700, 0, change);
			stage.addEventListener(MouseEvent.CLICK, onClick);
		
		}
		
		private function onClick(e:MouseEvent):void 
		{
			color4 = bmd.getPixel32(mouseX, mouseY);
			powerTrace(color4.toString(16));
		}
		
		private function change():void
		{
			var ct:ColorTransform = bmp2.transform.colorTransform
			ct.redOffset = redOffset;
			ct.greenOffset = greenOffset;
			ct.blueOffset = blueOffset;
			bmp.transform.colorTransform = ct
			//bmp2.transform.colorTransform = ct;
		
			//bmd.colorTransform
			//var filters:Array = bmd.filters;
			//showBlurFilter?filters.push(blurFilter):filters=ArrayCore.subtract( filters,[blurFilter]);
			//bmd.filters = filters;
		
		}
		
		private function onEnterFrame(e:Event):void
		{
			bmd.draw(video);
			bmd2.draw(bmd);
			if (active)
				bmd2.threshold(bmd2, bmd2.rect, new Point(), operation, threshold + 0xFF000000, color + 0xFF000000, masker + 0xFF000000, copySource);
			if (active2)
				bmd2.threshold(bmd2, bmd2.rect, new Point(), operation2, threshold2 + 0xFF000000, color2 + 0xFF000000, masker2 + 0xFF000000, copySource2);
			if (active3)
				bmd2.threshold(bmd2, bmd2.rect, new Point(), operation3, threshold3 + 0xFF000000, color3 + 0xFF000000, masker3 + 0xFF000000, copySource3);
			
			var rect:Rectangle = bmd2.getColorBoundsRect(mask4+ 0xFF000000, color4+0xFF000000, true);
			
			shape.width = rect.width;
			shape.height = rect.height;
			shape.x = rect.x ;
			shape.y = rect.y;
		}
	
	}

}