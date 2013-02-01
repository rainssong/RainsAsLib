package me.rainssong.display 
{
	import flash.display.Bitmap;
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip
	import flash.events.Event;
	import me.rainssong.display.IView;
	
	/**
	 * ...
	 * @author Rainssong
	 */
	dynamic public class MyMovieClip extends MovieClip implements IView 
	{
		private var _autoDestroy:Boolean = true;
		public var autoDisable:Boolean = true;
		private var _listenerArr:Vector.<Array>;
		private var _isEnable:Boolean = true;
		
		
		public function MyMovieClip() 
		{
			super();
			_listenerArr = new Vector.<Array>;
			onRgister();
			
		}
		
		/* INTERFACE rainssong.display.IView */
		
		public function onRgister():void 
		{
			if(stage)
				onAdd()
			else
				addEventListener(Event.ADDED_TO_STAGE, onAdd);
			
		}
		
		protected function onAdd(e:Event=null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAdd);
			addEventListener(Event.REMOVED_FROM_STAGE, onRemove);
		}
		
		public function show():void 
		{
			this.visible = true;
			if(autoDisable)enable();
		}
		
		public function enable():void 
		{
			this.mouseChildren = this.mouseEnabled = true;
			_isEnable = true;
		}
		
		public function disable():void 
		{
			this.mouseChildren = this.mouseEnabled = false;
			_isEnable = false;
		}
		
		public function hide():void 
		{
			if(autoDisable)disable();
			this.visible = false;
		}
		
		private function onRemove(e:Event):void 
		{
			removeEventListener(Event.REMOVED_FROM_STAGE, onRemove);
			
			if(autoDestroy)destroy();
		}
		
		public function destroy():void 
		{
			deleteVars();
			removeListeners();
			removeChildren();
			
			if (!autoDestroy && parent) parent.removeChild(this);
		}
		
		override public function addEventListener(type:String, listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false):void 
		{
			_listenerArr.push([type, listener, useCapture]);
			super.addEventListener(type, listener, useCapture, priority, useWeakReference);
		}
		
		private function deleteVars():void
		{
			for (var v:String in this) {
				delete this[v];
			}
		}
		
		override public function removeChildren(beginIndex:int=0, endIndex:int=2147483647):void
		{
		
			var i:int = this.numChildren - 1;
		   if (i > endIndex) i = endIndex;
		   for (i; i >= beginIndex; i-- )
		   {
			  
			    var child:* = this.getChildAt(i);
				 if (child == null)
				 {
					 return;
				 }
				if (child is Bitmap && (child as Bitmap).bitmapData) child.bitmapData.dispose();
				if (child is flash.display.MovieClip ) child.stop();
				this.removeChild(child);
		   }
		   
		}
		
		private function removeListeners():void
		{
			var temp:Array;
			while (_listenerArr.length)
			{
				temp = _listenerArr.pop();
				removeEventListener(temp[0], temp[1], temp[2]);
			}
		}
		
		public function get isEnable():Boolean 
		{
			return _isEnable;
		}
		
		public function get autoDestroy():Boolean
		{
			return _autoDestroy; 
		}
		
		public function set autoDestroy(value:Boolean):void 
		{
			_autoDestroy = value;
			var i:int = this.numChildren - 1;
			for (i; i >= 0; i--)
			{
				var child:* = this.getChildAt(i);
				try{child.autoDestroy = value }
				catch (e:Error) { };
			}
		}
	}

}