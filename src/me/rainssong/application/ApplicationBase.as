package me.rainssong.application 
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.FullScreenEvent;
	import flash.media.AudioPlaybackMode;
	import flash.media.SoundMixer;
	import flash.utils.getDefinitionByName;
	import me.rainssong.display.SmartSprite;
	
	/**
	 * ...
	 * @author Rainssong
	 */
	public class ApplicationBase extends Sprite 
	{
		static protected var _instance:ApplicationBase;
		
		
		public function ApplicationBase() 
		{
			if(stage)
				this.addEventListener(Event.ADDED_TO_STAGE, onAddToStage);
			else
				onAddToStage();
		}
		
		protected function onAddToStage(e:Event = null):void 
		{
			stage.removeEventListener(Event.ADDED_TO_STAGE, onAddToStage);
			ApplicationManager.init(stage);
			SoundMixer.audioPlaybackMode = AudioPlaybackMode.AMBIENT;
			_instance = this;
			stage.addEventListener(FullScreenEvent.FULL_SCREEN, onFullScreen);
			stage.addEventListener(Event.RESIZE, onStageResize);
			stage.addEventListener(Event.DEACTIVATE, onStageDeactivate);
			stage.addEventListener(Event.ACTIVATE, onStageActivate);
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
		
		private function onStageResize(e:Event):void 
		{
			
		}
		
		private function onFullScreen(e:Event):void 
		{
			
		}
		
		private function onStageDeactivate(e:Event):void 
		{
			
		}
		
		private function onStageActivate(e:Event):void 
		{
			
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
		
		static public function get instance():ApplicationBase 
		{
			return _instance||new ApplicationBase();
		}
	}

}
