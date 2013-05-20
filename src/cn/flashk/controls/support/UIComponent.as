package cn.flashk.controls.support 
{
	import cn.flashk.controls.ToolTip;
	import cn.flashk.controls.events.UIComponentEvent;
	import cn.flashk.controls.managers.ComponentsManager;
	import cn.flashk.controls.managers.SkinManager;
	import cn.flashk.controls.skin.ActionDrawSkin;
	
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	
	/**
	 * 当组件的大小改变时调度
	 * @cn.flashk.controls.events.UIComponentEvent.RESIZE
	 **/
	[Event(name="resize",type="cn.flashk.controls.events.UIComponentEvent")]
	/**
	 * 当用户在组件上按下键盘某个键时调度
	 * @eventType flash.events.KeyboardEvent.KEY_DOWN
	 **/
	[Event(name="keyDown",type="flash.events.KeyboardEvent")]
	/**
	 * 当用户在组件上按下键盘某个键弹起时调度
	 * @eventType flash.events.KeyboardEvent.KEY_UP
	 **/
	[Event(name="keyUp",type="flash.events.KeyboardEvent")]
	/**
	 * 当用户在组件上双击鼠标时调度
	 * @eventType flash.events.MouseEvent.DOUBLE_CLICK
	 **/
	[Event(name="doubleClick",type="flash.events.MouseEvent")]
	/**
	 * 当用户在组件上按下鼠标并弹起时调度
	 * @eventType flash.events.MouseEvent.CLICK
	 **/
	[Event(name="click",type="flash.events.MouseEvent")]
	/**
	 * 当用户鼠标划过组件时调度
	 * @eventType flash.events.MouseEvent.MOUSE_OVER
	 **/
	[Event(name="mouseOver",type="flash.events.MouseEvent")]
	/**
	 * 当用户鼠标离开组件时调度
	 * @eventType flash.events.MouseEvent.MOUSE_OUT
	 **/
	[Event(name="mouseOut",type="flash.events.MouseEvent")]
	/**
	 * 用户在组件实例上按下指针设备按钮时调度
	 * @eventType flash.events.MouseEvent.MOUSE_DOWN
	 **/
	[Event(name="mouseDown",type="flash.events.MouseEvent")]
	/**
	 * 用户在组件实例上释放指针设备按钮时调度
	 * @eventType flash.events.MouseEvent.MOUSE_UP
	 **/
	[Event(name="mouseUp",type="flash.events.MouseEvent")]
	/**
	 * 用户移动组件上的指针设备时调度
	 * @eventType flash.events.MouseEvent.MOUSE_MOVE
	 **/
	[Event(name="mouseMove",type="flash.events.MouseEvent")]
	/**
	 * 鼠标滚轮滚动到组件实例上时调度
	 * @eventType flash.events.MouseEvent.MOUSE_WHEEL
	 **/
	[Event(name="mouseWheel",type="flash.events.MouseEvent")]
	
	/**
	 * UIComponent 是所有界面组件的基类
	 * 
	 * <p>UIComponent定义了所有组件共同的以下方法和属性：toolTip、setSize、updateSkin、setDefaultSkin、setSkin、setStyle、getStyleValue</p>
	 * <p>UIComponent本身加入显示列表并不能产生作用。</p>
	 * 
	 * @langversion ActionScript 3.0
	 * @playerversion Flash 9.0
	 * 
	 * @see cn.flashk.controls.managers.ComponentsManager
	 * 
	 * @author flashk
	 */
	public class UIComponent extends Sprite
	{
		public static var stage:Stage;
		public static var isCtrlKeyDown:Boolean = false;
		public static var isAltKeyDown:Boolean = false;
		
		protected var _compoWidth:Number = 10;
		protected var _compoHeight:Number = 10;
		protected var styleSet:Object = new Object();
		protected var isStyleUserSet:Object = new Object();
		protected var skin:Object;
		protected var _tip:Object;
		protected var isUseSourceSkin:Boolean = false;
		
		/**
		 * 获得组件的宽度，此宽度并不一定等同于DisplayObject的width。是setSize的宽度
		 * 
		 * @see #setSize()
		 * @see flash.display.DisplayObject
		 */ 
		public function get compoWidth():Number {
			return _compoWidth;
		}
		/**
		 * 获得组件的高度，此宽度并不一定等同于DisplayObject的height。是setSize的高度度
		 * 
		 * @see #setSize()
		 * @see flash.display.DisplayObject
		 */ 
		public function get compoHeight():Number {
			return _compoHeight;
		}
		/**
		 * 设置组件的提示 接受简单String文本，HTML String，图像URL Request，BitmapData,库链接，DisplayObject
		 * @param value 和组件绑定的提示，用户鼠标在组件上悬停一段时间后将显示
		 */ 
		public function set toolTip(value:Object):void {
			_tip = value;
			if(_tip != null){
				ToolTip.registerTip(this,_tip);
			}else{
				ToolTip.clearTip(this);
			}
		}
		public function get toolTip():Object{
			return _tip;
		}
		public function get skinControler():Object{
			return skin;
		}
		/**
		 * 创建新的 UIComponent 组件实例，不建议直接创建此实例
		 */ 
		public function UIComponent() 
		{
			ComponentsManager.allRefs.push(this);
			if (SkinManager.isUseDefaultSkin == true) {
				isUseSourceSkin = false;
				setDefaultSkin();
			}else{
				isUseSourceSkin = true;
				setSourceSkin();
			}
			if(stage == null){
				this.addEventListener(Event.ADDED_TO_STAGE,addToStageInit);
			}
		}
		/**
		 * 设置组件的宽度和高度，组件将按此值调整并刷新显示
		 * @param newWidth 新的宽度值
		 * @param newHeight 新的高度值
		 */ 
		public function setSize(newWidth:Number, newHeight:Number):void {
			_compoWidth = newWidth;
			_compoHeight = newHeight;
			
			
			if (skin != null ) {
				try{
					skin.reDraw();
				}catch (e:Error) {
					
				}
			}
			this.dispatchEvent(new UIComponentEvent(UIComponentEvent.RESIZE));
		}
		/**
		 * 如果组件的数据源有更改或者其它原因需要刷新组件以显示组件最新的数据变化，强制组件刷新
		 */ 
		public function update():void {
			 
		}
		/**
		 * 强制组件立即刷新皮肤显示
		 */ 
		public function updateSkin():void {
			try{
				skin.updateSkin();
			}catch (e:Error) {
				
			}
			updateSkinPro();
		}
		protected function updateSkinPro():void{
			
		}
		/**
		 * 将组件设定为默认的ActionScript皮肤
		 */ 
		public function setDefaultSkin():void {
			
		}
		
		/**
		 * 将组件设定为默认的外部文件的皮肤
		 */ 
		public function setSourceSkin():void {
			
		}
		/**
		 * 为单个组件设定皮肤，要为整个程序组件设定皮肤，请参考SkinManager
		 * @param skin 对皮肤类的引用
		 * 
		 * @see cn.flashk.controls.managers.SkinManager
		 */ 
		public function setSkin(skin:Class):void {
			
		}
		/**
		 * 设定组件的呈现样式，通常每个组件会有很多不同的样式可以设定，这些样子被列在组件的Style项中。通过统一的setStyle方法设定。
		 * <p>有些和某些特定皮肤关联的样式可能不能设定在其它皮肤中（比如默认ASSkin的一些样式，请参见具体的样式说明）</p>
		 * 
		 * @param styleName 样式的名称
		 * @param value 和样式有关的新值
		 */ 
		public function setStyle(styleName:String, value:Object):void {
			styleSet[styleName] = value;
			isStyleUserSet[styleName] = true;
		}
		/**
		 * 查询设定的样式值，或者默认的样式值
		 * 
		 * @return 指定样式名称的值
		 */ 
		public function getStyleValue(styleName:String):Object{
			return styleSet[styleName];
		}
		protected function findStyleUserSet(styleName:String):Boolean {
			try {
				var a:Boolean = isStyleUserSet[styleName];
			}catch (e:Error) {
				trace("not found Style", styleName);
				return false;
			}
			return a;
		}
		/**
		 * 清除此组件的所有监听事件
		 */ 
		public function clearAllEventListener():void{
			
		}
		/**
		 * 销毁此组件，销毁过程中将按顺序进行以下操作：将自己从显示列表移除，清除组件使用的位图缓存，清除组件内部使用的其他内存。调用clearAllEventListener清除所有的监听
		 */ 
		public function destroy():void{
			
		}
		private function addToStageInit(event:Event):void{
			UIComponent.stage = this.stage;
			initStageLis();
		}
		protected static function initStageLis():void
		{
			UIComponent.stage.addEventListener(KeyboardEvent.KEY_DOWN,checkKeyDown);
			UIComponent.stage.addEventListener(KeyboardEvent.KEY_UP,checkKeyUp);
		}
		
		/*
		*/
		protected static function checkKeyUp(
			event:KeyboardEvent):void
		{
			if(event.keyCode == Keyboard.CONTROL || event.keyCode == 18){
				isCtrlKeyDown = event.ctrlKey;
				isAltKeyDown = event.altKey;
			}
			isCtrlKeyDown = false;
			isAltKeyDown = false;
		}
		
		/*
		*/
		protected static function checkKeyDown(
			event:KeyboardEvent):void
		{
			if(event.keyCode == Keyboard.CONTROL || event.keyCode == 18){
				isCtrlKeyDown = event.ctrlKey;
				isAltKeyDown = event.altKey;
			}
		}
	}

}