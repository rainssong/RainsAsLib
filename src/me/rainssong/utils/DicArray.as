package me.rainssong.utils 
{
	import adobe.utils.CustomActions;
	import flash.utils.Dictionary;
	
	/**
	 * @date 2015/5/17 7:34
	 * @author rainssong
	 * @blog http://blog.sina.com.cn/rainssong
	 * @homepage http://rainsgameworld.sinaapp.com
	 * @weibo http://www.weibo.com/rainssong
	 */
	public class DicArray 
	{
		private var _array:Array;
		//private var _dictionary:Dictionary
		private var _dic:RevDictionary
		public function DicArray() 
		{
			//_dictionary = new Dictionary();
			_array = [];
			_dic=new RevDictionary()
		}
		
		/* DELEGATE globalClassifier.Array */
		
		//public function every(callback:Function, thisObject:any = null):Boolean 
		//{
			//return _array.every(callback, thisObject);
		//}
		
		public function pop():* 
		{
			_dic.deleteValue(_array[_array.length-1]);
			return _array.pop();
		}
		
		public function push(id:String,value:*):void 
		{
			_array.push(value);
			_dic.setValue(id, value);
		}
		
		public function addAt(id:String,i:int,value:*):void 
		{
			_array.splice(i,1,value);
			_dic.setValue(id, value);
		}
		
		public function deleteByIndex(i:int):* 
		{
			_dic.deleteValue(_array[i]);
			return _array.splice(i, 1);
		}
		
		public function deleteById(id:String):* 
		{
			var data:Object = _dic.getValue(id);
			_dic.deleteKey(id);
			return _array.splice(_array.indexOf(data), 1);
		}
		
		public function getByIndex(index:int):*
		{
			return _array[index];
		}
		
		public function getById(id:String):*
		{
			return _dic.getValue(id);
		}
		
		public function get length():int
		{
			return _array.length;
		}

		
	}

}