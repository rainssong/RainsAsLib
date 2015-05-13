package me.rainssong.manager 
{
	
	/**
	 * 循环执行器接口
	 */
	public interface ILoopExecute extends IDestroy
	{
		/**
		 * 执行的动作
		 * 
		 * @param	currTime	调用时的当前毫秒时间
		 * @param	prevTime	上次调用的毫秒时间
		 */
		function loopExecute(currTime:int, prevTime:int):void;
		
		/**
		 * 是否要结束动作。当调用 loopExecute 时会先判断 这个属性是否为 true，如果是 true，会自动删除这个执行器。
		 * 调用 loopExecute 和 complete 的顺序类似于 while do
		 */
		function get complete():Boolean;
	}
	
}