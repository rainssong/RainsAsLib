package cn.flashk.controls.events
{
	import flash.events.Event;

	public class DataGridChangeEvent extends Event
	{
		public static const EDIT_CHANGE:String = "editChange";
		private var _row:int;
		private var _column:int;
		
		public function DataGridChangeEvent(type:String,rowD:int,columnD:int)
		{
			super(type);
			_row = rowD;
			_column = columnD;
		}
		public function get row():int{
			return _row;
		}
		public function get column():int{
			return _column;
		}
	}
}