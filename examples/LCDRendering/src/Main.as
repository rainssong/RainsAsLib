// Old-skool LCD rendering
//   click to display original image
//--------------------------------------------------
package
{
	import flash.display.*;
	import flash.geom.*;
	import flash.events.*;
	import flash.text.*;
	
	[SWF(width="740",height="540",backgroundColor="0",frameRate="10")]
	
	public class Main extends Sprite
	{
		private var _lcd:LCDRender;
		private var _screen:BitmapData = new BitmapData(740, 540, false, 0xffffff);
		private var _bitmap:Bitmap = new Bitmap(_screen);
		private var _shape:Shape = new Shape();
		private var _vbuf:Vector.<Number> = new Vector.<Number>();
		private var _vout:Vector.<Number> = new Vector.<Number>();
		private var _uvt:Vector.<Number> = new Vector.<Number>();
		private var _ibuf:Vector.<int> = new Vector.<int>();
		private var _projector:Matrix3D = new Matrix3D();
		private var _matrix:Matrix3D = new Matrix3D();
		private var _centering:Matrix = new Matrix(1, 0, 0, 1, 192, 210);
		private var _rotation:Number = 20;
		private var _text:TextField = new TextField();
		private var _movie:MovieClip;
		private var s1:Sprite = new Sprite();
		private var s2:Sprite = new Sprite();
		private var bmd:BitmapData;
		
		[Embed(source="waitandsee.swf")]
		public static const MOVIE:Class
		
		function Main()
		{
			
			_movie = new MOVIE();
			// LCDRender を addChild
			addEventListener(Event.ENTER_FRAME, _onEnterFrame);
			_lcd = new LCDRender();
			bmd = new BitmapData(stage.stageWidth, stage.stageHeight);
			addChild(_movie)
			addChild(_lcd);
			
			_movie.visible = false;
			stage.addEventListener(MouseEvent.CLICK, _onClick);
		}
		
		private function _onEnterFrame(e:Event):void
		{
			bmd.draw(_movie,new Matrix(2,0,0,2,0,0));
			_lcd.render(bmd);
		}
		
		private function _onClick(e:MouseEvent):void
		{
			_lcd.visible = !_lcd.visible;
			_movie.visible = !_movie.visible;
		}
	}
}
