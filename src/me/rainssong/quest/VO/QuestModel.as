package me.rainssong.quest.VO 
{
	import com.greensock.TweenLite;
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
		protected var _title:String="";
		protected var _index:int=0;
	
		//can't skip
		protected var _mandatory:Boolean = true;
	
		protected var _data:String;
		
		protected var _rightAnswer:String = "";
		
		protected var _userAnswer:String = "";
		
		protected var _isLast:Boolean = false;
	
		/**
		 * 
		 * @param	title
		 * @param	index
		 * @param	rightAnswers
		 * @param	mandatory
		 */
		
		public function QuestModel(title:String,vars:Object=null) 
		{
			_title = title;
			if (vars)
			{
				if(vars.index)
					_index = index;
					
				if(vars.mandatory)
					_mandatory = vars.mandatory;
					
				if (vars.rightAnswer)
					_rightAnswer =vars.rightAnswer;
			}
		}
		
		public function clearAnswer():void 
		{
			_userAnswer = "";
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
		
		public function get isRight():Boolean
		{
			powerTrace("标准结果" + _rightAnswer + "用户答案" + _userAnswer);
			return _rightAnswer==_userAnswer;
		}
		
		public function get index():int 
		{
			return _index;
		}
		
		public function set isLast(value:Boolean):void 
		{
			_isLast = value;
		}

		
		public function get data():String 
		{
			return _data;
		}
		
		public function set data(value:String):void 
		{
			_data = value;
		}
		
		public function get userAnswer():String 
		{
			return _userAnswer;
		}
		
		public function set userAnswer(value:String):void 
		{
			_userAnswer = value;
		}
		
	}

}