package me.rainssong.application 
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import me.rainssong.display.MySprite;
	import mx.core.Singleton;
	
	/**
	 * ...
	 * @author Rainssong
	 */
	public class ApplicationBase extends MySprite 
	{
		private var _instance:ApplicationBase;
		private var _bgLayer:MySprite;
		private var _sceneLayer:MySprite;
		private var _mainLayer:MySprite;
		private var _uiLayer:MySprite;
		private var _warningLayer:MySprite
		
		public function ApplicationBase() 
		{
			if (_instance) throw Error("singleton");
			else _instance = this;
			
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		public function init(e:Event=null):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			_bgLayer = new MySprite();
			_sceneLayer = new MySprite();
			_mainLayer = new MySprite();
			_uiLayer = new MySprite();
			_warningLayer = new MySprite();
			addChild(_bgLayer);
			addChild(_sceneLayer);
			addChild(_mainLayer);
			addChild(_uiLayer);
			addChild(_warningLayer);
		}
		
		private function get instance():ApplicationBase
		{
			if (!_instance)_instance = new ApplicationBase();
			return _instance as ApplicationBase;
		}
		
		public function get bgLayer():MySprite 
		{
			return _bgLayer;
		}
		
		public function get sceneLayer():MySprite 
		{
			return _sceneLayer;
		}
		
		public function get mainLayer():MySprite 
		{
			return _mainLayer;
		}
		
		public function get uiLayer():MySprite 
		{
			return _uiLayer;
		}
		
		public function get warningLayer():MySprite 
		{
			return _warningLayer;
		}
		
	}

}
