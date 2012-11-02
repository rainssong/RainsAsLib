package me.rainssong.application 
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.utils.getDefinitionByName;
	import me.rainssong.display.MySprite;
	import mx.core.Singleton;
	import utils.Config;
	
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
		
		public static var rotateDefaultEnable:Boolean=true;
		public static var rotateRigthEnable:Boolean=true;
		public static var rotateLeftEnable:Boolean=true;
		public static var rotateUpsideDownEnable:Boolean=true;
		
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
			
			
			try 
			{
				var StageOrientationEvent:Class = getDefinitionByName("StageOrientationEvent") as Class;
				stage.addEventListener(StageOrientationEvent.ORIENTATION_CHANGING, onOrientationChange); 
			}
			catch (e:Error)
			{
				trace("不支持旋转");
			}
		}
		
		
		private function onOrientationChange(e:*):void
		{
			var StageOrientation:Class = getDefinitionByName("StageOrientation") as Class;
			switch (e.afterOrientation)
			{
				case StageOrientation.DEFAULT: 
					if(!rotateDefaultEnable)e.preventDefault();
					break;
				case StageOrientation.ROTATED_RIGHT: 
					if(!rotateRigthEnable)e.preventDefault();
					break;
				case StageOrientation.ROTATED_LEFT:
					if(!rotateLeftEnable)e.preventDefault();
					break;
				case StageOrientation.UPSIDE_DOWN: 
					if(!rotateUpsideDownEnable)e.preventDefault();
					break;
			}
		}
		
		
		private function getInstance():ApplicationBase
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
		
		public static function get stage():Stage
		{
			return stage;
		}
	}

}
