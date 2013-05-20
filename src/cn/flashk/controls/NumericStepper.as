package cn.flashk.controls
{
	import cn.flashk.controls.managers.SkinLoader;
	import cn.flashk.controls.managers.SkinManager;
	import cn.flashk.controls.managers.SourceSkinLinkDefine;
	import cn.flashk.controls.skin.SkinThemeColor;
	
	import flash.display.Shape;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.utils.clearTimeout;
	import flash.utils.setTimeout;
	/**
	 * 
	 * NumericStepper 组件包括一个单行输入文本字段和一对用于逐一显示可能值的箭头按钮。还可使用向上箭头键和向下箭头增加减少这些值。。
	 * 
	 * @langversion ActionScript 3.0
	 * @playerversion Flash 9.0
	 * 
	 * @see cn.flashk.controls.support.UIComponent
	 * 
	 * @author flashk
	 */

	public class NumericStepper extends TextInput
	{
		public var stepSize:Number = 1;
		
		private var upBtn:Button;
		private var downBtn:Button;
		private var _maximum:Number = 100;
		private var _minimum:Number = 0;
		private var count:uint;
		private var id:int;
		private var sh:Shape;
		private var sh2:Shape;
		
		public function NumericStepper()
		{
			super();
			
			_compoWidth = 120;
			_compoHeight = 23;
			
			restrict = "0-9 .-";
			upBtn = new Button();
			upBtn.setSize(17,12);
			upBtn.y = 0;
			downBtn = new Button();
			downBtn.setSize(17,11);
			downBtn.y = 12;
			upBtn.x = downBtn.x = _compoWidth-15-2;
			upBtn.addEventListener(MouseEvent.CLICK,addNum);
			upBtn.addEventListener(MouseEvent.MOUSE_DOWN,upFrame);
			downBtn.addEventListener(MouseEvent.CLICK,lessNum);
			downBtn.addEventListener(MouseEvent.MOUSE_DOWN,downFrame);
			upBtn.label = "";
			downBtn.label = "";
			//upBtn.toolTip = "增加值，按下不放快速增加";
			//downBtn.toolTip = "减少值，按下不放快速减少";
			this.addChild(downBtn);
			this.addChild(upBtn);
			
			value = 0;
			if(SkinManager.isUseDefaultSkin == true){
				sh = new Shape();
				upBtn.icon = sh;
				sh2 = new Shape();
				downBtn.icon = sh2;
				updateSkinPro();
			}else{
				upBtn.useSkinSize = true;
				upBtn.setSkin(SkinLoader.getClassFromSkinFile(SourceSkinLinkDefine.NUMERIC_STEPPER_UP));
				downBtn.useSkinSize = true;
				downBtn.setSkin(SkinLoader.getClassFromSkinFile(SourceSkinLinkDefine.NUMERIC_STEPPER_DOWN));
			}
		}
		override protected function updateSkinPro():void{
			
			sh.graphics.beginFill(SkinThemeColor.border,1);
			var a:Number =0;
			var b:Number = -7;
			sh.graphics.moveTo(int(2 / 2)+2.5+a, 4+2+b);
			sh.graphics.lineTo(int(2 / 2)+6.5+a, 8+2+b);
			sh.graphics.lineTo(int(2 / 2)-1.5+a, 8+2+b);
			sh2.graphics.beginFill(SkinThemeColor.border,1);
			a = 0;
			b = -11;
			sh2.graphics.moveTo(int(2 / 2)+2.5+a, 12+2+b);
			sh2.graphics.lineTo(int(2 / 2)+6.5+a, 8+2+b);
			sh2.graphics.lineTo(int(2 / 2)-1.5+a, 8+2+b);
		}
		public function get upClickButton():Button{
			return upBtn;
		}
		public function get downClickButton():Button{
			return downBtn;
		}
		
		protected function upFrame(event:MouseEvent):void
		{
			id = setTimeout(upFrameMain,500);
		}
		private function upFrameMain():void{
			count =0;
			this.addEventListener(Event.ENTER_FRAME,addByFrame);
			this.stage.addEventListener(MouseEvent.MOUSE_UP,clearUpFrame);
		}
		protected function clearUpFrame(event:MouseEvent):void
		{
			this.removeEventListener(Event.ENTER_FRAME,addByFrame);
			this.stage.removeEventListener(MouseEvent.MOUSE_UP,clearUpFrame);
		}
		
		protected function addByFrame(event:Event):void
		{
			count ++;
			if(count>1){
				count = 0;
				addNum();
			}
		}
		
		protected function downFrame(event:MouseEvent):void
		{
			id = setTimeout(downFrameMain,500);
		}
		private function downFrameMain():void{
			count =0;
			this.addEventListener(Event.ENTER_FRAME,lessByFrame);
			this.stage.addEventListener(MouseEvent.MOUSE_UP,cleardownFrame);
		}
		protected function cleardownFrame(event:MouseEvent):void
		{
			this.removeEventListener(Event.ENTER_FRAME,lessByFrame);
			this.stage.removeEventListener(MouseEvent.MOUSE_UP,cleardownFrame);
		}
		
		protected function lessByFrame(event:Event):void
		{
			count ++;
			if(count>1){
				count = 0;
				lessNum();
			}
		}
		
		public function addNum(event:MouseEvent=null):void
		{
			var va:Number = Number(txt.text);
			va += stepSize;
			if(va>maximum )va = maximum;
			txt.text = String(va);
			if(event != null) clearTimeout(id);
		}
		public function lessNum(event:MouseEvent=null):void
		{
			var va:Number = Number(txt.text);
			va -= stepSize;
			if(va<minimum )va = minimum;
			txt.text = String(va);
			if(event != null) clearTimeout(id);
			
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
		public function set value(va:Number):void{
			txt.text = String(va);
		}
		public function get value():Number{
			return Number(txt.text);
		}
	}
}