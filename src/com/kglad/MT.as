package com.kglad{

	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.utils.getTimer;
	import flash.system.System;
	import flash.utils.Dictionary;
	
	//  adapted from  @author Damian Connolly
	//  http://divillysausages.com/blog/tracking_memory_leaks_in_as3

	public class MT {
		// Used to calculate the real frame rate
		private static var startTime:int=getTimer();
		// Used to generate trace output intermittantly
		private static var traceN:int=0;
		// Megabyte constant to convert from bytes to megabytes.
		private static const mb:int=1024*1024;
		private static var mc:MovieClip;
		// d is used to store weak references to objects that you want to track
		private static var d:Dictionary = new Dictionary(true);
		// Used to trigger a report on the tracked objects
		private static var reportBool:Boolean;
		// Used to (help) ensure gc takes place
		private static var gcN:int;
		// This is the variable that will store the reportFrequency value that you pass.
		private static var freq:int;

		public function MT() {
		}
		// traceF() is the listener function for an Enter.ENTER_FRAME event.  If the game is running at its maximum frame rate (=stage.frameRate), traceF() will be called stage.frameRate times per second.
		private static function traceF(e:Event):void {
			traceN++;
			// This conditional ensures trace output occurs no more frequently than every freq seconds
			if (traceN%(freq*mc.stage.frameRate)==0) {
				// This is used to (try and) force gc. 
				gcN = 0;
				forceGC();
				trace("FPS:",int(traceN*1000/(getTimer()-startTime)),"||","Memory Use:",int(100*System.totalMemory/mb)/100," MB");
				traceN=0;
				startTime=getTimer();
			}
		}
		// Called just prior to the trace() and called just prior to a memory report.  When called just prior to a memory report, reportBool is assigned true.
		private static function forceGC():void {
			// The first call to System.gc() marks items that are available for gc.  The second should sweep them and the third is for good luck because you can't count on anything being 
			// predictably gc'd.
			mc.addEventListener(Event.ENTER_FRAME,gcF,false,0,true);
			gcN = 0;
		}
		private static function gcF(e:Event):void {
			System.gc();
			gcN++;
			// 3 System.gc() statements is enough.
			if (gcN>2) {
				mc.removeEventListener(Event.ENTER_FRAME,gcF,false);
				// Here's where reportBool being true triggers the memory report.
				if(reportBool){
					reportBool = false;
					reportF();
				}
			}
		}
		// Memory report
		private static function reportF():void{
			trace("** MEMORY REPORT AT:",int(getTimer()/1000));
			for(var obj:* in d){
				trace(obj,"exists",d[obj]);
			}
		}
		public static function init(_mc:MovieClip,_freq:int=0) {
			mc=_mc;
			freq=_freq;
			// If you pass 0, there will be no trace output.
			if(freq>0){
				mc.addEventListener(Event.ENTER_FRAME,traceF,false,0,true);
			}
		}
		// This the function you use to pass objects to be tracked.
		public static function track(obj:*,detail:*=null):void{
			d[obj] = detail;
		}
		// This is the function used to trigger a memory report.
		public static function report():void{
			reportBool = true;
			forceGC();
		}
	}
}