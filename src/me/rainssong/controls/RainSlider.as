package me.rainssong.controls
{
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import me.rainssong.display.MySprite;
	import me.rainssong.math.MathCore;
	import me.rainssong.utils.superTrace;
	
	public class RainSlider extends MySprite
	{
		
		private var _maximum:int = 100;
		private var _minimum:int = 0;
		private var  _value:int = 0;
		
		private var _snapInterval:int = 1;
		private var _sliderWidth:Number;
		
		public function get sliderWidth():Number 
		{
			return _sliderWidth;
		}
		
		public function set sliderWidth(value:Number):void 
		{
			_sliderWidth = value;
			refreash();
		}
		
		
		public function RainSlider(maximum:int = 100, minimum:int = 0, value:int = 0, snapInterval:int = 1)
		{
			// constructor code
			sliderThumb.addEventListener(MouseEvent.MOUSE_DOWN, mouseDownHandler);
			
			
			_maximum = maximum;
			_minimum = minimum;
			_value = value;
			_sliderWidth = 500;
			_snapInterval = MathCore.getRangedNumber(snapInterval, 1);
			refreash();
		}
		
		public function refreash():void
		{
			moveTo(_value);
		}
		
		private function mouseDownHandler(e:MouseEvent)
		{
			stage.addEventListener(MouseEvent.MOUSE_MOVE, mouseMoveHandler);
			stage.addEventListener(MouseEvent.MOUSE_UP, mouseUpHandler);
		}
		
		private function mouseMoveHandler(e:MouseEvent)
		{
			var i:int;
			var unitWidth:Number = ( _sliderWidth / (maximum - minimum)) ;
			
			i = Math.round(mouseX / unitWidth/_snapInterval)*_snapInterval + _minimum;
			
			i = MathCore.getRangedNumber(i, _minimum, _maximum);
			//i = Math.round((mouseX - sliderMask.x) / ( _sliderWidth / (maximum - minimum)))*_snapInterval + _minimum;
			//i=Math.round(mouseX/( _sliderWidth / (maximum - minimum)*_snapInterval)+ _minimum;
			moveTo(i);
			
		}
		
		private function mouseUpHandler(e:MouseEvent)
		{
			stage.removeEventListener(MouseEvent.MOUSE_MOVE, mouseMoveHandler);
			stage.removeEventListener(MouseEvent.MOUSE_UP, mouseUpHandler);
		}
		
		
		
		
		
		
		
		override public function destroy():void 
		{
			super.destroy();
		
			sliderThumb.removeEventListener(MouseEvent.MOUSE_DOWN, mouseDownHandler);
			stage.removeEventListener(MouseEvent.MOUSE_MOVE, mouseMoveHandler);
			stage.removeEventListener(MouseEvent.MOUSE_UP, mouseUpHandler);
		
		}
		
		
		
		public function moveTo(i:int)
		{
			_value = MathCore.getRangedNumber(i,1);
			
			sliderMask.width = sliderThumb.x = _sliderWidth / (maximum - minimum)*(_value - _minimum);
			
			dispatchEvent(new Event(Event.CHANGE));
		}
		
		
		
		
		public function get snapInterval():int 
		{
			return _snapInterval;
		}
		
		public function get minimum():int 
		{
			return _minimum;
		}
		
		public function get maximum():int 
		{
			return _maximum;
		}
		
		
		
		
		
		
	}

}

