package me.rainssong.quest.VO 
{
	import me.rainssong.math.ArrayCore;
	/**
	 * ...
	 * @author rainsong
	 */
	public class FillQuestModel  extends QuestModel
	{
		private var _defaultText:String="";
		
	
		public function FillQuestModel(title:String,vars:Object=null) 
		{
			super(title, vars);
		}
		
		public function get defaultText():String 
		{
			return _defaultText;
		}
		
		
		
	}

}