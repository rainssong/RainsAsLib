package me.rainui.managers {
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.utils.Dictionary;
	import me.rainssong.utils.Handler;
	import me.rainui.events.RainUIEvent;
	import me.rainui.RainUI;
	
	/**
	 * UI渲染管理器，延迟渲染，减少计算，按照先到先服务
	 * @date 2015-01-13 01:45:45
	 * @author Rainssong
	 * @blog http://blog.sina.com.cn/rainssong
	 * @homepage http://rainsgameworld.sinaapp.com
	 * @weibo http://www.weibo.com/rainssong
	 */
	public class RenderManager {
		private var _handlers:Vector.<Function> = new Vector.<Function>;
		//private var _handlers:Array.<Function> = [];
		private var _handlerDic:Dictionary = new Dictionary();
		
		private var _renderED:DisplayObject = new Sprite();
		
		private function invalidate():void {
			_renderED.addEventListener(Event.RENDER, onValidate);
			//render有一定几率无法触发，这里加上保险处理
			_renderED.addEventListener(Event.ENTER_FRAME, onValidate);
			if (RainUI.stage) 
			{
				RainUI.stage.invalidate();
			}
		}
		
		private function onValidate(e:Event):void {
			_renderED.removeEventListener(Event.RENDER, onValidate);
			_renderED.removeEventListener(Event.ENTER_FRAME, onValidate);
			renderAll();
			_renderED.dispatchEvent(new Event(RainUIEvent.RENDER_COMPLETED));
		}
		
		/**执行所有延迟调用*/
		public function renderAll():void {
			while(_handlers.length)
				exeCallLater(_handlers.shift());
		}
		
		/**延迟调用*/
		public function callLater(method:Function, args:Array = null):void {
			if (_handlerDic[method] == null) 
			{
				_handlers.push(method);
				_handlerDic[method] = args || [];
				invalidate();
			}
		}
		
		/**执行延迟调用*/
		public function exeCallLater(method:Function):void {
			if (_handlerDic[method] != null) {
				var args:Array = _handlerDic[method];
				delete _handlerDic[method];
				method.apply(null, args);
			}
		}
		
		public function clearCallLater(method:Function):void {
			if (_handlerDic[method] != null) {
				delete _handlerDic[method];
			}
		}
		
		public function get renderED():DisplayObject 
		{
			return _renderED;
		}
		
		public function set renderED(value:DisplayObject):void 
		{
			if (_renderED)
			{
				_renderED.removeEventListener(Event.RENDER, onValidate);
				_renderED.removeEventListener(Event.ENTER_FRAME, onValidate);
			}
		}
	}
}