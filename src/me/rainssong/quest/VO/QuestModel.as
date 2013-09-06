package me.rainssong.quest.VO 
{
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.events.EventDispatcher;
	import me.rainssong.math.ArrayCore;
	/**
	 * ...
	 * @author rainsong
	 */
	public class QuestModel extends EventDispatcher
	{
		protected var _title:String;
		protected var _index:int;
		
		/**
		 * like "ACDF"
		 */
		protected var _rightAnswer:String;
		protected var _userAnswer:Array;
		protected var _userIntactAnswer:Vector.<String>;
		//private var _userSelection:Vector.<Boolean> ;
		protected var _mandatory:Boolean = true;
		protected var _isLast:Boolean = false;
		protected var _pics:Vector.<DisplayObject>;
	
		/**
		 * 
		 * @param	title
		 * @param	index
		 * @param	rightAnswers
		 * @param	mandatory
		 */
		public function QuestModel(title:String,index:int=0,rightAnswer:String="",mandatory:Boolean=true) 
		{
			_index = index;
			_title = title;
			_rightAnswer = Vector.<String>(rightAnswer);
			_options = Vector.<String>(options);
			_mandatory = mandatory;
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
		
		public function get isLast():Boolean 
		{
			return _isLast;
		}
		
		public function get rightAnswer():String 
		{
			return _rightAnswer;
		}
		
		public function get index():int 
		{
			return _index;
		}
		
		public function get userAnswer():Array
		{
			return _userAnswer;
		}
		
		/**
		 * User ansers as abcd
		 */
		public function set userAnswer(value:Array):void
		{
			//_userAnswer = formatResult(value);
			_userAnswers =value;
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
				else if (_userAnswers[i] is String)
					vec.push(ArrayCore.UPPER_CASE_LETTER_ARR[i]+"."+options[i]+":"+_userAnswer[i]);
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
		
		private function get isRight():Boolean
		{
			powerTrace("标准结果" + rightAnswesr + "用户答案" + userSimpleAnswer.join(""));
			return rightAnswesr==userSimpleAnswer.join("");
		}
		
		public function get pics():Vector.<DisplayObject> 
		{
			return _pics;
		}
		
	}

}