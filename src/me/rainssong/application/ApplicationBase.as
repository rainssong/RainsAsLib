package me.rainssong.application 
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.utils.getDefinitionByName;
	import me.rainssong.display.SmartSprite;
	
	/**
	 * ...
	 * @author Rainssong
	 */
	public class ApplicationBase extends SmartSprite 
	{
		protected var _instance:ApplicationBase;
		protected var _bgLayer:SmartSprite;
		protected var _mainLayer:SmartSprite;
		protected var _uiLayer:SmartSprite;
		protected var _warningLayer:SmartSprite
		
		
		
		public function ApplicationBase() 
		{
			super();
		}
		
		override protected function onAdd(e:Event = null):void 
		{
			super.onAdd(e);
			
			
			_bgLayer = new SmartSprite();
			
			_mainLayer = new SmartSprite();
			_uiLayer = new SmartSprite();
			_warningLayer = new SmartSprite();
			addChild(_bgLayer);
			
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
		
		
		protected function onOrientationChange(e:*):void
		{
			//var StageOrientation:Class = getDefinitionByName("StageOrientation") as Class;
			//switch (e.afterOrientation)
			//{
				//case StageOrientation.DEFAULT: 
					//if(!rotateDefaultable || !rotateable)e.preventDefault();
					//break;
				//case StageOrientation.ROTATED_RIGHT: 
					//if(!rotateRightable || !rotateable)e.preventDefault();
					//break;
				//case StageOrientation.ROTATED_LEFT:
					//if(!rotateLeftable || !rotateable)e.preventDefault();
					//break;
				//case StageOrientation.UPSIDE_DOWN: 
					//if(!rotateUpsideDownable || !rotateable)e.preventDefault();
					//break;
			//}
		}
		
		public function get bgLayer():SmartSprite 
		{
			return _bgLayer;
		}
		
		
		public function get mainLayer():SmartSprite 
		{
			return _mainLayer;
		}
		
		public function get uiLayer():SmartSprite 
		{
			return _uiLayer;
		}
		
		public function get warningLayer():SmartSprite 
		{
			return _warningLayer;
		}
	}

}
