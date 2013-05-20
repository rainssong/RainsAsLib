package cn.flashk.controls.support
{
	import cn.flashk.controls.ComboBox;
	import cn.flashk.controls.List;
	import cn.flashk.controls.events.DataGridChangeEvent;
	import cn.flashk.controls.interfaces.IListItemRender;
	
	import flash.events.Event;

	public class ComboBoxItemRender extends ComboBox implements IListItemRender
	{
		private var _data:Object;
		private var _mlist:List;
		
		public function ComboBoxItemRender()
		{
		}
		public function set data(value:Object):void{
			_data = value;
			this.selectedIndex = value.selectedIndex;
			this.dataProvider = value.dataProvider;
			this.addEventListener(Event.CHANGE,disPathChange);
		}
		public function get data():Object{
			return _data;
		}
		public function get itemHeight():Number{
			return 23;
		}
		public function set list(value:List):void{
			_mlist = value;
		}
		public function set selected(value:Boolean):void{
			
		}
		public function get selected():Boolean{
			return false;
		}
		protected function disPathChange(event:Event):void
		{
			_data.selectedIndex = this.selectedIndex;
			_mlist.dispatchEvent(new DataGridChangeEvent(DataGridChangeEvent.EDIT_CHANGE,DataGridItemRender(this.parent).index,DataGridItemRender(this.parent).getRenderIndex(this)));
		}
	}
}