package  me.rainssong.display
{
	import flash.display.Bitmap;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.net.URLRequest;
	
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
		protected var _loader:Loader;
		protected var _example:*;
		
		public function Slide(value:*=null) 
		{
			super();
			_loader = new Loader();
			if(value!=null)
				reload(value);
		}

		public function reload(value:*):void
		{
			unload();
			
			if (value is String)
			{
				_loader.load(new URLRequest(value))
				addChild(_loader);
			}
			if (value is Class)
			{
				_example = new value();
				addChild(_example);
			}
		}

public function unload():void
		{
			
			_loader.unloadAndStop();
			if (_loader.parent)
				_loader.parent.removeChild(_loader);
			try
			{
				removeChild(_example);
				_example = null;
			}
			catch (e:Error)
			{
				
			}
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
			
			if (_example is MovieClip)
				_example.play();
		}
		
		override public function disable():void 
		{
			super.disable();
			if (_example is MovieClip)
				_example.gotoAnsStop(1);
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