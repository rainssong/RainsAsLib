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
	dynamic public class QuestModel extends EventDispatcher
	{
		protected var _title:String;
		protected var _index:int;
		
		/**
		 * like "ACDF"
		 */
		protected var _rightAnswer:String;
		protected var _userAnswer:Array;
		
		
		protected var _mandatory:Boolean = true;
		protected var _isLast:Boolean = false;
		protected var _pics:Vector.<String>;
	
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
			_rightAnswer = rightAnswer;
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
			_userAnswer =value;
		}
		
		public function set isLast(value:Boolean):void 
		{
			_isLast = value;
		}
		
		public function get isRight():Boolean
		{
			powerTrace("标准结果" + _rightAnswer + "用户答案" + _userAnswer.join(""));
			return _rightAnswer==_userAnswer.join("");
		}
		
		public function get pics():Vector.<String> 
		{
			return _pics;
		}
		
		public function set pics(value:Vector.<String>):void 
		{
			_pics = value;
		}
		
	}

}