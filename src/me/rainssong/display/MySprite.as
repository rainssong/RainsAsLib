package me.rainssong.display
{
	import flash.display.Bitmap;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.utils.Timer;
	
	/**
	 * instead by SmartSprite
	 * @author Rainssong
	 * Can self destroy when removed from stage
	 */
	public class MySprite extends Sprite implements IView
	{
		private var _autoDestroy:Boolean = true;
		public var autoDisable:Boolean = true;
		private var _listenerArr:Vector.<Array>=new Vector.<Array>;
		
		public function MySprite()
		{
			super();
			
			onRegister();
		}
		
		/* INTERFACE rainssong.display.IView */
		
		protected function onRegister():void
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
			if (autoDisable)
				enable();
		}
		
		public function enable():void
		{
			this.mouseChildren = this.mouseEnabled = true;
		}
		
		public function disable():void
		{
			this.mouseChildren = this.mouseEnabled = false;
		}
		
		public function hide():void
		{
			if (autoDisable)
				disable();
			this.visible = false;
		}
		
		protected function onRemove(e:Event):void
		{
			removeEventListener(Event.REMOVED_FROM_STAGE, onRemove);
			if (autoDestroy)
				destroy();
		}
		
		public function destroy():void
		{
			
			removeListeners();
			removeChildren();
			deleteVars();
			//remove();
			if (!autoDestroy && parent)
				parent.removeChild(this);
		}
		
		override public function addEventListener(type:String, listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false):void
		{
			_listenerArr.push([type, listener, useCapture]);
			super.addEventListener(type, listener, useCapture, priority, useWeakReference);
		}
		
		private function deleteVars():void
		{
			for (var v:String in this)
			{
				if (this[v] is URLLoader)
					URLLoader(this[v]).close();
				if (this[v] is Loader)
					Loader(this[v]).unloadAndStop();
				if (this[v] is Timer)
					Timer(this[v]).stop();
				
				delete this[v];
			}
		}
		
		override public function removeChildren(beginIndex:int = 0, endIndex:int = 2147483647):void
		{
			//while (this.numChildren)
			//{
			//var child:* = this.getChildAt(0);
			//if (child is Bitmap && (child as Bitmap).bitmapData) child.bitmapData.dispose();
			//if (child is flash.display.MovieClip ) child.stop();
			//this.removeChild(child);
			//this.removeChildAt(0);
			//}
			var i:int = this.numChildren - 1;
			if (i > endIndex)
				i = endIndex;
			for (i; i >= beginIndex; i--)
			{
				var child:* = this.getChildAt(i);
				if (child is Bitmap && (child as Bitmap).bitmapData)
					child.bitmapData.dispose();
				if (child is flash.display.MovieClip)
					child.stop();
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