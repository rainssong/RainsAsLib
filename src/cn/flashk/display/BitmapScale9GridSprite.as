package cn.flashk.display
{
	import cn.flashk.image.DisplayObjectDrawScale9GridBitmap;
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	
	
	/**
	 * 支持位图九宫格缩放的Sprite，如果有需要在Sprite中使用位图九宫格，请直接从此类继承，Sprite本身的set width和set height函数已经被重写，然后直接使用s.width=150这样的操作就可以了（如果是使用scaleX属性设置，请在设置完后调用updta方法）
	 */ 

	public class BitmapScale9GridSprite extends Sprite
	{
		/**
		 * 标记哪些子显示对象需要显示原生对象。在此数组中的显示对象将设visible = true同时不会被绘制到bitmap表面，其他此Sprite中的所有子显示对象将visible = false并都绘制到bitmap中。
		 * 也就是此数组中的显示对象采用flash自己的缩放，而其他子显示对象采用九宫格缩放。如果有需要用户选择的文本等请放到此数组中，因为如果不这样，文本将会变成bitmap位图。
		 * 九宫格操作是针对绘制后的bitmap的，默认visibleChildrens为空数组(请勿将此属性设为null，改用[]），也就是绘制九宫格缩放后所有此Sprite子显示对象将隐藏（除了DisplayObjectDrawScale9GridBitmap本身）
		 */ 
		public var visibleChildrens:Array = [];
		
		/**
		 * 当重设宽高时是否重新draw一次sprite,设false时将使用缓存数据（也就是上一次draw的数据）。
		 */ 
		public var whenResizeReDraw:Boolean = false;
		
		protected var dodSGBitmap:DisplayObjectDrawScale9GridBitmap;
		protected var isScale9GridBitmapCatch:Boolean = false;
		
		public function BitmapScale9GridSprite()
		{
			super();
			dodSGBitmap = new DisplayObjectDrawScale9GridBitmap();
			this.addChildAt(dodSGBitmap,0);
		}
		/**
		 * 立即刷新Sprite的九宫格显示，如果一个Sprite被放置到了舞台而且使用了Flash CS的缩放工具缩放，请在构造函数中调用此方法（或者在其他代码中调用此方法）
		 */ 
		public function update():void{
			width = width;
			//height = height;
		}
		override public function set width(value:Number):void{
			trace("BitmapScale9GridSprite fun");
			super.width = value;
			if(isScale9GridBitmapCatch == false || whenResizeReDraw == true ){
				showOthersVisible();
				dodSGBitmap.draw(this,true,whenResizeReDraw);
				hideOthersVisible();
			}else{
				dodSGBitmap.draw(this,true,whenResizeReDraw);
			}
			dodSGBitmap.scaleX = 1/this.scaleX;
			dodSGBitmap.scaleY = 1/this.scaleY;
			isScale9GridBitmapCatch = true;
		}
		override public function set height(value:Number):void{
			super.height = value;
			if(isScale9GridBitmapCatch == false || whenResizeReDraw == true ){
				showOthersVisible();
				dodSGBitmap.draw(this,true,whenResizeReDraw);
				hideOthersVisible();
			}else{
				dodSGBitmap.draw(this,true,whenResizeReDraw);
			}
			dodSGBitmap.scaleX = 1/this.scaleX;
			dodSGBitmap.scaleY = 1/this.scaleY;
			isScale9GridBitmapCatch = true;
		}
		protected function hideOthersVisible():void{
			var dis:DisplayObject;
			var j:int;
			var isInArray:Boolean;
			for(var i:int=0;i<this.numChildren;i++){
				dis = this.getChildAt(i);
				isInArray = false;
				for(j=0;j<visibleChildrens.length;j++){
					if(visibleChildrens[j] == dis){
						isInArray = true;
						break;
					}
				}
				if(isInArray == true || dis == dodSGBitmap){
					dis.visible = true;
				}else{
					dis.visible = false;
				}
			}
		}
		protected function showOthersVisible():void{
			var dis:DisplayObject;
			var j:int;
			var isInArray:Boolean;
			for(var i:int=0;i<this.numChildren;i++){
				dis = this.getChildAt(i);
				isInArray = false;
				for(j=0;j<visibleChildrens.length;j++){
					if(visibleChildrens[j] == dis){
						isInArray = true;
						break;
					}
				}
				if(isInArray == true || dis == dodSGBitmap){
					dis.visible = false;
				}else{
					dis.visible = true;
				}
			}
		}
	}
}