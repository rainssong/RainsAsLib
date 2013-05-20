package cn.flashk.controls.support
{
	import cn.flashk.controls.CheckBox;
	import cn.flashk.controls.List;
	import cn.flashk.controls.events.DataGridChangeEvent;
	import cn.flashk.controls.interfaces.IListItemRender;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Point;

	public class CheckBoxItemRender extends Sprite implements IListItemRender
	{
		private var _data:Object;
		private var cb:CheckBox;
		private var _list:List;
		
		public function CheckBoxItemRender()
		{
			cb = new CheckBox();
			this.addChild(cb);
		}
		
		protected function disPathChange(event:Event):void
		{
			_data.selected = cb.selected;
			_list.dispatchEvent(new DataGridChangeEvent(DataGridChangeEvent.EDIT_CHANGE,DataGridItemRender(this.parent).index,DataGridItemRender(this.parent).getRenderIndex(this)));
		}
		public function set data(value:Object):void{
			_data = value;
			cb.selected = value.selected;
			cb.label = value.label;
			cb.addEventListener(Event.CHANGE,disPathChange);
		}
		public function get data():Object{
			return _data;
		}
		public function get itemHeight():Number{
			return 23;
		}
		public function set list(value:List):void{
			_list = value;
		}
		 public function set selected(value:Boolean):void{
			;
		}
		 public function get selected():Boolean{
			return false;
		}
		 public function setSize(newWidth:Number, newHeight:Number):void{
			 cb.setSize(newWidth,newHeight);
		 }
	}
}