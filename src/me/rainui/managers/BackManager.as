package me.rainui.managers 
{
	import adobe.utils.CustomActions;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import me.rainssong.utils.Draw;
	import me.rainssong.utils.ScaleMode;
	import me.rainui.RainUI;
	import me.rainui.components.Container;
	import me.rainui.components.DisplayResizer;
	import me.rainui.components.Page;
	import me.rainui.data.FunctionStack;
	
	/**
	 * @date 2015/9/19 2:52
	 * @author rainssong
	 * @blog http://blog.sina.com.cn/rainssong
	 * @homepage http://rainsgameworld.sinaapp.com
	 * @weibo http://www.weibo.com/rainssong
	 */
	public class BackManager 
	{
		static private var _funStack:FunctionStack = new FunctionStack();
		
		
		/* DELEGATE me.rainui.data.FunctionStack */
		
		static public function regFun(fun:Function,params:Array=null) :void
		{
			_funStack.regFun(fun,params);
		}
		
		static public function runLast() :void
		{
			_funStack.runLast();
		}
		
		static public function runLastAndUnreg() :void
		{
			_funStack.runLastAndUnreg();
		}
		
		static public function unregFun(fun:Function = null,params:Array=null) :void
		{
			_funStack.unregFun(fun,params);
		}
		
		
		
	}

}