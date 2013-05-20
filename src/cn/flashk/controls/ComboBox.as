package cn.flashk.controls
{
	import cn.flashk.controls.managers.DefaultStyle;
	import cn.flashk.controls.managers.SkinLoader;
	import cn.flashk.controls.managers.SkinManager;
	import cn.flashk.controls.managers.SourceSkinLinkDefine;
	import cn.flashk.controls.modeStyles.ButtonStyle;
	import cn.flashk.controls.proxy.DataProvider;
	import cn.flashk.controls.skin.ActionDrawSkin;
	import cn.flashk.controls.skin.ComboBoxSkin;
	import cn.flashk.controls.skin.sourceSkin.ComboBoxSourceSkin;
	import cn.flashk.controls.support.UIComponent;
	import cn.flashk.conversion.ColorConversion;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.text.TextField;
	import flash.text.TextFieldType;
	import flash.text.TextFormat;
	
	/**
	 * ComboBox 组件包含一个下拉列表，用户可以从该列表中选择单个值。 其功能与 HTML 中的 SELECT 表单元素的功能相似。 ComboBox 组件可以是可编辑的，在这种情况下，用户可以在 ComboBox 组件的 TextInput 部分键入不在列表中的条目。 。
	 *  
	 * @langversion ActionScript 3.0
	 * @playerversion Flash 9.0
	 * 
	 * @see cn.flashk.controls.support.UIComponent
	 * 
	 * @author flashk
	 */

	public class ComboBox extends UIComponent
	{
		protected var _list:List;
		protected var _rowCount:uint = 5;
		protected var txt:TextField;
		protected var _editable:Boolean = false;
		protected var tf:TextFormat;
		protected var initIndex:int;
		protected var _dataProvider:DataProvider;
		
		public function ComboBox()
		{
			super();
			
			_compoWidth = 100;
			_compoHeight = 21;
			new ButtonStyle(styleSet);
			_list = new List();
			_list.setSize(_compoWidth,_rowCount*List.defaultItemHeight);
			_list.addEventListener(Event.CHANGE,updateSelect);
			_list.addEventListener("getSelectIndexData",setSelectLabel);
			setSize(_compoWidth-2, _compoHeight);
			initMouseEvents();
			txt = new TextField();
			txt.x = 5;
			txt.height = _compoHeight;
			txt.width = compoWidth-_compoHeight-txt.x;
			txt.mouseEnabled = _editable;
			txt.type = TextFieldType.INPUT;
			tf = new TextFormat();
			tf.size = DefaultStyle.fontSize;
			tf.color = ColorConversion.transformWebColor(DefaultStyle.textColor);
			tf.font = DefaultStyle.font;
			txt.defaultTextFormat = tf;
			this.addChild(txt);
		}
		
		/**
		 * 设置ComboBox的数据源，它应该是个DataProvider对象（可以直接将二维数组转为DataProvider，请参见DataProvider构造函数）
		 * 
		 * @see cn.flashk.controls.proxy.DataProvider
		 */ 
		public function set dataProvider(value:DataProvider):void{
			_dataProvider = value;
			_list.dataProvider = _dataProvider;
			
		}
		public function get dataProvider():DataProvider{
			return _dataProvider;
		}
		protected function setSelectLabel(event:Event=null):void
		{
			trace("init",initIndex);
			txt.text = _list.getItemAt(initIndex).label;
		}
		public function get editable():Boolean{
			return _editable;
		}
		/**
		 * 获取或设置一个布尔值，该值指示 ComboBox 组件为可编辑还是只读。
		 */ 
		public function set editable(value:Boolean):void{
			_editable = value;
			txt.mouseEnabled = _editable;
		}
		public function get selectedItem():Object{
			return _list.selectedItem;
		}
		/**
		 * 获取或设置下拉列表中所选项目的值。
		 */ 
		public function set selectedItem(value:Object):void{
			_list.selectedItem = value;
		}
		public function get selectedIndex():uint{
			return _list.selectedIndex;
		}
		/**
		 * 获取或设置单选列表中的选定项目的索引。
		 */ 
		public function set selectedIndex(value:uint):void{
			initIndex = value;
			_list.selectedIndex = value;
		}
		public function get text():String{
			return txt.text;
		}
		/**
		 * 获取或设置可编辑 ComboBox 组件中文本框所包含的文本。
		 */ 
		public function set text(value:String):void{
			txt.text = value;
			txt.setTextFormat(tf);
		}
		/**
		 * 获取对 ComboBox 组件所包含的 TextInput 组件的引用。
		 */ 
		public function get textField():TextField{
			return txt;
		}
		public function get restrict():String{
			return txt.restrict;
		}
		/**
		 * 获取或设置用户可以在文本字段中输入的字符。
		 */ 
		public function set restrict(value:String):void{
			txt.restrict = value;
		}
		/**
		 * 获取对 ComboBox 组件所包含的 _list 组件的引用。
		 */ 
		public function get dropdown():List{
			return _list;
		}
		public function get rowCount():uint{
			return _rowCount;
		}
		/**
		 * 获取或设置没有滚动条的下拉列表中可显示的最大行数。
		 */ 
		public function set rowCount(value:uint):void{
			_rowCount = value;
			_list.setSize(_compoWidth,_rowCount*List.defaultItemHeight);
		}
		protected function updateSelect(event:Event):void
		{
			this.stage.removeChild(_list);
			this.stage.removeEventListener(MouseEvent.MOUSE_DOWN,checkRemove_list);
			txt.text = _list.selectedItem.label;
			this.dispatchEvent(event.clone());
		}
		public function addItem(item:Object):void{
			_list.addItem(item);
			if(_list.length>_list.selectedIndex){
				setSelectLabel();
			}
		}
		public function addItemAt(item:Object,index:uint):void{
			_list.addItemAt(item,index);
			if(_list.length>_list.selectedIndex){
				setSelectLabel();
			}
		}
		override public function setDefaultSkin():void {
			setSkin(ComboBoxSkin);
		}
		override public function setSourceSkin():void {
			setSkin(SkinLoader.getClassFromSkinFile(SourceSkinLinkDefine.COMBO_BOX));
		}
		override public function setSkin(Skin:Class):void {
			if(SkinManager.isUseDefaultSkin == true){
				skin = new Skin();
				ActionDrawSkin(skin).init(this,styleSet);
			}else{
				var sous:ComboBoxSourceSkin = new ComboBoxSourceSkin();
				sous.init(this,styleSet,Skin);
				skin = sous;
			}
		}
		override public function setSize(newWidth:Number, newHeight:Number):void {
			//trace("size", this);
			super.setSize(newWidth, newHeight);
			_list.setSize(newWidth,_list.compoHeight);
		}
		protected function initMouseEvents():void
		{
			skin.skinDisplayObject.addEventListener(MouseEvent.CLICK,open_list);
			
		}
		
		protected function open_list(event:MouseEvent):void
		{
			trace("click");
			this.stage.addChild(_list);
			var po:Point = this.localToGlobal(new Point(0,_compoHeight+1));
			_list.x = int(po.x);
			_list.y = po.y;
			if(_list.y+_list.compoHeight>this.stage.stageHeight){
				_list.y = po.y - _compoHeight-_list.compoHeight-1;
			}
			this.stage.addEventListener(MouseEvent.MOUSE_DOWN,checkRemove_list);
			
		}
		private function checkRemove_list(event:MouseEvent):void{
			if(_list.mouseX<-5 || _list.mouseY<=-5-_compoHeight || _list.mouseX>_list.compoWidth+5 || _list.mouseY> _list.compoHeight+5){
				this.stage.removeEventListener(MouseEvent.MOUSE_DOWN,checkRemove_list);
				this.stage.removeChild(_list);
			}
		}
	}
}