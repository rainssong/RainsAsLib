package
{
	import com.bit101.components.CheckBox;
	import com.bit101.components.Label;
	import com.vsdevelop.controls.Fps;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.media.Camera;
	import flash.media.StageVideo;
	import flash.media.Video;
	import com.bit101.components.ColorChooser
	import flash.system.Capabilities;
	import me.rainssong.math.MathCore;
	import me.rainssong.utils.Color;
	import net.hires.debug.Stats;
	
	/**
	 * ...
	 * @author Rainssong
	 */
	public class NewCatcher extends Sprite
	{
		public var video:Video;
		private var camera:Camera;
		
		private var colorTracker:ColorTracker
		
		private var bmd:BitmapData
		private var bmd2:BitmapData
		private var bmp:Bitmap;
		private var bmp2:Bitmap;
		
		private var colorChooser:ColorChooser
		
		private var detectColor:uint = 0;
		
		private var detectRect:Rectangle = new Rectangle(640, 480, 0, 0);
		
		private var lastPoint:Point = new Point();
		private var pointVector:Vector.<Point> = new Vector.<Point>();
		private var shape:Shape = new Shape();
		private var circle:Shape = new Shape()
		
		private var toggleCamera:CheckBox;
		private var fpsLabel:Label;
		private var flashFps:Label;
		
		private var points:Vector.<Point> = new Vector.<Point>();
		
		public function NewCatcher()
		{
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT
			
			camera = Camera.getCamera(String(Camera.names.length-1));
			camera.setMode(stage.stageWidth, stage.stageHeight, 60);
			//camera.addEventListener(Event.ENTER_FRAME, onEnterFrame);
			video = new Video(camera.width, camera.height);
			
			video.attachCamera(Camera.getCamera());
			bmd = new BitmapData(video.width, video.height);
		
			addChild(bmp = new Bitmap(bmd));
		
			addChild(shape);
			addChild(circle);
			circle.graphics.beginFill(0xFF0000);
			circle.graphics.drawCircle(-2, -2, 4);
			
		
			//video.viewPort = bmd.rect;
			//addChild(video);
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
			stage.addEventListener(MouseEvent.CLICK, onClick);
			
			colorChooser = new ColorChooser(this, 0, 0, 0x00FF00);
			
			fpsLabel = new Label(this, 100, 0, "fps:");
		
			fpsLabel.textField.textColor = 0xFF0000;
		
		}
		
		private function onEnterFrame(e:Event):void
		{
			bmd.draw(video);
			if (!colorTracker) return;
			
			fpsLabel.text = "fps:" + camera.currentFPS;
			
			var pps:Vector.<Point> = colorTracker.trackPoints;
			
			points.push(MathCore.averagePoint(pps));
			
			
			if (points.length > 5) points.shift();
			var p:Point = MathCore.averagePoint(points);
			if (points.length == 1) shape.graphics.moveTo(p.x, p.y)
			
			circle.x = p.x;
			circle.y = p.y;
			
		
			
			for each(var pp:Point in pps)
				bmd.setPixel(pp.x, pp.y, 0xFF0000);
				
			if (isNaN(p.x)) return;
			//shape.graphics.lineStyle(1,0xFF0000);
			shape.graphics.lineTo(p.x, p.y);
		}
		
		private function onClick(e:MouseEvent):void
		{
			if (mouseY < 50)
				return;
				
			shape.graphics.clear();
			shape.graphics.lineStyle(1, 0xFF0000);
			points = new Vector.<Point>();
		
			//shape.graphics.moveTo(mouseX,mouseY)
			colorTracker = new ColorTracker(bmd, bmd.getPixel(mouseX, mouseY));
			colorChooser.value = colorTracker.color;
		
		}
		
		public function getCenterPoint(vec:Vector.<Point>):Point
		{
			var point:Point = new Point();
			for each (var p:Point in vec)
			{
				point.x += p.x;
				point.y += p.y;
			}
			point.x /= vec.length;
			point.y /= vec.length;
			return point;
		}
		
		
	}
}