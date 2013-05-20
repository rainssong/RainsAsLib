package cn.flashk.controls.support
{
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

	public class ListItemRender extends Sprite implements IListItemRender
	{
		protected var _data:Object;
		protected var txt:TextField;
		protected var bg:Shape;
		protected var _height:Number = 23;
		protected var _width:Number;
		protected var _list:Object;
		protected var tf:TextFormat;
		protected var _selected:Boolean = false;
		protected var bp:Bitmap;
		protected var padding:Number;
		protected var _isUseMyselfPadding:Boolean = false;
		protected var skin:ListItemSourceSkin;
		
		public function ListItemRender()
		{
			txt = new TextField();
			txt.mouseEnabled = false;
			txt.selectable = false;
			txt.y = 2;
			txt.height = _height-2;
			txt.x = 20;
			tf = new TextFormat();
			tf.font = DefaultStyle.font;
			tf.color = ColorConversion.transformWebColor(DefaultStyle.textColor);
			txt.defaultTextFormat =tf ;
			this.addChild(txt);
			bg = new Shape();
			bg.alpha = 0;
			if(SkinManager.isUseDefaultSkin == true){
				this.addChildAt(bg,0);
			}else{
				skin = new ListItemSourceSkin();
				skin.init2(this,{},SkinLoader.getClassFromSkinFile(SourceSkinLinkDefine.LIST_ITEM_BACKGROUND));
				skin.space = 1;
			}
			this.addEventListener(MouseEvent.MOUSE_OVER,showOver);
			this.addEventListener(MouseEvent.MOUSE_OUT,showOut);
		}
		
		protected function showOver(event:MouseEvent=null):void
		{
			if(_selected == false){
				bg.alpha = 0.3;
				tf.color = SkinThemeColor.itemMouseOverTextColor;
				txt.setTextFormat(tf);
				if(skin != null){
					skin.showState(1);
				}
			}
			
		}
		
		public function showSelect(event:MouseEvent=null):void
		{
			bg.alpha = 1;
			tf.color = SkinThemeColor.itemOverTextColor;
			txt.setTextFormat(tf);
			txt.defaultTextFormat =tf ;
			if(skin != null){
				skin.showState(2);
			}
		}
		protected function showOut(event:MouseEvent =null):void
		{
			if(_selected == false){
				bg.alpha = 0;
				tf.color = ColorConversion.transformWebColor(DefaultStyle.textColor);
				txt.setTextFormat(tf);
				txt.defaultTextFormat =tf ;
				if(skin != null){
					skin.showState(0);
				}
			}
			
		}
		public function set list(value:List):void{
			_list = value;
		}
		public function set data(value:Object):void{
			_data = value;
			txt.text = _data.label;
			if(_data.icon != null){
				setIcon(_data.icon);
			}else{
				//txt.x = 1;
			}
		}
		public function setIcon(iconRef:Object,isUseMyselfPadding:Boolean = false,iconTxtpaddingNumber:Number = 17):void{
			_isUseMyselfPadding = isUseMyselfPadding;
			if(bp == null){
				bp = new Bitmap();
			}
			if(iconRef is Class){
				var icon:Object = new iconRef();
				bp.bitmapData = icon as BitmapData;
			}
			trace(iconRef is BitmapData);
			if(iconRef is BitmapData){
				bp.bitmapData = iconRef as BitmapData;
			}
			this.addChild(bp);
			if(isUseMyselfPadding == false){
				bp.x = Number(_list.getStyleValue("iconPadding"));
			}else{
				bp.x = padding;
				txt.x = bp.x + iconTxtpaddingNumber;
			}
			trace(bp.x);
			bp.y = int((_height - bp.height)/2);
			if(bp.y<0) bp.y = 0;
			
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
			
			if(_isUseMyselfPadding == false){
				txt.x = Number(_list.getStyleValue("textPadding"));
			}
			txt.width = _width - txt.x;
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