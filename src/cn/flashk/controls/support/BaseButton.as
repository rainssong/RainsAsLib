package cn.flashk.controls.support 
{
	/**
	 * ...
	 * @author flashk
	 */
	public class BaseButton extends UIComponent
	{
		protected var _enabled:Boolean;
		
		public function BaseButton() 
		{
			super();
		}
		public function get enabled():Boolean {
			return _enabled;
		}
		/**
		 * 是否允许按钮接受用户鼠标交互
		 */ 
		public function set enabled(value:Boolean):void {
			_enabled = value;
			if (_enabled == false) {
				this.mouseChildren = false;
				this.mouseEnabled = false;
				this.alpha = 0.5;
			}else {
				this.mouseChildren = true;
				this.mouseEnabled = true;
				this.alpha = 1.0;
			}
		}
	}

}