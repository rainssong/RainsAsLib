package cn.flashk.controls
{
	import cn.flashk.controls.managers.SkinLoader;
	import cn.flashk.controls.managers.SkinManager;
	import cn.flashk.controls.managers.SourceSkinLinkDefine;
	import cn.flashk.controls.skin.ActionDrawSkin;
	import cn.flashk.controls.skin.SliderSkin;
	import cn.flashk.controls.skin.sourceSkin.SliderSourceSkin;
	import cn.flashk.controls.support.UIComponent;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	
	/**
	 * Slider 组件提供一个滑块，也可以提供两个滑块使用户选择一个区间，可以设定最小区间值。
	 *  
	 * @langversion ActionScript 3.0
	 * @playerversion Flash 9.0
	 * 
	 * @see cn.flashk.controls.support.UIComponent
	 * 
	 * @author flashk
	 */

	public class Slider extends UIComponent
	{
		protected var slider1:Sprite;
		protected var slider2:Sprite;
		protected var bar:Sprite;
		protected var _snapInterval:Number=10;
		protected var _maximum:Number = 100;
		protected var _minimum:Number = 0;
		protected var _sliderNum:uint = 1;
		protected var dragTarget:Sprite;
		protected var _spaceNum:uint =1;
		protected var _liveDragging:Boolean = true;
		protected var toPos1:Number;
		protected var toPos2:Number;
		protected var mx1:Number;
		protected var mx2:Number;
		private var _smothMode:uint = 2;
		private var _smothStep:uint = 15;
		private var _smothLess:Number = 6.9;
		
		public function Slider()
		{
			super();
			_compoWidth = 200;
			_compoHeight = 4;
			setSize(_compoWidth, _compoHeight);
		}
		public function get value():Number{
			var va:Number;
			va = _minimum+ (slider1.x/_compoWidth)*(_maximum-_minimum);
			va = int(va/_snapInterval)*_snapInterval;
			return va;
		}
		public function set value(num:Number):void{
			slider1.x = _compoWidth*(num-minimum)/maximum;
		}
		public function get values():Array{
			var va:Number;
			va = _minimum+ (slider1.x/_compoWidth)*(_maximum-_minimum);
			va = int(va/_snapInterval)*_snapInterval;
			var va2:Number;
			va2 = _minimum+ (slider2.x/_compoWidth)*(_maximum-_minimum);
			va2 = int(va2/_snapInterval)*_snapInterval;
			return [va,va2];
		}
		public function set snapInterval(value:Number):void{
			_snapInterval = value;
		}
		public function get snapInterval():Number{
			return _snapInterval;
		}
		public function set maximum(value:Number):void{
			_maximum = value;
		}
		public function get maximum():Number{
			return _maximum;
		}
		public function set minimum(value:Number):void{
			_minimum = value;
		}
		public function get minimum():Number{
			return _minimum;
		}
		public function get thumbCount():uint{
			return _sliderNum;
		}
		public function set thumbCount(value:uint):void{
			setSliderMode(value);
		}
		public function set minSpaceNum(value:int):void{
			_spaceNum = value;
		}
		public function set liveDragging(value:Boolean):void{
			_liveDragging = value;
		}
		public function get liveDragging():Boolean{
			return _liveDragging;
		}
		public function setSliderMode(sliderNum:uint,mode:String=""):void{
			_sliderNum = sliderNum;
			if (skin is ActionDrawSkin) {
				(skin).init(this,styleSet);
			}else{
				skin.init(this,styleSet,SkinLoader.getClassFromSkinFile(SourceSkinLinkDefine.SLIDER));
			}
			skin.reDraw();
			slider1=Object(skin).getSliderByIndex(0);
			if(_sliderNum == 2){
				slider2 = Object(skin).getSliderByIndex(1);
			}
			bar = skin.bar;
			initLis();
		}
		/*
		设置用户在滑动槽按下鼠标是滑块移动的模式，1为平均动画，2为缓冲动画
		要关闭滑动效果，使滑块直接移动到按下的位置，请使用setMotion(1,1);
		motionArg 当motionMode为1时，表示移动将被分割多少次，默认为15
		motionArg 当motionMode为2时，表示缓冲的程度值，缓冲公式为：当前位置 = (目标位置-当前位置)/motionArg+当前位置，默认为6.9
		motionArg使用负值将被视为无效，将继续使用上一次设定的值
		*/
		public function setMotion(motionMode:uint,motionArg:Number=-1.0):void{
			_smothMode = motionMode;
			if(motionArg <0){
				return;
			}
			if(_smothMode == 1){
				_smothStep = uint(motionArg);
			}else{
				_smothLess = motionArg;
			}
		}
		public function showTick(num:uint,color:uint=0x000000,alpha:Number=0.5,lineLength:Number=3,pos:Number=9):void{
			this.graphics.clear();
			if(num == 0 ) return;
			this.graphics.beginFill(color,alpha);
			for(var i:int=0;i<=num;i++){
				this.graphics.drawRect(i/num*_compoWidth,pos,1,lineLength);
			}
		}
		override public function setDefaultSkin():void {
			setSkin(SliderSkin);
		}
		override public function setSourceSkin():void {
			setSkin(SkinLoader.getClassFromSkinFile(SourceSkinLinkDefine.SLIDER));
		}
		override public function setSkin(Skin:Class):void {
			if(SkinManager.isUseDefaultSkin == true){
				skin = new Skin();
				ActionDrawSkin(skin).init(this,styleSet);
			}else{
				var sous:SliderSourceSkin = new SliderSourceSkin();
				sous.init(this,styleSet,Skin);
				skin = sous;
			}
			slider1=Object(skin).getSliderByIndex(0);
			bar = skin.bar;
			initLis();
		}
		protected function initLis():void{
			slider1.addEventListener(MouseEvent.MOUSE_DOWN,startDragSlider);
			bar.addEventListener(MouseEvent.MOUSE_DOWN,moveToPoint);
			if(_sliderNum == 2){
				slider2.addEventListener(MouseEvent.MOUSE_DOWN,startDragSlider);
			}
		}
		protected function startDragSlider(event:MouseEvent):void
		{
			dragTarget = event.currentTarget as Sprite;
			this.stage.addEventListener(MouseEvent.MOUSE_MOVE,updateSlivderX);
			this.stage.addEventListener(MouseEvent.MOUSE_UP,stopDragSlider);
			this.removeEventListener(Event.ENTER_FRAME,moveSlider1);
			this.removeEventListener(Event.ENTER_FRAME,moveSlider2);
		}
		
		protected function stopDragSlider(event:MouseEvent):void
		{
			this.stage.removeEventListener(MouseEvent.MOUSE_MOVE,updateSlivderX);
			this.stage.removeEventListener(MouseEvent.MOUSE_UP,stopDragSlider);
			this.dispatchEvent(new Event(Event.CHANGE));
			
		}
		protected function updateSlivderX(event:MouseEvent):void
		{
			var snap:Number;
			
			if(_sliderNum == 1){
				slider1.x = this.mouseX;
				snap = _snapInterval*_compoWidth/(_maximum-_minimum);
				slider1.x = Math.round(slider1.x/snap)*snap;
				if(slider1.x > _compoWidth) slider1.x = _compoWidth;
				if(slider1.x <0) slider1.x = 0;
			}
			if(_sliderNum == 2){
				if(dragTarget == slider1){
					slider1.x = this.mouseX;
					snap = _snapInterval*_compoWidth/(_maximum-_minimum);
					slider1.x = Math.round(slider1.x/snap)*snap;
					if(slider1.x > slider2.x -_snapInterval*_spaceNum*_compoWidth/(_maximum-_minimum) ) slider1.x = slider2.x -_snapInterval*_spaceNum*_compoWidth/(_maximum-_minimum);
					if(slider1.x <0) slider1.x = 0;
				}
				//
				if(dragTarget == slider2){
					slider2.x = this.mouseX;
					snap = _snapInterval*_compoWidth/(_maximum-_minimum);
					slider2.x = Math.round(slider2.x/snap)*snap;
					if(slider2.x <slider1.x +_snapInterval*_spaceNum*_compoWidth/(_maximum-_minimum)) slider2.x = slider1.x +_snapInterval*_spaceNum*_compoWidth/(_maximum-_minimum);
					if(slider2.x > _compoWidth ) slider2.x = _compoWidth;
				}
				try{
					skin.updateSliderSpace();
				}catch(e:Error){
					
				}
			}
			if(_liveDragging == true){
				this.dispatchEvent(new Event(Event.CHANGE));
			}
			event.updateAfterEvent();
		}
		protected function moveToPoint(event:MouseEvent):void{
			var snap:Number;
			if(_sliderNum == 1){
				toPos1 = this.mouseX;
				snap = _snapInterval*_compoWidth/(_maximum-_minimum);
				toPos1 = Math.round(toPos1/snap)*snap;
				if(toPos1 > _compoWidth) toPos1 = _compoWidth;
				if(toPos1 <0) toPos1 = 0;
				mx1 = (toPos1-slider1.x)/_smothStep;
				this.addEventListener(Event.ENTER_FRAME,moveSlider1);
			}
			if(_sliderNum == 2){
				if(Math.abs(this.mouseX-slider1.x) < Math.abs(this.mouseX-slider2.x)){
					toPos1 = this.mouseX;
					snap = _snapInterval*_compoWidth/(_maximum-_minimum);
					toPos1 = Math.round(toPos1/snap)*snap;
					if(toPos1 > slider2.x -_snapInterval*_spaceNum*_compoWidth/(_maximum-_minimum) ) toPos1 = slider2.x -_snapInterval*_spaceNum*_compoWidth/(_maximum-_minimum);
					if(toPos1 <0) toPos1 = 0;
					mx1 = (toPos1-slider1.x)/_smothStep;
					this.addEventListener(Event.ENTER_FRAME,moveSlider1);
				}else{
					
					toPos2 = this.mouseX;
					snap = _snapInterval*_compoWidth/(_maximum-_minimum);
					toPos2 = Math.round(toPos2/snap)*snap;
					if(toPos2 <slider1.x +_snapInterval*_spaceNum*_compoWidth/(_maximum-_minimum)) toPos2 = slider1.x +_snapInterval*_spaceNum*_compoWidth/(_maximum-_minimum);
					if(toPos2 > _compoWidth ) toPos2 = _compoWidth;
					mx2 = (toPos2 - slider2.x)/_smothStep;
					this.addEventListener(Event.ENTER_FRAME,moveSlider2);
					
				}
			}
		}
		private function moveSlider1(event:Event):void{
			if(_smothMode == 1){
				slider1.x +=  mx1;
			}else{
				slider1.x +=  (toPos1-slider1.x)/_smothLess;
			}
			if(Math.abs(toPos1-slider1.x)<=0.5){
				slider1.x = toPos1;
				this.removeEventListener(Event.ENTER_FRAME,moveSlider1);
			}
			if(_sliderNum == 2){
				try{
					skin.updateSliderSpace();
				}catch(e:Error){
					
				}
			}
		}
		private function moveSlider2(event:Event):void{
			if(_smothMode == 1){
				slider2.x +=  mx2;
			}else{
				slider2.x +=  (toPos2-slider2.x)/_smothLess;
			}
			if(Math.abs(toPos2-slider2.x)<=0.5){
				slider2.x = toPos2;
				this.removeEventListener(Event.ENTER_FRAME,moveSlider2);
			}
			if(_sliderNum == 2){
				try{
					skin.updateSliderSpace();
				}catch(e:Error){
					
				}
			}
		}
	}
}