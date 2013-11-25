package  me.rainssong.display
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.IBitmapDrawable;
	import flash.filters.DropShadowFilter;
	import flash.geom.Matrix;
	import flash.geom.Rectangle;
	
	/**
	 * ...
	 * @author Rainssong
	 */
	public class LCDRender extends Bitmap 
	{
    private var _screen:BitmapData = new BitmapData(384, 384, true, 0);
    private var _display:BitmapData = new BitmapData(400, 400, false, 0);
    private var _cls:BitmapData = new BitmapData(400, 400, false, 0);
    private var _matS2D:Matrix = new Matrix(1,0,0,1,8,8);
    private var _shadow:DropShadowFilter = new DropShadowFilter(4, 45, 0, 0.6, 6, 6);
    private var _data:BitmapData = new BitmapData(96, 96, false, 0);
    private var _residueMap:Vector.<Number> = new Vector.<Number>(9216, true);
    private var _toneFilter:uint;
    private var _dotColor:uint;
    private var _residue:Number;
    private var dot:Rectangle = new Rectangle(0,0,3,3);
    private var mat:Matrix = new Matrix();
    
    /**
     *  Create a new instance of the LCDBitmapOldSkool with setting.
     *  @param bit The bit count of shades of gray scale. the bit=2 sets 4 shades of gray scale.
     *  @param backColor The background color of display.
     *  @dot0Color The color for the pixel of 0.
     *  @dot0Color The color for the pixel of 1.
     *  @residue The ratio of residual image for 1 update.
     */
		public function LCDRender(bit:int=2, 
						   backColor:uint = 0xb0c0b0, 
						   dot0Color:uint = 0xb0b0b0, 
						   dot1Color:uint = 0x000000, 
						   residue:Number = 0.5) 
		{
			_toneFilter = 0xff00 >> bit;
			_dotColor = dot1Color;
			_cls.fillRect(_cls.rect, backColor);
			_residue = residue;
			for (dot.x=8; dot.x<392; dot.x+=4)
				for (dot.y=8; dot.y<392; dot.y+=4)
					_cls.fillRect(dot, dot0Color);
			super(_display);
			x = 32;
			y = 32;
		}
    
    
    /** 
     *  Rendering LCD Bitmap.
     *  @param source Source BitmapData rendering on the old-school LCD display.
     */
		public function render(src:DisplayObject) : void
		{
			var x:int, y:int, rgb:uint, mask:uint, i:int, r:Number=96/src.width;
			_data.lock();
			_screen.lock();
			mat.identity();
			mat.scale(r, r);
			_data.draw(src, mat, null, null, null, true);
			_screen.fillRect(_screen.rect, 0);
			for (i=0, dot.y=0, y=0; y<96; dot.y+=4, y++)
				for (dot.x = 0, x = 0; x < 96; dot.x += 4, x++, i++) 
				{
					rgb = _data.getPixel(x, y);
					rgb = ((((rgb>>18)&63)+((rgb>>9)&127)+((rgb>>3)&31)) & _toneFilter) + int(_residueMap[i]);
					mask = rgb & 0x100;
					rgb |= mask - (mask>>8);
					_residueMap[i] = (rgb&0xff) * _residue;
					if (rgb) _screen.fillRect(dot, (rgb<<24) | _dotColor);
				}
			_screen.applyFilter(_screen, _screen.rect, _screen.rect.topLeft, _shadow);
			_display.copyPixels(_cls, _cls.rect, _cls.rect.topLeft);
			_display.draw(_screen, _matS2D);
			_data.unlock();
			_screen.unlock();
		}
		
	
		
	}

}