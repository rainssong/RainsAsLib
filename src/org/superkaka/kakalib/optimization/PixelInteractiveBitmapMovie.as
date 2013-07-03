package org.superkaka.kakalib.optimization 
{
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import org.superkaka.kakalib.events.PixelMouseEvent;
	import org.superkaka.kakalib.struct.BitmapFrameInfo;
	/**
	 * 支持像素级交互的位图动画对象
	 * 由于支持像素交互检测需要消耗额外的性能，因此建议只在需要时使用此类，其它时候使用BitmapMovie类以获得最佳性能
	 * @author ｋａｋａ
	 */
	public class PixelInteractiveBitmapMovie extends BitmapMovie 
	{
		
		static private const dic_mouseEvent:Object = { };
		dic_mouseEvent[MouseEvent.CLICK] = PixelMouseEvent.CLICK;
		dic_mouseEvent[MouseEvent.DOUBLE_CLICK] = PixelMouseEvent.DOUBLE_CLICK;
		dic_mouseEvent[MouseEvent.MOUSE_DOWN] = PixelMouseEvent.MOUSE_DOWN;
		dic_mouseEvent[MouseEvent.MOUSE_MOVE] = PixelMouseEvent.MOUSE_MOVE;
		dic_mouseEvent[MouseEvent.MOUSE_UP] = PixelMouseEvent.MOUSE_UP;
		
		/**
		 * 保持一个point对象用于hitTestPoint，避免重复创建
		 */
		static private var pot:Point = new Point();
		
		/**
		 * 最小alpha通道值,点击、碰撞测试将其视为不透明的
		 */
		private var _alphaThreshold:uint;
		
		public function PixelInteractiveBitmapMovie(frameInfo:Vector.<BitmapFrameInfo> = null):void
		{
			
			super(frameInfo);
			
			for (var key:String in dic_mouseEvent)
			{
				addEventListener(key, testMouseEvent);
			}
			
			addEventListener(MouseEvent.ROLL_OVER, checkMouseInOut);
			addEventListener(MouseEvent.ROLL_OUT, checkMouseInOut);
			
		}
		
		override protected function init():void
		{
			
			super.init();
			
			this.alphaThreshold = 0.01;
			setMouseIn(false);
			
		}
		
		/**
		 * 跳转到指定索引的帧
		 * @param	frameIndex
		 */
		override protected function gotoFrame(frameIndex:int):void
		{
			
			super.gotoFrame(frameIndex);
			
			checkMouseInOut();
			
		}
		
		private function isPointTransparent(x:int, y:int):Boolean
		{
			
			return (bitmap.bitmapData.getPixel32(x, y) >> 24 & 0xff) < _alphaThreshold;
			
		}
		
		override public function hitTestPoint(x:Number, y:Number, shapeFlag:Boolean = false):Boolean
		{
			
			if (shapeFlag)
			{
				
				pot.x = x;
				pot.y = y;
				
				pot = bitmap.globalToLocal(pot);
				
				return !isPointTransparent(pot.x, pot.y);
				
			}
			else
			{
				
				return super.hitTestPoint(x, y, shapeFlag);
				
			}
			
		}
		
		/**
		 * 获取或设置最小alpha通道值,点击、碰撞测试将其视为不透明的
		 */
		public function get alphaThreshold():Number 
		{
			return _alphaThreshold / 255;
		}
		
		public function set alphaThreshold(value:Number):void 
		{
			_alphaThreshold = value * 255;
		}
		
		private var _mouseIn:Boolean;
		
		public function setMouseIn(value:Boolean):void
		{
			
			if (value == _mouseIn) return;
			_mouseIn = value;
			
			if (_mouseIn)
			{
				this.removeEventListener(MouseEvent.MOUSE_MOVE, checkMouseInOut);
				if (null != stage)
				stage.addEventListener(MouseEvent.MOUSE_MOVE, checkMouseInOut);
				
				dispatchEvent(new PixelMouseEvent(PixelMouseEvent.ROLL_OVER, this.mouseX, this.mouseY));
				
			}
			else
			{
				this.addEventListener(MouseEvent.MOUSE_MOVE, checkMouseInOut);
				if (null != stage)
				stage.removeEventListener(MouseEvent.MOUSE_MOVE, checkMouseInOut);
				
				dispatchEvent(new PixelMouseEvent(PixelMouseEvent.ROLL_OUT, this.mouseX, this.mouseY));
				
			}
			
		}
		
		private function checkMouseInOut(evt:MouseEvent = null):void
		{
			
			setMouseIn(!isPointTransparent(bitmap.mouseX, bitmap.mouseY));
			
		}
		
		private function testMouseEvent(evt:MouseEvent):void
		{
			
			if (!isPointTransparent(bitmap.mouseX, bitmap.mouseY))
			dispatchEvent(new PixelMouseEvent(dic_mouseEvent[evt.type], this.mouseX, this.mouseY));
			
		}
		
	}

}