package me.rainssong.quest.VO 
{
	/**
	 * ...
	 * @author rainsong
	 */
	public class QuestModel 
	{
		private var _title:String;
		private var _options:Vector.<String>;
		private var _minChoose:int;
		private var _maxChoose:int;
		private var _isLast:Boolean;
		private var _answerIndex:int;
		private var _index:int;
		private var _randomOrder:Boolean;
		private var _rightAnswer:String;
		public function QuestModel(index:int, title:String,rightAnswer:String, options:Vector.<String>,  minChoose:int = 1, maxChoose:int = 1,randomOrder:Boolean=false ) 
		{
			_index = index;
			_title = title;
			_rightAnswer = rightAnswer;
			_options = options;
			_isLast = isLast;
			_minChoose = minChoose;
			_maxChoose = maxChoose;
			_randomOrder = randomOrder;
		}
		
		public function get title():String 
		{
			return _title;
		}
		
		/**
		 * 1->n
		 */
		
		public function get number():int
		{
			return _index + 1;
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
		
		public function get answerIndex():int 
		{
			return _answerIndex;
		}
		
		public function get isLast():Boolean 
		{
			return _isLast;
		}
		
		
		
		public function get randomOrder():Boolean 
		{
			return _randomOrder;
		}
		
		public function get rightAnswer():String 
		{
			return _rightAnswer;
		}
		
		
	
		
	}

}