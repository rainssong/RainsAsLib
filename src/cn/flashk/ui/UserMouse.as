package cn.flashk.ui
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Stage;
	import flash.events.MouseEvent;
	import flash.filters.DropShadowFilter;
	import flash.ui.Mouse;

	/**
	 * UserMouse用来创建自定义鼠标，并使自定义鼠标获得和操作系统一样的刷新速度。可以接受BitmapData，BitmapData数组（此数组中的BitmapData将播放成循环动画），DisplayObject实例（Shape、Sprite、MovieClip）
	 * 
	 * @langversion 3.0
	 * @playerversion Flash 9.0
	 */ 
	public class UserMouse
	{
		public static var mouseDisplayObjectContainer:DisplayObjectContainer;
		
		public static var mouseDisplayObject:DisplayObject;
		
		public static var mouseFilter:Array = [new DropShadowFilter(2,45,0,1,4,4,0.3) ];
		
		public static var x:Number;
		public static var y:Number;
		
		private static var bds:Array;
		private static var index:int;
		private static var bp:Bitmap = new Bitmap();
		
		/**
		 * 显示自定义鼠标，并隐藏操作系统鼠标
		 * 
		 * @param mouseObject 自定义鼠标的资源，可以接受BitmapData，BitmapData数组（此数组中的BitmapData将播放成循环动画），DisplayObject实例（Shape、Sprite、MovieClip）
		 * @param x X坐标偏移量
		 * @param y Y坐标偏移量
		 * @param isShowDrop 是否显示鼠标阴影，阴影滤镜在UserMouse.mouseFilter可以自行指定
		 */
		
		public static function showCustomMouse(mouseObject:Object,x:Number=0,y:Number=0,isShowDrop:Boolean=true):void{
			Mouse.hide();
			index = 0;
			UserMouse.x = x;
			UserMouse.y = y;
			if(mouseObject is BitmapData){
				mouseDisplayObject = bp;
				Bitmap(mouseDisplayObject).bitmapData = mouseObject as BitmapData;
			}
			if(mouseObject is Array){
				mouseDisplayObject = bp;
				bds = mouseObject as Array;
				Bitmap(mouseDisplayObject).bitmapData = bds[0] as BitmapData;
			}
			if(mouseObject is DisplayObject){
				mouseDisplayObject = mouseObject as DisplayObject;
			}

			mouseDisplayObjectContainer.addChild(mouseDisplayObject);
			mouseDisplayObjectContainer.stage.addEventListener(MouseEvent.MOUSE_MOVE,updateMouseMove);
			if(isShowDrop == true){
				mouseDisplayObject.filters = mouseFilter;
			}else{
				mouseDisplayObject.filters = null;
			}
			
		}
		/**
		 * 隐藏自定义鼠标，并显示操作系统鼠标
		 */ 
		public static function hideCustomMouse():void{
			Mouse.show();
			if(mouseDisplayObject is Bitmap){
				Bitmap(mouseDisplayObject).bitmapData = null;
			}
		}
		
		protected static function updateMouseMove(event:MouseEvent):void
		{
			mouseDisplayObject.x = mouseDisplayObjectContainer.stage.mouseX+UserMouse.x;
			mouseDisplayObject.y = mouseDisplayObjectContainer.stage.mouseY+UserMouse.y;
			event.updateAfterEvent();
			
		}
	}
}