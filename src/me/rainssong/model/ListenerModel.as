package me.rainssong.model 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import me.rainssong.rainMVC.model.Model;
	
	
	/**
	 * @date 2015/11/28 5:47
	 * @author rainssong
	 * @blog http://blog.sina.com.cn/rainssong
	 * @homepage http://rainsgameworld.sinaapp.com
	 * @weibo http://www.weibo.com/rainssong
	 */
	public class ListenerModel extends Model 
	{
		public var type:String;
		public var listener:Function;
		public var useCapture:Boolean;
		public var priority:int;
		public var useWeakReference:Boolean;
		public function ListenerModel(type:String, listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false) 
		{
			this.type = type;
			this.listener = listener;
			this.useCapture = useCapture;
			this.priority = priority;
			this.useWeakReference = useWeakReference;
		}
		
	}

}