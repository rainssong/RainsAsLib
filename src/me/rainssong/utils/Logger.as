package me.rainssong.utils
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.utils.getQualifiedClassName;
 
	/**
	 * 一个简单的日志记录工具类
	 * 使用方式：
	 * <pre>
	 * var logger:Logger = Logger.getInstance(MyClass);
	 * logger.info("hello");
	 * logger.error("失败:{0},{1}",event.code,event.message);
	 * </pre>
	 * @author shaorui
	 * 
	 */	
	public class Logger
	{
		/**系统启动后所有的日志记录*/
		public static var logRecords:String = "";
 
		/**当日志改变，派发事件*/
		public static var dispatcher:EventDispatcher = new EventDispatcher();
 
		/**获取日志实例*/
		public static function getInstance(clazz:Class):Logger
		{
			var cname:String = getQualifiedClassName(clazz);
			if(cname.indexOf("::") != -1)
				cname = cname.split("::")[1];
			var logger:Logger = new Logger();
			logger.cname = cname;
			return logger;
		}
 
		/**信息分隔符*/
		public var fieldSeparator:String = ":";
		/**是否在输出中包含日期*/
		public var includeDate:Boolean = true;
		/**是否在输出中包含类定义信息*/
		public var includeCategory:Boolean = true;
		/**是否在输出中包含信息类别*/
		public var includeLevel:Boolean = true;
		/**类名称*/
		public var cname:String;
 
		/**@private*/
		public function Logger()
		{
		}
 
		/**信息*/
		public function info(msg:String,...args):void
		{
			internalLog("INFO",msg,args);
		}
 
		/**调试*/
		public function debug(msg:String,...args):void
		{
			internalLog("DEBUG",msg,args);
		}
 
		/**错误*/
		public function error(msg:String,...args):void
		{
			internalLog("ERROR",msg,args);
		}
 
		/**输出日志*/
		private function internalLog(level:String,message:String,params:Array):void
		{
			var date:String = ""
			if (includeDate)
			{
				var d:Date = new Date();
				date = Number(d.getMonth() + 1).toString() + "/" + d.getDate().toString() + "/" + d.getFullYear() + fieldSeparator;  
				date += padTime(d.getHours()) + ":" +padTime(d.getMinutes()) + ":" +padTime(d.getSeconds());
			}
			if (includeLevel)
			{
				level = "[" + level +"]" + fieldSeparator;
			}
			else
			{
				level = "";
			}
			var category:String = includeCategory ?cname + fieldSeparator :"";
			if(params != null && params.length>0)
			{
				for (var i:int = 0; i < params.length; i++) 
				{
					message = message.replace("{"+i+"}",params[i]);
				}
			}
			var resultString:String = date + level + category + message;
			//TODO:先用trace输出
			trace(resultString);
			logRecords+="\n"+resultString;
			dispatcher.dispatchEvent(new Event("LogChanged"));
		}
 
		/**@private*/
		private function padTime(num:Number, millis:Boolean = false):String
		{
			if (millis)
			{
				if (num < 10)
					return "00" + num.toString();
				else if (num < 100)
					return "0" + num.toString();
				else 
					return num.toString();
			}
			else
			{
				return num > 9 ? num.toString() : "0" + num.toString();
			}
		}
 
	}
}