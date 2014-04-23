package
{
	import flash.display.DisplayObjectContainer;
	import flash.display.Shape;
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.filters.GlowFilter;
	import flash.system.System;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	
	/**
	 * @author: flashk
	 * @version: 0.9
	 * 
	 * 此静态类辅助ActionScript在脱离FB,CS的情况下（在线）调试输出或记录信息。也可用于FB环境下。
	 * 调试器会在SWF的顶层创建一个html格式的文本和在Firefox的firebug和Chrome的控制台下输出信息。
	 * 
	 * 默认情况下firebug和Chrome的输出为关闭，要启用这些输出，请使用Debug.browserConsoleIsOn = true或者打开调试界面点击按钮切换输出打开/关闭
	 * 
	 * 要使用更高级的浏览器控制台输出，请访问debug.DebugExternal类的方法
	 * 
	 * 使用此类的 
			Debug.changeTopTextState("show");
			Debug.updateTopText("ping:30ms");
			 方法还可以帮助你在顶部一直显示某个需要刷新的信息,默认此文本有200*54的宽高，使用Debug.changeTopTextState("style")来修改样式;
	 */ 
	
	public class Debug
	{
		//最大显示信息条数，当信息量超过最大条数时只显示最后指定条数的文字，此时可以点击控制台上的复制全部按钮并将剪切板中的内容另存为.html文件查看
		public static var maxLine:uint = 100;
		//Deubg文字框的宽度
		public static var width:int=370;
		//文本背景的透明度
		public static var textBGFullAlpha:Number = 0.95;
		public static var textBGHalfAlpha:Number = 0.6;
		//默认是否打开Firefox的Firebug和Chrome的控制台输出
		public static var browserConsoleIsOn:Boolean=false;
		//背景颜色
		public static var bgColor:uint = 0x0;
		//默认文本颜色
		public  static var txtColor:uint = 0xC0C0C0;
		//其它颜色，可以用在Debug.traceColor参数中
		public static var color1:uint = 0xFF9999;
		public static var color2:uint = 0x99CC99;
		public static var color3:uint = 0x009999;
		public static var isIDE:Boolean=false;
		
		private static var stage:Stage;
		private static var info_txt:TextField;
		private static var box:DisplayObjectContainer;
		private static var infoStr:String="";
		private static var bg:Shape;
		private static var tools:Sprite;
		private static var btnAble:Sprite;
		private static var btnAlpha:Sprite;
		private static var btnColor:Sprite;
		private static var btnCopy:Sprite;
		private static var btnCopyAll:Sprite;
		private static var btnCopyError:Sprite;
		private static var btnClose:Sprite;
		private static var btnLock:Sprite;
		private static var btnFireBug:Sprite;
		private static var txtAble:Boolean = true;
		private static var logStr:String="";
		private static var operateStr:String;
		private static var errorStr:String="";
		private static var opeCount:int=0;
		private static var isLockScroll:Boolean = false;
		private static var topTxt:TextField;
		private static var isTopTxtSetStyle:Boolean = false;
		private static var topTxtSet:Object={};
		private static var topTxtData:Array = [];
		private static var allMsg:Array = [];
		private static var lastTopTxtStr:String="";
		private static var alphaNum:Number;
		
		public function Debug()
		{
		
		}
		/**
		 *  初始化Debug 
		 * @param showDisplay 要将Debug显示加入到显示列表的容器
		 * @param stage 舞台对象，用来监听键盘事件，如果为空则使用showDisplay的stage属性，如果showDisplay.stage继续为空，则监听showDisplay的键盘事件
		 * 
		 */
		public static function init(showDisplay:DisplayObjectContainer,stage:Stage=null):void{
			Debug.stage = stage;
			if(stage == null)
			{
				Debug.stage = showDisplay.stage;
			}
			box = showDisplay;
			alphaNum = textBGFullAlpha;
			topTxt = new TextField();
			topTxt.multiline = true;
			topTxt.wordWrap = true;
			info_txt = new TextField();
			info_txt.x = 2;
			info_txt.y = 30;
			info_txt.width = width;
			info_txt.multiline = true;
			info_txt.wordWrap=true;
			info_txt.defaultTextFormat = new TextFormat("Verdana,Arial,宋体",12,txtColor);
			bg = new Shape();
			tools = new Sprite();
			tools.x = 2;
			tools.y = 5;
			btnAble = creatBtn("可点");
			btnAble.addEventListener(MouseEvent.CLICK,switchTxtAble);
			tools.addChild(btnAble);
			btnAlpha = creatBtn("透明");
			btnAlpha.addEventListener(MouseEvent.CLICK,switchAlpha);
			tools.addChild(btnAlpha);
			btnColor = creatBtn("白");
			btnColor.addEventListener(MouseEvent.CLICK,switchColor);
			tools.addChild(btnColor);
			btnCopyAll = creatBtn("复制全部");
			tools.addChild(btnCopyAll);
			btnCopyAll.addEventListener(MouseEvent.CLICK,onbtnCopyAll);
			btnCopy = creatBtn("日志");
			tools.addChild(btnCopy);
			btnCopy.addEventListener(MouseEvent.CLICK,onbtnCopy);
			btnCopyError = creatBtn("错误");
			tools.addChild(btnCopyError);
			btnCopyError.addEventListener(MouseEvent.CLICK,onbtnCopyError);
			btnFireBug = creatBtn("Firebug开");
			tools.addChild(btnFireBug);
			browserConsoleIsOn = !browserConsoleIsOn;
			onbtnFireBug();
			btnFireBug.addEventListener(MouseEvent.CLICK,onbtnFireBug);
			//♧♡♂♀♠♣♥❤☜☞☎☏⊙◎ ☺☻☼▧▨♨◐◑↔↕▪ ▒ ◊◦▣▤▥ ▦▩◘ ◈◇♬♪♩♭♪の★☆→
			btnLock = creatBtn("▦ "); 
			tools.addChild(btnLock);
			btnLock.addEventListener(MouseEvent.CLICK,switchScrollLock);
			btnClose = creatBtn("×");
			tools.addChild(btnClose);
			btnClose.addEventListener(MouseEvent.CLICK,switchVisible);
			var nowWidth:int=0;
			for(var i:int=0;i<tools.numChildren;i++)
			{
				tools.getChildAt(i).x = nowWidth;
				nowWidth += tools.getChildAt(i).width-2;
			}
			if(Debug.stage != null)
			{
				Debug.stage.addEventListener(KeyboardEvent.KEY_UP,checkKey);
			}else
			{
				showDisplay.addEventListener(KeyboardEvent.KEY_UP,checkKey);
			}
			if(showDisplay.loaderInfo.url.indexOf("http") == -1)
			{
				isIDE = true;
			}
		}
		
		public static function get operateInfo():String{
			return operateStr;
		}
		
		public static function get logInfo():String{
			return logStr;
		}
		
		public static function get errorInfo():String
		{
			return errorStr;
		}
		
		/**
		 * 
		 * @param htmlText 要更新的文本
		 * @param index 索引行，每个索引行为新的一行
		 * @param color 要使用的文本颜色
		 * 
		 */
		public static function updateTopText(htmlText:String,index:uint = 0,color:uint=0xF000000):void
		{
			if(color != 0xF000000)
			{
				htmlText = '<font color="#'+color.toString(16)+'">'+htmlText+'</font>';
			}
			topTxtData[index] = htmlText;
		}
		
		private static function checkUpdateToText(event:Event=null):void
		{
			if(topTxt.parent == null) return;
			var str:String = topTxtData.join("<br>");
			if(lastTopTxtStr != str)
			{
				lastTopTxtStr =str ;
				topTxt.htmlText = lastTopTxtStr ;
			}
		}
		
		/**
		 * 
		 * @param state "style"修改样式 "show"显示 "hide"隐藏
		 * @param align R 右上角对齐 RB 右下角对齐 LB 左下角对齐
		 * @param textFormat
		 * @param spaceX
		 * @param spaceY
		 * @param textWidth
		 * @param textHeight
		 * @return 
		 * 
		 */
		public static function changeTopTextState(state:String = "show",textColor:uint=0x666666,align:String="R",textFormat:TextFormat=null,spaceX:Number = 10,spaceY:Number = 10,textWidth:uint=200,textHeight:uint =54):TextField
		{
			if(state == "show")
			{
				if(Debug.stage != null)
				{
					Debug.stage.addChild(topTxt);
					Debug.stage.addEventListener(Event.RESIZE,reAlginTopText);
					Debug.stage.addEventListener(Event.ENTER_FRAME,checkUpdateToText);
				}
				if(isTopTxtSetStyle == false)
				{
					changeTopTextState("style");
				}
				reAlginTopText();
			}else if(state == "hide")
			{
				if(topTxt.parent != null)
				{
					topTxt.parent.removeChild(topTxt);
					if(Debug.stage != null)
					{
						Debug.stage.removeEventListener(Event.RESIZE,reAlginTopText);
						Debug.stage.removeEventListener(Event.ENTER_FRAME,checkUpdateToText);
					}
				}
			}else	if(state == "style")
			{
				isTopTxtSetStyle = true;
				topTxt.width = textWidth;
				topTxt.height = textHeight;
				topTxtSet.spaceX = spaceX;
				topTxtSet.spaceY = spaceY;
				topTxtSet.align = align;
				if(textFormat == null)
				{
					textFormat = new TextFormat();
					textFormat.color = textColor;
					textFormat.size = 12;
					textFormat.font ="Verdana";
					if(align == "R" || align =="RB")
					{
						textFormat.align =TextFormatAlign.RIGHT;
					}
				}
				topTxt.defaultTextFormat = textFormat;
			}
			topTxt.selectable = false;
			topTxt.mouseEnabled = false;
			return topTxt;
		}
		
		public static function trace2(...args):void{
			var str:String = getString(args);
			infoStr +=str +"<br/>";
			if(info_txt == null) return;
			allMsg.push(str);
			if(info_txt.parent != null){
				if(allMsg.length>maxLine)
				{
					info_txt.htmlText = allMsg.slice(allMsg.length-maxLine).join("<br/>");
				}else
				{
					info_txt.htmlText = infoStr;
				}
				if(isLockScroll == false)
				{
					info_txt.scrollV = info_txt.maxScrollV;
				}
			}
		}
		
		/**
		 * 输出调试信息
		 */ 
		public static function trace(...args):void{
			trace2.apply(null,args);
			
			checkTraceToConsole(getString(args));
		}
		
		public static function traceColor(color:uint,...args):void{
			trace2('<font color="#'+color.toString(16)+'">'+getString(args)+'</font>');
			checkTraceToConsole(getString(args));
		}
		
		public static function error(...args):void
		{
			errorStr += getString(args)+"\n";
			trace2('<font color="#CC0000">'+getString(args)+'</font>');
			checkTraceToConsole("**Error**:"+getString(args));
		}
		
		public static function log(...args):void
		{
			logStr += getString(args)+"\n";
			trace2('<font color="#00AA00">'+getString(args)+'</font>');
			checkTraceToConsole("**Log**:"+getString(args));
		}
		
		public static function recordUserOperate(...args):void
		{
			var str:String = "";
			var date:Date = new Date();
			opeCount++;
			str += date.hours+":"+date.minutes+":"+date.seconds+"."+date.milliseconds+" ";
			str += Debug.stage.mouseX+"/"+Debug.stage.mouseY+"/"+Debug.stage.stageWidth+"/"+Debug.stage.stageHeight+" ";
			operateStr += str+getString(args)+"\n";
			trace2('<font color="#0066FF">'+opeCount+": "+getString(args)+'</font>');
			checkTraceToConsole("**UserOperate**:"+opeCount+": "+str+getString(args));
		}
		
		public static function traceToConsole(...args):void
		{
			DebugExternal.traceToIDEConsole(getString(args));
			DebugExternal.traceToBrowserConsole(getString(args));
		}
		public static function clearFirebug():void
		{
			DebugExternal.clearBrowserConsole();
		}
		
		private static function checkTraceToConsole(...args):void
		{
			if(isIDE == true) DebugExternal.traceToIDEConsole(getString(args));
			if(browserConsoleIsOn == true) DebugExternal.traceToBrowserConsole(getString(args));
		}
		
		private static function getString(array:Array):String
		{
			var str:String = "";
			for(var i:int=0;i<array.length;i++)
			{
				str += String(array[i])+",";
			}
			return str.slice(0,-1);
		}
		
		private static function onbtnCopyError(event:MouseEvent):void
		{
			if(errorStr != ""){
				System.setClipboard(errorStr);
			}else
			{
				System.setClipboard("Error Empty");
			}
		}
		
		private static function switchScrollLock(event:MouseEvent):void
		{
			isLockScroll = !isLockScroll;
			if(isLockScroll)
			{
				TextField(btnLock.getChildByName("label")).text = "▨ ";
			}else
			{
				TextField(btnLock.getChildByName("label")).text = "▦";
			}
		}
		
		private static function onbtnFireBug(event:MouseEvent = null):void
		{
			browserConsoleIsOn = !browserConsoleIsOn;
			if(browserConsoleIsOn == true)
			{
				TextField(btnFireBug.getChildByName("label")).text = "Firebug关";
			}else
			{
				TextField(btnFireBug.getChildByName("label")).text = "Firebug开";
			}
		}
		
		private static function onbtnCopy(event:MouseEvent):void
		{
			if(logStr != "")
			{
				System.setClipboard(logStr);
			}else
			{
				System.setClipboard("LogEmpty");
			}
		}
		
		private static function onbtnCopyAll(event:MouseEvent):void
		{
			System.setClipboard(allMsg.join("<br/>"));
		}

		private static function switchTxtAble(event:MouseEvent):void
		{
			txtAble = !txtAble;
			info_txt.mouseEnabled = txtAble;
			TextField(btnAble.getChildByName("label")).text = txtAble ? "可点" : "可选";
		}
		
		private static function switchAlpha(event:MouseEvent):void
		{
			if(alphaNum >textBGHalfAlpha){
				alphaNum = textBGHalfAlpha;
				TextField(btnAlpha.getChildByName("label")).text = "不透";
			}else
			{
				TextField(btnAlpha.getChildByName("label")).text = "透明";
				alphaNum = textBGFullAlpha;
			}
			resetTxtSize();
		}
		
		private static function switchColor(event:MouseEvent):void
		{
			if(bgColor == 0x0){
				bgColor = 0xFFFFFF;
				txtColor = 0x0;
				TextField(btnColor.getChildByName("label")).text = "黑";
			}else
			{
				bgColor = 0x0;
				txtColor = 0xBBBBBB;
				TextField(btnColor.getChildByName("label")).text = "白";
			}
			info_txt.defaultTextFormat = new TextFormat("Verdana",12,txtColor);
			info_txt.htmlText = infoStr;
			resetTxtSize();
		}
		
		private static function creatBtn(label:String):Sprite
		{
			var sp:Sprite = new Sprite();
			var txt:TextField = new TextField();
			txt.x = 5;
			txt.width = 200;
			txt.height = 20;
			txt.htmlText = label;
			txt.width = txt.textWidth+13;
			txt.name = "label";
			txt.mouseEnabled = false;
			//var sh:Shape = new Shape();
			sp.graphics.lineStyle(1,0x003C74);
			sp.graphics.beginFill(0xE0E0EB,1);
			sp.graphics.drawRect(0,0,txt.width,txt.height);
			sp.graphics.lineStyle(0,0x333333,0);
			sp.graphics.beginFill(0xFAFAF9,1);
			sp.graphics.drawRect(1,1,txt.width-1,int(txt.height/2)-1);
			//sp.addChild(sh);
			sp.addChild(txt);
			sp.addEventListener(MouseEvent.MOUSE_OVER,onMouseOver);
			sp.addEventListener(MouseEvent.MOUSE_OUT,onMouseOvut);
			return sp;
		}
		
		private static function onMouseOver(event:MouseEvent):void{
			Sprite(event.currentTarget).filters = [new GlowFilter(0xFAC150,1,3,3,2.6,2,true)];
			TextField(Sprite(event.currentTarget).getChildByName("label")).textColor = 0xBD4B00;
		}
		
		private static function onMouseOvut(event:MouseEvent):void{
			Sprite(event.currentTarget).filters = null;
			TextField(Sprite(event.currentTarget).getChildByName("label")).textColor = 0x0;
		}
		
		private static function checkKey(event:KeyboardEvent):void{
			if(event.ctrlKey == true && event.altKey == true){
				if(event.keyCode == 89){
					switchVisible();
				}
				if(event.keyCode == 85){
					if(topTxt.parent)
					{
						changeTopTextState("hide");
					}else
					{
						changeTopTextState("show");
					}
				}
			}
		}
		
		private static function switchVisible(event:Event=null):void
		{
			if(info_txt.parent == null){
				box.addChild(bg);
				box.addChild(info_txt);
				box.addChild(tools);
				if(allMsg.length>maxLine)
				{
					info_txt.htmlText = allMsg.slice(allMsg.length-maxLine).join("<br/>");
				}else
				{
					info_txt.htmlText = infoStr;
				}
				if(isLockScroll == false)
				{
					info_txt.scrollV = info_txt.maxScrollV;
				}
				box.stage.addEventListener(Event.RESIZE,resetTxtSize);
				resetTxtSize();
			}else{
				box.removeChild(bg);
				box.removeChild(info_txt);
				box.removeChild(tools);
				box.removeEventListener(Event.RESIZE,resetTxtSize);
			}
		}
		
		private static function reAlginTopText(event:Event=null):void
		{
			if(topTxtSet.align == "R")
			{
				topTxt.x = Debug.stage.stageWidth - topTxtSet.spaceX - topTxt.width;
			}
			if(topTxtSet.align == "RB")
			{
				topTxt.x = Debug.stage.stageWidth - topTxtSet.spaceX - topTxt.width;
				topTxt.y = Debug.stage.stageHeight - topTxtSet.spaceY - topTxt.height;
			}
			if(topTxtSet.align == "LB")
			{
				topTxt.y = Debug.stage.stageHeight - topTxtSet.spaceY - topTxt.height;
			}
		}
		
		private static function resetTxtSize(event:Event=null):void
		{
			info_txt.height = box.stage.stageHeight-30;
			bg.graphics.clear();
			bg.graphics.beginFill(bgColor,alphaNum);
			bg.graphics.drawRect(0,0,info_txt.width+2,box.stage.stageHeight);
		}
		
	}
}