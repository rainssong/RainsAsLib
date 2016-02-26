package me.rainssong.effects {
	import com.codeTooth.actionscript.lang.utils.destroy.DestroyUtil;
	import com.codeTooth.actionscript.lang.utils.destroy.IDestroy;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.BitmapDataChannel;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.events.Event;
	import flash.filters.BitmapFilterType;
	import flash.filters.BlurFilter;
	import flash.filters.DisplacementMapFilter;
	import flash.filters.DisplacementMapFilterMode;
	import flash.filters.GradientGlowFilter;
	import flash.geom.ColorTransform;
	import flash.geom.Matrix;
	import flash.geom.Point;
	
	/**
	 * Burning 类为显示对象添加火焰燃烧动画特效
	 * @author PhoenixKerry（http://blog.sina.com.cn/yyy98）
	 * @version 0.3
	 * 
	 * Modify by jim
	 * 把循环中需要 new 的对象设为类级变量，减少创建的对象数量。
	 * 构造函数中，可以多传入一写火焰的参数。
	 * 删除原来通过内部 EnterFrame 侦听来进行更新，改为提供 public 方法，让外部调用。
	 * 添加设置火焰对象的方法。
	 * 添加 destroy 销毁方法。
	 * @version 0.4
	 */
	public class Burning implements IDestroy
	{
		private var source:DisplayObjectContainer;
		private var speed:Number;
		
		private var flame:BitmapData;
		private var perlinNoise:BitmapData;
		private var perlinSeed:int;
		private var perlinOffsets:Array;
		
		private var stretch:int;
		private var flameBitmap:Bitmap;
		
		private var _matrix:Matrix = null;
		private var _colorTransform:ColorTransform = null;
		private var _point:Point = null;
		private var _blurFilter:BlurFilter = null;
		private var _displacementMapFilter:DisplacementMapFilter = null;
		
		/**
		 * 为 source 添加火焰燃烧效果动画
		 * @param	source 要添加燃烧效果动画的显示对象（容器）
		 * @param	stageWidth 舞台宽度
		 * @param	stageHeight 舞台高度
		 * @param	speed 燃烧速度
		 * @param	stretch 火焰延伸长度 [-20 ~ 20]
		 * @param	scaleX 火焰横向距离
		 * @param	scaleY 火焰纵向距离
		 * @param	redMultiplier 详见 ColorTransform 的 redMultiplier
		 * @param	greenMultiplier 详见 ColorTransform 的 greenMultiplier
		 * @param	blueMultiplier 详见 ColorTransform 的 blueMultiplier
		 * @param	alphaMultiplier 详见 ColorTransform 的 alphaMultiplier
		 * @param	blurX 详见 BlurFilter 的 blurX
		 * @param	blurY 详见 BlurFilter 的 blurY
		 * @param	blurQuality 详见 BlurFilter 的 blurQuality
		 * 
		 * @example 以下是该类的使用范例代码，burn_mc 为舞台上一个 MovieClip 实例，flame_mc 是位于 burn_mc 中的一个 MovieClip 实例
			<listing version="3.0">
			new Burning(burn_mc, stage.stageWidth, stage.stageHeight, burn_mc.flame_mc);</listing>
		 */
		public function Burning(source:DisplayObjectContainer, 
								stageWidth:Number, stageHeight:Number, transparent:Boolean = true, 
								speed:Number = 10, stretch:int = -4, 
								scaleX:Number = 2, scaleY:Number = 8, 
								redMultiplier:Number = .9, greenMultiplier:Number = .9, blueMultiplier:Number = .9, alphaMultiplier:Number = .7, 
								blurX:Number = 2, blurY:Number = 4, blurQuality:int = 1) 
		{
			this.source = source;
			this.speed = speed;
			
			flame = new BitmapData(
				stageWidth,
				stageHeight,
				true,
				transparent ? 0x00000000 : 0xFF000000
			);
			
			
			flameBitmap = new Bitmap(flame);
			source.addChildAt(flameBitmap, 0);
			
			perlinNoise = flame.clone();
			perlinSeed = 846338099;
			perlinOffsets = [new Point()];
			
			setFlameStretch( stretch );
			
			_matrix = new Matrix();
			_colorTransform = new ColorTransform(redMultiplier, greenMultiplier, blueMultiplier, alphaMultiplier);
			_point = new Point();
			_blurFilter = new BlurFilter(blurX, blurY, blurQuality);
			_displacementMapFilter = 
				new DisplacementMapFilter(
					perlinNoise, _point, 
					BitmapDataChannel.RED, BitmapDataChannel.RED, 
					scaleX, scaleY, 
					DisplacementMapFilterMode.CLAMP
				);
		}
		
		// 火焰对象
		private var _fireTarget:DisplayObject = null;
		
		/**
		 * 设置火焰对象
		 * 
		 * @param	target
		 * @param	distance 其它参数的解释见 GradientGlowFilter
		 * 
		 * @return
		 */
		public function setFireTarget(target:DisplayObject, 
										distance:Number = 4, angle:Number = 45, 
										colors:Array = null, alphas:Array = null, ratios:Array = null, 
										blurX:Number = 20, blurY:Number = 20, 
										strength:Number = 1, quality:int = 1, 
										type:String = "inner", knockout:Boolean = false):DisplayObject
		{
			if (target == null)
			{
				destroyFireTarget();
			}
			else
			{
				_fireTarget = target;
				_fireTarget.filters = [
					new GradientGlowFilter(
						distance, angle,
						colors == null ? [0xFF0000, 0xFFFF00] : colors, 
						alphas == null ? [.5, .8] : colors, 
						ratios == null ? [150, 255] : ratios,
						blurX, blurY, 
						strength, quality, type, knockout
					)
				];
			}
			
			return target;
		}
		
		private function destroyFireTarget():void
		{
			if (_fireTarget != null)
			{
				_fireTarget.filters = null;
				_fireTarget = null;
			}
		}
		
		
		/**
		 * 设置火焰延伸的长度
		 * @param	value 延伸长度值 [-20 ~ 20]
		 */
		public function setFlameStretch(value:int):void {
			stretch = value;
		}
		
		/**
		 * 更新显示
		 */
		public function refresh():void {
			flame.draw(source, _matrix, _colorTransform);
			
			flame.applyFilter(flame, flame.rect, _point, _blurFilter);
			flame.scroll(0, stretch);
			
			perlinNoise.perlinNoise(20, 20, 1,
				perlinSeed,
				false, true,
				BitmapDataChannel.RED,
				true, perlinOffsets
			);
			
			perlinOffsets[0].y += speed;
			
			flame.applyFilter(flame, flame.rect, _point, _displacementMapFilter);
		}
		
		//--------------------------------------------------------------------------------------------------------------------
		// 实现 IDestroy 接口
		//--------------------------------------------------------------------------------------------------------------------
		
		public function destroy():void
		{
			if (source != null)
			{
				if (flameBitmap != null)
				{
					if (flameBitmap.bitmapData != null)
					{
						flameBitmap.bitmapData.dispose();
						flameBitmap.bitmapData = null;
					}
					
					if (source.contains(flameBitmap))
					{
						source.removeChild(flameBitmap);
					}
					flameBitmap = null;
				}
				
				source = null;
			}
			
			if (flame != null)
			{
				flame.dispose();
				flame = null;
			}
			
			if (perlinNoise != null)
			{
				perlinNoise.dispose();
				perlinNoise = null;
			}
			
			if (perlinOffsets != null)
			{
				DestroyUtil.destroyArray(perlinOffsets);
				perlinOffsets = null;
			}
			
			_matrix = null;
			_colorTransform = null;
			_point = null;
			_blurFilter = null;
			_displacementMapFilter = null;
			
			destroyFireTarget();
		}
	}
}