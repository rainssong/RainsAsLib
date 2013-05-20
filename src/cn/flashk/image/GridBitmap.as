package cn.flashk.image
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	
	/**
	 * GridBitmap 用来显示网格图片的某个格子/帧。
	 * 
	 *  
	 * @langversion ActionScript 3.0
	 * @playerversion Flash 9.0
	 * 
	 * @see cn.flashk.controls.support.UIComponent
	 * 
	 * @author flashk
	 */
	
	public class GridBitmap extends Bitmap
	{
		/**
		 * 设置网格图像是按横向排列(true)还是竖向排列(false)，只影响viewByFrame方法，不影响viewByXY方法
		 * 
		 * @see #viewByFrame()
		 */ 
		public var isHorizontal:Boolean = true;
		
		protected var sourceBD:BitmapData;
		protected var gw:uint;
		protected var gh:uint;
		protected var bd:BitmapData;
		protected var lastViewFrame:uint;
		protected var lastX:uint;
		protected var lastY:uint;
		
		
		/**
		 * 创建一个网格图像显示对象，以便加入到显示列表
		 */ 
		public function GridBitmap()
		{
		}
		/**
		 * 设置网格图片的图像数据源，可以与其他 Bitmap 共用一个 Bitmapdata
		 */ 
		public function set sourceBitmapData(value:BitmapData):void{
			sourceBD = value;
		}
		/**
		 * 获得横向格子的数目
		 */ 
		public function get gridWidth():uint{
			return Math.round(sourceBD.width/gw);
		}
		/**
		 * 获得纵向格子的数目
		 */ 
		public function get gridHeight():uint{
			return Math.round(sourceBD.height/gh);
		}
		/**
		 * 获得格子的总数目，也就是总帧数
		 */ 
		public function get totalFrames():uint{
			return gridWidth*gridHeight;
		}
		/**
		 * 设置每个格子占多少宽高像素
		 */ 
		public function setGridSize(gridWidth:uint,gridHeight:uint):void{
			gw = gridWidth;
			gh = gridHeight;
			if(bd != null){
				bd.dispose();
			}
			bd = new BitmapData(gw,gh,true,0x00000000);
			this.bitmapData = bd;
		}
		/**
		 * 按照格子的坐标显示图像
		 */ 
		public function viewByXY(X:uint,Y:uint):void{
			bd.copyPixels(sourceBD,new Rectangle((X-1)*gw,(Y-1)*gh,gw,gh),new Point(0,0));
			lastX = X;
			lastY = Y;
		}
		/**
		 * 按照帧位置显示图像
		 */ 
		public function viewByFrame(frame:uint):void{
			var max:uint;
			var X:uint;
			var Y:uint;
			if(frame == 0) frame = 1;
			if(lastViewFrame == frame) return;
			if(isHorizontal == true){
				max = Math.round(sourceBD.width/gw);
				X = frame%max;
				if(X == 0) X = max;
				Y = uint((frame-1)/max)+1;
			}else{
				max = Math.round(sourceBD.height/gh);
				Y = frame%max;
				if(Y == 0) Y = max;
				X = uint((frame-1)/max)+1;
			}
			viewByXY(X,Y);
			lastViewFrame = frame;
		}
		/**
		 * 如果更新了sourceBitmapData中的数据，可以调用update立即刷新
		 */ 
		public function update():void{
			viewByXY(lastX,lastY);
		}
	}
}