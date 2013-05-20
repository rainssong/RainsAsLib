package cn.flashk.controls 
{
	import cn.flashk.controls.events.ColorPickEvent;
	import cn.flashk.controls.support.UIComponent;
	import cn.flashk.conversion.ColorConversion;
	import flash.display.BitmapData;
	import flash.display.MovieClip;
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	/**
	 * ColorPickerPanel 组件拥有一个调色板和一组预先设定好的色卡，用户可以方便的选择颜色。
	 *  
	 * @langversion ActionScript 3.0
	 * @playerversion Flash 9.0
	 * 
	 * @see cn.flashk.controls.support.UIComponent
	 * 
	 * @author flashk
	 */
	public class ColorPickerPanel extends UIComponent
	{
		public var autoRemoveChild:Boolean = false;
		
		public var colorTab_mc:MovieClip;
		public var tab_mc:MovieClip;
		public var tab1_btn:SimpleButton;
		public var tab2_btn:SimpleButton;
		public var prev_btn:SimpleButton;
		public var next_btn:SimpleButton;
		public var done_btn:SimpleButton;
		public var close_btn:SimpleButton;
		public var state_mc:MovieClip;
		public var bg_mc:MovieClip;
		protected var bd:BitmapData;
		protected var bdWidth:Number;
		protected var bdHeight:Number;
		protected var isAUsefulColor:Boolean = true;
		protected var _selectColor:uint;
		protected var colorChanged:Boolean = false;
		protected var isHide:Boolean;
		protected var switchFun:Function;
		protected var index:uint;
		protected var hn:Number;
		protected var sn:Number;
		
		public function ColorPickerPanel() 
		{
			super();
			colorTab_mc.stop();
			colorTab_mc.colors_mc.stop();
			tab_mc.stop();
			tab1_btn.addEventListener(MouseEvent.CLICK, tabClick);
			tab2_btn.addEventListener(MouseEvent.CLICK, tabClick);
			tab1_btn.useHandCursor = false;
			tab2_btn.useHandCursor = false;
			prev_btn.addEventListener(MouseEvent.CLICK, prevClick);
			next_btn.addEventListener(MouseEvent.CLICK, nextClick);
			bdWidth = colorTab_mc.colors_mc.width;
			bdHeight = colorTab_mc.colors_mc.height;
			colorTab_mc.addEventListener(MouseEvent.MOUSE_MOVE, showOverColor);
			colorTab_mc.addEventListener(MouseEvent.CLICK, selectColorClick);
			done_btn.addEventListener(MouseEvent.CLICK, doneClick);
			close_btn.addEventListener(MouseEvent.CLICK, closeMe);
			index = 1;
			switchTabMain();
		}
		public function get selectColor():uint {
			return _selectColor;
		}
		public function getMouseOverColor():uint {
			var color32:uint = bd.getPixel32(colorTab_mc.mouseX, colorTab_mc.mouseY);
			var alpha:uint = ColorConversion.getAlphaFromeARGB(color32);
			if (alpha>=255) {
				isAUsefulColor = true;
			}else {
				isAUsefulColor = false;
			}
			var color:uint = bd.getPixel(colorTab_mc.mouseX, colorTab_mc.mouseY);
			return color;
		}
		public function closeMe(event:MouseEvent = null):void {
			this.parent.removeChild(this);
		}
		protected function switchTab(newIndex:uint):void {
			index = newIndex;
			switchFun = switchTabMain;
			hn = 0.07;
			sn = 0.12;
			alphaSwitch();
		}
		protected function switchTabMain():void{
			colorTab_mc.gotoAndStop(index);
			tab_mc.gotoAndStop(index);
			tab1_btn.mouseEnabled = true;
			tab2_btn.mouseEnabled = true;
			SimpleButton(this.getChildByName("tab" + index + "_btn")).mouseEnabled = false;
			bg_mc.gotoAndStop(index);
			initBD();
		}
		protected function tabClick(event:MouseEvent):void {
			var na:String = event.currentTarget.name;
			switchTab(uint(na.slice(3, 4)));
		}
		protected function prevClick(event:MouseEvent):void {
			switchFun = prevClickMain;
			hn = 0.2;
			sn = 0.3;
			alphaSwitch();
		}
		protected function prevClickMain():void{
			if (colorTab_mc.colors_mc.currentFrame == 1) {
				colorTab_mc.colors_mc.gotoAndStop(colorTab_mc.colors_mc.totalFrames);
			}else{
				colorTab_mc.colors_mc.prevFrame();
			}
			initBD();
		}
		protected function nextClick(event:MouseEvent):void {
			switchFun = nextClickMain;
			hn = 0.2;
			sn = 0.3;
			alphaSwitch();
		}
		protected function nextClickMain():void{
			if (colorTab_mc.colors_mc.currentFrame == colorTab_mc.colors_mc.totalFrames) {
				colorTab_mc.colors_mc.gotoAndStop(1);
			}else {
				colorTab_mc.colors_mc.nextFrame();
			}
			initBD();
		}
		protected function initBD():void {
			if (bd != null) {
				bd.dispose();
			}
			bd = new BitmapData(bdWidth, bdHeight, true, 0x00FFFFFF);
			bd.draw(colorTab_mc);
		}
		protected function showOverColor(event:MouseEvent):void {
			var color:uint = getMouseOverColor();
			if(isAUsefulColor == true){
				state_mc.graphics.beginFill(color, 1);
				state_mc.graphics.drawRect(0, 0, 60, 30);
				state_mc.overColor_txt.text = "#" + color.toString(16).toUpperCase();
			}
		}
		protected function selectColorClick(event:MouseEvent):void {
			var color:uint = getMouseOverColor();
			if (isAUsefulColor == true) {
				_selectColor = color;
				colorChanged = true;
				state_mc.graphics.beginFill(color, 1);
				state_mc.graphics.drawRect(120, 15, 45, 15);
				state_mc.selectColor_txt.text = "#" + color.toString(16).toUpperCase();
				this.dispatchEvent(new ColorPickEvent(ColorPickEvent.COLOR_SELECT, _selectColor));
			}
		}
		protected function  doneClick(event:MouseEvent):void {
			if(colorChanged == true){
				this.dispatchEvent(new ColorPickEvent(ColorPickEvent.COLOR_CHANGE, _selectColor));
			}
			colorChanged = false;
			if (autoRemoveChild == true) {
				this.parent.removeChild(this);
			}
		}
		protected function alphaSwitch():void {
			isHide = true;
			this.addEventListener(Event.ENTER_FRAME, alphaShow);
		}
		protected function alphaShow(event:Event):void {
			if(isHide == true){
				colorTab_mc.alpha -= hn;
				if (colorTab_mc.alpha <= 0) {
					isHide = false;
					switchFun();
				}
			}else {
				colorTab_mc.alpha += sn;
				if (colorTab_mc.alpha >= 1) {
					this.removeEventListener(Event.ENTER_FRAME, alphaShow);
				}
			}
			bg_mc.alpha = colorTab_mc.alpha;
		}
	}

}