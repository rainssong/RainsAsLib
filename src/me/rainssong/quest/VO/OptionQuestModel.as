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
	
		public function OptionQuestModel(title:String,index:int=0,rightAnswer:String="",mandatory:Boolean=true) 
		{
			super(title, index, rightAnswer, mandatory);
			
			//_options = Vector.<String>(options);
			//
			//_minChoose = minChoose;
			//_maxChoose = maxChoose;
			//_randomOrder = randomOrder;
			//_userSelection	= new Vector.<Boolean>(_options.length);
		}
		
	
		
		public function get userSimpleAnswer():Vector.<String>
		{
			var vec:Vector.<String> = new Vector.<String>();
			for (var i:int = 0; i < _userAnswer.length; i++ )
			{
				if (_userAnswer[i] === true)
				{
					vec.push(ArrayCore.UPPER_CASE_LETTER_ARR[i]);
				}
				else if (_userAnswer[i] is String)
					vec.push(ArrayCore.UPPER_CASE_LETTER_ARR[i]+":"+_userAnswer[i]);
			}
			
			return vec;
		}
		
		/**
		 * User ansers as content
		 */
		public function get userIntactAnswer():Vector.<String>
		{
			var vec:Vector.<String> = new Vector.<String>();
			for (var i:int = 0; i < _userAnswer.length; i++ )
			{
				if (_userAnswer[i] === true)
				{
					vec.push(ArrayCore.UPPER_CASE_LETTER_ARR[i]+"."+options[i]);
				}
				else if (_userAnswer[i] is String)
					vec.push(ArrayCore.UPPER_CASE_LETTER_ARR[i]+"."+options[i]+":"+_userAnswer[i]);
			}
			
			return vec;
		}
		
		public function get options():Vector.<String> 
		{
			return _options;
		}
		
		public function set options(value:Vector.<String>):void 
		{
			_options = value;
		}
		
		public function get minChoose():int 
		{
			return _minChoose;
		}
		
		public function set minChoose(value:int):void 
		{
			_minChoose = value;
		}
		
		public function get maxChoose():int 
		{
			return _maxChoose;
		}
		
		public function set maxChoose(value:int):void 
		{
			_maxChoose = value;
		}
		
		public function get randomOrder():Boolean 
		{
			return _randomOrder;
		}
		
		public function set randomOrder(value:Boolean):void 
		{
			_randomOrder = value;
		}
		
	
		
	}

}