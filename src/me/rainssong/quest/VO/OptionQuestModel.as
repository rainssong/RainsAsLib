package me.rainssong.quest.VO 
{
	import me.rainssong.math.ArrayCore;
	/**
	 * ...
	 * @author rainsong
	 */
	public class OptionQuestModel  extends QuestModel
	{
		private var _options:Vector.<String>;
		private var _minChoose:int;
		private var _maxChoose:int;
		private var _randomOrder:Boolean = false;
	
		public function QuestModel(title:String,index:int=0,rightAnswer:String="",mandatory:Boolean=true) 
		{
			super(title, index, rightAnswer, mandatory);
			
			//_options = Vector.<String>(options);
			//
			//_minChoose = minChoose;
			//_maxChoose = maxChoose;
			//_randomOrder = randomOrder;
			//_userSelection	= new Vector.<Boolean>(_options.length);
		}
		
		public function get options():Vector.<String> 
		{
			return _options;
		}
		
		public function get minChoose():int 
		{
			return _minChoose;
		}
		
		public function get maxChoose():int 
		{
			return _maxChoose;
		}
		
	
		
	}

}