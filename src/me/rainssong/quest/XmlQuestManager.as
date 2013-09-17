package me.rainssong.quest 
{

	import flash.display.DisplayObject;
	import me.rainssong.math.*;
	import me.rainssong.quest.VO.OptionQuestModel;
	import me.rainssong.quest.VO.QuestModel;
	
	/**
	 * ...
	 * @author rainsong
	 */
	public class XmlQuestManager 
	{
		private var _xml:XML;
		private var _numQuests:int;
		private var _questArr:Vector.<QuestModel>
		private const _isRandom:Boolean = true;
		private var _randomOrderArr:Array;
		
		public function XmlQuestManager(xml:XML) 
		{
			_xml = xml;
			_questArr = new Vector.<QuestModel>();
			
			//_numQuests = xmlData.quest.length();
			
			createQuests();
			//_randomOrderArr = MathCore.getRandomizedArray((MathCore.getIntVector(0, _questArr.length - 1))) as Vector.<int>;
			_randomOrderArr= ArrayCore.getRandomizedArray(ArrayCore.getIntArray(0, _questArr.length - 1));
		}
		
		protected function createQuests():void 
		{
			for (var i:int = 0; i < _xml.quest.length(); i++ )
			{
				_questArr.push(createQuest(i));
			}
		}
		
		//todo:自动排错——答案排序，大小写等
		protected  function createQuest(index:int):QuestModel 
		{
			if (!_xml.quest[index]) return null;
			var title:String = _xml.quest[index].title;
			var options:Vector.<String> = new Vector.<String>;
			var pics:Vector.<String> = new Vector.<String>;
			for (var i:int = 0; i < _xml.quest[index].option.length(); i++ )
			{
				options.push(_xml.quest[index].option[i].toString())
			}
			for (var ii:int = 0; ii < _xml.quest[index].pic.length(); ii++ )
			{
				pics.push(_xml.quest[index].pic[ii].toString())
			}
			
			var minChoose:int = _xml.quest[index].@minChoose?_xml.quest[index].@minChoose:1;
			var maxChoose:int = _xml.quest[index].@maxChoose?_xml.quest[index].@maxChoose:1;
			var randomOrder:Boolean=_xml.quest[index].@random=="true"?true:false;
			var rightAnswer:String = _xml.quest[index].@key.toString();
			var questModel:OptionQuestModel = new OptionQuestModel(title, index, rightAnswer);
			questModel.options = options;
			questModel.minChoose = minChoose
			questModel.maxChoose=maxChoose
			questModel.isLast = (index == _xml.quest.length() - 1);
			questModel.pics = pics;
			return questModel;
		}
		
		public function getQuest(index:int):QuestModel
		{
			return _questArr[index];
		}
		
		public function getRandomizedQuest(index:int):QuestModel
		{
			return _questArr[_randomOrderArr[index]];
		}
		
		public function get questArr():Vector.<QuestModel> 
		{
			return _questArr;
		}
		
		//public function hasNext():Boolean
		//{
			//return false;
		//}
		
		//public function get numQuests():int 
		//{
			//return _numQuests;
		//}
		
		//public function get currentIndex():int 
		//{
			//return _currentIndex;
		//}
		//
		//public function set currentIndex(value:int):void 
		//{
			//_currentIndex = value;
		//}
		
		
	}

}