/**
 *@Author:
 *	General_Clarke
 *@Date:
 *	since 2011-8-22
 *	lastUpdate:2011-9-24
 *@Version:
 *	v1.0 release
 *@Description:
 *	利用这个类可以将一个for循环分担到多帧上，
 *  用于即时观看for循环运行百分比，以及避免丢帧，避免15秒运算超时等。  
 *  本类末尾附有调用示例
 *@Interface:
 *   run(workspace:* = null):Boolean
 *   destroy():void
 */

package me.rainssong.utils
{
	import flash.display.Sprite;
	import flash.events.Event;
	public class RepeaterOverTimeLine
	{
		protected var repeatRecall:Function;
		protected var rpf:int;
		protected var frameRecall:Function;
		protected var finalRecall:Function;
		protected var iInit:int;
		protected var iJudge:Function;
		protected var iOper:Function;
		
		protected var i:int;
		protected var f:int;
		protected var listener:Sprite = new Sprite;
		
		protected var workspace:Object;
		/**
		*构造一个RepeaterOverTimeLine对象。这个对象在调用run方法前不会有任何作用。
		*@param
		*  iInit:for循环中初始值
		*  iJudge_i$b:for循环中的条件判断。这是一个回调函数，有1个int型参数，Boolean型返回。其参数表示i，返回值表示判断是否成功。
		*  iOper_i$i:for循环中的下一个。这是一个回调函数，有1个int型参数，int型返回。其参数表示i，返回值表示变化后的i。
		*  repeatsPerFrame:每帧重复次数
		*  repeatRecall_i_o:被重复的函数。这是一个回调函数，参数1是int型表被回调次数，参数2是object型是本类run方法传递的参数。无返回值。
		*  frameRecall_i_o:每经过一帧后调用一次。这是一个回调函数，参数1是int型表被经过帧数，参数2是object型是本类run方法传递的参数。无返回值。晚于repeatRecall_i_o被调用
		*  finalRecall_i_o:iJudge返回false时调用。这是一个回调函数，参数是object型是本类run方法传递的参数。无返回值。
		*/
		public function RepeaterOverTimeLine(iInit:int,iJudge_i$b:Function,iOper_i$i:Function,repeatsPerFrame:int,repeatRecall_i_o:Function,frameRecall_i_o:Function = null,finalRecall_o:Function = null)
		{			
			this.workspace = null;
			this.iInit = iInit;
			this.iJudge = iJudge_i$b;
			this.iOper = iOper_i$i;
			this.repeatRecall = repeatRecall_i_o;
			this.rpf = repeatsPerFrame;
			this.frameRecall = frameRecall_i_o;
			this.finalRecall = finalRecall_o;
		}
		/**
		*运行这个对象中存储的程序
		*@param
		*  workspace:这个参数将被传递给各种回调函数。可以将其设置成Object或Array来传递多个参数
		*/
		public function run(workspace:* = null):Boolean{
			if(workspace){
				this.workspace = workspace;
			}
			i = iInit;
			f = 0;
			var r:int = 0;
			var flag:Boolean = true;
			while(iJudge(i)){
				repeatRecall(i,workspace);
				i = iOper(i);
				r++;
				if(r>=rpf){
					flag = false;
					break;
				}
			}
			if(frameRecall!=null){
				frameRecall(f,workspace);
			}
			f++;
			if(flag){
				finish();
				return false;
			}else{
				listener.addEventListener(Event.ENTER_FRAME,OEF);
				return true;
			}
		}
		/**
		*销毁这个对象的全部回调函数引用，避免因此导致其它类对象释放不掉		
		*/
		public function destroy():void{
			this.workspace = null;
			this.iJudge = null;
			this.iOper =null;
			this.repeatRecall =null;
			this.frameRecall =null;
			this.finalRecall =null;
			listener.removeEventListener(Event.ENTER_FRAME,OEF);			
		}
		protected function OEF(e:Event):void{
			var r:int = 0;
			var flag:Boolean = true;
			while(iJudge(i)){
				repeatRecall(i,workspace);
				i = iOper(i);
				r++;
				if(r>=rpf){
					flag = false;
					break;
				}
			}
			if(frameRecall!=null){
				frameRecall(f,workspace);
			}
			f++;
			if(flag){
				finish();
			}
		}
		protected function finish():void{
			if(finalRecall!=null){
				finalRecall(workspace);
			}
			listener.removeEventListener(Event.ENTER_FRAME,OEF);			
		}
		
	}
}


/**
调用示例
function iJudge(i:int):Boolean{
	return i<10;
}
function iOper(i:int):int{
	return i+1;
}
function repeatRecall(i:int,workspace:Object):void{
	trace("repeatRecall",i);
	workspace.num+=100;
}
function frameRecall(frame:int,workspace:Object):void{
	trace("frameRecall",frame);
}
function finalRecall(workspace:Object):void{
	trace("finallRecall",workspace.num);
}
var rep:RepeaterOverTimeLine = new RepeaterOverTimeLine(0,iJudge,iOper,3,repeatRecall,frameRecall,finalRecall);
rep.run({num:0});
该程序将num+=100分担
每帧执行3次，共执行10次
最后输出执行之后的num值。
*/