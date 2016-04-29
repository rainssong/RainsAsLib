package me.rainssong.model 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
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
		public var target:IEventDispatcher
		public var type:String;
		public var listener:Function;
		public var useCapture:Boolean;
		public var priority:int;
		public var useWeakReference:Boolean;
		public function ListenerModel(target:IEventDispatcher,type:String, listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false) 
		{
			this.target = target;
			this.type = type;
			this.listener = listener;
			this.useCapture = useCapture;
			this.priority = priority;
			this.useWeakReference = useWeakReference;
		}
		
		public function add():void
		{
			if (target != null)
			target.addEventListener(type, listener, useCapture, priority, useWeakReference);
		}
		
		public function remove():void
		{
			if (target != null)
			target.removeEventListener(type, listener, useCapture);
		}
		
		
		
		
	}

}