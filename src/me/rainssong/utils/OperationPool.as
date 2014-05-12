package me.rainssong.utils 
{
	import flash.utils.Dictionary;
	/**
	 * ...
	 * @author Rainssong
	 * @timeStamp 2014/5/9 12:51
	 * @blog http://blog.sina.com.cn/rainssong
	 */
	public class OperationPool 
	{
		public var operationQueue:Array = [];
		public function OperationPool() 
		{
			
		}
		
		public function addOperation(method:Function,params:Array=null):void
		{
			operationQueue.push([method, params]);
		}
		
		public function runOperation():void
		{
			if (operationQueue[0] != null) {
				var args:Array = operationQueue.shift() as Array;
				args[0].apply(args[1]);
			}
		}
		
		public function runOperation():void
		{
			if (operationQueue.length && operationQueue[0] != null ) {
				var args:Array = operationQueue.shift() as Array;
				args[0].apply(args[1]);
			}
		}
		
		public function runAllOperation():void {
			while (operationQueue.length)
				runOperation();
		}
	}

}