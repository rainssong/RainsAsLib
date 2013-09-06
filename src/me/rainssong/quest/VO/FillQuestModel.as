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
		
	
		public function FillQuestModel(title:String,index:int=0,rightAnswer:String="",mandatory:Boolean=true) 
		{
			super(title, index, rightAnswer, mandatory);
		}
		
		public function get defaultText():String 
		{
			return _defaultText;
		}
		
		
		
	}

}