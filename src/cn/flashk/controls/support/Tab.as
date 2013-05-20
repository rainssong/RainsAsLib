package cn.flashk.controls.support 
{
	import cn.flashk.controls.Button;
	import cn.flashk.controls.TabBar;
	import cn.flashk.controls.managers.SkinLoader;
	import cn.flashk.controls.managers.SkinManager;
	import cn.flashk.controls.managers.SourceSkinLinkDefine;
	import cn.flashk.controls.modeStyles.ButtonMode;
	import cn.flashk.controls.modeStyles.ButtonStyle;
	import cn.flashk.controls.skin.ActionDrawSkin;
	import cn.flashk.controls.skin.ButtonSkin;
	import cn.flashk.controls.skin.SkinThemeColor;
	import cn.flashk.controls.skin.sourceSkin.ButtonSourceSkin;
	
	import flash.display.CapsStyle;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.GradientType;
	import flash.display.JointStyle;
	import flash.display.LineScaleMode;
	import flash.display.Shape;
	import flash.events.MouseEvent;
	import flash.geom.ColorTransform;
	import flash.geom.Matrix;
	

	/**
	 * ...
	 * @author flashk
	 */
	public class Tab extends UIComponent
	{
		public var isAble:Boolean = true;
		public var index:uint;
		private var closeBtn:Button;
		public var btn:Button;
		private var sh:Shape;
		
		public function Tab() 
		{
			super();
			btn = new Button();
			
			btn.setStyle( ButtonStyle.DEFAULT_SKIN_ELLIPSE_BOTTOM_WIDTH , 0);
			btn.setStyle( ButtonStyle.DEFAULT_SKIN_ELLIPSE_BOTTOM_HEIGHT , 0);
			if(SkinManager.isUseDefaultSkin == false){
				btn.setSkin(SkinLoader.getClassFromSkinFile(SourceSkinLinkDefine.TAB_BUTTON));
			}
			btn.addEventListener(MouseEvent.CLICK,showPress);
			this.addChild(btn);
			
			initSelShow();
		}
		public function set label(value:String):void{
			btn.label = value;
		}
		public function get label():String{
			return btn.label;
		}
		public function set icon(value:Object):void{
			btn.icon = value;
		}
		public function showCloseButton():void{
			if(closeBtn == null){
				closeBtn = new Button();
				closeBtn.mode = ButtonMode.JUST_ICON;
				if(SkinManager.isUseDefaultSkin == false){
					closeBtn.useSkinSize = true;
					closeBtn.setSkin(SkinLoader.getClassFromSkinFile(SourceSkinLinkDefine.TAB_CLOSE_BUTTON));
					//closeBtn.setSize(15,15);
					closeBtn.y = int((btn.compoHeight-ButtonSourceSkin(closeBtn.skinControler).sc9Bitmap.height)/2);
					closeBtn.x = btn.compoWidth - closeBtn.y - ButtonSourceSkin(closeBtn.skinControler).sc9Bitmap.width+1;
				}else{
					closeBtn.setSize(11,11);
					sh = new Shape();
					updateSkin();
					closeBtn.icon = sh;
					closeBtn.y = int((btn.compoHeight-11)/2);
					closeBtn.x = btn.compoWidth - closeBtn.y - 11+1;
					closeBtn.isOutSkinHide = true;
				}
			}
			btn.setStyle("padding",7);
			btn.setStyle("align","left");
			btn.update();
			this.addEventListener(MouseEvent.MOUSE_OVER,showCloseBtn);
			this.addEventListener(MouseEvent.MOUSE_OUT,hideCloseBtn);
			this.addChild(closeBtn);
			closeBtn.toolTip = "关闭";
			closeBtn.visible = false;
			closeBtn.addEventListener(MouseEvent.CLICK,closeMe);
		}
		
		protected function hideCloseBtn(event:MouseEvent):void
		{
			if(btn.mouseEnabled == false) return;
			closeBtn.visible = false;
		}
		
		protected function showCloseBtn(event:MouseEvent):void
		{
			closeBtn.visible = true;
		}
		public function hideCloseButton():void{
			
		}
		public function setSelectOn():void {
			isAble = false;
			btn.mouseEnabled = false;
			btn.mouseChildren = false;
			if(SkinManager.isUseDefaultSkin == false){
				
				btn.removeEventListener(MouseEvent.MOUSE_OUT,ButtonSourceSkin(btn.skinControler).showOut);
				
				ButtonSourceSkin(btn.skinControler).showPressState();
			}else{
				
				btn.transform.colorTransform = new ColorTransform(1,1,1,1,30,30,30,0);
			}
			if(closeBtn != null){
				closeBtn.visible = true;
			}
		}
		public function setSelectOff():void {
			isAble = true;
			btn.mouseEnabled = true;
			btn.mouseChildren = true;
			btn.transform.colorTransform = new ColorTransform();
			if(SkinManager.isUseDefaultSkin == false){
				btn.addEventListener(MouseEvent.MOUSE_OUT,ButtonSourceSkin(btn.skinControler).showOut);
				ButtonSourceSkin(btn.skinControler).showOutState();
			}
			if(closeBtn != null){
				closeBtn.visible = false;
			}
		}
		override public function setSize(newWidth:Number, newHeight:Number):void{
			super.setSize(newWidth,newHeight);
			btn.setSize(newWidth,newHeight);
		}
		override public function updateSkin():void{
			if(sh != null){
				sh.graphics.clear();
				sh.graphics.lineStyle(1.5,SkinThemeColor.border,1);
				var a:Number = 4;
				sh.graphics.moveTo(-3+a,-3+a+1);
				sh.graphics.lineTo(3+a,3+a+1);
				sh.graphics.moveTo(3+a,-3+a+1);
				sh.graphics.lineTo(-3+a,3+a+1);
			}
		}
		protected function initSelShow():void {
			
		}
		protected function closeMe(event:MouseEvent):void{
			
			TabBar(this.parent).closeTab(index);
		}
		protected function showPress(event:MouseEvent):void{
		}
	}

}