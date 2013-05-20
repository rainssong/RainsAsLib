package cn.flashk.controls.support
{
	import cn.flashk.controls.Menu;
	import cn.flashk.controls.managers.DefaultStyle;
	import cn.flashk.controls.managers.SkinManager;
	import cn.flashk.controls.skin.SkinThemeColor;
	import cn.flashk.controls.skin.sourceSkin.ListItemSourceSkin;
	import cn.flashk.conversion.ColorConversion;
	
	import flash.display.BlendMode;
	import flash.display.Shape;
	import flash.events.MouseEvent;

	public class MenuItemRender extends ListItemRender
	{
		public var _menu:Menu;
		private var menuUnableUse:Boolean = false;
		private var menuEnabled:Boolean = true;
		private var arrowView:Shape;
		
		public function MenuItemRender()
		{
			super();
			
			if(SkinManager.isUseDefaultSkin == true){
			}else{
				ListItemSourceSkin(skin).space = 2;
			}
		}
		public function set menu(value:Menu):void{
			_menu = value;
			_list = _menu;
		}
		override public function set data(value:Object):void{
			_data = value;
			if(String(_data.@type) == "separator"){
				_height = 8;
				this.removeEventListener(MouseEvent.MOUSE_OVER,showOver);
				this.removeEventListener(MouseEvent.MOUSE_OUT,showOut);
				menuUnableUse = true;
				return;
			}
			txt.text = _data.@label;
			txt.height = _height;
			if(String(_data.@enabled) == "false"){
				txt.alpha = 0.5;
				txt.blendMode = BlendMode.LAYER;
				menuEnabled = false;
			}
			var a:String = String(_data.@icon);
			if(a != ""){
				setIcon(_menu.iconGetFunction(_data.@icon));
			}
			if(_data.children().length()>0){
				arrowView = new Shape();
				this.addChild(arrowView);
				arrowView.graphics.beginFill(ColorConversion.transformWebColor(DefaultStyle.textColor),1);
				arrowView.graphics.moveTo(0,-4);
				arrowView.graphics.lineTo(4,0);
				arrowView.graphics.lineTo(0,4);
				arrowView.graphics.endFill();
			}
		}
		public function get textWidth():Number{
			return txt.textWidth;
		}
		override protected function showOver(event:MouseEvent=null):void
		{
			if(_selected == false){
				bg.alpha = 0.5;
				tf.color = SkinThemeColor.itemMouseOverTextColor;
				txt.setTextFormat(tf);
				if(skin != null){
					skin.showState(1);
				}
			}
			if(menuEnabled == false){
				bg.alpha=0.2;
				if(skin != null){
					skin.showState(3);
				}
			}
		}
		override public function setSize(newWidth:Number, newHeight:Number):void{
			if(menuUnableUse == false){
				super.setSize(newWidth,newHeight);
			}else{
				this.graphics.clear();
				this.graphics.lineStyle(0.1,0,0.2);
				this.graphics.moveTo(1,4);
				this.graphics.lineTo(newWidth,4);
				this.graphics.lineStyle(0.1,0xFFFFFF,1.0);
				this.graphics.moveTo(1,5);
				this.graphics.lineTo(newWidth,5);
			}
			if(arrowView != null){
				arrowView.x = newWidth-12;
				arrowView.y = int(_height/2)+0.5;
			}
		}
	}
}