package me.rainssong.quest.VO
{
	import me.rainssong.math.ArrayCore;
	
	/**
	 * ...
	 * @author rainsong
	 */
	public class OptionQuestModel extends QuestModel
	{
		private var _options:Vector.<String>;
		private var _minChoose:int=1;
		private var _maxChoose:int=1;
		private var _randomOrder:Boolean = false;
		private var _userInputArr:Array = []
		
		public function OptionQuestModel(title:String, options:Vector.<String>, vars:Object = null)
		{
			super(title, vars);
			
			_options = options;
			//
			
			if (vars)
			{
				if (vars.minChoose)
					_minChoose = minChoose;
				if (vars.maxChoose)
					_maxChoose = maxChoose;
				if (vars.randomOrder)
					_randomOrder = randomOrder;
			}
		
		}
		
		/**
		 * User ansers as content
		 */
		public function get userIntactAnswer():Vector.<String>
		{
			var vec:Vector.<String> = new Vector.<String>();
			for (var i:int = 0; i < _userAnswer.length; i++)
			{
				if (_userInputArr[i] == "" || _userInputArr[i]==null)
				{
					vec.push(ArrayCore.UPPER_CASE_LETTER_ARR[i] + "." + options[i]);
				}
				else if (_userInputArr[i] is String)
					vec.push(ArrayCore.UPPER_CASE_LETTER_ARR[i] + "." + options[i] + ":" + _userInputArr[i]);
				
			}
			
			return vec;
		}
		
		override public function set userAnswer(value:String):void
		{
			_userAnswer = value.split("").sort().join("");
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
		
		public function get userInputArr():Array
		{
			return _userInputArr;
		}
		
		public function set userInputArr(value:Array):void
		{
			_userInputArr = value;
		}
		
		override public function clearAnswer():void
		{
			super.clearAnswer();
			_userInputArr = [];
		
		}
	
	}

}