////////////////////////////////////////////////////////////////////////////////
//
//  Power by www.RIAHome.cn
//                 -- Y.Boy
//
////////////////////////////////////////////////////////////////////////////////

package me.rainssong.display
{
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;

	/**
	 *  BitmapTransformer 类包含各种对显示对象进行变形转换的方法，包括：裁剪、旋转、缩放、倾斜、对齐、分布。
	 */
	public class DisplayObjectTransformer
	{
		/**
		 *  水平缩放时，定轴为左边缘。
		 */
		public static const SCALE_AXIS_LEFT:String = "left";
		
		
		
		/**
		 *  水平缩放时，定轴为水平中心轴。
		 */
		public static const SCALE_AXIS_HORIZONAL_CENTER:String = "horizonalCenter";
		
		
		
		/**
		 *  水平缩放时，定轴为右边缘。
		 */
		public static const SCALE_AXIS_RIGHT:String = "right";
		
		
		
		/**
		 *  垂直缩放时，定轴为上边缘。
		 */
		public static const SCALE_AXIS_TOP:String = "top";
		
		
		
		/**
		 *  垂直缩放时，定轴为垂直中心轴。
		 */
		public static const SCALE_AXIS_VERTICAL_CENTER:String = "verticalCenter";
		
		
		
		/**
		 *  垂直缩放时，定轴为下边缘。
		 */
		public static const SCALE_AXIS_BOTTOM:String = "bottom";
		
		
		
	    /**
	     *  构造函数
	     *  <p>本类所有方法均为静态方法，不应创建实例。</p>
	     */
		public function DisplayObjectTransformer()
		{
			
		}
		
		
		
		//------------------------------------------------------------
		//
		//  裁剪
		//     |- 裁剪矩形
		//     |- 裁剪任意形状
		//
		//------------------------------------------------------------
	    /**
	     *  裁剪指定矩形区域并返回一个包含结果的 BitmapData 对象。
	     *
	     *  @param target 需要裁剪的显示对象。
	     *
	     *  @param width 位图图像的宽度，以像素为单位。
	     *
	     *  @param height 位图图像的高度，以像素为单位。
	     *
	     *  @param distanceX 切割矩形左上角的点到显示对象矩形左上角的点的水平距离。注意：左上角的点不一定就是注册点（0, 0）外，变形过的显示对象就是一个例外。
	     *
	     *  @param distanceY 切割矩形左上角的点到显示对象矩形左上角的点的垂直距离。注意：左上角的点不一定就是注册点（0, 0）外，变形过的显示对象就是一个例外。
	     *
	     *  @param transparent 指定裁剪后的位图图像是否支持每个像素具有不同的透明度。默认值为 true（透明）。若要创建完全透明的位图，请将 transparent 参数的值设置为 true，将 fillColor 参数的值设置为 0x00000000（或设置为 0）。将 transparent 属性设置为 false 可以略微提升呈现性能。
	     *
	     *  @param fillColor 用于填充裁剪后的位图图像区域背景的 32 位 ARGB 颜色值。默认值为 0x00000000（纯透明黑色）。
	     *
	     *  @returns 返回裁剪后的 BitmapData 对象。
	     */
		public static function cutOutRect( target:DisplayObject, width:Number, height:Number, distanceX:Number, distanceY:Number, transparent:Boolean = true, fillColor:uint = 0x00000000 ):BitmapData
		{
			var m:Matrix = target.transform.matrix;
			m.tx -= target.getBounds( target.parent ).x + distanceX;
			m.ty -= target.getBounds( target.parent ).y + distanceY;
			
			var bmpData:BitmapData = new BitmapData( width, height, transparent, fillColor );
			bmpData.draw( target, m );
			
			return bmpData;
		}
		
		
		/**
		 *  超级裁剪工具！可裁剪任意形状！给定一个裁剪目标和一个模板，就可根据模板裁剪出形状相配的 BitmapData 数据。
		 *
		 *  @param target 需要裁剪的显示对象。
		 *
		 *  @param template 裁剪模板，可以是任意形状。
		 *
		 *  @returns 返回裁剪后的 BitmapData 对象。
		 */
		public static function cutOutSuper( target:DisplayObject, template:DisplayObject ):BitmapData
		{
			var rectTarget:Rectangle = target.transform.pixelBounds;
			var rectTemplate:Rectangle = template.transform.pixelBounds;
			var targetBitmapData:BitmapData = DisplayObjectTransformer.cutOutRect( target, rectTarget.width, rectTarget.height, 0, 0, true, 0x00000000 );
			var templateBitmapData:BitmapData = DisplayObjectTransformer.cutOutRect( template, rectTemplate.width, rectTemplate.height, 0, 0, true, 0x00000000 );
			
			for( var pixelY:int = 0; pixelY < rectTemplate.height; pixelY++ )
			{
				for( var pixelX:int = 0; pixelX < rectTemplate.width; pixelX++ )
				{
					if( templateBitmapData.getPixel( pixelX, pixelY ) != 0 )
					{
						var color:uint = targetBitmapData.getPixel32( pixelX + rectTemplate.x - rectTarget.x, pixelY + rectTemplate.y - rectTarget.y );
						templateBitmapData.setPixel32( pixelX, pixelY, color );
					}
				}
			}
			
			return templateBitmapData;
			
		}
		
		
		
		//------------------------------------------------------------
		//
		//  旋转
		//     |- 绕内部点
		//     |- 绕外部点
		//
		//------------------------------------------------------------
		/**
		 *  令显示对象围绕其内部的变形点进行旋转，旋转角度由 angleDegress 参数指定。
		 *
		 *  @param target 要进行旋转的显示对象。
		 *
		 *  @param x 该点的 x 坐标。
		 *
		 *  @param y 该点的 y 坐标。
		 *
		 *  @param angleDegrees 以度为单位的旋转角度。
		 */
		public static function rotateAroundInternalPoint( target:DisplayObject, x:Number, y:Number, angleDegrees:Number ):void
		{
			var m:Matrix = target.transform.matrix;
			
			// fl.motion.MatrixTransformer.rotateAroundInternalPoint(m:Matrix, x:Number, y:Number, angleDegrees:Number)
			var point:Point = new Point( x, y );
			point = m.transformPoint( point );
			m.tx -= point.x;
			m.ty -= point.y;
			m.rotate( angleDegrees * Math.PI / 180 );
			m.tx += point.x;
			m.ty += point.y;
			
			target.transform.matrix = m;
		}
		
		
		
		/**
		 *  令显示对象围绕其父级中的变形点进行旋转，旋转角度由 angleDegress 参数指定。
		 *
		 *  @param target 要进行旋转的显示对象。
		 *
		 *  @param x 该点的 x 坐标。
		 *
		 *  @param y 该点的 y 坐标。
		 *
		 *  @param angleDegrees 以度为单位的旋转角度。
		 */
		public static function rotateAroundExternalPoint( target:DisplayObject, x:Number, y:Number, angleDegrees:Number ):void
		{
			var m:Matrix = target.transform.matrix;
			
			// fl.motion.MatrixTransformer.rotateAroundExternalPoint(m:Matrix, x:Number, y:Number, angleDegrees:Number)
			m.tx -= x;
			m.ty -= y;
			m.rotate( angleDegrees * Math.PI / 180 );
			m.tx += x;
			m.ty += y;
			
			target.transform.matrix = m;
		}
		
		
		
		//------------------------------------------------------------
		//
		//  缩放
		//     |- 水平缩放
		//     |        |- 左边缘定轴
		//     |        |- 中垂线定轴
		//     |        |- 右边缘定轴
		//     |
		//     |- 垂直缩放
		//              |- 上边缘定轴
		//              |- 中横线定轴
		//              |- 下边缘定轴
		//
		//  搭配
		//     |- 左边缘: left
		//     |- 中垂线: horizonalCenter
		//     |- 右边缘: right
		//     |- 上边缘: top
		//     |- 中横线: verticalCenter
		//     |- 下边缘: bottom
		//     |- 左上角: right-bottom
		//     |- 左下角: right-top
		//     |- 右上角: left-bottom
		//     |- 右下角: left-top
		//     |- 中心点: horizonalCenter-verticalCenter
		//
		//------------------------------------------------------------
		/**
		 *  对显示对象进行水平缩放，缩放后的新宽度由 newWidth 指定。
		 *
		 *  @param target 要进行水平缩放的显示对象。
		 *
		 *  @param newWidth 水平缩放后新的宽度。可以为负值，负值表示翻转。
		 *
		 *  @param scaleAxis 水平缩放的定轴。可选值有：left、right、horizonalCenter。假如以左边缘为定轴进行缩放，则应值用 DisplayObjectTransformer.SCALE_AXIS_LEFT 值。
		 */
		public static function scaleX( target:DisplayObject, newWidth:Number, scaleAxis:String ):void
		{
			// 避免宽度被设为0
			if( newWidth == 0 )
			{
				newWidth = 1;
			}
			
			// 显示对象旧的 Rectangle 范围。
			var oldRect:Rectangle = target.transform.pixelBounds; // target.getBounds( target.stage );
			
			// 水平缩放
			var sx:Number = newWidth / target.width;
			var m:Matrix = target.transform.matrix;
			if( m.a < 0 )
			{
				m.scale( -sx, 1 );
			}else
			{
				m.scale( sx, 1 );
			}
			target.transform.matrix = m;
			
			// 水平移动
			var newRect:Rectangle = target.transform.pixelBounds; // 显示对象新的 Rectangle 范围。
			switch( scaleAxis )
			{
				case SCALE_AXIS_LEFT:
					// 定轴为左边框
					m.tx -= newRect.x - oldRect.x;
					break;
					
				case SCALE_AXIS_HORIZONAL_CENTER:
					// 定轴为水平中心轴
					m.tx -= (newRect.x + newRect.width / 2) - (oldRect.x + oldRect.width / 2);
					break;
					
				case SCALE_AXIS_RIGHT:
					// 定轴为右边框
					m.tx -= (newRect.x + newRect.width) - (oldRect.x + oldRect.width);
					break;
				
				default:
					throw new Error( "水平缩放时，指定的定轴类型不正确！" );
			}
			target.transform.matrix = m;
		}
		
		
		
		/**
		 *  对显示对象进行垂直缩放，缩放后的新高度由 newHeight 指定。
		 *
		 *  @param target 要进行垂直缩放的显示对象。
		 *
		 *  @param newHeight 垂直缩放后新的高度。可以为负值，负值表示翻转。
		 *
		 *  @param scaleAxis 垂直缩放的定轴。可选值有：top、bottom、verticalCenter。假如以上边缘为定轴进行缩放，则应值用 DisplayObjectTransformer.SCALE_AXIS_TOP 值。
		 */
		public static function scaleY( target:DisplayObject, newHeight:Number, scaleAxis:String ):void
		{
			// 避免高度被设为0
			if( newHeight == 0 )
			{
				newHeight = 1;
			}
			
			// 显示对象旧的 Rectangle 范围。
			var oldRect:Rectangle = target.transform.pixelBounds;
			
			// 垂直缩放
			var sy:Number = newHeight / target.height;
			var m:Matrix = target.transform.matrix;
			if( m.d < 0 )
			{
				m.scale( 1, -sy );
			}else
			{
				m.scale( 1, sy );
			}
			target.transform.matrix = m;
			
			// 垂直移动
			var newRect:Rectangle = target.transform.pixelBounds; // 显示对象新的 Rectangle 范围。
			switch( scaleAxis )
			{
				case SCALE_AXIS_TOP:
					// 定轴为上边框
					m.ty -= newRect.y - oldRect.y;
					break;
					
				case SCALE_AXIS_VERTICAL_CENTER:
					// 定轴为垂直中心轴
					m.ty -= (newRect.y + newRect.height / 2) - (oldRect.y + oldRect.height / 2);
					break;
					
				case SCALE_AXIS_BOTTOM:
					// 定轴为下边框
					m.ty -= (newRect.y + newRect.height) - (oldRect.y + oldRect.height);
					break;
				
				default:
					throw new Error( "垂直缩放时，指定的定轴类型不正确！" );
			}
			target.transform.matrix = m;
		}
		
		
		
		//------------------------------------------------------------
		//
		//  倾斜
		//     |- 水平倾斜
		//     |- 垂直倾斜
		//
		//------------------------------------------------------------
		/**
		 *  对显示对象进行水平倾斜，倾斜的角度由 skewX 指定。
		 *
		 *  @param target 要进行水平倾斜的显示对象。
		 *
		 *  @param skewX 需要增加的水平倾斜度，以度为单位，可为负值。
		 */
		public static function skewX( target:DisplayObject, skewX:Number ):void
		{
			var m:Matrix = target.transform.matrix;
			m.c += Math.tan( skewX * Math.PI / 180 );
			target.transform.matrix = m;
		}
		
		
		
		/**
		 *  对显示对象进行垂直倾斜，倾斜的角度由 skewY 指定。
		 *
		 *  @param target 要进行垂直倾斜的显示对象。
		 *
		 *  @param skewX 需要增加的垂直倾斜度，以度为单位，可为负值。
		 */
		public static function skewY( target:DisplayObject, skewY:Number ):void
		{
			var m:Matrix = target.transform.matrix;
			m.b += Math.tan( skewY * Math.PI / 180 );
			target.transform.matrix = m;
		}
		
		
		
		//------------------------------------------------------------
		//
		//  对齐
		//     |- 左对齐
		//     |- 水平中齐
		//     |- 右对齐
		//     |- 上对齐
		//     |- 垂直中齐
		//     |- 底对齐
		//
		//------------------------------------------------------------
		/**
		 *  左对齐给定的显示对象，所有显示对象将向最左边的显示对象靠拢。需要进行左对齐操作的显示对象将包含在 targets 参数里。
		 *
		 *  @param targets 包含若干个显示对象的数组。
		 */
		public static function alignLeftEdge( targets:Array ):void
		{
			var xArray:Array = new Array(); // 存放 targets 对应的 Rectangle 范围的 x 坐标。
			var i:int = 0; // 轮询 targets 时的循环计数器。
			var target:DisplayObject; // 轮询 targets 时的当前显示对象。
			var minX:Number = 0; // 最左边的显示对象所对应的 Rectangle 范围的 x 坐标。
			
			// 轮询 targets，获取对应 Rectangle 范围的 x 坐标。
			for( i = 0; i < targets.length; i++ )
			{
				target = targets[i] as DisplayObject;
				xArray.push( target.transform.pixelBounds.x );
			}
			
			minX = xArray[ xArray.sort( Array.NUMERIC | Array.RETURNINDEXEDARRAY )[0] ];
			
			// 移动显示对象，使其左对齐。
			for( i = 0; i < targets.length; i++ )
			{
				target = targets[i] as DisplayObject;
				var m:Matrix = target.transform.matrix;
				m.tx -= xArray[i] - minX;
				target.transform.matrix = m;
			}
		}
		
		
		
		/**
		 *  水平中对齐给定的显示对象，所有显示对象将向最左边的显示对象的左边缘与最右边的显示对象的右边缘之间的水平中线靠拢。需要进行水平中对齐操作的显示对象将包含在 targets 参数里。
		 *
		 *  @param targets 包含若干个显示对象的数组。
		 */
		public static function alignHorizonalCenter( targets:Array ):void
		{
			var xArray:Array = new Array(); // 存放 targets 对应的 Rectangle 范围的 x 坐标。
			var widthArray:Array = new Array(); // 存放 targets 对应的 Rectangle 范围的 width 值。
			var i:int = 0; // 轮询 targets 时的循环计数器。
			var target:DisplayObject; // 轮询 targets 时的当前显示对象。
			var centerX:Number = 0; // 目录对齐的水平中线的 x 坐标。
			
			// 轮询 targets，获取对应 Rectangle 范围的 x 坐标和 width 值。
			for( i = 0; i < targets.length; i++ )
			{
				target = targets[i] as DisplayObject;
				var rect:Rectangle = target.transform.pixelBounds;
				xArray.push( rect.x );
				widthArray.push( rect.width );
			}
			
			// 求最右边缘的 x 坐标。
			var rightEdgeXArray:Array = new Array();
			for( i = 0; i < targets.length; i++ )
			{
				rightEdgeXArray.push( xArray[i] + widthArray[i] );
			}
			var maxX:Number = rightEdgeXArray[ rightEdgeXArray.sort( Array.NUMERIC | Array.RETURNINDEXEDARRAY | Array.DESCENDING )[0] ];
			var minX:Number = xArray[ xArray.sort( Array.NUMERIC | Array.RETURNINDEXEDARRAY )[0] ];
			centerX = (maxX + minX) / 2;
			
			// 移动显示对象，使其水平中对齐。
			for( i = 0; i < targets.length; i++ )
			{
				target = targets[i] as DisplayObject;
				var m:Matrix = target.transform.matrix;
				m.tx -= xArray[i] + widthArray[i] / 2 - centerX;
				target.transform.matrix = m;
			}
		}
		
		
		
		/**
		 *  右对齐给定的显示对象，所有显示对象将向最右边的显示对象靠拢。需要进行右对齐操作的显示对象将包含在 targets 参数里。
		 *
		 *  @param targets 包含若干个显示对象的数组。
		 */
		public static function alignRightEdge( targets:Array ):void
		{
			var xArray:Array = new Array(); // 存放 targets 对应的 Rectangle 范围的 x 坐标。
			var widthArray:Array = new Array(); // 存放 targets 对应的 Rectangle 范围的 width 值。
			var i:int = 0; // 轮询 targets 时的循环计数器。
			var target:DisplayObject; // 轮询 targets 时的当前显示对象。
			var maxX:Number = 0; // 最右边的显示对象的右边缘所对应的 Rectangle 范围的 x 坐标。
			
			// 轮询 targets，获取对应 Rectangle 范围的 x 坐标和 width 值。
			for( i = 0; i < targets.length; i++ )
			{
				target = targets[i] as DisplayObject;
				var rect:Rectangle = target.transform.pixelBounds;
				xArray.push( rect.x );
				widthArray.push( rect.width );
			}
			
			// 求最右边缘的 x 坐标。
			var rightEdgeXArray:Array = new Array();
			for( i = 0; i < targets.length; i++ )
			{
				rightEdgeXArray.push( xArray[i] + widthArray[i] );
			}
			maxX = rightEdgeXArray[ rightEdgeXArray.sort( Array.NUMERIC | Array.RETURNINDEXEDARRAY | Array.DESCENDING )[0] ];
			
			// 移动显示对象，使其水平中对齐。
			for( i = 0; i < targets.length; i++ )
			{
				target = targets[i] as DisplayObject;
				var m:Matrix = target.transform.matrix;
				m.tx += maxX - (xArray[i] + widthArray[i]);
				target.transform.matrix = m;
			}
		}
		
		
		
		/**
		 *  上对齐给定的显示对象，所有显示对象将向最上边的显示对象靠拢。需要进行上对齐操作的显示对象将包含在 targets 参数里。
		 *
		 *  @param targets 包含若干个显示对象的数组。
		 */
		public static function alignTopEdge( targets:Array ):void
		{
			var yArray:Array = new Array(); // 存放 targets 对应的 Rectangle 范围的 y 坐标。
			var i:int = 0; // 轮询 targets 时的循环计数器。
			var target:DisplayObject; // 轮询 targets 时的当前显示对象。
			var minY:Number = 0; // 最上边的显示对象所对应的 Rectangle 范围的 y 坐标。
			
			// 轮询 targets，获取对应 Rectangle 范围的 y 坐标。
			for( i = 0; i < targets.length; i++ )
			{
				target = targets[i] as DisplayObject;
				yArray.push( target.transform.pixelBounds.y );
			}
			
			minY = yArray[ yArray.sort( Array.NUMERIC | Array.RETURNINDEXEDARRAY )[0] ];
			
			// 移动显示对象，使其上对齐。
			for( i = 0; i < targets.length; i++ )
			{
				target = targets[i] as DisplayObject;
				var m:Matrix = target.transform.matrix;
				m.ty -= yArray[i] - minY;
				target.transform.matrix = m;
			}
		}
		
		
		
		/**
		 *  垂直中对齐给定的显示对象，所有显示对象将向最上边的显示对象的上边缘与最下边的显示对象的下边缘之间的垂直中线靠拢。需要进行垂直中对齐操作的显示对象将包含在 targets 参数里。
		 *
		 *  @param targets 包含若干个显示对象的数组。
		 */
		public static function alignVerticalCenter( targets:Array ):void
		{
			var yArray:Array = new Array(); // 存放 targets 对应的 Rectangle 范围的 y 坐标。
			var heightArray:Array = new Array(); // 存放 targets 对应的 Rectangle 范围的 height 值。
			var i:int = 0; // 轮询 targets 时的循环计数器。
			var target:DisplayObject; // 轮询 targets 时的当前显示对象。
			var centerY:Number = 0; // 目录对齐的垂直中线的 y 坐标。
			
			// 轮询 targets，获取对应 Rectangle 范围的 y 坐标和 height 值。
			for( i = 0; i < targets.length; i++ )
			{
				target = targets[i] as DisplayObject;
				var rect:Rectangle = target.transform.pixelBounds;
				yArray.push( rect.y );
				heightArray.push( rect.height );
			}
			
			// 求最下边缘的 y 坐标。
			var bottomEdgeYArray:Array = new Array();
			for( i = 0; i < targets.length; i++ )
			{
				bottomEdgeYArray.push( yArray[i] + heightArray[i] );
			}
			var maxY:Number = bottomEdgeYArray[ bottomEdgeYArray.sort( Array.NUMERIC | Array.RETURNINDEXEDARRAY | Array.DESCENDING )[0] ];
			var minY:Number = yArray[ yArray.sort( Array.NUMERIC | Array.RETURNINDEXEDARRAY )[0] ];
			centerY = (maxY + minY) / 2;
			
			// 移动显示对象，使其垂直中对齐。
			for( i = 0; i < targets.length; i++ )
			{
				target = targets[i] as DisplayObject;
				var m:Matrix = target.transform.matrix;
				m.ty -= yArray[i] + heightArray[i] / 2 - centerY;
				target.transform.matrix = m;
			}
		}
		
		
		
		/**
		 *  底对齐给定的显示对象，所有显示对象将向最下边的显示对象靠拢。需要进行底对齐操作的显示对象将包含在 targets 参数里。
		 *
		 *  @param targets 包含若干个显示对象的数组。
		 */
		public static function alignBottomEdge( targets:Array ):void
		{
			var yArray:Array = new Array(); // 存放 targets 对应的 Rectangle 范围的 y 坐标。
			var heightArray:Array = new Array(); // 存放 targets 对应的 Rectangle 范围的 height 值。
			var i:int = 0; // 轮询 targets 时的循环计数器。
			var target:DisplayObject; // 轮询 targets 时的当前显示对象。
			var maxY:Number = 0; // 最下边的显示对象的下边缘所对应的 Rectangle 范围的 y 坐标。
			
			// 轮询 targets，获取对应 Rectangle 范围的 y 坐标和 height 值。
			for( i = 0; i < targets.length; i++ )
			{
				target = targets[i] as DisplayObject;
				var rect:Rectangle = target.transform.pixelBounds;
				yArray.push( rect.y );
				heightArray.push( rect.height );
			}
			
			// 求最下边缘的 y 坐标。
			var bottomEdgeYArray:Array = new Array();
			for( i = 0; i < targets.length; i++ )
			{
				bottomEdgeYArray.push( yArray[i] + heightArray[i] );
			}
			maxY = bottomEdgeYArray[ bottomEdgeYArray.sort( Array.NUMERIC | Array.RETURNINDEXEDARRAY | Array.DESCENDING )[0] ];
			
			// 移动显示对象，使其底对齐。
			for( i = 0; i < targets.length; i++ )
			{
				target = targets[i] as DisplayObject;
				var m:Matrix = target.transform.matrix;
				m.ty += maxY - (yArray[i] + heightArray[i]);
				target.transform.matrix = m;
			}
		}
		
		
		
		//------------------------------------------------------------
		//
		//  分布
		//     |- 顶部分布
		//     |- 垂直居中分布
		//     |- 底部分布
		//     |- 左侧分布
		//     |- 水平居中分布
		//     |- 右侧分布
		//
		//------------------------------------------------------------
		/**
		 *  顶部分布。以显示对象上边缘为准，在最上边与最下边的显示对象之间平均分布所有显示对象。需要进行顶部分布操作的显示对象将包含在 targets 参数里。
		 *
		 *  @param targets 包含若干个显示对象的数组。
		 */
		public static function distributeTopEdge( targets:Array ):void
		{
			var topEdgeYArray:Array = new Array(); // 存放 targets 对应的 Rectangle 上边缘的 y 坐标。
			var topEdgeYIndexedArray:Array; // 对 topEdgeYArray 进行排序并保存对应的索引值，升序。
			var i:int = 0;
			var target:DisplayObject;
			var yGap:Number = 0; // 平均分布所需的间隔。
			
			// 轮询 targets，获取对应 Rectangle 范围的 y 坐标。
			for( i = 0; i < targets.length; i++ )
			{
				target = targets[i] as DisplayObject;
				topEdgeYArray.push( target.transform.pixelBounds.y );
			}
			
			topEdgeYIndexedArray = topEdgeYArray.sort( Array.NUMERIC | Array.RETURNINDEXEDARRAY );
			var minY:Number = topEdgeYArray[ topEdgeYIndexedArray[0] ];
			var maxY:Number = topEdgeYArray[ topEdgeYIndexedArray[topEdgeYIndexedArray.length - 1] ];
			yGap = (maxY - minY) / (targets.length - 1);
			
			// 移动显示对象，进行顶部分布操作。从第2个开始，到第 length - 1 个，第一个和最后一个不用移动。
			for( i = 1; i < topEdgeYIndexedArray.length - 1; i++ )
			{
				target = targets[ topEdgeYIndexedArray[i] ] as DisplayObject;
				var m:Matrix = target.transform.matrix;
				m.ty -= topEdgeYArray[ topEdgeYIndexedArray[i] ] - (minY + yGap * i);
				target.transform.matrix = m;
			}
		}
		
		
		
		/**
		 *  垂直居中分布。以显示对象的垂直中横线为准，在最上边与最下边的显示对象之间平均分布所有显示对象。需要进行垂直居中分布操作的显示对象将包含在 targets 参数里。
		 *
		 *  @param targets 包含若干个显示对象的数组。
		 */
		public static function distributeVerticalCenter( targets:Array ):void
		{
			var centerYArray:Array = new Array(); // 存放 targets 对应的 Rectangle 垂直中横线的 y 坐标。
			var centerYIndexedArray:Array; // 对 centerYArray 进行排序并保存对应的索引值，升序。
			var i:int = 0;
			var target:DisplayObject;
			var yGap:Number = 0; // 平均分布所需的间隔。
			
			// 轮询 targets，获取对应 Rectangle 垂直中线的 y 坐标和 height 值。
			for( i = 0; i < targets.length; i++ )
			{
				target = targets[i] as DisplayObject;
				var rect:Rectangle = target.transform.pixelBounds;
				centerYArray.push( rect.y + rect.height / 2 );
			}
			
			centerYIndexedArray = centerYArray.sort( Array.NUMERIC | Array.RETURNINDEXEDARRAY );
			var minY:Number = centerYArray[ centerYIndexedArray[0] ];
			var maxY:Number = centerYArray[ centerYIndexedArray[centerYIndexedArray.length - 1] ];
			yGap = (maxY - minY) / (targets.length - 1);
			
			// 移动显示对象，进行垂直居中分布操作。从第2个开始，到第 length - 1 个，第一个和最后一个不用移动。
			for( i = 1; i < centerYIndexedArray.length - 1; i++ )
			{
				target = targets[ centerYIndexedArray[i] ] as DisplayObject;
				var m:Matrix = target.transform.matrix;
				m.ty -= centerYArray[ centerYIndexedArray[i] ] - (minY + yGap * i);
				target.transform.matrix = m;
			}
		}
		
		
		
		
		/**
		 *  底部分布。以显示对象下边缘为准，在最上边与最下边的显示对象之间平均分布所有显示对象。需要进行底部分布操作的显示对象将包含在 targets 参数里。
		 *
		 *  @param targets 包含若干个显示对象的数组。
		 */
		public static function distributeBottomEdge( targets:Array ):void
		{
			var bottomEdgeYArray:Array = new Array(); // 存放 targets 对应的 Rectangle 下边缘的 y 坐标。
			var bottomEdgeYIndexedArray:Array; // 对 bottomEdgeYArray 进行排序并保存对应的索引值，升序。
			var i:int = 0;
			var target:DisplayObject;
			var yGap:Number = 0; // 平均分布所需的间隔。
			
			// 轮询 targets，获取对应 Rectangle 下边缘的 y 坐标和 height 值。
			for( i = 0; i < targets.length; i++ )
			{
				target = targets[i] as DisplayObject;
				var rect:Rectangle = target.transform.pixelBounds;
				bottomEdgeYArray.push( rect.y + rect.height );
			}
			
			bottomEdgeYIndexedArray = bottomEdgeYArray.sort( Array.NUMERIC | Array.RETURNINDEXEDARRAY );
			var minY:Number = bottomEdgeYArray[ bottomEdgeYIndexedArray[0] ];
			var maxY:Number = bottomEdgeYArray[ bottomEdgeYIndexedArray[bottomEdgeYIndexedArray.length - 1] ];
			yGap = (maxY - minY) / (targets.length - 1);
			
			// 移动显示对象，进行底部分布操作。从第2个开始，到第 length - 1 个，第一个和最后一个不用移动。
			for( i = 1; i < bottomEdgeYIndexedArray.length - 1; i++ )
			{
				target = targets[ bottomEdgeYIndexedArray[i] ] as DisplayObject;
				var m:Matrix = target.transform.matrix;
				m.ty -= bottomEdgeYArray[ bottomEdgeYIndexedArray[i] ] - (minY + yGap * i);
				target.transform.matrix = m;
			}
		}
		
		
		
		/**
		 *  左侧分布。以显示对象左边缘为准，在最左边与最右边的显示对象之间平均分布所有显示对象。需要进行左侧分布操作的显示对象将包含在 targets 参数里。
		 *
		 *  @param targets 包含若干个显示对象的数组。
		 */
		public static function distributeLeftEdge( targets:Array ):void
		{
			var leftEdgeXArray:Array = new Array(); // 存放 targets 对应的 Rectangle 左边缘的 x 坐标。
			var leftEdgeXIndexedArray:Array; // 对 leftEdgeXArray 进行排序并保存对应的索引值，升序。
			var i:int = 0;
			var target:DisplayObject;
			var xGap:Number = 0; // 平均分布所需的间隔。
			
			// 轮询 targets，获取对应 Rectangle 范围的 y 坐标。
			for( i = 0; i < targets.length; i++ )
			{
				target = targets[i] as DisplayObject;
				leftEdgeXArray.push( target.transform.pixelBounds.x );
			}
			
			leftEdgeXIndexedArray = leftEdgeXArray.sort( Array.NUMERIC | Array.RETURNINDEXEDARRAY );
			var minX:Number = leftEdgeXArray[ leftEdgeXIndexedArray[0] ];
			var maxX:Number = leftEdgeXArray[ leftEdgeXIndexedArray[leftEdgeXIndexedArray.length - 1] ];
			xGap = (maxX - minX) / (targets.length - 1);
			
			// 移动显示对象，进行顶部分布操作。从第2个开始，到第 length - 1 个，第一个和最后一个不用移动。
			for( i = 1; i < leftEdgeXIndexedArray.length - 1; i++ )
			{
				target = targets[ leftEdgeXIndexedArray[i] ] as DisplayObject;
				var m:Matrix = target.transform.matrix;
				m.tx -= leftEdgeXArray[ leftEdgeXIndexedArray[i] ] - (minX + xGap * i);
				target.transform.matrix = m;
			}
		}
		
		
		
		/**
		 *  水平居中分布。以显示对象的中垂线为准，在最左边与最右边的显示对象之间平均分布所有显示对象。需要进行水平居中分布操作的显示对象将包含在 targets 参数里。
		 *
		 *  @param targets 包含若干个显示对象的数组。
		 */
		public static function distributeHorizonalCenter( targets:Array ):void
		{
			var centerXArray:Array = new Array(); // 存放 targets 对应的 Rectangle 中垂线的 x 坐标。
			var centerXIndexedArray:Array; // 对 centerXArray 进行排序并保存对应的索引值，升序。
			var i:int = 0;
			var target:DisplayObject;
			var xGap:Number = 0; // 平均分布所需的间隔。
			
			// 轮询 targets，获取对应 Rectangle 垂直中线的 x 坐标和 width 值。
			for( i = 0; i < targets.length; i++ )
			{
				target = targets[i] as DisplayObject;
				var rect:Rectangle = target.transform.pixelBounds;
				centerXArray.push( rect.x + rect.width / 2 );
			}
			
			centerXIndexedArray = centerXArray.sort( Array.NUMERIC | Array.RETURNINDEXEDARRAY );
			var minX:Number = centerXArray[ centerXIndexedArray[0] ];
			var maxX:Number = centerXArray[ centerXIndexedArray[centerXIndexedArray.length - 1] ];
			xGap = (maxX - minX) / (targets.length - 1);
			
			// 移动显示对象，进行水平居中分布操作。从第2个开始，到第 length - 1 个，第一个和最后一个不用移动。
			for( i = 1; i < centerXIndexedArray.length - 1; i++ )
			{
				target = targets[ centerXIndexedArray[i] ] as DisplayObject;
				var m:Matrix = target.transform.matrix;
				m.tx -= centerXArray[ centerXIndexedArray[i] ] - (minX + xGap * i);
				target.transform.matrix = m;
			}
		}
		
		
		
		/**
		 *  右侧分布。以显示对象右边缘为准，在最左边与最右边的显示对象之间平均分布所有显示对象。需要进行右侧分布操作的显示对象将包含在 targets 参数里。
		 *
		 *  @param targets 包含若干个显示对象的数组。
		 */
		public static function distributeRightEdge( targets:Array ):void
		{
			var rightEdgeXArray:Array = new Array(); // 存放 targets 对应的 Rectangle 右边缘的 x 坐标。
			var rightEdgeXIndexedArray:Array; // 对 rightEdgeXArray 进行排序并保存对应的索引值，升序。
			var i:int = 0;
			var target:DisplayObject;
			var xGap:Number = 0; // 平均分布所需的间隔。
			
			// 轮询 targets，获取对应 Rectangle 右边缘的 x 坐标和 width 值。
			for( i = 0; i < targets.length; i++ )
			{
				target = targets[i] as DisplayObject;
				var rect:Rectangle = target.transform.pixelBounds;
				rightEdgeXArray.push( rect.x + rect.width );
			}
			
			rightEdgeXIndexedArray = rightEdgeXArray.sort( Array.NUMERIC | Array.RETURNINDEXEDARRAY );
			var minX:Number = rightEdgeXArray[ rightEdgeXIndexedArray[0] ];
			var maxX:Number = rightEdgeXArray[ rightEdgeXIndexedArray[rightEdgeXIndexedArray.length - 1] ];
			xGap = (maxX - minX) / (targets.length - 1);
			
			// 移动显示对象，进行右侧分布操作。从第2个开始，到第 length - 1 个，第一个和最后一个不用移动。
			for( i = 1; i < rightEdgeXIndexedArray.length - 1; i++ )
			{
				target = targets[ rightEdgeXIndexedArray[i] ] as DisplayObject;
				var m:Matrix = target.transform.matrix;
				m.tx -= rightEdgeXArray[ rightEdgeXIndexedArray[i] ] - (minX + xGap * i);
				target.transform.matrix = m;
			}
		}
		
		
		
	}
}