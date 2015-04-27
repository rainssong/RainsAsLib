package me.rainssong.effects 
{
	import com.greensock.easing.Back;
	import com.greensock.easing.Linear;
	import com.greensock.TweenLite;
	import flash.display.DisplayObject;
	import flash.geom.Point;
	import me.rainssong.display.SmartSprite;
	
	/**
	 * ...
	 * @author Rainssong
	 */
	public class TurnoverCard extends SmartSprite 
	{
		private var _front:DisplayObject;
		private var _back:DisplayObject;
		private var _isFront:Boolean = true;
		private var _type:int = 0;
		private var _inAnim:Boolean = false;
		
		public function TurnoverCard(front:DisplayObject,back:DisplayObject ) 
		{
			super();
			_front = front;
			_back = back;
			
			addChild(_back);
			addChild(_front);
			_back.rotationY = -180;
			_back.x = _back.width * 0.5;
			
			_front.x = -_front.width * 0.5;
		}
		
		public function turn():void
		{
			_isFront?turnBack():turnFront();
		}
		
		public function turnBack():void
		{
			TweenLite.to(this, 1, {rotationY:-180,ease:Back.easeOut,onUpdate :turnUpdate,onComplete:onComp});
			//TweenLite.to(_back, 1, {rotationY:-180,ease:Back.easeOut});
			_isFront = false;
			_inAnim = true;
			
		}
		
		public function turnFront():void
		{
			TweenLite.to(this, 1, {rotationY:0,ease:Back.easeOut,onUpdate :turnUpdate,onComplete:onComp});
			
			_isFront = true;
			_inAnim = true;
		}
		
		private function onComp():void 
		{
			_inAnim = false;
		}
		
		private function turnUpdate():void 
		{
			var p1:Point=_front.localToGlobal(new Point(0,0));
			var p2:Point=_front.localToGlobal(new Point(100,0));
			var p3:Point=_front.localToGlobal(new Point(0,100));
			var mag:Number = ((p2.x-p1.x)*(p3.y-p1.y) - (p2.y-p1.y)*(p3.x-p1.x));
			if (mag>0) {
				_front.visible = true;
			} else {
				
				_front.visible = false;
			}
		}
		
		public function get inAnim():Boolean 
		{
			return _inAnim;
		}
		
		public function get isFront():Boolean 
		{
			return _isFront;
		}
		
		
	}

}