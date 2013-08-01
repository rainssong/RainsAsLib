package me.rainssong.quest.VO 
{
	import me.rainssong.math.ArrayCore;
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
		private var _userAnswer:String="";
		//private var _userIntactAnswer:Vector.<String>;
		//private var _userSelection:Vector.<Boolean> ;
		
	
		public function QuestModel(index:int, title:String, options:Array,rightAnswer:String="" , minChoose:int = 1, maxChoose:int = 1,randomOrder:Boolean=false ) 
		{
			_index = index;
			_title = title;
			_rightAnswer = rightAnswer;
			_options = Vector.<String>(options);
			_isLast = isLast;
			_minChoose = minChoose;
			_maxChoose = maxChoose;
			_randomOrder = randomOrder;
			//_userSelection	= new Vector.<Boolean>(_options.length);
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
		
		public function get index():int 
		{
			return _index;
		}
		
		public function get userAnswer():String 
		{
			return _userAnswer;
		}
		
		/**
		 * User ansers as abcd
		 */
		public function set userAnswer(value:String):void 
		{
			_userAnswer = formatResult(value);
		}
		
		/**
		 * User ansers as content
		 */
		public function get userIntactAnswer():Vector.<String>
		{
			var vec:Vector.<String> = new Vector.<String>();
			for (var i:int = 0; i < _options.length; i++ )
			{
				if (_userAnswer.indexOf(ArrayCore.UPPER_CASE_LETTER_ARR[i]) >= 0)
				{
					vec.push(_options[i]);
				}
			}
			
			return vec;
		}
		
		public function set options(value:Vector.<String>):void 
		{
			_options = value;
		}
		
		public function set isLast(value:Boolean):void 
		{
			_isLast = value;
		}
	
		
	
		
		public function formatResult(str:String):String
		{
			var resortArr:Array = str.toUpperCase().split("");
			resortArr.sort();
			
			return resortArr.join("");
		}
		
		private function checkAnswer(resultString:String):Boolean
		{
			powerTrace("标准结果" + rightAnswer + "用户答案" + formatResult(_userAnswer),_userAnswer == formatResult(rightAnswer)?true: false);
			var isRight:Boolean=_userAnswer == formatResult(rightAnswer)?true: false;
			return isRight;
		}
		
	
		
	}

}