package me.rainssong.display
{
	import flash.display.Bitmap;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Graphics;
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.display.Shape;
	import flash.events.Event;
	import flash.net.URLRequest;
	import flash.utils.setTimeout;
	import me.rainssong.events.SlideEvent;
	import me.rainssong.utils.superTrace;
	
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
		protected var _example:DisplayObject;
		protected var _contentWidth:int;
		protected var _contentHeight:int;
		protected var _bg:Sprite=new Sprite()
		
		public function Slide(content:* = null, contentWidth:int = 1024, contentHeight:int = 768)
		{
			super();
			
			_contentWidth = contentWidth;
			_contentHeight = contentHeight;
			
			_bg.graphics.beginFill(0xFFFFFF,0);
			_bg.graphics.drawRect(0, 0, contentWidth, contentHeight);
			
			addChild(_bg);
			
			if (content != null)
				reload(content);
		
		}
		
		public function reload(content:*):void
		{
			unload();
			
			addChild(_example = DisplayObjectTransfer.transfer(content));
			_example.addEventListener(SlideEvent.LOCK, lock);
			_example.addEventListener(SlideEvent.UNLOCK, unlock);
			
			if (_example is Loader)
			{
				Loader(_example).contentLoaderInfo.addEventListener(Event.COMPLETE, resize);
			}
		}
		
		private function resize(e:Event = null):void
		{
			if (!_example) return;
			DisplayObject(_example).width = _contentWidth;
			DisplayObject(_example).height = _contentHeight;
			DisplayObject(_example).scaleX = DisplayObject(_example).scaleY = Math.min(DisplayObject(_example).scaleX, DisplayObject(_example).scaleY);
			DisplayObject(_example).x = _contentWidth / 2 - DisplayObject(_example).width / 2;
			//DisplayObject(_example).y = _contentHeight / 2 - DisplayObject(_example).height / 2;
		
		}
		
		override protected function onAdd(e:Event = null):void
		{
			super.onAdd(e);
		
		}
		
		public function unload():void
		{
			if (_example is Loader)
			{
				Loader(_example).unloadAndStop();
				Loader(_example).contentLoaderInfo.removeEventListener(Event.COMPLETE, resize);
			}
			else if (_example is MovieClip)
				MovieClip(_example).stop();
			else if (_example is Bitmap)
				Bitmap(_example).bitmapData.dispose();
			
			if (_example && _example.parent)
			{
				removeChild(_example);
				_example = null;
			}
		}
		
		public function lock(e:SlideEvent = null):void
		{
			_isLocked = true;
		}
		
		public function unlock(e:SlideEvent = null):void
		{
			_isLocked = false;
		}
		
		override public function enable():void
		{
			super.enable();
			
			if (_example is MovieClip)
				MovieClip(_example).play();
		
		}
		
		override public function disable():void
		{
			super.disable();
			if (_example is MovieClip)
				MovieClip(_example).gotoAndStop(1);
		}
		
		override public function destroy():void
		{
			unload();
			super.destroy();
		}
		
		public function get hasContent():Boolean
		{
			return _example ? true : false;
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