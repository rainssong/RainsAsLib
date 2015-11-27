package me.rainssong.game.avatar
{
	import com.codeTooth.actionscript.game.action.Action;
	import com.codeTooth.actionscript.game.action.ActionData;
	import com.codeTooth.actionscript.lang.utils.destroy.DestroyUtil;
	import com.codeTooth.actionscript.lang.utils.destroy.IDestroy;
	
	import flash.display.BitmapData;
	import flash.display.Sprite;
	
	/**
	 * 纸娃娃
	 */
	public class Avatar extends Sprite implements IDestroy
	{
		public function Avatar()
		{
			initializeCanvas();
			initializeSwapCanvas();
			mouseEnabled = false;
			mouseChildren = false;
		}
		
		//------------------------------------------------------------------------------------------------------------------------------
		// Actions Static
		//------------------------------------------------------------------------------------------------------------------------------
		
		private static var _actions:AvatarActionsManager = new AvatarActionsManager();
		
		/**
		 * @copy com.codeTooth.actionscript.game.avatar.AvatarActionsManager#createAction()
		 */
		public static function createAction(style:int, avatartUnitType:int, bmpd:BitmapData, sparrow:XML, origionX:int, origionY:int):Boolean
		{
			return _actions.createAction(style, avatartUnitType, bmpd, sparrow, origionX, origionY);
		}
		
		/**
		 * @copy com.codeTooth.actionscript.game.avatar.AvatarActionsManager#deleteAction()
		 */
		public static function deleteAction(style:int, avatartUnitType:int):Boolean
		{
			return _actions.deleteAction(style, avatartUnitType);
		}
		
		/**
		 * @copy com.codeTooth.actionscript.game.avatar.AvatarActionsManager#containsAction()
		 */
		public static function containsAction(style:int, avatarUnitType:int):Boolean
		{
			return _actions.containsAction(style, avatarUnitType);
		}
		
		/**
		 * @copy com.codeTooth.actionscript.game.avatar.AvatarActionsManager#getAction()
		 */
		public static function getAction(style:int, avatartUnitType:int, clone:Boolean = true):ActionData
		{
			return _actions.getAction(style, avatartUnitType, clone);
		}
		
		//------------------------------------------------------------------------------------------------------------------------------
		// Player
		//------------------------------------------------------------------------------------------------------------------------------
		
		// 动作规则
		private var _actionsIndex:Array = null;
		
		private var _action:int = 0;
		
		private var _actionIndex:int = 0;
		
		/**
		 * 播放指定的动作
		 * 
		 * @param action
		 */
		public function play(action:int):void
		{
			if(_actionsIndex == null)
			{
				return;
			}
			
			if(_action == action)
			{
				_actionIndex = _actionIndex >= _action + _actionsIndex[_action] ? _action : _actionIndex;
			}
			else
			{
				_action = action;
				_actionIndex = _action;
			}
			for each(var canvas:Action in _canvas)
			{
				refreshCanvas(canvas);
			}
			_actionIndex++;
		}
		
		/**
		 * 设置动作规则
		 * 
		 * @param actionsIndex
		 * 
		 * <pre>
		 * 第一个动作从第0帧开始，持续8帧
		 * 第二个动作从第8帧开始，持续8帧
		 * 第二个动作从第16帧开始，持续8帧
		 * 以此类推
		 * var actionsIndex:Array = new Array();
		 * actionsIndex[0] = 8;
		 * actionsIndex[8] = 8;
		 * actionsIndex[16] = 8;
		 * actionsIndex[24] = 8;
		 * actionsIndex[32] = 8;
		 * </pre>
		 */
		public function setActionsIndex(actionsIndex:Array):void
		{
			_actionsIndex = actionsIndex;
		}
		
		/**
		 * 获得动作规律
		 * 
		 * @return 
		 */
		public function getActionsIndex():Array
		{
			return _actionsIndex;
		}
		
		private function refreshCanvas(canvas:Action):void
		{
			if(canvas.getActionData() != null)
			{
				canvas.gotoClip(_actionIndex);
				canvas.refreshClip();
			}
		}
		
		//------------------------------------------------------------------------------------------------------------------------------
		// Actions
		//------------------------------------------------------------------------------------------------------------------------------
		
		/**
		 * 纸娃娃穿上部件
		 * 
		 * @param style
		 * @param avatarUnitType
		 * @param immediately
		 * 
		 * @return 
		 */
		public function setAvatarUnit(style:int, avatarUnitType:int, immediately:Boolean = false):Boolean
		{
			var action:ActionData = getAction(style, avatarUnitType, false);
			if(action == null)
			{
				return false;
			}
			else
			{
				var canvas:Action = getCanvas(avatarUnitType);
				if(canvas != null)
				{
					canvas.setActionData(action);
					immediately ? refreshCanvas(canvas) : null;
				}
				
				return true;
			}
		}
		
		/**
		 * 纸娃娃脱下部件
		 * 
		 * @param avatarUnitType
		 * @param immediately
		 */
		public function clearAvatarUnit(avatarUnitType:int, immediately:Boolean = false):void
		{
			var canvas:Action = getCanvas(avatarUnitType);
			if(canvas != null)
			{
				canvas.setActionData(null);
				immediately ? refreshCanvas(canvas) : null;
			}
		}
		
		//------------------------------------------------------------------------------------------------------------------------------
		// Swap Canvas
		//------------------------------------------------------------------------------------------------------------------------------
		
		private var _swapCanvas:Array = null; 
		
		protected function swapCanvas(avatarUnitType1:int, avatarUnitType2:int, swapOrReset:Boolean, immediately:Boolean = true):Boolean
		{
			var canvas1:Action = getCanvas(avatarUnitType1);
			var canvas2:Action = getCanvas(avatarUnitType2);
			if(canvas1 == null || canvas2 == null)
			{
				return false;
			}
			else
			{
				var data1:ActionData = null
				var data2:ActionData = null;
				if(swapOrReset)
				{
					if(_swapCanvas[avatarUnitType1] == null)
					{
						data1 = canvas1.getActionData();
						data2 = canvas2.getActionData();
						if(data1 == null && data2 == null)
						{
							return false;
						}
						else
						{
							_swapCanvas[avatarUnitType1] = avatarUnitType2;
							_swapCanvas[avatarUnitType2] = avatarUnitType1;
							canvas1.setActionData(data2);
							canvas2.setActionData(data1);
							if(immediately)
							{
								refreshCanvas(canvas1);
								refreshCanvas(canvas2);
							}
							
							return true;
						}
					}
					else
					{
						return false;
					}
				}
				else
				{
					if(_swapCanvas[avatarUnitType1] != null)
					{
						delete _swapCanvas[avatarUnitType1];
						delete _swapCanvas[avatarUnitType2];
						data1 = canvas1.getActionData();
						data2 = canvas2.getActionData();
						canvas1.setActionData(data2);
						canvas2.setActionData(data1);
						if(immediately)
						{
							refreshCanvas(canvas1);
							refreshCanvas(canvas2);
						}
						
						return true;
					}
					else
					{
						return false;
					}
				}
			}
		}
		
		private function initializeSwapCanvas():void
		{
			_swapCanvas = new Array();
		}
		
		private function destroySwapCanvas():void
		{
			_swapCanvas = null;
		}
		
		//------------------------------------------------------------------------------------------------------------------------------
		// Canvas
		//------------------------------------------------------------------------------------------------------------------------------
		
		private var _canvas:Array = null;
		
		private function initializeCanvas():void
		{
			_canvas = new Array();
			_canvas[AvatarUnitType.ARM_LEFT_BEFORE] = new Action();
			_canvas[AvatarUnitType.ARM_LEFT] = new Action();
			_canvas[AvatarUnitType.ARM_LEFT_AFTER] = new Action();
			
			_canvas[AvatarUnitType.ARM_RIGHT_BEFORE] = new Action();
			_canvas[AvatarUnitType.ARM_RIGHT] = new Action();
			_canvas[AvatarUnitType.ARM_RIGHT_AFTER] = new Action();
			
			_canvas[AvatarUnitType.BODY_BEFORE] = new Action();
			_canvas[AvatarUnitType.BODY] = new Action();
			_canvas[AvatarUnitType.BODY_AFTER] = new Action();
			
			_canvas[AvatarUnitType.LEG_LEFT_BEFORE] = new Action();
			_canvas[AvatarUnitType.LEG_LEFT] = new Action();
			_canvas[AvatarUnitType.LEG_LEFT_AFTER] = new Action();
			
			_canvas[AvatarUnitType.LEG_RIGHT_BEFORE] = new Action();
			_canvas[AvatarUnitType.LEG_RIGHT] = new Action();
			_canvas[AvatarUnitType.LEG_RIGHT_AFTER] = new Action();
			
			_canvas[AvatarUnitType.CLOTHES_ARM_LEFT_BEFORE] = new Action();
			_canvas[AvatarUnitType.CLOTHES_ARM_LEFT] = new Action();
			_canvas[AvatarUnitType.CLOTHES_ARM_LEFT_AFTER] = new Action();
			
			_canvas[AvatarUnitType.CLOTHES_ARM_RIGHT_BEFORE] = new Action();
			_canvas[AvatarUnitType.CLOTHES_ARM_RIGHT] = new Action();
			_canvas[AvatarUnitType.CLOTHES_ARM_RIGHT_AFTER] = new Action();
			
			_canvas[AvatarUnitType.CLOTHES_BODY_BEFORE] = new Action();
			_canvas[AvatarUnitType.CLOTHES_BODY] = new Action();
			_canvas[AvatarUnitType.CLOTHES_BODY_AFTER] = new Action();
			
			_canvas[AvatarUnitType.GLOVES_LEFT_BEFORE] = new Action();
			_canvas[AvatarUnitType.GLOVES_LEFT] = new Action();
			_canvas[AvatarUnitType.GLOVES_LEFT_AFTER] = new Action();
			
			_canvas[AvatarUnitType.GLOVES_RIGHT_BEFORE] = new Action();
			_canvas[AvatarUnitType.GLOVES_RIGHT] = new Action();
			_canvas[AvatarUnitType.GLOVES_RIGHT_AFTER] = new Action();
			
			_canvas[AvatarUnitType.HAT_BEFORE] = new Action();
			_canvas[AvatarUnitType.HAT] = new Action();
			_canvas[AvatarUnitType.HAT_AFTER] = new Action();
			
			_canvas[AvatarUnitType.HEAD_BEFORE] = new Action();
			_canvas[AvatarUnitType.HEAD] = new Action();
			_canvas[AvatarUnitType.HEAD_AFTER] = new Action();
			
			_canvas[AvatarUnitType.PANTS_LEFT_BEFORE] = new Action();
			_canvas[AvatarUnitType.PANTS_LEFT] = new Action();
			_canvas[AvatarUnitType.PANTS_LEFT_AFTER] = new Action();
			
			_canvas[AvatarUnitType.PANTS_RIGHT_BEFORE] = new Action();
			_canvas[AvatarUnitType.PANTS_RIGHT] = new Action();
			_canvas[AvatarUnitType.PANTS_RIGHT_AFTER] = new Action();
			
			_canvas[AvatarUnitType.SHOES_LEFT_BEFORE] = new Action();
			_canvas[AvatarUnitType.SHOES_LEFT] = new Action();
			_canvas[AvatarUnitType.SHOES_LEFT_AFTER] = new Action();
			
			_canvas[AvatarUnitType.SHOES_RIGHT_BEFORE] = new Action();
			_canvas[AvatarUnitType.SHOES_RIGHT] = new Action();
			_canvas[AvatarUnitType.SHOES_RIGHT_AFTER] = new Action();
			
			_canvas[AvatarUnitType.WEAPON_BEFORE] = new Action();
			_canvas[AvatarUnitType.WEAPON] = new Action();
			_canvas[AvatarUnitType.WEAPON_AFTER] = new Action();
			
			for each(var action:Action in _canvas)
			{
				addChild(action);
			}
		}
		
		private function destroyCanvas():void
		{
			DestroyUtil.destroyArray(_canvas);
			_canvas = null;
			DestroyUtil.removeChildren(this);
		}
		
		private function getCanvas(avatarUnitType:int):Action
		{
			return _canvas[avatarUnitType];
		}
		
		//------------------------------------------------------------------------------------------------------------------------------
		// IDestroy
		//------------------------------------------------------------------------------------------------------------------------------
		
		public function destroy():void
		{
			destroyCanvas();
			destroySwapCanvas();
		}
	}
}