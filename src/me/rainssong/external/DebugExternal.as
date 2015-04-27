package me.rainssong.external
{
	import flash.external.ExternalInterface;
	import flash.system.Capabilities;
	import me.rainssong.manager.SystemManager;

	public class DebugExternal
	{
		public function DebugExternal()
		{
		}
		
		public static function traceToIDEConsole(...args):void
		{
			trace.apply(null,args);
		}
		
		public static function callJavaScript(functionName:String,...args):void
		{
			if(SystemManager.isStandAlonePlayer) return;
			ExternalInterface.call(functionName, args);
		}
		
		public static function alertMessage(...args):void
		{
			if(SystemManager.isStandAlonePlayer) return;
			ExternalInterface.call("alert", args);
		}
		
		/**
		 * 向Firefox的firebug和chrome控制台输出信息
		 */ 
		public static function traceToBrowserConsole(...args):void
		{
			if(SystemManager.isStandAlonePlayer) return;
			ExternalInterface.call('console.log', args);
		}
		
		public static function warnToBrowserConsole(...args):void
		{
			if(SystemManager.isStandAlonePlayer) return;
			ExternalInterface.call('console.warn', args);
		}
		
		/**
		 * DebugExternal.traceToFirebugAdvanced("warn","error:code16");
		 * 
		 * 
		 * console.log(object[, object, ...])
			 使用频率最高的一条语句：向控制台输出一条消息。支持 C 语言 printf 式的格式化输出。当然，也可以不使用格式化输出来达到同样的目的：

			console.debug(object[, object, ...])
			 向控制台输出一条信息，它包括一个指向该行代码位置的超链接。
			 
			console.info(object[, object, ...])
			 向控制台输出一条信息，该信息包含一个表示“信息”的图标，和指向该行代码位置的超链接。
			 
			console.warn(object[, object, ...])
			 同 info。区别是图标与样式不同。
			 
			console.error(object[, object, ...])
			 同 info。区别是图标与样式不同。error 实际上和 throw new Error() 产生的效果相同，使用该语句时会向浏览器抛出一个 js 异常。
			 
			console.assert(expression[, object, ...])
			 断言，测试一条表达式是否为真，不为真时将抛出异常（断言失败）。
			 
			console.dir(object)
			 输出一个对象的全部属性（输出结果类似于 DOM 面板中的样式）。
			 
			console.dirxml(node)
			 输出一个 HTML 或者 XML 元素的结构树，点击结构树上面的节点进入到 HTML 面板。
			 
			console.trace()
			 输出 Javascript 执行时的堆栈追踪。
			 
			console.group(object[, object, ...])
			 输出消息的同时打开一个嵌套块，用以缩进输出的内容。调用 console.groupEnd() 用以结束这个块的输出。
			 
			console.groupCollapsed()
			 同 console.group(); 区别在于嵌套块默认是收起的。

			console.time(name)
			 计时器，当调用 console.timeEnd(name);并传递相同的 name 为参数时，计时停止，并输出执行两条语句之间代码所消耗的时间（毫秒）。
			 
			console.profile([title])
			 与 profileEnd() 结合使用，用来做性能测试，与 console 面板上 profile 按钮的功能完全相同。
			 
			console.count([title])
			 输出该行代码被执行的次数，参数 title 将在输出时作为输出结果的前缀使用。
			 
			console.clear()
		 * 
		 * 
		 * @param command
		 * @param args
		 * 
		 */
		public static function traceToBrowserConsoleAdvanced(command:String,...args):void
		{
			if(SystemManager.isStandAlonePlayer) return;
			ExternalInterface.call('console.'+command, args);
		}
		
		public static function clearBrowserConsole():void
		{
			if(SystemManager.isStandAlonePlayer) return;
			ExternalInterface.call('console.clear');
		}
		
	}
}