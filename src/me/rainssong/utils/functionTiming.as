package  me.rainssong.utils
{
	import flash.utils.getTimer;
	/**
	 * ...
	 * @author Rainssong
	 */
	 
	/**
	 * 
	 * @param	fun 被测函数
	 * @param	forTime 重复次数
	 * @param	params 函数参数
	 * @param	thisArg 函数指向的对象
	 * @return  总用时(ms)
	 */
	public function functionTiming(fun:Function,forTime:int=1,params:Array=null,thisArg:*=null):int
	{
		var time:int = getTimer();
		while(forTime)
		{
			fun.apply(thisArg,params);
			forTime--;
		}
		return getTimer() - time;
	}
}