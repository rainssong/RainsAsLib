package me.rainssong.application 
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.utils.getDefinitionByName;
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
		
		public static var rotateable:Boolean=true;
		public static var rotateDefaultable:Boolean=true;
		public static var rotateRigthable:Boolean=true;
		public static var rotateLeftable:Boolean=true;
		public static var rotateUpsideDownable:Boolean=true;
		
		public function ApplicationBase() 
		{
			super();
		}
		
		override protected function onAdd(e:Event = null):void 
		{
			super.onAdd(e);
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
					if(!rotateDefaultable || !rotateable)e.preventDefault();
					break;
				case StageOrientation.ROTATED_RIGHT: 
					if(!rotateRigthable || !rotateable)e.preventDefault();
					break;
				case StageOrientation.ROTATED_LEFT:
					if(!rotateLeftable || !rotateable)e.preventDefault();
					break;
				case StageOrientation.UPSIDE_DOWN: 
					if(!rotateUpsideDownable || !rotateable)e.preventDefault();
					break;
			}
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
