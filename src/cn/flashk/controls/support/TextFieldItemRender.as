package cn.flashk.controls.support
{
	import cn.flashk.controls.CheckBox;
	import cn.flashk.controls.List;
	import cn.flashk.controls.interfaces.IListItemRender;
	import cn.flashk.controls.managers.DefaultStyle;
	import cn.flashk.controls.skin.SkinThemeColor;
	import cn.flashk.conversion.ColorConversion;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	public class TextFieldItemRender extends TextField implements IListItemRender
	{
		private var _data:Object;
		private var _selected:Boolean;
		private var tf:TextFormat;
		
		public function TextFieldItemRender()
		{
			this..selectable = false;
			this.mouseEnabled = false;
			tf = new TextFormat();
			tf.font = DefaultStyle.font;
			tf.color = ColorConversion.transformWebColor(DefaultStyle.textColor);
			tf.size = DefaultStyle.fontSize;
			this.defaultTextFormat = tf;
			this.addEventListener(Event.ADDED_TO_STAGE,setLis);
		}
		
		protected function setLis(event:Event):void
		{
			this.parent.addEventListener(MouseEvent.MOUSE_OVER,showOver);
			this.parent.addEventListener(MouseEvent.MOUSE_OUT,showOut);
		}
		
		protected function showOut(event:MouseEvent):void
		{
			if(_selected == false){
			tf.color = ColorConversion.transformWebColor(DefaultStyle.textColor);
			this.setTextFormat(tf);
			}
		}
		
		protected function showOver(event:MouseEvent):void
		{
			tf.color = SkinThemeColor.itemMouseOverTextColor;
			this.setTextFormat(tf);
			
		}
		public function set data(value:Object):void{
			this.text = String(value);
			this.setTextFormat(tf);
			this.defaultTextFormat = tf;
		}
		public function get data():Object{
			return _data;
		}
		public function get itemHeight():Number{
			return 23;
		}
		public function set list(value:List):void{
			
		}
		public function set selected(value:Boolean):void{
			_selected = value;
			if(value == true){
				tf.color = SkinThemeColor.itemOverTextColor;
				this.setTextFormat(tf);
			}else{
				tf.color = ColorConversion.transformWebColor(DefaultStyle.textColor);
				this.setTextFormat(tf);
			}
		}
		public function get selected():Boolean{
			return _selected;
		}
		public function setSize(newWidth:Number, newHeight:Number):void{
			this.width = newWidth;
			this.height = newHeight;
			//trace(newWidth,newHeight);
		}
	}
}