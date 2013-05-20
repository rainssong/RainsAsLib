package cn.flashk.controls.events
{
	import flash.events.Event;

	public class MenuEvent extends Event
	{
		public static const ITEM_CLICK:String = "itemClick";
		
		private var _item:Object;
		
		public function MenuEvent(type:String,itemObj:Object)
		{
			super(type);
			_item = itemObj;
			trace(data);
		}
		public function get index():uint{
			return 1;
		}
		public function get item():Object{
			return _item;
		}
		public function get data():Object{
			return _item.@data;
		}
		override public function clone():Event{
			return new MenuEvent(this.type,_item);
		}
	}
}