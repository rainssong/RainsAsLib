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
		
		
		protected var _isLeftRollInEnabled:Boolean = true;
		protected var _isRightRollInEnabled:Boolean = true;
		protected var _isLeftRollOutEnabled:Boolean = true;
		protected var _isRightRollOutEnabled:Boolean = true;
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
		
		public function get isLeftRollInEnabled():Boolean 
		{
			return _isLeftRollInEnabled;
		}
		
		public function get isRightRollInEnabled():Boolean 
		{
			return _isRightRollInEnabled;
		}
		
		public function get isLeftRollOutEnabled():Boolean 
		{
			return _isLeftRollOutEnabled;
		}
		
		public function get isRightRollOutEnabled():Boolean 
		{
			return _isRightRollOutEnabled;
		}
		
		public function get isLocked():Boolean 
		{
			return _isLocked;
		}
		
		
		
	}

}