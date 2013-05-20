package cn.flashk.controls 
{
	import cn.flashk.controls.managers.SkinLoader;
	import cn.flashk.controls.managers.SkinManager;
	import cn.flashk.controls.managers.SourceSkinLinkDefine;
	import cn.flashk.controls.skin.ActionDrawSkin;
	import cn.flashk.controls.skin.ToggleButtonSkin;
	import cn.flashk.controls.skin.ToggleDrawSkin;
	import cn.flashk.controls.skin.sourceSkin.ButtonSourceSkin;
	import cn.flashk.controls.skin.sourceSkin.ToggleButtonSourceSkin;
	
	import flash.events.Event;
	import flash.events.MouseEvent;

	/**
	 * 当selected的值因为用户操作或者程序设置更改时触发
	 * @eventType flash.events.Event.CHANGE
	 **/
	[Event(name="change",type="flash.events.Event")]
	
	/**
	 * ToggleButton 组件定义切换按钮。单击该按钮会在弹起状态和按下状态之间进行切换。如果在按钮处于弹起状态时单击该按钮，则它会切换到按下状态。必须再次单击该按钮才可将其切换回弹起状态。 
	 *  
	 * @langversion ActionScript 3.0
	 * @playerversion Flash 9.0
	 * 
	 * @see cn.flashk.controls.support.UIComponent
	 * 
	 * @author flashk
	 */
	public class ToggleButton extends Button
	{
		protected var _selected:Boolean;
		
		public function ToggleButton() 
		{
			super();
			this.addEventListener(MouseEvent.CLICK, switchSelect);
		}
		/**
		 * 设置/获取按钮是否处于选中状态
		 */ 
		public function set selected(value:Boolean):void {
			_selected = value;
			
			skin.updateToggleView(_selected);
			
			this.dispatchEvent(new Event(Event.CHANGE));
		}
		public function get selected():Boolean {
			return _selected;
		}
		protected function switchSelect(event:MouseEvent):void {
			selected = !_selected;
		}
		
		override public function setDefaultSkin():void {
			setSkin(ToggleButtonSkin);
		}
		override public function setSourceSkin():void {
			setSkin(SkinLoader.getClassFromSkinFile(SourceSkinLinkDefine.BUTTON));
		}
		override public function setSkin(Skin:Class):void {
			if(SkinManager.isUseDefaultSkin == true){
				skin = new Skin();
				ActionDrawSkin(skin).init(this,styleSet);
			}else{
				var sous:ToggleButtonSourceSkin = new ToggleButtonSourceSkin();
				sous.init(this,styleSet,Skin);
				skin = sous;
			}
		}
	}

}