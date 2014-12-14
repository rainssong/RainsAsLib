package me.rainssong.display
{
	import com.greensock.TweenLite;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import me.rainssong.display.MouseDragableSprite;
	import me.rainssong.rainMVC.view.Mediator;
	
	/**
	 * ...
	 * @author Rainssong
	 */
	public class RestoreLocationSprite extends MouseDragableSprite
	{
		private var _originX:Number;
		private var _originY:Number;
		
		
		public function RestoreLocationSprite() 
		{
			super();
			
			
			saveLocation();
		}
		
		public function saveLocation():void
		{
			_originX = x;
			_originY = y;
		}
		
		override public function stopDragging():void 
		{
			super.stopDragging();
			restore();
		}
		override public function onDragging():void 
		{
			super.onDragging();
			this.x += _speedX;
			this.y += _speedY;
		}
		
		public function restore(duration:Number=0.5):void
		{
			TweenLite.to(this, duration, { x:_originX, y:_originY });
		}
		
		public function get originX():Number 
		{
			return _originX;
		}
		
		public function set originX(value:Number):void 
		{
			_originX = value;
		}
		
		public function get originY():Number 
		{
			return _originY;
		}
		
		public function set originY(value:Number):void 
		{
			_originY = value;
		}
		
	}

}