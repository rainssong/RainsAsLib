package cn.flashk.controls 
{
	import cn.flashk.controls.managers.DefaultStyle;
	import cn.flashk.controls.managers.SkinLoader;
	import cn.flashk.controls.managers.SkinManager;
	import cn.flashk.controls.managers.SourceSkinLinkDefine;
	import cn.flashk.controls.modeStyles.ButtonMode;
	import cn.flashk.controls.modeStyles.ButtonStyle;
	import cn.flashk.controls.skin.ActionDrawSkin;
	import cn.flashk.controls.skin.CheckBoxSkin;
	import cn.flashk.controls.skin.sourceSkin.CheckBoxSourceSkin;
	
	import flash.text.TextFormatAlign;
	
	/**
	 * CheckBox 组件显示一个小方框，该方框内可以有选中标记。 CheckBox 组件还可以显示可选的文本标。
	 * 
	 * <p>CheckBox 组件为响应鼠标单击将更改其状态，或者从选中状态变为取消选中状态，或者从取消选中状态变为选中状态。 CheckBox 组件包含一组非相互排斥的 true 或 false 值。</p>
	 *  
	 * @langversion ActionScript 3.0
	 * @playerversion Flash 9.0
	 * 
	 * @see cn.flashk.controls.support.UIComponent
	 * 
	 * @author flashk
	 */
	public class CheckBox extends ToggleButton
	{
		
		public function CheckBox() 
		{
			super();
			label = "多选";
			
			styleSet[ ButtonStyle.TEXT_COLOR ] = DefaultStyle.checkBoxTextColor;
			styleSet[ ButtonStyle.TEXT_OVER_COLOR ] = DefaultStyle.checkBoxTextOverColor;
			styleSet[ ButtonStyle.TEXT_DOWN_COLOR ] = DefaultStyle.checkBoxTextColor;
			
			initTextColor();
			tf.align = TextFormatAlign.LEFT;
			txt.setTextFormat(tf)
		}
		override public function setDefaultSkin():void {
			setSkin(CheckBoxSkin);
		}
		override public function setSourceSkin():void {
			setSkin(SkinLoader.getClassFromSkinFile(SourceSkinLinkDefine.CHECK_BOX));
		}
		override public function setSkin(Skin:Class):void {
			if(SkinManager.isUseDefaultSkin == true){
				skin = new Skin();
				ActionDrawSkin(skin).init(this,styleSet);
			}else{
				var sous:CheckBoxSourceSkin = new CheckBoxSourceSkin();
				sous.init(this,styleSet,Skin);
				skin = sous;
			}
		}
		override public function updateSkin():void {
		
			super.updateSkin();
			
			styleSet[ ButtonStyle.TEXT_COLOR ] = DefaultStyle.checkBoxTextColor;
			styleSet[ ButtonStyle.TEXT_OVER_COLOR ] = DefaultStyle.checkBoxTextOverColor;
			styleSet[ ButtonStyle.TEXT_DOWN_COLOR ] = DefaultStyle.checkBoxTextColor;
			initTextColor();
		}
		override public function setSize(newWidth:Number, newHeight:Number):void {
			//trace("size", this);
			super.setSize(newWidth, newHeight);
			if (_mode == ButtonMode.JUST_ICON) {
				iconBD.x = int((_compoWidth - iconBD.width) / 2)+1;
			}else{
				txt.width = _compoWidth -16;
				txt.x = 16;
				txt.y = int((_compoHeight - txt.height) / 2);
				txtDrop.width = txt.width;
				txtDrop.x = txt.x;
				txtDrop.y = txt.y+1;
			}
		}
	}

}