package me.rainui.data 
{
	import me.rainssong.math.ArrayCore;
	
	/**
	 * @date 2019-01-24 0:34
	 * @author Rainssong
	 * @blog http://blog.sina.com.cn/rainssong
	 * @homepage http://rainsgameworld.sinaapp.com
	 * @weibo http://www.weibo.com/rainssong
	 */
	public class FunctionStack 
	{
		private var _funVector:Vector.<Function> = new Vector.<Function>();
		private var _paramsVector:Vector.<Array> = new Vector.<Array>();
		
		public function FunctionStack() 
		{
			
		}
		
		public function regFun( fun:Function,params:Array=null):void
		{
			_funVector.push(fun);
			_paramsVector.push(params);
		}
		
		public function unregFun(fun:Function =null,params:Array=null):void
		{
			
			if(fun==null)
				if (_funVector.length > 0)
				{
					_funVector.pop();
					_paramsVector.pop();
				}
			if(fun!=null)
				for (var i:int = _funVector.length-1; i >=0	; i--) 
				{
					if (_funVector[i] == fun && ArrayCore.equals(_paramsVector[i],params))
					{
						_funVector.splice(i, 1);
						_paramsVector.splice(i, 1);
						break;
					}
				}
		}
		
		public function runLast():void
		{
			_funVector[_funVector.length-1].apply(null, _paramsVector[_funVector.length-1]);
		}
		
		public function runLastAndUnreg():void
		{
			runLast();
			unregFun();
		}
		
	}

}