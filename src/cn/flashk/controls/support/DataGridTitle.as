package cn.flashk.controls.support
{
	import cn.flashk.controls.Button;
	import cn.flashk.controls.DataGrid;
	import cn.flashk.controls.managers.DefaultStyle;
	import cn.flashk.controls.managers.SkinLoader;
	import cn.flashk.controls.managers.SkinManager;
	import cn.flashk.controls.managers.SourceSkinLinkDefine;
	import cn.flashk.controls.modeStyles.ButtonStyle;
	import cn.flashk.controls.skin.SkinThemeColor;
	import cn.flashk.conversion.ColorConversion;
	
	import flash.display.DisplayObject;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.text.TextFormatAlign;

	public class DataGridTitle extends UIComponent
	{
		public var dg:DataGrid;
		private var bus:Array = [];
		private var _width:Number;
		private var _height:Number;
		private var shapes:Array=[];
		private var isUpSort:Boolean = false;
		private var lastClick:Object;
		private var shape:Shape;
		
		public function DataGridTitle()
		{
			shape = new Shape();
			this.addChild(shape);
		}
		override public function setSize(newWidth:Number, newHeight:Number):void{
			_width = newWidth;
			_height = newHeight;
		}
		public function updateLabels():void{
			var shape:Shape;
			for(var i:int=0;i<dg.labels.length;i++){
				if(bus[i] == null){
					bus[i] = new Button;
					this.addChild(bus[i] as DisplayObject);
					Button(bus[i]).setStyle(ButtonStyle.DEFAULT_SKIN_ELLIPSE_WIDTH, 0);
					Button(bus[i]).setStyle(ButtonStyle.DEFAULT_SKIN_ELLIPSE_HEIGHT, 0);
					Button(bus[i]).setStyle(ButtonStyle.DEFAULT_SKIN_ELLIPSE_BOTTOM_WIDTH, 0);
					Button(bus[i]).setStyle(ButtonStyle.DEFAULT_SKIN_ELLIPSE_BOTTOM_HEIGHT, 0);
					Button(bus[i]).setStyle(ButtonStyle.TEXT_ALIGN,TextFormatAlign.LEFT);
					Button(bus[i]).setStyle(ButtonStyle.TEXT_PADDING,dg.getStyleValue("textPadding")+5);
					Button(bus[i]).label = dg.labels[i];
					Button(bus[i]).addEventListener(MouseEvent.CLICK,sortDataGrid);
					if(SkinManager.isUseDefaultSkin == false){
						Button(bus[i]).setSkin(SkinLoader.getClassFromSkinFile(SourceSkinLinkDefine.DATA_GRID_TITLE));
					}
					if(i != 0 ){
					shape = new Shape();
					this.addChild(shape);
					shape.graphics.lineStyle(0.1,SkinThemeColor.border,0.3);
					shape.graphics.moveTo(0,0);
					shape.graphics.lineTo(0,dg.compoHeight);
					shapes[i] = shape;
					}
				}
			}
			if(SkinManager.isUseDefaultSkin == false){
				this.x += 1;
			}
			reAlign();
		}
		override public function updateSkin():void {
			var shape:Shape;
			for(var i:int=1;i<dg.labels.length;i++){
				shape = shapes[i] as  Shape;
				shape.graphics.clear();
				shape.graphics.lineStyle(0.1,SkinThemeColor.border,0.3);
				shape.graphics.moveTo(0,0);
				shape.graphics.lineTo(0,dg.compoHeight);
			}
		}
		
		public function reAlign():void{
			var _list:DataGrid = dg;
			var wi:Number = _width;
			var pa:Number = Number(_list.getStyleValue("textPadding"));
			var bu:Button;
			var nop:Number;
			for(var i:int=0;i<_list.labels.length;i++){
				bu = bus[i] as Button;
				if(i == 0){
					bu.x = 0;
					if(_list.columnWidths[i] <0 ){
						bu.setSize( -_list.columnWidths[i]/100*wi,_height);
					}else{
						bu.setSize( _list.columnWidths[i],_height);
					}
				}else{
					nop = 0;
					for(var j:int=0;j<i;j++){
						nop += _list.columnWidths[j];
					}
					if(_list.columnWidths[i] <0 ){
						bu.x =  int( -nop*wi/100)-1;
						bu.setSize( -_list.columnWidths[i]/100*wi+i+1,_height);
					}else{
						bu.x = nop;
						bu.setSize( _list.columnWidths[i]+i*2,_height);
					}
					Shape(shapes[i]).x= bu.x;
				}
			}
		}
		private function sortDataGrid(event:MouseEvent):void{
			var bu:Button = event.currentTarget as Button;
			/*
			var index:uint;
			for(var i:int=0;i<dg.labels.length;i++){
				if(dg.labels[i] == bu.label){
					index = i;
				}
			}
			trace(i);
			*/
			if(bu == lastClick){
				isUpSort = !isUpSort;
			}else{
				isUpSort = true;
			}
			shape.graphics.clear();
			shape.graphics.beginFill(ColorConversion.transformWebColor(DefaultStyle.buttonOutTextColor),1);
			shape.graphics.lineStyle(0,0,0);
			var dx:Number = event.currentTarget.x + Button(event.currentTarget).compoWidth-30;
			if(dx<event.currentTarget.x+5) dx = event.currentTarget.x +5;
			var dy:Number = int(_height/2)+2;
			if(isUpSort == false){
				shape.graphics.moveTo(dx-2.5,dy-3);
				shape.graphics.lineTo(dx+5,dy-3);
				shape.graphics.lineTo(dx+1.5,dy+1);
				shape.graphics.endFill();
			}else{
				//
				shape.graphics.moveTo(dx-3.5,dy+1);
				shape.graphics.lineTo(dx+4.5,dy+1);
				shape.graphics.lineTo(dx+0.5,dy-3);
				shape.graphics.endFill();
			}
			dg.sortOnByTitle(bu.label,  isUpSort);
			this.setChildIndex(shape,this.numChildren-1);
			lastClick = bu;
		}
	}
}