package  me.rainssong.display
{
	import flash.display.Bitmap;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	
	import flash.display.Sprite;
	import me.rainssong.display.MyMovieClip;
	import me.rainssong.display.Slide;
	
	/**
	 * ...
	 * @author rainssong
	 */
	public dynamic class Slide extends MyMovieClip implements ISlide 
	{
		
		protected var _isLocked:Boolean = false;
		
		
		public function Slide() 
		{
			super();
			
		}
		
		public function lock():void
		{
			_isLocked = true;
			
			//mouseEnabled = true;
			//mouseChildren = true;
		}
		
		public function unlock():void
		{
			_isLocked = false;
			
			//mouseEnabled = false;
			//mouseChildren = false;
		}
		
		public function get isLocked():Boolean 
		{
			return _isLocked;
		}
		
		override public function enable():void 
		{
			super.enable();
			play();
		}
		
		override public function disable():void 
		{
			super.disable();
			gotoAndStop(1);
		}
		
		
		
	}

}