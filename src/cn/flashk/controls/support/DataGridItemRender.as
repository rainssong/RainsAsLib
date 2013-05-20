package cn.flashk.controls.support
{
	import cn.flashk.controls.DataGrid;
	import cn.flashk.controls.List;
	import cn.flashk.controls.interfaces.IListItemRender;
	import cn.flashk.controls.managers.DefaultStyle;
	import cn.flashk.controls.managers.SkinLoader;
	import cn.flashk.controls.managers.SkinManager;
	import cn.flashk.controls.managers.SourceSkinLinkDefine;
	import cn.flashk.controls.skin.SkinThemeColor;
	import cn.flashk.controls.skin.sourceSkin.ListItemSourceSkin;
	import cn.flashk.conversion.ColorConversion;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFormat;

	public class DataGridItemRender extends Sprite  implements IListItemRender
	{
		private var _data:Object;
		private var txt:IListItemRender;
		private var txts:Array = [];
		private var bg:Shape;
		private var _height:Number = 23;
		private var _width:Number;
		private var _list:DataGrid;
		private var tf:TextFormat;
		private var _selected:Boolean = false;
		private var bp:Bitmap;
		private var bps:Array = [];
		protected var skin:ListItemSourceSkin;
		
		public function DataGridItemRender()
		{
			tf = new TextFormat();
			tf.font = DefaultStyle.font;
			tf.color = ColorConversion.transformWebColor(DefaultStyle.textColor);
			bg = new Shape();
			bg.alpha = 0;
			if(SkinManager.isUseDefaultSkin == true){
				this.addChildAt(bg,0);
			}else{
				skin = new ListItemSourceSkin();
				skin.init2(this,{},SkinLoader.getClassFromSkinFile(SourceSkinLinkDefine.LIST_ITEM_BACKGROUND));
			}
			this.addEventListener(MouseEvent.MOUSE_OVER,showOver);
			this.addEventListener(MouseEvent.MOUSE_OUT,showOut);
		}
		protected function showOver(event:MouseEvent=null):void
		{
			if(_selected == false){
				bg.alpha = 0.3;
				if(skin != null){
					skin.showState(1);
				}
			}
		}
		
		public function get index():int{
			return this.parent.getChildIndex(this);
		}
		public function getRenderIndex(render:DisplayObject):int{
			return this.getChildIndex(render)-1;
		}
		protected function showSelect(event:MouseEvent=null):void
		{
			bg.alpha = 1;
			tf.color = SkinThemeColor.itemOverTextColor;
			for(var i:int=0;i<txts.length;i++){
				txt = txts[i] as IListItemRender;
				txt.selected = _selected;
				//txt.setTextFormat(tf);
				//txt.defaultTextFormat =tf ;
			}
			if(skin != null){
				skin.showState(2);
			}
		}
		protected function showOut(event:MouseEvent =null):void
		{
			if(_selected == false){
				bg.alpha = 0;
				tf.color = ColorConversion.transformWebColor(DefaultStyle.textColor);
				for(var i:int=0;i<txts.length;i++){
					txt = txts[i] as IListItemRender;
					txt.selected = _selected;
					//txt.setTextFormat(tf);
					//txt.defaultTextFormat =tf ;
				}
				if(skin != null){
					skin.showState(0);
				}
			}
		}
		public function set list(value:List):void{
			_list = value as DataGrid;
			var classRef:Class;
			for(var i:int=0;i<_list.dataField.length;i++){
				classRef = _list.renders[i] as Class;
				txt = new classRef as IListItemRender;
				txt.list = value;
				this.addChild(DisplayObject(txt));
				txts[i] = txt;
				//trace(txt);
			}
		}
		public function reAlign():void{
			var wi:Number = _width;
			var pa:Number = Number(_list.getStyleValue("padding"));
			var pa2:Number = Number(_list.getStyleValue("paddingRight"));
			var nop:Number;
			for(var i:int=0;i<_list.dataField.length;i++){
				txt = txts[i] as IListItemRender;
				if(i == 0){
					DisplayObject(txt).x =0 + pa;
					DisplayObject(txt).y = 1;
					if(_list.columnWidths[i] <0 ){
						txt.setSize( int(-_list.columnWidths[i]/100*wi-pa-pa2),_height-2);
					}else{
						txt.setSize( int(_list.columnWidths[i]-pa-pa2),_height-2);
					}
				}else{
					nop = 0;
					for(var j:int=0;j<i;j++){
						nop += _list.columnWidths[j];
					}
					DisplayObject(txt).y = 1;
					if(_list.columnWidths[i] <0 ){
						DisplayObject(txt).x =int( -nop*wi/100 +pa);
						txt.setSize( -_list.columnWidths[i]/100*wi-pa-pa2,_height-2);
					}else{
						DisplayObject(txt).x =int( nop +pa);
						txt.setSize(_list.columnWidths[i]-pa-pa2,_height-2);
					}
				}
			}
		}
		public function set data(value:Object):void{
			_data = value;
			
			IListItemRender(txts[0]).data = _data[_list.dataField[0]];
			IListItemRender(txts[1]).data = _data[_list.dataField[1]];
			IListItemRender(txts[2]).data = _data[_list.dataField[2]];
			/*
			if(_data.icon != null){
				if(bp == null){
					bp = new Bitmap();
				}
				var icon:Object = new _data.icon();
				bp.bitmapData = icon as BitmapData;
				this.addChild(bp);
				bp.x = Number(_list.getStyleValue("iconPadding"));
				bp.y = int((_height - bp.height)/2);
				if(bp.y<0) bp.y = 0;
			}
			*/
		}
		public function get data():Object{
			return _data;
		}
		public function get itemHeight():Number{
			return _height;
		}
		public function setSize(newWidth:Number, newHeight:Number):void{
			_width = newWidth;
			bg.graphics.clear();
			bg.graphics.beginFill(SkinThemeColor.itemOverColor,1);
			bg.graphics.drawRect(0,0,newWidth,_height);
			
			
			reAlign();
			//txt.x = Number(_list.getStyleValue("textPadding"));
			//txt.width = _width - txt.x;
			if(_selected == true){
				showSelect();
			}
			if(skin != null){
				skin.setSize(newWidth,newHeight);
			}
		}
		public function set selected(value:Boolean):void{
			_selected = value;
			if(_selected == true){
				showSelect();
			}else{
				showOut();
			}
		}
		public function get selected():Boolean{
			return _selected;
		}
	}
}