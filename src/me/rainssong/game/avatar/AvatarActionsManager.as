package me.rainssong.game.avatar
{
	import com.codeTooth.actionscript.game.action.ActionData;
	import com.codeTooth.actionscript.game.action.ActionUtil;
	import com.codeTooth.actionscript.game.action.ClipData;
	import com.codeTooth.actionscript.lang.exceptions.NullPointerException;
	
	import flash.display.BitmapData;

	/**
	 * @private
	 * 
	 * 纸娃娃动作管理器。
	 */
	internal class AvatarActionsManager
	{
		// 存储所有的动作
		private var _actions:Array/*index style:int, value Array(index AvatarUnitType:int, value ActionData)*/ = null;
		
		public function AvatarActionsManager()
		{
			_actions = new Array();
		}
		
		/**
		 * 创建一个新的纸娃娃动作。
		 * 
		 * @param style 动作类型。任何不重复int值。
		 * @param avatarUnitType 动作部位。AvatarUnitType常量。
		 * @param bmpd 动作的位图。
		 * @param sparrow 动作的描述XML。Sparrow格式。
		 * @param origionX 注册点x像素坐标。
		 * @param origionY 注册点y像素坐标。
		 * 
		 * @return 是否成功创建。
		 */
		public function createAction(style:int, avatarUnitType:int, bmpd:BitmapData, sparrow:XML, origionX:int, origionY:int):Boolean
		{
			if(containsAction(style, avatarUnitType))
			{
				return false;
			}
			else
			{
				if(bmpd == null)
				{
					throw new NullPointerException("Null input bmpd parameter.");
				}
				if(sparrow == null)
				{
					throw new NullPointerException("Null input sparrow parameter.");
				}
				
				var clipsData:Vector.<ClipData> = ActionUtil.createClipsBySparrow(sparrow);
				ActionUtil.sliceClips(bmpd, clipsData);
				if(_actions[style] == null)
				{
					_actions[style] = new Array();
				}
				_actions[style][avatarUnitType] = new ActionData(0, clipsData, origionX, origionY, 0, 0);
				
				return true;
			}
		}
		
		/**
		 * 删除一个动作。
		 * 
		 * @param style
		 * @param avatarUnitType
		 * 
		 * @return 
		 */
		public function deleteAction(style:int, avatarUnitType:int):Boolean
		{
			if(containsAction(style, avatarUnitType))
			{
				var action:ActionData = _actions[style][avatarUnitType];
				action.destroy();
				delete _actions[style][avatarUnitType];
				
				return true;
			}
			else
			{
				return false;
			}
		}
		
		/**
		 * 获得一个动作数据。
		 * 
		 * @param style
		 * @param avatarUnitType
		 * @param clone 复制一份数据，这样每次得到的都是一个新的对象，可以随意修改。如果不是复制新对象，那么就不能随意修改返回的值。
		 * 
		 * @return 不存在指定的动作返回null。
		 */
		public function getAction(style:int, avatarUnitType:int, clone:Boolean = true):ActionData
		{
			if(containsAction(style, avatarUnitType))
			{
				var actionData:ActionData = _actions[style][avatarUnitType];
				return clone ? actionData.clone() : actionData;
			}
			else
			{
				return null;
			}
		}
		
		/**
		 * 是否包含指定的动作。
		 * 
		 * @param style
		 * @param avatarUnitType
		 * 
		 * @return 
		 */
		public function containsAction(style:int, avatarUnitType:int):Boolean
		{
			return _actions[style] != null && _actions[style][avatarUnitType] != null;
		}
	}
}