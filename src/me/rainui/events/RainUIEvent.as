/**
 * Morn UI Version 2.0.0526 http://www.mornui.com/
 * Feedback yungzhu@gmail.com http://weibo.com/newyung
 */
package me.rainui.events {
	import flash.events.Event;
	import me.rainssong.events.ObjectEvent;
	
	/**UI事件类*/
	public class RainUIEvent extends ObjectEvent {
		//-----------------Component-----------------	
		/**移动组件*/
		public static const MOVE:String = "move";
		public static const SELECT:String = "select";
		public static const CHANGE:String = "change";
		/**更新完毕*/
		public static const RENDER_COMPLETED:String = "renderCompleted";
		/**显示鼠标提示*/
		public static const SHOW_TIP:String = "showTip";
		/**隐藏鼠标提示*/
		public static const HIDE_TIP:String = "hideTip";
		//-----------------Image-----------------
		/**图片加载完毕*/
		public static const IMAGE_LOADED:String = "imageLoaded";
		//-----------------TextArea-----------------
		/**滚动*/
		public static const SCROLL:String = "scroll";
		//-----------------FrameClip-----------------
		/**帧跳动*/
		public static const FRAME_CHANGED:String = "frameChanged";
		//-----------------List-----------------
		/**项渲染*/
		public static const ITEM_RENDER:String = "listRender";
		
		
		public function RainUIEvent(type:String, data:*, bubbles:Boolean = false, cancelable:Boolean = false) {
			super(type, data, bubbles, cancelable);
			
		}
		
		override public function clone():Event {
			return new RainUIEvent(type,data, bubbles, cancelable);
		}
	}
}