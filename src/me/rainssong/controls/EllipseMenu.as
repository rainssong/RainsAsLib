package view 
{
	import flash.display.DisplayObject;
	import me.rainssong.display.SmartSprite;
	import me.rainssong.math.MathCore;
	
	/**
	 * ...
	 * @author Rainssong
	 * @timeStamp 2014/1/10 12:02
	 * @blog http://blog.sina.com.cn/rainssong
	 */
	public class NewEllipseMenu extends SmartSprite 
	{
		private var _items:Array;
		private var _radians:Number = 0;
		public var  a:Number = 300;
		public var  b:Number = -50;
		
		public function NewEllipseMenu(items:Array) 
		{
			super();
			_items = items;
			
			//for (var i:int = 0; i < items.length; i++ )
				//addChild(_items[i]);
				//
			refreash();
		}
		
		public function refreash():void
		{
			var partRadians:Number = Math.PI * 2 / _items.length;
			var actualRadians:Number;
			var scaleRadians:Number;
			for (var i:int = 0; i < _items.length; i++ )
			{
				scaleRadians =  partRadians * i+_radians;
				if (scaleRadians > Math.PI) scaleRadians = Math.PI * 2 - scaleRadians;
				//scaleRadians = MathCore.getCycledNumber(scaleRadians,-180,180);
				actualRadians = partRadians * i - Math.PI / 2 +_radians;
				//actualRadians = MathCore.getCycledNumber(scaleRadians,-180,180);
				
				_items[i].scaleX = _items[i].scaleY =1.5-Math.abs(scaleRadians)/Math.PI;
				_items[i].alpha=1-Math.abs(scaleRadians)/Math.PI*0.5
				_items[i].x = a * Math.cos(actualRadians)-_items[i].width*0.5;
				_items[i].y = b * Math.sin(actualRadians) - _items[i].height * 0.5;
				
			}
			
			var sort:Array = _items.slice();
			sort.sortOn("scaleX");
			
			for (i= 0; i < sort.length; i++ )
				addChild(sort[i]);
		}
		
		public function get radians():Number 
		{
			return _radians;
		}
		
		public function set radians(value:Number):void 
		{
			_radians = MathCore.getCycledNumber(value,-Math.PI,Math.PI)
			refreash();
		}
		
		public function get degree():Number 
		{
			return MathCore.radiansToDegree(_radians);
		}
		
		public function set degree(value:Number):void 
		{
			radians = MathCore.degreeToRadians(value);
			
		}
		
		
		
		
		
		
	}

}