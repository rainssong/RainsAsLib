package mvc.model 
{

	import mvc.model.VO.QuestModel;
	import utils.PublicData;
	/**
	 * ...
	 * @author rainsong
	 */
	public class XmlQuestManager 
	{
		private var xmlData:XML;
		private var _numQuests:int;
		private var _currentIndex:int; //顺序值0~n-1
		private const _isRandom:Boolean = true;
		private var randomOrderArr:Array;
		
		public function XmlQuestManager(xml:XML) 
		{
			xmlData = xml;
			//_numQuests = xmlData.quest.length();
			
			var nullQuestIndexArr:Array=AnswerProxy.getAnswerArray(PublicData.centerChapter, AnswerProxy.NULL);
			var wrongQuestIndexArr:Array=AnswerProxy.getAnswerArray(PublicData.centerChapter, AnswerProxy.WRONG);
			//var allQuestIndexArr:Array=AnswerProxy.getAnswerArray(PublicData.centerChapter, "*");
			var rightQuestIndexArr:Array=AnswerProxy.getAnswerArray(PublicData.centerChapter, AnswerProxy.RIGHT);
			var tempArr:Array;
			if (nullQuestIndexArr.length > 0)
			{
				_numQuests = nullQuestIndexArr.length;
				tempArr = nullQuestIndexArr;
			}
			else if (wrongQuestIndexArr.length > 0)
			{
				_numQuests = wrongQuestIndexArr.length;
				tempArr = wrongQuestIndexArr;
			}
			else
			{
				_numQuests = rightQuestIndexArr.length;
				tempArr = rightQuestIndexArr;
			}
			_currentIndex = -1;
			
			
			randomOrderArr = [];
			if (_isRandom)
			{
				while (tempArr.length > 0)
				{
					var r:int = Math.floor(Math.random() * tempArr.length);
					randomOrderArr.push(tempArr[r].QuestIndex);
					tempArr.splice(r, 1);
				}
				
			}
			
			trace(this + "随机完毕");
		}
		
		public function getQuest(index:int = 0):QuestModel
		{
			if (!xmlData.quest[index]) return null;
			var title:String = xmlData.quest[index].title;
			var options:Vector.<String> = new Vector.<String>;
			for (var i:int = 0; i < xmlData.quest[index].option.length(); i++ )
			{
				options.push(xmlData.quest[index].option[i].toString())
			}
			var minChoose:int = xmlData.quest[index].@minChoose?xmlData.quest[index].@minChoose:1;
			var maxChoose:int = xmlData.quest[index].@maxChoose?xmlData.quest[index].@maxChoose:1;
			var randomOrder:Boolean=xmlData.quest[index].@random=="true"?true:false;
			var isLast:Boolean = index == _numQuests - 1;
			var rightAnswer:String = xmlData.quest[index].@key.toString();
			
			var questModel:QuestModel = new QuestModel(_currentIndex,index,title,rightAnswer, options,isLast, minChoose, maxChoose,randomOrder);
			return questModel;
		}
		
		public function hasNext():Boolean
		{
			return _currentIndex < _numQuests-1;
		}
		
		public function getNextQuest():QuestModel
		{
			if (hasNext())
			{
				_currentIndex++;
				return getQuest(randomOrderArr[_currentIndex]);
			}
			return null;
		}
		
		public function get numQuests():int 
		{
			return _numQuests;
		}
		
		public function get currentIndex():int 
		{
			return _currentIndex;
		}
		
		public function set currentIndex(value:int):void 
		{
			_currentIndex = value;
		}
		
		
	}

}