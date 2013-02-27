package  me.rainssong.rainMVC.model
{
	import flash.events.Event;
	import me.rainssong.math.MathCore;
	import me.rainssong.rainMVC.model.Model;
	
	/**
	 * ...
	 * @author Rainssong
	 */
	public class RangeNumberModel extends Model
	{
		private var _value:Number;
		private var _max:Number;
		private var _min:Number;
		public function RangeNumberModel(value:Number,min:Number=0,max:Number=100) 
		{
			_min = Math.min(min, max);
			_max = Math.max(min, max);
			value = value;
		}
		
		public function get value():Number 
		{
			return _value;
		}
		
		public function set value(value:Number):void 
		{
			_value = MathCore.getRangedNumber( value, _min, _max);
			dispatchEvent(new Event(Event.CHANGE));
		}
		
		public function get max():Number 
		{
			return _max;
		}
		
		public function set max(value:Number):void 
		{
			_max = value;
			dispatchEvent(new Event(Event.CHANGE));
		}
		
		public function get min():Number 
		{
			return _min;
		}
		
		public function set min(value:Number):void 
		{
			_min = value;
			dispatchEvent(new Event(Event.CHANGE));
		}
		
		public function get percent():Number
		{
			return _value / (_max - _min);
		}
		
		public function set percent(value:Number):void
		{
			value = (_max - _min) * percent + _min;
			dispatchEvent(new Event(Event.CHANGE));
		}
		
	}

}