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
		
		private var _max:int = 100;
		private var _min:int = 0;
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
		
		
		public function RainSlider(max:int = 100, min:int = 0, value:int = 0, snapInterval:int = 1)
		{
			// constructor code
			this["sliderThumb"].addEventListener(MouseEvent.MOUSE_DOWN, mouseDownHandler);
			
			_max = max;
			_min = min;
			moveTo(value);
			_sliderWidth = 500;
			_snapInterval = MathCore.getRangedNumber(snapInterval, 1);
		}
		
		public function refreash():void
		{
			this["sliderMask"].width = this["sliderThumb"].x = _sliderWidth / (max - min)*(value - _min);
		}
		
		private function mouseDownHandler(e:MouseEvent):void
		{
			stage.addEventListener(MouseEvent.MOUSE_MOVE, mouseMoveHandler);
			stage.addEventListener(MouseEvent.MOUSE_UP, mouseUpHandler);
		}
		
		private function mouseMoveHandler(e:MouseEvent):void
		{
			var i:int;
			var unitWidth:Number = ( _sliderWidth / (max - min)) ;
			
			i = Math.round(mouseX / unitWidth/_snapInterval)*_snapInterval + _min;
			
			moveTo(i);
		}
		
		private function mouseUpHandler(e:MouseEvent):void
		{
			stage.removeEventListener(MouseEvent.MOUSE_MOVE, mouseMoveHandler);
			stage.removeEventListener(MouseEvent.MOUSE_UP, mouseUpHandler);
		}
		
		override public function destroy():void 
		{
			super.destroy();
		
			this["sliderThumb"].removeEventListener(MouseEvent.MOUSE_DOWN, mouseDownHandler);
			stage.removeEventListener(MouseEvent.MOUSE_MOVE, mouseMoveHandler);
			stage.removeEventListener(MouseEvent.MOUSE_UP, mouseUpHandler);
		}
		
		
		public function moveTo(i:int):void
		{
			if (value == i)
			{
				refreash();
			}
			else
			{
			
				i = MathCore.getRangedNumber(i, min, max);
				_value = i;
				
				dispatchEvent(new Event(Event.CHANGE));
			}
			
		}
		
		public function get percent():Number
		{
			return (value-min) / (max - min);
		}
		
		
		public function get snapInterval():int 
		{
			return _snapInterval;
		}
		
	
		public function get max():int 
		{
			return _max;
		}
		
		public function set max(value:int):void 
		{
			_max = value;
		}
		
		public function get min():int 
		{
			return _min;
		}
		
		public function set min(value:int):void 
		{
			_min = value;
		}
		
		public function set snapInterval(value:int):void 
		{
			_snapInterval = value;
		}
		
		public function get value():int 
		{
			return _value;
		}
	}

}

